package sw

import chisel3._
import chisel3.util._
import common.Consts._
import common.Instructions._

// instとregfileが重要
// デコードの強化で，instをEX以降のステージに受け渡す必要がなくなった

// 5つのステージ
class Core extends Module {

	// 入出力
	val io = IO(new Bundle {
		val imem = Flipped(new ImemPortIo())
		val dmem = Flipped(new DmemPortIo())

		val exit = Output(Bool())
	})

	// レジスタ実体
	val regfile = Mem(32, UInt(WORD_LEN.W)) // 複数のレジスタはこれで作る


	// IF -----------------------------------------------------

	// プログラムカウンタ
	val pc_reg = RegInit(START_ADDR) // 単体のレジスタはこれで作る
	// pc_reg := pc_reg + 4.U(WORD_LEN.W)
	val pc_plus4 = pc_reg + 4.U(WORD_LEN.W)

	// Wireで宣言のみ
	val br_flg = Wire(Bool())
	val br_target = Wire(UInt(WORD_LEN.W))

	val pc_next = MuxCase(pc_plus4, Seq(
		br_flg -> br_target
	))
	pc_reg := pc_next

	// メモリから命令を受け取る
	io.imem.addr := pc_reg
	val inst = io.imem.inst

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

	// 演算内容，　オペランド１，　オペランド２，　メモリストアか否か，　WBするか否か，　WBのデータはどれ？
	val csignals = ListLookup(inst,
			List(ALU_X, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
		Array(
			LW 		-> List(ALU_ADD, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_MEM),
			SW 		-> List(ALU_ADD, OP1_RS1, OP2_IMS, MEN_S, REN_X, WB_X),
			ADD 	-> List(ALU_ADD, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			ADDI 	-> List(ALU_ADD, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			SUB 	-> List(ALU_SUB, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			AND 	-> List(ALU_AND, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			OR 		-> List(ALU_OR, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			XOR 	-> List(ALU_XOR, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			ANDI 	-> List(ALU_AND, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			ORI 	-> List(ALU_OR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			XORI 	-> List(ALU_XOR, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			SLL 	-> List(ALU_SLL, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			SRL 	-> List(ALU_SRL, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			SRA 	-> List(ALU_SRA, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			SLLI 	-> List(ALU_SLL, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			SRLI 	-> List(ALU_SRL, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			SRAI 	-> List(ALU_SRA, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			SLT 	-> List(ALU_SLT, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			SLTU 	-> List(ALU_SLTU, OP1_RS1, OP2_RS2, MEN_X, REN_S, WB_ALU),
			SLTI 	-> List(ALU_SLT, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			SLTUI 	-> List(ALU_SLTU, OP1_RS1, OP2_IMI, MEN_X, REN_S, WB_ALU),
			BEQ 	-> List(ALU_BEQ, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
			BNE 	-> List(ALU_BNE, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
			BLT 	-> List(ALU_BLT, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
			BGE 	-> List(ALU_BGE, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
			BLTU 	-> List(ALU_BLTU, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
			BGEU 	-> List(ALU_BGEU, OP1_RS1, OP2_RS2, MEN_X, REN_X, WB_X),
		)
	)

	val exe_fun :: op1_sel :: op2_sel :: mem_wen :: rf_wen :: wb_sel :: Nil = csignals

	val op1_data = MuxCase(0.U(WORD_LEN.W), Seq(
		(op1_sel === OP1_RS1) -> rs1_data
	))

	val op2_data = MuxCase(0.U(WORD_LEN.W), Seq(
		(op2_sel === OP2_RS2) -> rs2_data,
		(op2_sel === OP2_IMI) -> imm_i_sext,
		(op2_sel === OP2_IMS) -> imm_s_sext,
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
	val alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
		(exe_fun === ALU_ADD) 	-> (op1_data + op2_data),
		(exe_fun === ALU_SUB) 	-> (op1_data - op2_data),
		(exe_fun === ALU_AND) 	-> (op1_data & op2_data),
		(exe_fun === ALU_OR) 	-> (op1_data | op2_data),
		(exe_fun === ALU_XOR) 	-> (op1_data ^ op2_data),
		(exe_fun === ALU_SLL) 	-> (op1_data << op2_data(4, 0))(31, 0), // 溢れた桁は捨てる(オーバーフローは捨てる)
		(exe_fun === ALU_SRL) 	-> (op1_data >> op2_data(4, 0)).asUInt(),
		(exe_fun === ALU_SRA) 	-> (op1_data.asSInt() >> op2_data(4, 0)).asUInt(),
		(exe_fun === ALU_SLT) 	-> (op1_data.asSInt() < op2_data.asSInt()).asUInt(),
		(exe_fun === ALU_SLTU) 	-> (op1_data < op2_data).asUInt(),
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

	// WB -----------------------------------------------------

	// LW結果を受け取り(LW命令でWB使うんだな)
	// val wb_data = io.dmem.rdata
	// val wb_data = MuxCase(alu_out, Seq(
	// 	(inst === LW) -> io.dmem.rdata
	// ))

	// デフォルトは演算結果をWB, LW命令の時はメモリからの出力をWB
	val wb_data = MuxCase(alu_out, Seq(
		(wb_sel === WB_MEM) -> io.dmem.rdata
	))

	// WBするものだけ記述
	// when(inst === LW || inst === ADD || inst === ADDI || inst === SUB || inst === AND || inst === OR || inst === XOR || inst === ANDI || inst === ORI || inst === XORI) {
	// 	regfile(wb_addr) := wb_data
	// }
	when(rf_wen === REN_S) {
		regfile(wb_addr) := wb_data
	}

	// 終了判定 -----------------------------------------------------

	io.exit := (inst === 0x00602823.U(WORD_LEN.W))

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

	printf("-----------------------------------------------------------\n")
}
