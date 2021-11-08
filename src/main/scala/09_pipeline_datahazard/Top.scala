package pipeline_datahazard

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

// 分岐ハザード
// ・ジャンプ命令や分岐命令を実行したとき，前段のパイプラインステージで処理している命令が無効になる
// ・具体的には，EXステージで分岐先のアドレスを計算している場合，IF/IDで並列で計算している命令が，無意味になってしまう可能性（間違っている可能性がある）
// ・単純な解決策は，EXステージで次の命令が確定するまで，IF,IDをしないということだが，それだとパイプライン処理をする意味がなくなる
// ・分岐は発生しない可能性が高いと判断し，通常は後続の命令を処理して，分岐ハザードが発生するときは，IF,IDステージでの処理内容を無効化する．
// ・->このような方法を「常に分岐しないと予測する」静的分岐予測という．
// ・具体的には，分岐・ジャンプ命令をフェッチしても，次のサイクルでPC+4アドレスをフェッチする．（変えないということ）
// ・EXステージで分岐が成立した時だけ，無効化する．（停止することをパイプラインストールという．ストールにより無効化された命令はバブルと呼ばれる）

// データハザード
// ・命令間でデータ依存がある場合，依存先の命令処理が終わるまで処理を止める，ストールする必要がある状況がある．
// ・IDステージで読み取るデータが，EX/MEM/WBステージにおける書き込み先のデータと一緒の時，書き込まれる前にデータを読み出してしまうと，違う値を読み出してしまう．
// ・MEM/WBとのデータ依存は，MEMとWBで保存したレジスタライトバック予定の値を，直接貰えばいい（フォワーディング）
// ・EXとのデータ依存は，ライトバックデータがまだ決まってないから，フォワーディングできない．したがって，IFとIDステージを１サイクルだけストールする．
// ・１サイクルのストール後は，MEMステージでライトバックデータを算出してくれるから，それをフォワーディングすればいい．