package decode

import chisel3._
import chisel3.util._

class Top extends Module {
	// 信号を生成
	val io = IO(new Bundle {
		val exit = Output(Bool())
	})

	// CoreクラスとMemoryクラスをnewでインスタンス化，Moduleでハードウェア化
	val core		= Module(new Core())
	val memory 		= Module(new Memory())

	// coreのioとmemoryのioはImemPortIoを反転した関係にあるので，"<>"で一括接続
	core.io.imem <> memory.io.imem

	// coreの出力をtopの出力に配線
	io.exit := core.io.exit
}