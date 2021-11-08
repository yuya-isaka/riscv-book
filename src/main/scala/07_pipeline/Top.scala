package ctest

import chisel3._
import chisel3.util._
import common.Consts._

class Top extends Module {

	val io = IO(new Bundle {
		val exit = Output(Bool())
		val gp = Output(UInt(WORD_LEN.W))
	})

	val core		= Module(new Core())
	val memory 		= Module(new Memory())

	core.io.imem <> memory.io.imem
	core.io.dmem <> memory.io.dmem

	io.exit := core.io.exit
	io.gp := core.io.gp

}

// パイプライン処理
// ・一つの命令をいくつかの段階に分割実行することで，複数の命令を並列実行する．
// ・スループットが増える．（単位時間あたりに処理できる量）
// ・レイテンシが減る．（レスポンスまでの遅延時間）

// CPU処理のパイプライン化
// ・単純には無理．（回路は概念的には分割されているが，物理的には一つの回路にまとまってしまっているので，各命令がどのステージまで進んだか識別できない）
// ・レジスタによるクロック同期回路で解決．（クロック立ち上がりエッジでの各ステージの出力をレジスタに記録する，確実に１サイクルで１ステージの処理を進められる．）
// ・細かくレジスタを経由すると処理速度は低下する？　パイプラインレジスタやその周辺の制御回路が増加する？
// ・１サイクルで処理すべき演算量が減る．したがってサイクル周期を短縮できる．＆　パイプライン処理でCPUのスループットは向上する． なので処理速度は低下しない．（回路規模は増加するが）
