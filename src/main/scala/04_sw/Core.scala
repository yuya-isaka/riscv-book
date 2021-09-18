package lw

import chisel3._
import chisel3.util._
import common.Consts._
import common.Instructions._

class Core extends Module {
	// 信号を生成
	val io = IO(new Bundle {
		// ImemPortIoをインスタンス化したものをFlippedで反転
		val imem = Flipped(new ImemPortIo())
		val dmem = Flipped(new DmemPortIo())

		// プログラムが終わったらtrue.Bとなるよう設計
		val exit = Output(Bool())
	})

	// 32bit幅 x 32本 のレジスタを生成
	val regfile = Mem(32, UInt(WORD_LEN.W))

	// IF Stage -----------------------------------------------------

	// 初期値0のPCレジスタを生成
	// サイクルごとに4ずつカウントアップ
	val pc_reg = RegInit(START_ADDR)
	pc_reg := pc_reg + 4.U(WORD_LEN.W)

	// 出力ポートaddrにpc_regを接続
	io.imem.addr := pc_reg
	// 入力ポートinstを変数instで受け取る
	val inst = io.imem.inst

	// ID -----------------------------

	// レジスタ番号の解読
	val rs1_addr = inst(19, 15)	// 4bitで32本から選択
	val rs2_addr = inst(24, 20)
	val wb_addr  = inst(11, 7)

	// レジスタデータの読み出し
	val rs1_data = Mux((rs1_addr =/= 0.U(WORD_LEN.U)), regfile(rs1_addr), 0.U(WORD_LEN.W)) // 指定しているアドレスが0だったら0にする(マルチプレクサ)
	val rs2_data = Mux((rs2_addr =/= 0.U(WORD_LEN.U)), regfile(rs2_addr), 0.U(WORD_LEN.W))

	// LW命令はI形式
	val imm_i = inst(31, 20) // I形式の即値
	val imm_i_sext = Cat(Fill(20, imm_i(11)), imm_i) // imm_iの最上位ビットで符号拡張 // offsetの符号拡張

	// EX ----------------------------------------------------

	// 今回の計算結果はメモリアドレス
	val alu_out = MuxCase(0.U(WORD_LEN.W), Seq(
		// 現在実行する命令がLWのとき，メモリアドレスを返す
		(inst === LW) -> (rs1_data + imm_i_sext)
	))

	// Mem ---------------------------------------

	// メモリアドレスもLW命令時に限らず常時メモリへ出力する形で問題ない
	// when(inst === LW) {
	// 	io.dmem.addr := alu_out
	// }
	io.dmem.addr := alu_out

	// WB ------------------------------------------

	val wb_data = io.dmem.rdata
	when(inst === LW) {
		regfile(wb_addr) := wb_data
	}

	// 終了 ----------------------------

	// exit信号はinstが（読み込ませるプログラムの最終行）の場合にtrue.B
	io.exit := (inst === 0x14131211.U(WORD_LEN.W))


	// デバッグ --------------------------
	printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}\n")
	printf(p"inst  : 0x${Hexadecimal(inst)}\n")

	printf(p"rs1_addr: $rs1_addr\n")
	printf(p"rs2_addr: $rs2_addr\n")
	printf(p"wb_addr : $wb_addr\n")
	printf(p"rs1_data: 0x${Hexadecimal(rs1_data)}\n")
	printf(p"rs2_data: 0x${Hexadecimal(rs2_data)}\n")

	printf(p"wb_data: 0x${Hexadecimal(wb_data)}\n")
	printf(p"dmem.addr: 0x${io.dmem.addr}\n")

	printf("------------\n") // サイクルの切れ目
}
