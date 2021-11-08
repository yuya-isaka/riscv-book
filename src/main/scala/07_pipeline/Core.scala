package pipeline

import chisel3._
import chisel3.util._
import common.Consts._
import common.Instructions._

class Core extends Module {

	val io = IO(new Bundle {
		val imem 	= Flipped(new ImemPortIo())
		val dmem 	= Flipped(new DmemPortIo())
		val exit 	= Output(Bool())
		val gp 		= Output(UInt(WORD_LEN.W))
	})

	val regfile 	= Mem(32, UInt(WORD_LEN.W))
	val csr_regfile = Mem(4096, UInt(WORD_LEN.W))

	// IF/ID State
  	val id_reg_pc             = RegInit(0.U(WORD_LEN.W))
  	val id_reg_inst           = RegInit(0.U(WORD_LEN.W))

  	// ID/EX State
  	val exe_reg_pc            = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_wb_addr       = RegInit(0.U(ADDR_LEN.W))
  	val exe_reg_op1_data      = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_op2_data      = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_rs2_data      = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_exe_fun       = RegInit(0.U(EXE_FUN_LEN.W))
  	val exe_reg_mem_wen       = RegInit(0.U(MEN_LEN.W))
  	val exe_reg_rf_wen        = RegInit(0.U(REN_LEN.W))
  	val exe_reg_wb_sel        = RegInit(0.U(WB_SEL_LEN.W))
  	val exe_reg_csr_addr      = RegInit(0.U(CSR_ADDR_LEN.W))
  	val exe_reg_csr_cmd       = RegInit(0.U(CSR_LEN.W))
  	val exe_reg_imm_i_sext    = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_imm_s_sext    = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_imm_b_sext    = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_imm_u_shifted = RegInit(0.U(WORD_LEN.W))
  	val exe_reg_imm_z_uext    = RegInit(0.U(WORD_LEN.W))

  	// EX/MEM State
  	val mem_reg_pc            = RegInit(0.U(WORD_LEN.W))
  	val mem_reg_wb_addr       = RegInit(0.U(ADDR_LEN.W))
  	val mem_reg_op1_data      = RegInit(0.U(WORD_LEN.W))
  	val mem_reg_rs2_data      = RegInit(0.U(WORD_LEN.W))
  	val mem_reg_mem_wen       = RegInit(0.U(MEN_LEN.W))
  	val mem_reg_rf_wen        = RegInit(0.U(REN_LEN.W))
  	val mem_reg_wb_sel        = RegInit(0.U(WB_SEL_LEN.W))
  	val mem_reg_csr_addr      = RegInit(0.U(CSR_ADDR_LEN.W))
  	val mem_reg_csr_cmd       = RegInit(0.U(CSR_LEN.W))
  	val mem_reg_imm_z_uext    = RegInit(0.U(WORD_LEN.W))
  	val mem_reg_alu_out       = RegInit(0.U(WORD_LEN.W))

  	// MEM/WB State
  	val wb_reg_wb_addr        = RegInit(0.U(ADDR_LEN.W))
  	val wb_reg_rf_wen         = RegInit(0.U(REN_LEN.W))
  	val wb_reg_wb_data        = RegInit(0.U(WORD_LEN.W))

	io.gp := regfile(3)

	// IF -----------------------------------------------------

	val if_reg_pc 	= RegInit(START_ADDR)
	io.imem.addr 	= if_reg_pc
	val if_inst 	= io.imem.inst

	val exe_br_flg 		= Wire(Bool())
	val exe_br_target 	= Wire(UInt(WORD_LEN.W))

	val exe_jmp_flg = Wire(Bool())
	val exe_alu_out = Wire(UInt(WORD_LEN.W))

	val pc_plus4 = if_reg_pc + 4.U(WORD_LEN.W)
	val pc_next 	= MuxCase(pc_plus4, Seq(
		exe_br_flg 				-> exe_br_target,
		exe_jmp_flg 			-> exe_alu_out,
		(if_inst === ECALL) 	-> csr_regfile(0x305)
	))
	if_pc_reg := pc_next

	// IF/ID -------------------------------------------------

	id_reg_pc 	:= if_reg_pc
	id_reg_inst := if_inst   // n

	// ID ----------------------------------------------------- idのことはidで判断する(regがついてるやつは前のステージから引き継いだもの)

	val id_rs1_addr = id_reg_inst(19, 15)
	val id_rs2_addr = id_reg_inst(24, 20)
	val id_wb_addr  = id_reg_inst(11, 7)

	val id_rs1_data = Mux((id_rs1_addr =/= 0.U(WORD_LEN.U)), regfile(rs1_addr), 0.U(WORD_LEN.W))
	val id_rs2_data = Mux((id_rs2_addr =/= 0.U(WORD_LEN.U)), regfile(rs2_addr), 0.U(WORD_LEN.W))

