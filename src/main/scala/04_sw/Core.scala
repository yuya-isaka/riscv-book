package sw

import chisel3._
import chisel3.util._
import common.Consts._
import common.Instructions._

// instが重要（こいつに命令が入ってる．こいつを見ればわかる）

class Core extends Module {

	// 入出力
	val io = IO(new Bundle {
		val imem = Flipped(new ImemPortIo())
		val dmem = Flipped(new DmemPortIo())

		val exit = Output(Bool())
	})

	// レジスタ実体
	val regfile = Mem(32, UInt(WORD_LEN.W))


	// IF -----------------------------------------------------

	// プログラムカウンタ
	val pc_reg = RegInit(START_ADDR)
	pc_reg := pc_reg + 4.U(WORD_LEN.W)

	// メモリから命令を受け取る
	io.imem.addr := pc_reg
	val inst = io.imem.inst

	// ID -----------------------------------------------------

	// 解読
	val rs1_addr = inst(19, 15)
	val rs2_addr = inst(24, 20)
	val wb_addr  = inst(11, 7)

	// レジスタデータ読み出し
	val rs1_data = Mux((rs1_addr =/= 0.U(WORD_LEN.U)), regfile(rs1_addr), 0.U(WORD_LEN.W))
	val rs2_data = Mux((rs2_addr =/= 0.U(WORD_LEN.U)), regfile(rs2_addr), 0.U(WORD_LEN.W))

	// LW命令の即値(I形式)
	val imm_i = inst(31, 20)
	val imm_i_sext = Cat(Fill(20, imm_i(11)), imm_i) // 符号拡張

	// EX -----------------------------------------------------

	// 演算結果格納
	val alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
		(inst === LW) -> (rs1_data + imm_i_sext)
	))

	// MEM -----------------------------------------------------

	// 演算結果（メモリアドレス）をメモリへ(LW)
	io.dmem.addr := alu_out

	// WB -----------------------------------------------------

	// LW結果を受け取り
	val wb_data = io.dmem.rdata
	when(inst === LW) {
		regfile(wb_addr) := wb_data
	}

	// 終了判定 -----------------------------------------------------

	io.exit := (inst === 0x14131211.U(WORD_LEN.W))

	// デバッグ -----------------------------------------------------

	printf(p"pc_reg(プログラムカウンタ): 0x${Hexadecimal(pc_reg)}\n")
	printf(p"inst(命令): 0x${Hexadecimal(inst)}\n")

	printf(p"rs1_addr(レジスタ１アドレス): $rs1_addr\n")
	printf(p"rs1_data(レジスタ１データ): 0x${Hexadecimal(rs1_data)}\n")

	printf(p"rs2_addr(レジスタ２アドレス): $rs2_addr\n")
	printf(p"rs2_data(レジスタ２データ): 0x${Hexadecimal(rs2_data)}\n")

	printf(p"wb_addr(書き込み先アドレス): $wb_addr\n")
	printf(p"dmem.addr(ロードしたいメモリアドレス): 0x${io.dmem.addr}\n")
	printf(p"wb_data(書き込みデータ 兼　ロードデータ): 0x${Hexadecimal(wb_data)}\n")

	printf("-----------------------------------------------------------\n")
}
