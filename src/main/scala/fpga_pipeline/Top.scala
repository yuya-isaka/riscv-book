package fpga_pipeline

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.stage.ChiselStage

class Top extends Module {
  val io = IO(new Bundle {
    val led = Output(UInt(WORD_LEN.W))
    // val exit = Output(Bool())
  })
  val core = Module(new Core())
  val memory = Module(new Memory())
  core.io.imem <> memory.io.imem
  core.io.dmem <> memory.io.dmem
  io.led   := core.io.led
  // io.exit := core.io.exit
}

object Elaborate extends App {
  (new ChiselStage).emitVerilog(new Top, Array(
    "-o", "riscv.v",
    "--target-dir", "rtl/riscv",
  ))
}