	val imm_i 			= id_inst(31, 20)
	val id_imm_i_sext 	= Cat(Fill(20, imm_i(11)), imm_i)

	val imm_s 			= Cat(id_inst(31, 25), id_inst(11, 7))
	val id_imm_s_sext 	= Cat(Fill(20, imm_s(11)), imm_s)

	val imm_b 			= Cat(id_inst(31), id_inst(7), id_inst(30, 25), id_inst(11, 8))
	val id_imm_b_sext 	= Cat(Fill(19, imm_b(11)), imm_b, 0.U(1.U))

	val imm_j 			= Cat(id_inst(31), id_inst(19, 12), id_inst(20), id_inst(30, 21))
	val id_imm_j_sext 	= Cat(Fill(11, imm_j(19)), imm_j, 0.U(1.U))

	val imm_u 				= id_inst(31, 12)
	val id_imm_u_shifted 	= Cat(imm_u, Fill(12, 0.U))

	val imm_z 			= id_inst(19, 15)
	val id_imm_z_uext 	= Cat(Fill(27, 0.U), imm_z)

	val csignals = ListLookup(id_reg_inst,
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

	val id_exe_fun :: id_op1_sel :: id_op2_sel :: id_mem_wen :: id_rf_wen :: id_wb_sel :: id_csr_cmd :: Nil = csignals

	val id_op1_data = MuxCase(0.U(WORD_LEN.W), Seq(
		(id_op1_sel === OP1_RS1) 	-> id_rs1_data,
		(id_op1_sel === OP1_PC) 	-> id_reg_pc,
		(id_op1_sel === OP1_IMZ) 	-> id_imm_z_uext
	))

	val id_op2_data = MuxCase(0.U(WORD_LEN.W), Seq(
		(id_op2_sel === OP2_RS2) 	-> id_rs2_data,
		(id_op2_sel === OP2_IMI) 	-> id_imm_i_sext,
		(id_op2_sel === OP2_IMS) 	-> id_imm_s_sext,
		(id_op2_sel === OP2_IMJ) 	-> id_imm_j_sext,
		(id_op2_sel === OP2_IMU) 	-> id_imm_u_shifted
	))

	// idのinstを使いたいからここに移動
	val id_csr_addr = Mux(id_csr_cmd === CSR_E, 0x342.U(CSR_ADDR_LEN.W), id_inst(31,20))

	// ID/EX -------------------------------------------------------------------------------------------------------------------------- これ以降で使うレジスタを保持しておく exとmemとwbで使うやつ

	exe_reg_pc 				:= id_reg_pc
	exe_reg_op1_data 		:= id_op1_data			// n
	exe_reg_op2_data 		:= id_op2_data			// n
	exe_reg_rs2_data 		:= id_rs2_data			// n
	exe_reg_imm_i_sext 		:= id_imm_i_sext		// n
	exe_reg_imm_s_sext 		:= id_imm_s_sext		// n
	exe_reg_imm_b_sext 		:= id_imm_b_sext		// n
	exe_reg_imm_u_shifted 	:= id_imm_u_shifted		// n
	exe_reg_imm_z_uxet 		:= id_imm_z_uext		// n
	exe_reg_wb_addr 		:= id_wb_addr			// n
	exe_reg_exe_fun 		:= id_exe_fun			// n
	exe_reg_mem_wen 		:= id_mem_wen			// n
	exe_reg_rf_wen 			:= id_rf_wen			// n
	exe_reg_csr_cmd 		:= id_csr_cmd			// n
	exe_reg_csr_addr 		:= id_csr_addr			// n

	// EX -----------------------------------------------------------------------------------------------------------------------------

	exe_alu_out := MuxCase(0.U(WORD_LEN.W), Seq(
		(exe_reg_exe_fun === ALU_ADD) 	-> (exe_reg_op1_data + exe_reg_op2_data),
		(exe_reg_exe_fun === ALU_SUB) 	-> (exe_reg_op1_data - exe_reg_op2_data),
		(exe_reg_exe_fun === ALU_AND) 	-> (exe_reg_op1_data & exe_reg_op2_data),
		(exe_reg_exe_fun === ALU_OR) 	-> (exe_reg_op1_data | exe_reg_op2_data),
		(exe_reg_exe_fun === ALU_XOR) 	-> (exe_reg_op1_data ^ exe_reg_op2_data),
		(exe_reg_exe_fun === ALU_SLL) 	-> (exe_reg_op1_data << exe_reg_op2_data(4, 0))(31, 0),
		(exe_reg_exe_fun === ALU_SRL) 	-> (exe_reg_op1_data >> exe_reg_op2_data(4, 0)).asUInt(),
		(exe_reg_exe_fun === ALU_SRA) 	-> (exe_reg_op1_data.asSInt() >> exe_reg_op2_data(4, 0)).asUInt(),
		(exe_reg_exe_fun === ALU_SLT) 	-> (exe_reg_op1_data.asSInt() < exe_reg_op2_data.asSInt()).asUInt(),
		(exe_reg_exe_fun === ALU_SLTU) 	-> (exe_reg_op1_data < exe_reg_op2_data).asUInt(),
		(exe_reg_exe_fun === ALU_JALR) 	-> ((exe_reg_op1_data + exe_reg_op2_data) & !(1.U(WORD_LEN.W))),
		(exe_reg_exe_fun === ALU_COPY1) -> exe_reg_op1_data
	))

	exe_br_flg := MuxCase(false.B, Seq(
		(exe_reg_exe_fun === BR_BEQ)	-> (exe_reg_op1_data === exe_reg_op2_data),
		(exe_reg_exe_fun === BR_BNE)	-> !(exe_reg_op1_data === exe_reg_op2_data),
		(exe_reg_exe_fun === BR_BLT)	-> (exe_reg_op1_data.asSInt() < exe_reg_op2_data.asSInt()),
		(exe_reg_exe_fun === BR_BGE)	-> !(exe_reg_op1_data.asSInt() < exe_reg_op2_data.asSInt()),
		(exe_reg_exe_fun === BR_BLTU)	-> (exe_reg_op1_data < exe_reg_op2_data),
		(exe_reg_exe_fun === BR_BGEU)	-> !(exe_reg_op1_data < exe_reg_op2_data),
	))

	exe_br_target := exe_reg_pc + exe_reg_imm_b_sext

	exe_jmp_flg := (exe_reg_wb_sel === WB_PC) // ジャンプフラグ追加（最初はinstで判断してたけど，wb_selで判断できそうだから，あえてinstをidステージから引き継がなかった．）-> 引き継がずに判断できるものは，捨ててよし

	// EXE/MEM-----------------------------------------------------------------------------------------------------------------

	mem_reg_pc 			:= exe_reg_pc
	mem_reg_op1_data 	:= exe_reg_op1_data
	mem_reg_rs2_data 	:= exe_reg_rs2_data
	mem_reg_wb_addr 	:= exe_reg_wb_addr
	mem_reg_imm_z_uext 	:= exe_reg_imm_z_uext
	mem_reg_alu_out 	:= exe_alu_out 			// n
	mem_reg_mem_wen 	:= exe_reg_mem_wen
	mem_reg_rf_wen 		:= exe_reg_rf_wen
	mem_reg_wb_sel 		:= exe_reg_wb_sel
	mem_reg_csr_cmd 	:= exe_reg_csr_cmd
	mem_reg_csr_addr 	:= exe_reg_csr_addr

	// MEM --------------------------------------------------------------------------------------------------------------------

	io.dmem.addr 	:= mem_reg_alu_out
	io.dmem.wen 	:= mem_reg_mem_wen
	io.dmem.wdata 	:= mem_reg_rs2_data

	val csr_rdata = csr_regfile(mem_reg_csr_addr) // ここはprefixをつけない．．．これは，次に渡さないことが確定しているからか．（次に渡さないやつでつけてるやつがないかチェックしよう

	val csr_wdata = MuxCase(0.U(WORD_LEN.W), Seq(
		(mem_reg_csr_cmd === CSR_W) -> mem_reg_op1_data,
		(mem_reg_csr_cmd === CSR_S) -> (csr_rdata | mem_reg_op1_data),	// set
		(mem_reg_csr_cmd === CSR_C) -> (csr_rdata & !mem_reg_op1_data),	// clear
		(mem_reg_csr_cmd === CSR_E) -> 11.U(WORD_LEN.W),		// ecall
	))

	when(mem_reg_csr_cmd > 0.U) {
		csr_regfile(mem_reg_csr_addr) := csr_wdata
	}

	// io.dmem.rdataを接続する関係で移行
	val mem_wb_data = MuxCase(mem_reg_alu_out, Seq(
		(mem_reg_wb_sel === WB_MEM) -> io.dmem.rdata, // LW命令
		(mem_reg_wb_sel === WB_PC) 	-> (mem_reg_pc + 4.U(WORD_LEN.W)),
		(mem_reg_wb_sel === WB_CSR) -> csr_rdata,
	))

	// MEM/WB ------------------------------------------------------------------------------------------------------------------

	wb_reg_wb_addr 	:= mem_reg_wb_addr
	wb_reg_rf_wen 	:= mem_reg_rf_wen
	wb_reg_wb_data	:= mem_wb_data		// n

	// WB ---------------------------------------------------------------------------------------------------------------------

	when(wb_reg_rf_wen === REN_S) {
		regfile(wb_reg_wb_addr) := wb_reg_wb_data
	}

	// 終了判定 -----------------------------------------------------

	io.exit := (inst === UNIMP)

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
