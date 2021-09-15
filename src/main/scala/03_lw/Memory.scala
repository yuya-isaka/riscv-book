package lw

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import common.Consts._

// Bundleを継承する形で，２つの信号をまとめている．
// 命令用のCPU-メモリのポート
class ImemPortIo extends Bundle {
	// 値のビット幅を指定できる（32）
	val addr = Input(UInt(WORD_LEN.W))
	val inst = Output(UInt(WORD_LEN.W))
}

// データ用のCPU-メモリのポート
class DmemPortIo extends Bundle {
	val addr = Input(UInt(WORD_LEN.W))
	val rdata = Output(UInt(WORD_LEN.W))
}

class Memory extends Module {
	val io = IO(new Bundle {
		val imem = new ImemPortIo()
		val dmem = new DmemPortIo()
	})

	// メモリの実体（8bit幅 x 16384(16KB)のレジスタをメモリとして扱う）
	// メモリにアクセスするとき（mem(1)とか）は，メモリ上では8ビットごとに番地が指定される．
	val mem = Mem(16384, UInt(8.W))

	// ファイルからメモリデータをロード
	// loadMemoryFromFile(mem, "src/hex/fetch.hex")
	loadMemoryFromFile(mem, "src/hex/lw.hex")

	// リトルエンディアン？
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
}