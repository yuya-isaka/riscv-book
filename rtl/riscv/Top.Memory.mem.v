module BindsTo_0_Memory(
  input         clock,
  input         reset,
  input  [31:0] io_imem_addr,
  output [31:0] io_imem_inst,
  input  [31:0] io_dmem_addr,
  output [31:0] io_dmem_rdata,
  input         io_dmem_ren,
  output        io_dmem_rvalid,
  input  [1:0]  io_dmem_wen,
  input  [31:0] io_dmem_wdata
);

initial begin
  $readmemh("src/riscv/rv32ui-p-addi.hex", Memory.mem);
end
                      endmodule

bind Memory BindsTo_0_Memory BindsTo_0_Memory_Inst(.*);