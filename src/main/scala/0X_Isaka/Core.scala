package isaka

import chisel3._
import chisel3.util._

class Core extends Module {

	val io = IO(new Bundle {
		val imem = Flipped(new ImemPortIo())
		val dmem = Flipped(new DmemPortIo())

		val exit = Output(Bool())
	})

	val regfile = Mem(32, UInt(WORD_LEN.W))

	// IF
	val pc_reg = RegInit(0.U(WORD_LEN.W))
	pc_reg := pc_reg + 4.U(WORD_LEN.W)

	io.imem.addr := pc_reg
	val inst = io.imem.inst

	// exit
	io.exit := (inst === 0x34333231).U(WORD_LEN.W)

	// debug
	printf(p"pc_reg: 0x${Hexadecimal(pc_reg)}\n")
	printf(p"inst: 0x${Hexadecimal(inst)}\n")
	printf("-----------------------------------\n")
}