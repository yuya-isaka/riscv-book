package ctest

import chisel3._
import chisel3.util._
import common.Consts._

// Topはハードウェア生成とポート接続
class Top extends Module {

	// 出力
	val io = IO(new Bundle {
		val exit = Output(Bool())
		val gp = Output(UInt(WORD_LEN.W))
	})

	// コアとメモリを生成
	val core		= Module(new Core())
	val memory 		= Module(new Memory())


	// 命令ポート接続
	core.io.imem <> memory.io.imem

	// データポート接続
	core.io.dmem <> memory.io.dmem

	// 出力値を設定
	io.exit := core.io.exit

	io.gp := core.io.gp
}