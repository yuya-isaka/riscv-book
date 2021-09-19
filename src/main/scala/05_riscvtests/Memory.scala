package sw

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import common.Consts._

// memが重要

// 命令用ポート
class ImemPortIo extends Bundle {
	// 値のビット幅を指定できる（32）
	val addr = Input(UInt(WORD_LEN.W))
	val inst = Output(UInt(WORD_LEN.W))
}

// データ用ポート
class DmemPortIo extends Bundle {
	val addr = Input(UInt(WORD_LEN.W))
	val rdata = Output(UInt(WORD_LEN.W))

	val wen = Input(Bool())
	val wdata = Input(UInt(WORD_LEN.W))
}

// メモリ（アクセスに対応する値を返す）
class Memory extends Module {

	// 入出力
	val io = IO(new Bundle {
		val imem = new ImemPortIo()
		val dmem = new DmemPortIo()
	})

	// メモリ実体
	val mem = Mem(16384, UInt(8.W))
	loadMemoryFromFile(mem, "src/hex/sw.hex")

	// 出力値を設定
	io.imem.inst := Cat(
		mem(io.imem.addr + 3.U(WORD_LEN.W)),
		mem(io.imem.addr + 2.U(WORD_LEN.W)),
		mem(io.imem.addr + 1.U(WORD_LEN.W)),
		mem(io.imem.addr),
	)

	io.dmem.rdata := Cat(
		mem(io.dmem.addr + 3.U(WORD_LEN.W)),
		mem(io.dmem.addr + 2.U(WORD_LEN.W)),
		mem(io.dmem.addr + 1.U(WORD_LEN.W)),
		mem(io.dmem.addr),
	)

	when(io.dmem.wen) {
		mem(io.dmem.addr) := io.dmem.wdata(7, 0)
		mem(io.dmem.addr + 1.U) := io.dmem.wdata(15,8)
		mem(io.dmem.addr + 2.U) := io.dmem.wdata(23, 16)
		mem(io.dmem.addr + 3.U) := io.dmem.wdata(31, 24)
	}
}