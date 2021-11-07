package ctest

import chisel3._
import chisel3.util._
import common.Consts._
import common.Instructions._

// instとregfileが重要
// デコードの強化で，instをEX以降のステージに受け渡す必要がなくなった

// CSR関連は，実際はCSRレジスタごとにアクセス権が異なっていたりと複雑
// 今回はマシンモードとして最高特権で実行しているので，アクセス権などに関して考える必要はない

// 5つのステージ
class Core extends Module {

	// 入出力
	val io = IO(new Bundle {
		val imem = Flipped(new ImemPortIo())
		val dmem = Flipped(new DmemPortIo())

		val exit = Output(Bool())
		val gp = Output(UInt(WORD_LEN.W))
	})

	// レジスタ実体
	val regfile = Mem(32, UInt(WORD_LEN.W)) // 複数のレジスタはこれで作る
	val csr_regfile = Mem(4096, UInt(WORD_LEN.W))

	io.gp := regfile(3) // グローバルポインタ

	// IF -----------------------------------------------------

	// プログラムカウンタ
	val pc_reg = RegInit(START_ADDR) // 単体のレジスタはこれで作る
	// pc_reg := pc_reg + 4.U(WORD_LEN.W)
	val pc_plus4 = pc_reg + 4.U(WORD_LEN.W)

	// Wireで宣言のみ
	val br_flg = Wire(Bool())
	val br_target = Wire(UInt(WORD_LEN.W))


	// メモリから命令を受け取る
	io.imem.addr := pc_reg
	val inst = io.imem.inst

	val jmp_flg = (inst === JAL || inst === JALR)
	val alu_out = Wire(UInt(WORD_LEN.W))

	val pc_next = MuxCase(pc_plus4, Seq(
		br_flg 				-> br_target,
		jmp_flg 			-> alu_out,
		(inst === ECALL) 	-> csr_regfile(0x305) // 0x305:mtvecにはtrap_vectorアドレスが格納されている
	))
	pc_reg := pc_next

	// ID -----------------------------------------------------

	// 解読
	val rs1_addr = inst(19, 15)
	val rs2_addr = inst(24, 20)
	val wb_addr  = inst(11, 7) // rd

	// レジスタデータ読み出し
	val rs1_data = Mux((rs1_addr =/= 0.U(WORD_LEN.U)), regfile(rs1_addr), 0.U(WORD_LEN.W))
	val rs2_data = Mux((rs2_addr =/= 0.U(WORD_LEN.U)), regfile(rs2_addr), 0.U(WORD_LEN.W))

	// LW命令の即値(I形式)
	val imm_i = inst(31, 20)
	val imm_i_sext = Cat(Fill(20, imm_i(11)), imm_i) // 符号拡張

	// SW命令の即値(S形式)
	val imm_s = Cat(inst(31, 25), inst(11, 7))
	val imm_s_sext = Cat(Fill(20, imm_s(11)), imm_s) // 符号拡張

	// 分岐命令の即値(B形式)
	val imm_b = Cat(inst(31), inst(7), inst(30, 25), inst(11, 8))
	val imm_b_sext = Cat(Fill(19, imm_b(11)), imm_b, 0.U(1.U)) // 最下位ビットを0にセットすることで必ず２の倍数

	// ジャンプ命令の即値(J形式)
	val imm_j = Cat(inst(31), inst(19, 12), inst(20), inst(30, 21))
	val imm_j_sext = Cat(Fill(11, imm_j(19)), imm_j, 0.U(1.U))

	// 即値ロード命令の即値(U形式)
	val imm_u = inst(31, 12)
	val imm_u_shifted = Cat(imm_u, Fill(12, 0.U)) // 12bit左シフト

	// CSR命令の即値(Z形式)
	val imm_z = inst(19, 15)
	val imm_z_uext = Cat(Fill(27, 0.U), imm_z)

