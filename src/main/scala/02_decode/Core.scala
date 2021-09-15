package decode

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

	// decode -----------------------------

	// レジスタ番号の解読
	val rs1_addr = inst(19, 15)	// 4bitで32本から選択
	val rs2_addr = inst(24, 20)
	val wb_addr  = inst(11, 7)

	// レジスタデータの読み出し
	val rs1_data = Mux((rs1_addr =/= 0.U(WORD_LEN.U)), regfile(rs1_addr), 0.U(WORD_LEN.W)) // 指定しているアドレスが0だったら0にする(マルチプレクサ)
	val rs2_data = Mux((rs2_addr =/= 0.U(WORD_LEN.U)), regfile(rs2_addr), 0.U(WORD_LEN.W))


	// 終了 ----------------------------

	// exit信号はinstが（読み込ませるプログラムの最終行）の場合にtrue.B
	io.exit := (inst === 0x34333231.U(WORD_LEN.W))


	// デバッグ --------------------------
	printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}\n")
	printf(p"inst  : 0x${Hexadecimal(inst)}\n")

	printf(p"rs1_addr: $rs1_addr\n")
	printf(p"rs2_addr: $rs2_addr\n")
	printf(p"wb_addr : $wb_addr\n")
	printf(p"rs1_data: 0x${Hexadecimal(rs1_data)}\n")
	printf(p"rs2_data: 0x${Hexadecimal(rs2_data)}\n")

	printf("------------\n") // サイクルの切れ目
}
