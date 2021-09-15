package fetch

import chisel3._
import chisel3.util._
import common.Consts._

class Core extends Module {
	// 信号を生成
	val io = IO(new Bundle {
		// ImemPortIoをインスタンス化したものをFlippedで反転
		val imem = Flipped(new ImemPortIo())

		// プログラムが終わったらtrue.Bとなるよう設計
		val exit = Output(Bool())
	})

	// 32bit幅 x 32本 のレジスタを生成
	val regfile = Mem(32, UInt(WORD_LEN.W))

	// Instruction Fetch (IF) Stage

	// 初期値0のPCレジスタを生成
	// サイクルごとに4ずつカウントアップ
	val pc_reg = RegInit(START_ADDR)
	pc_reg := pc_reg + 4.U(WORD_LEN.W)

	// 出力ポートaddrにpc_regを接続
	io.imem.addr := pc_reg
	// 入力ポートinstを変数instで受け取る
	val inst = io.imem.inst


	// 終了 ----------------------------

	// exit信号はinstが（読み込ませるプログラムの最終行）の場合にtrue.B
	io.exit := (inst === 0x34333231.U(WORD_LEN.W))


	// デバッグ --------------------------
	printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}\n")
	printf(p"inst  : 0x${Hexadecimal(inst)}\n")

	printf("------------\n") // サイクルの切れ目
}