	// 演算内容，　オペランド１，　オペランド２，　メモリストアか否か，　WBするか否か，　WBのデータはどれ？, CSR
	val csignals = ListLookup(inst,
			List(ALU_X, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
		Array(
			LW 		-> List(ALU_ADD, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM, CSR_X),
			SW 		-> List(ALU_ADD, OP1_RS1, OP2_IMS, MEN_S, REN_X, WB_X, CSR_X),
			ADD 	-> List(ALU_ADD, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			ADDI 	-> List(ALU_ADD, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			SUB 	-> List(ALU_SUB, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			AND 	-> List(ALU_AND, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			OR 		-> List(ALU_OR, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			XOR 	-> List(ALU_XOR, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			ANDI 	-> List(ALU_AND, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			ORI 	-> List(ALU_OR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			XORI 	-> List(ALU_XOR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			SLL 	-> List(ALU_SLL, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			SRL 	-> List(ALU_SRL, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			SRA 	-> List(ALU_SRA, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			SLLI 	-> List(ALU_SLL, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			SRLI 	-> List(ALU_SRL, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			SRAI 	-> List(ALU_SRA, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			SLT 	-> List(ALU_SLT, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			SLTU 	-> List(ALU_SLTU, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU, CSR_X),
			SLTI 	-> List(ALU_SLT, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			SLTIU 	-> List(ALU_SLTU, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU, CSR_X),
			BEQ 	-> List(BR_BEQ, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
			BNE 	-> List(BR_BNE, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
			BLT 	-> List(BR_BLT, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
			BGE 	-> List(BR_BGE, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
			BLTU 	-> List(BR_BLTU, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
			BGEU 	-> List(BR_BGEU, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X, CSR_X),
			JAL 	-> List(ALU_ADD, OP1_PC, OP2_IMJ, MEN_X, REN_S, WB_PC, CSR_X),
			JALR 	-> List(ALU_JALR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_PC, CSR_X),
			LUI		-> List(ALU_ADD, OP1_X, OP2_IMU, MEN_X, REN_S, WB_ALU, CSR_X),
			AUIPC	-> List(ALU_ADD, OP1_PC, OP2_IMU, MEN_X, REN_S, WB_ALU, CSR_X),
			CSRRW	-> List(ALU_COPY1, OP1_RS1, OP2_X, MEN_X, REN_S, WB_CSR, CSR_W),
			CSRRWI	-> List(ALU_COPY1, OP1_IMZ, OP2_X, MEN_X, REN_S, WB_CSR, CSR_W),
			CSRRS	-> List(ALU_COPY1, OP1_RS1, OP2_X, MEN_X, REN_S, WB_CSR, CSR_S),
			CSRRSI	-> List(ALU_COPY1, OP1_IMZ, OP2_X, MEN_X, REN_S, WB_CSR, CSR_S),
			CSRRC	-> List(ALU_COPY1, OP1_RS1, OP2_X, MEN_X, REN_S, WB_CSR, CSR_C),
			CSRRCI	-> List(ALU_COPY1, OP1_IMZ, OP2_X, MEN_X, REN_S, WB_CSR, CSR_C),
			ECALL	-> List(ALU_X, OP1_X, OP2_X, MEN_X, REN_X, WB_X, CSR_E),
		)
	)

	val exe_fun :: op1_sel :: op2_sel :: mem_wen :: rf_wen :: wb_sel :: csr_cmd :: Nil = csignals

	val op1_data = MuxCase(0.U(WORD_LEN.W), Seq(
		(op1_sel === OP1_RS1) -> rs1_data,
		(op1_sel === OP1_PC) -> pc_reg,
		(op1_sel === OP1_IMZ) -> imm_z_uext
	))

	val op2_data = MuxCase(0.U(WORD_LEN.W), Seq(
		(op2_sel === OP2_RS2) -> rs2_data,
		(op2_sel === OP2_IMI) -> imm_i_sext,
		(op2_sel === OP2_IMS) -> imm_s_sext,
		(op2_sel === OP2_IMJ) -> imm_j_sext,
		(op2_sel === OP2_IMU) -> imm_u_shifted
	))

	// EX -----------------------------------------------------

	// 演算結果格納
	// val alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
	// 	(inst === LW || inst === ADDI) -> (rs1_data + imm_i_sext),
	// 	(inst === SW) -> (rs1_data + imm_s_sext),
	// 	(inst === ADD) -> (rs1_data + rs2_data),
	// 	(inst === SUB) -> (rs1_data - rs2_data),
	// 	(inst === AND) -> (rs1_data & rs2_data),
	// 	(inst === OR) -> (rs1_data | rs2_data),
	// 	(inst === XOR) -> (rs1_data ^ rs2_data),
	// 	(inst === ANDI) -> (rs1_data & imm_i_sext),
	// 	(inst === ORI) -> (rs1_data | imm_i_sext),
	// 	(inst === XORI) -> (rs1_data ^ imm_i_sext)
	// ))

	// UInt型が入る
	// val alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
	// 上で宣言したから書き方変わる
	alu_out := MuxCase(0.U(WORD_LEN.W), Seq(
		(exe_fun === ALU_ADD) 	-> (op1_data + op2_data),
		(exe_fun === ALU_SUB) 	-> (op1_data - op2_data),
		(exe_fun === ALU_AND) 	-> (op1_data & op2_data),
		(exe_fun === ALU_OR) 	-> (op1_data | op2_data),
		(exe_fun === ALU_XOR) 	-> (op1_data ^ op2_data),
		(exe_fun === ALU_SLL) 	-> (op1_data << op2_data(4, 0))(31, 0), // 溢れた桁は捨てる(オーバーフローしたら捨てる)
		(exe_fun === ALU_SRL) 	-> (op1_data >> op2_data(4, 0)).asUInt(),
		(exe_fun === ALU_SRA) 	-> (op1_data.asSInt() >> op2_data(4, 0)).asUInt(),
		(exe_fun === ALU_SLT) 	-> (op1_data.asSInt() < op2_data.asSInt()).asUInt(),
		(exe_fun === ALU_SLTU) 	-> (op1_data < op2_data).asUInt(),
		(exe_fun === ALU_JALR) 	-> ((op1_data + op2_data) & !(1.U(WORD_LEN.W))),
		(exe_fun === ALU_COPY1) -> op1_data
	))

	// 分岐するか否か
	br_flg := MuxCase(false.B, Seq(
		(exe_fun === BR_BEQ)	-> (op1_data === op2_data),
		(exe_fun === BR_BNE)	-> !(op1_data === op2_data),
		(exe_fun === BR_BLT)	-> (op1_data.asSInt() < op2_data.asSInt()),
		(exe_fun === BR_BGE)	-> !(op1_data.asSInt() < op2_data.asSInt()),
		(exe_fun === BR_BLTU)	-> (op1_data < op2_data),
		(exe_fun === BR_BGEU)	-> !(op1_data < op2_data),
	))

	// 分岐先のメモリアドレス
		br_target := pc_reg + imm_b_sext

	// MEM access -----------------------------------------------------

	// 演算結果（メモリアドレス）をメモリへ（LW と SW）
	io.dmem.addr := alu_out

	// ストアしたいデータをメモリへ（SW）
	// io.dmem.wen := (inst === SW)
	io.dmem.wen := mem_wen // instの再デコード処理が不要に
	io.dmem.wdata := rs2_data


	// val csr_addr 	= inst(31, 20)
	val csr_addr	= Mux(csr_cmd === CSR_E, 0x342.U(CSR_ADDR_LEN.W), inst(31, 20))

	// CSRの読み出し
	val csr_rdata 	= csr_regfile(csr_addr)

	// CSRの書き込み
	val csr_wdata = MuxCase(0.U(WORD_LEN.W), Seq(
		(csr_cmd === CSR_W) -> op1_data,
		(csr_cmd === CSR_S) -> (csr_rdata | op1_data),	// set
		(csr_cmd === CSR_C) -> (csr_rdata & !op1_data),	// clear
		(csr_cmd === CSR_E) -> 11.U(WORD_LEN.W),		// ecall
	))

	// 1.U以上であればCSR命令だと，csr_cmdで判別できるよう設定（consts.scalaで）
	when(csr_cmd > 0.U) {
		csr_regfile(csr_addr) := csr_wdata
	}

	// WB -----------------------------------------------------

	// LW結果を受け取り(LW命令でWB使うんだな)
	// val wb_data = io.dmem.rdata
	// val wb_data = MuxCase(alu_out, Seq(
	// 	(inst === LW) -> io.dmem.rdata
	// ))

	// デフォルトは演算結果をWB
	// LW命令の時はメモリからの出力をWB
	// ジャンプ命令の時はプログラムカウンタをWB(リターンアドレス)
	// CSR命令の時はCSR読み出しデータをWB (書き込みデータではない)
	val wb_data = MuxCase(alu_out, Seq(
		// 本来はWB_ALUもあるがそれはWBしないから入れてない
		(wb_sel === WB_MEM) -> io.dmem.rdata, // LW命令
		(wb_sel === WB_PC) 	-> pc_plus4,
		(wb_sel === WB_CSR) -> csr_rdata,
	))

	// WBするものだけ記述
	// when(inst === LW || inst === ADD || inst === ADDI || inst === SUB || inst === AND || inst === OR || inst === XOR || inst === ANDI || inst === ORI || inst === XORI) {
	// 	regfile(wb_addr) := wb_data
	// }
	when(rf_wen === REN_S) {
		// wb_addr = rdレジスタ
		regfile(wb_addr) := wb_data
	}

	// 終了判定 -----------------------------------------------------

	// io.exit := (pc_reg === 0x44.U(WORD_LEN.W))
	io.exit := (inst === UNIMP) // unimplementationの略（今回の実装ではCSR命令についてやってないから，これを終了条件とする．）

	// デバッグ -----------------------------------------------------

	printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}\n")
	printf(p"inst: 0x${Hexadecimal(inst)}\n")

	printf(p"rs1_addr: $rs1_addr\n")
	printf(p"rs1_data: 0x${Hexadecimal(rs1_data)}\n")

	printf(p"rs2_addr: $rs2_addr\n")
	printf(p"rs2_data: 0x${Hexadecimal(rs2_data)}\n")

	printf(p"wb_addr: $wb_addr\n")
	printf(p"dmem.addr: ${io.dmem.addr}\n")
	printf(p"wb_data: 0x${Hexadecimal(wb_data)}\n")

	printf(p"dmem.wen: ${io.dmem.wen}\n")
	printf(p"dmem.wdata: 0x${Hexadecimal(io.dmem.wdata)}\n")

	printf(p"gp : ${regfile(3)}\n")

	printf("-----------------------------------------------------------\n")
}
