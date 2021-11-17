package pipeline_datahazard2

import chisel3._
import chisel3.util._
import common.Consts._
import chisel3.util.experimental.loadMemoryFromFile

class ImemPortIo extends Bundle {
  val addr = Input(UInt(WORD_LEN.W))
  val inst = Output(UInt(WORD_LEN.W))
  val valid = Output(Bool())
}

class DmemPortIo extends Bundle {
  val addr  = Input(UInt(WORD_LEN.W))
  val rdata = Output(UInt(WORD_LEN.W))
  val ren   = Input(Bool())
  val rvalid = Output(Bool())
  val wen   = Input(UInt(MEN_LEN.W))
  val wdata = Input(UInt(WORD_LEN.W))
}

class Memory extends Module {
  val io = IO(new Bundle {
    val imem = new ImemPortIo()
    val dmem = new DmemPortIo()
  })

  val instIsFirst = RegInit(true.B)
  val instAddr = io.imem.addr(WORD_LEN-1, 2)
  val instData = Wire(UInt(WORD_LEN.W))
  val instFetchedAddr = RegInit(0.U((WORD_LEN - 2).W))
  val instFetchingAddr = Wire(UInt((WORD_LEN - 2).W))
  val instValid = instFetchedAddr === instAddr && !instIsFirst

  instIsFirst := false.B
  io.imem.inst := instData
  io.imem.valid := instValid
  instFetchingAddr := Mux(instValid, instFetchedAddr + 1.U, instAddr)
  // instData := io.imemReadPort.data
  instFetchedAddr := instFetchingAddr

  val mem = Mem(16384, UInt(8.W))
  loadMemoryFromFile(mem, "src/riscv/rv32addsub.hex")
  instData := Cat(
    mem(io.imem.addr + 3.U(WORD_LEN.W)), 
    mem(io.imem.addr + 2.U(WORD_LEN.W)),
    mem(io.imem.addr + 1.U(WORD_LEN.W)),
    mem(io.imem.addr)
  )
  val rdata = RegInit(0.U(WORD_LEN.W))
  val rvalid = RegInit(false.B)
  io.dmem.rdata := rdata
  io.dmem.rvalid := rvalid
  rvalid := false.B
  when( !io.dmem.wen && io.dmem.ren ) {
    rdata := Cat(
      mem(io.dmem.addr + 3.U(WORD_LEN.W)),
      mem(io.dmem.addr + 2.U(WORD_LEN.W)), 
      mem(io.dmem.addr + 1.U(WORD_LEN.W)),
      mem(io.dmem.addr)
    )
    rvalid := true.B
  } 

  when(io.dmem.wen === MEN_S){
    mem(io.dmem.addr)                   := io.dmem.wdata( 7,  0)
    mem(io.dmem.addr + 1.U(WORD_LEN.W)) := io.dmem.wdata(15,  8)
    mem(io.dmem.addr + 2.U(WORD_LEN.W)) := io.dmem.wdata(23, 16)
    mem(io.dmem.addr + 3.U(WORD_LEN.W)) := io.dmem.wdata(31, 24)
  }
}