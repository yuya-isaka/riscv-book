module Core(
  input         clock,
  input         reset,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_inst,
  input         io_imem_valid,
  output [31:0] io_dmem_raddr,
  input  [31:0] io_dmem_rdata,
  output        io_dmem_ren,
  input         io_dmem_rvalid,
  output [31:0] io_dmem_waddr,
  output        io_dmem_wen,
  output [3:0]  io_dmem_wstrb,
  output [31:0] io_dmem_wdata,
  output        io_exit
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile [0:31]; // @[Core.scala 18:20]
  wire [31:0] regfile_id_rs1_data_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_id_rs1_data_MPORT_addr; // @[Core.scala 18:20]
  wire [31:0] regfile_id_rs2_data_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_id_rs2_data_MPORT_addr; // @[Core.scala 18:20]
  wire [31:0] regfile_io_gp_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_io_gp_MPORT_addr; // @[Core.scala 18:20]
  wire [31:0] regfile_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_MPORT_addr; // @[Core.scala 18:20]
  wire  regfile_MPORT_mask; // @[Core.scala 18:20]
  wire  regfile_MPORT_en; // @[Core.scala 18:20]
  reg [31:0] csr_trap_vector; // @[Core.scala 20:32]
  reg [31:0] id_reg_pc; // @[Core.scala 26:38]
  reg [31:0] id_reg_inst; // @[Core.scala 27:38]
  reg [31:0] exe_reg_pc; // @[Core.scala 30:38]
  reg [4:0] exe_reg_wb_addr; // @[Core.scala 31:38]
  reg [31:0] exe_reg_op1_data; // @[Core.scala 32:38]
  reg [31:0] exe_reg_op2_data; // @[Core.scala 33:38]
  reg [31:0] exe_reg_rs2_data; // @[Core.scala 34:38]
  reg [4:0] exe_reg_exe_fun; // @[Core.scala 35:38]
  reg [1:0] exe_reg_mem_wen; // @[Core.scala 36:38]
  reg [1:0] exe_reg_rf_wen; // @[Core.scala 37:38]
  reg [2:0] exe_reg_wb_sel; // @[Core.scala 38:38]
  reg [11:0] exe_reg_csr_addr; // @[Core.scala 39:38]
  reg [2:0] exe_reg_csr_cmd; // @[Core.scala 40:38]
  reg [31:0] exe_reg_imm_b_sext; // @[Core.scala 43:38]
  reg [31:0] exe_reg_mem_w; // @[Core.scala 46:38]
  reg  exe_is_ecall; // @[Core.scala 47:38]
  reg [31:0] mem_reg_pc; // @[Core.scala 50:38]
  reg [4:0] mem_reg_wb_addr; // @[Core.scala 51:38]
  reg [31:0] mem_reg_op1_data; // @[Core.scala 52:38]
  reg [31:0] mem_reg_rs2_data; // @[Core.scala 53:38]
  reg [1:0] mem_reg_mem_wen; // @[Core.scala 54:38]
  reg [1:0] mem_reg_rf_wen; // @[Core.scala 55:38]
  reg [2:0] mem_reg_wb_sel; // @[Core.scala 56:38]
  reg [11:0] mem_reg_csr_addr; // @[Core.scala 57:38]
  reg [2:0] mem_reg_csr_cmd; // @[Core.scala 58:38]
  reg [31:0] mem_reg_alu_out; // @[Core.scala 60:38]
  reg [31:0] mem_reg_mem_w; // @[Core.scala 61:38]
  reg [3:0] mem_reg_mem_wstrb; // @[Core.scala 62:38]
  reg [4:0] wb_reg_wb_addr; // @[Core.scala 64:38]
  reg [1:0] wb_reg_rf_wen; // @[Core.scala 65:38]
  reg [31:0] wb_reg_wb_data; // @[Core.scala 66:38]
  reg [31:0] if_reg_pc; // @[Core.scala 72:26]
  wire [31:0] if_inst = io_imem_valid ? io_imem_inst : 32'h13; // @[Core.scala 74:20]
  wire  _T_1 = ~reset; // @[Core.scala 75:9]
  wire [31:0] if_pc_plus4 = if_reg_pc + 32'h4; // @[Core.scala 83:31]
  wire  _if_pc_next_T_1 = 32'h73 == if_inst; // @[Core.scala 88:14]
  wire  _id_rs1_data_hazard_T = exe_reg_rf_wen == 2'h1; // @[Core.scala 112:44]
  wire [4:0] id_rs1_addr_b = id_reg_inst[19:15]; // @[Core.scala 108:34]
  wire  id_rs1_data_hazard = exe_reg_rf_wen == 2'h1 & id_rs1_addr_b != 5'h0 & id_rs1_addr_b == exe_reg_wb_addr; // @[Core.scala 112:82]
  wire [4:0] id_rs2_addr_b = id_reg_inst[24:20]; // @[Core.scala 109:34]
  wire  id_rs2_data_hazard = _id_rs1_data_hazard_T & id_rs2_addr_b != 5'h0 & id_rs2_addr_b == exe_reg_wb_addr; // @[Core.scala 113:82]
  wire  mem_stall_flg = io_dmem_ren & ~io_dmem_rvalid; // @[Core.scala 299:32]
  wire  stall_flg = id_rs1_data_hazard | id_rs2_data_hazard | mem_stall_flg; // @[Core.scala 114:57]
  wire  _if_pc_next_T_3 = stall_flg | ~io_imem_valid; // @[Core.scala 89:16]
  wire [31:0] _if_pc_next_T_4 = _if_pc_next_T_3 ? if_reg_pc : if_pc_plus4; // @[Mux.scala 98:16]
  wire  exe_jmp_flg = exe_reg_wb_sel == 3'h2; // @[Core.scala 266:34]
  wire  _exe_alu_out_T = exe_reg_exe_fun == 5'h1; // @[Core.scala 241:22]
  wire [31:0] _exe_alu_out_T_2 = exe_reg_op1_data + exe_reg_op2_data; // @[Core.scala 241:58]
  wire  _exe_alu_out_T_3 = exe_reg_exe_fun == 5'h2; // @[Core.scala 242:22]
  wire [31:0] _exe_alu_out_T_5 = exe_reg_op1_data - exe_reg_op2_data; // @[Core.scala 242:58]
  wire  _exe_alu_out_T_6 = exe_reg_exe_fun == 5'h3; // @[Core.scala 243:22]
  wire [31:0] _exe_alu_out_T_7 = exe_reg_op1_data & exe_reg_op2_data; // @[Core.scala 243:58]
  wire  _exe_alu_out_T_8 = exe_reg_exe_fun == 5'h4; // @[Core.scala 244:22]
  wire [31:0] _exe_alu_out_T_9 = exe_reg_op1_data | exe_reg_op2_data; // @[Core.scala 244:58]
  wire  _exe_alu_out_T_10 = exe_reg_exe_fun == 5'h5; // @[Core.scala 245:22]
  wire [31:0] _exe_alu_out_T_11 = exe_reg_op1_data ^ exe_reg_op2_data; // @[Core.scala 245:58]
  wire  _exe_alu_out_T_12 = exe_reg_exe_fun == 5'h6; // @[Core.scala 246:22]
  wire [62:0] _GEN_38 = {{31'd0}, exe_reg_op1_data}; // @[Core.scala 246:58]
  wire [62:0] _exe_alu_out_T_14 = _GEN_38 << exe_reg_op2_data[4:0]; // @[Core.scala 246:58]
  wire  _exe_alu_out_T_16 = exe_reg_exe_fun == 5'h7; // @[Core.scala 247:22]
  wire [31:0] _exe_alu_out_T_18 = exe_reg_op1_data >> exe_reg_op2_data[4:0]; // @[Core.scala 247:58]
  wire  _exe_alu_out_T_19 = exe_reg_exe_fun == 5'h8; // @[Core.scala 248:22]
  wire [31:0] _exe_alu_out_T_23 = $signed(exe_reg_op1_data) >>> exe_reg_op2_data[4:0]; // @[Core.scala 248:100]
  wire  _exe_alu_out_T_24 = exe_reg_exe_fun == 5'h9; // @[Core.scala 249:22]
  wire  _exe_alu_out_T_27 = $signed(exe_reg_op1_data) < $signed(exe_reg_op2_data); // @[Core.scala 249:67]
  wire  _exe_alu_out_T_28 = exe_reg_exe_fun == 5'ha; // @[Core.scala 250:22]
  wire  _exe_alu_out_T_29 = exe_reg_op1_data < exe_reg_op2_data; // @[Core.scala 250:58]
  wire  _exe_alu_out_T_30 = exe_reg_exe_fun == 5'h11; // @[Core.scala 251:22]
  wire [31:0] _exe_alu_out_T_34 = _exe_alu_out_T_2 & 32'hfffffffe; // @[Core.scala 251:79]
  wire  _exe_alu_out_T_35 = exe_reg_exe_fun == 5'h12; // @[Core.scala 252:22]
  wire [31:0] _exe_alu_out_T_36 = _exe_alu_out_T_35 ? exe_reg_op1_data : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_37 = _exe_alu_out_T_30 ? _exe_alu_out_T_34 : _exe_alu_out_T_36; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_38 = _exe_alu_out_T_28 ? {{31'd0}, _exe_alu_out_T_29} : _exe_alu_out_T_37; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_39 = _exe_alu_out_T_24 ? {{31'd0}, _exe_alu_out_T_27} : _exe_alu_out_T_38; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_40 = _exe_alu_out_T_19 ? _exe_alu_out_T_23 : _exe_alu_out_T_39; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_41 = _exe_alu_out_T_16 ? _exe_alu_out_T_18 : _exe_alu_out_T_40; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_42 = _exe_alu_out_T_12 ? _exe_alu_out_T_14[31:0] : _exe_alu_out_T_41; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_43 = _exe_alu_out_T_10 ? _exe_alu_out_T_11 : _exe_alu_out_T_42; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_44 = _exe_alu_out_T_8 ? _exe_alu_out_T_9 : _exe_alu_out_T_43; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_45 = _exe_alu_out_T_6 ? _exe_alu_out_T_7 : _exe_alu_out_T_44; // @[Mux.scala 98:16]
  wire [31:0] _exe_alu_out_T_46 = _exe_alu_out_T_3 ? _exe_alu_out_T_5 : _exe_alu_out_T_45; // @[Mux.scala 98:16]
  wire [31:0] exe_alu_out = _exe_alu_out_T ? _exe_alu_out_T_2 : _exe_alu_out_T_46; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T = exe_reg_exe_fun == 5'hb; // @[Core.scala 257:22]
  wire  _exe_br_flg_T_1 = exe_reg_op1_data == exe_reg_op2_data; // @[Core.scala 257:57]
  wire  _exe_br_flg_T_2 = exe_reg_exe_fun == 5'hc; // @[Core.scala 258:22]
  wire  _exe_br_flg_T_4 = ~_exe_br_flg_T_1; // @[Core.scala 258:38]
  wire  _exe_br_flg_T_5 = exe_reg_exe_fun == 5'hd; // @[Core.scala 259:22]
  wire  _exe_br_flg_T_9 = exe_reg_exe_fun == 5'he; // @[Core.scala 260:22]
  wire  _exe_br_flg_T_13 = ~_exe_alu_out_T_27; // @[Core.scala 260:38]
  wire  _exe_br_flg_T_14 = exe_reg_exe_fun == 5'hf; // @[Core.scala 261:22]
  wire  _exe_br_flg_T_16 = exe_reg_exe_fun == 5'h10; // @[Core.scala 262:22]
  wire  _exe_br_flg_T_18 = ~_exe_alu_out_T_29; // @[Core.scala 262:38]
  wire  _exe_br_flg_T_20 = _exe_br_flg_T_14 ? _exe_alu_out_T_29 : _exe_br_flg_T_16 & _exe_br_flg_T_18; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_21 = _exe_br_flg_T_9 ? _exe_br_flg_T_13 : _exe_br_flg_T_20; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_22 = _exe_br_flg_T_5 ? _exe_alu_out_T_27 : _exe_br_flg_T_21; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_23 = _exe_br_flg_T_2 ? _exe_br_flg_T_4 : _exe_br_flg_T_22; // @[Mux.scala 98:16]
  wire  exe_br_flg = _exe_br_flg_T ? _exe_br_flg_T_1 : _exe_br_flg_T_23; // @[Mux.scala 98:16]
  wire [31:0] exe_br_target = exe_reg_pc + exe_reg_imm_b_sext; // @[Core.scala 264:31]
  wire  _id_reg_inst_T = exe_br_flg | exe_jmp_flg; // @[Core.scala 99:17]
  wire [31:0] id_inst = _id_reg_inst_T | stall_flg ? 32'h13 : id_reg_inst; // @[Core.scala 117:20]
  wire [4:0] id_rs1_addr = id_inst[19:15]; // @[Core.scala 119:28]
  wire [4:0] id_rs2_addr = id_inst[24:20]; // @[Core.scala 120:28]
  wire [4:0] id_wb_addr = id_inst[11:7]; // @[Core.scala 121:28]
  wire  _id_rs1_data_T = id_rs1_addr == 5'h0; // @[Core.scala 125:18]
  wire  _id_rs1_data_T_2 = mem_reg_rf_wen == 2'h1; // @[Core.scala 126:59]
  wire  _id_rs1_data_T_3 = id_rs1_addr == mem_reg_wb_addr & mem_reg_rf_wen == 2'h1; // @[Core.scala 126:40]
  wire  _id_rs1_data_T_5 = wb_reg_rf_wen == 2'h1; // @[Core.scala 127:59]
  wire  _id_rs1_data_T_6 = id_rs1_addr == wb_reg_wb_addr & wb_reg_rf_wen == 2'h1; // @[Core.scala 127:40]
  wire [31:0] _id_rs1_data_T_7 = _id_rs1_data_T_6 ? wb_reg_wb_data : regfile_id_rs1_data_MPORT_data; // @[Mux.scala 98:16]
  wire  _mem_wb_data_T = mem_reg_wb_sel == 3'h1; // @[Core.scala 334:21]
  wire  _mem_wb_data_load_T = mem_reg_mem_w == 32'h3; // @[Core.scala 327:20]
  wire [1:0] mem_wb_byte_offset = mem_reg_alu_out[1:0]; // @[Core.scala 324:43]
  wire [5:0] _mem_wb_rdata_T = 4'h8 * mem_wb_byte_offset; // @[Core.scala 325:44]
  wire [31:0] mem_wb_rdata = io_dmem_rdata >> _mem_wb_rdata_T; // @[Core.scala 325:36]
  wire [23:0] _mem_wb_data_load_T_3 = mem_wb_rdata[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _mem_wb_data_load_T_5 = {_mem_wb_data_load_T_3,mem_wb_rdata[7:0]}; // @[Core.scala 318:40]
  wire  _mem_wb_data_load_T_6 = mem_reg_mem_w == 32'h2; // @[Core.scala 328:20]
  wire [15:0] _mem_wb_data_load_T_9 = mem_wb_rdata[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _mem_wb_data_load_T_11 = {_mem_wb_data_load_T_9,mem_wb_rdata[15:0]}; // @[Core.scala 318:40]
  wire  _mem_wb_data_load_T_12 = mem_reg_mem_w == 32'h5; // @[Core.scala 329:20]
  wire [31:0] _mem_wb_data_load_T_15 = {24'h0,mem_wb_rdata[7:0]}; // @[Core.scala 321:31]
  wire  _mem_wb_data_load_T_16 = mem_reg_mem_w == 32'h4; // @[Core.scala 330:20]
  wire [31:0] _mem_wb_data_load_T_19 = {16'h0,mem_wb_rdata[15:0]}; // @[Core.scala 321:31]
  wire [31:0] _mem_wb_data_load_T_20 = _mem_wb_data_load_T_16 ? _mem_wb_data_load_T_19 : mem_wb_rdata; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_load_T_21 = _mem_wb_data_load_T_12 ? _mem_wb_data_load_T_15 : _mem_wb_data_load_T_20; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_load_T_22 = _mem_wb_data_load_T_6 ? _mem_wb_data_load_T_11 : _mem_wb_data_load_T_21; // @[Mux.scala 98:16]
  wire [31:0] mem_wb_data_load = _mem_wb_data_load_T ? _mem_wb_data_load_T_5 : _mem_wb_data_load_T_22; // @[Mux.scala 98:16]
  wire  _mem_wb_data_T_1 = mem_reg_wb_sel == 3'h2; // @[Core.scala 335:21]
  wire [31:0] _mem_wb_data_T_3 = mem_reg_pc + 32'h4; // @[Core.scala 335:48]
  wire  _mem_wb_data_T_4 = mem_reg_wb_sel == 3'h3; // @[Core.scala 336:21]
  wire  _csr_rdata_T = mem_reg_csr_addr == 12'h305; // @[Core.scala 302:40]
  wire [31:0] csr_rdata = mem_reg_csr_addr == 12'h305 ? csr_trap_vector : 32'h0; // @[Core.scala 302:22]
  wire [31:0] _mem_wb_data_T_5 = _mem_wb_data_T_4 ? csr_rdata : mem_reg_alu_out; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_T_6 = _mem_wb_data_T_1 ? _mem_wb_data_T_3 : _mem_wb_data_T_5; // @[Mux.scala 98:16]
  wire [31:0] mem_wb_data = _mem_wb_data_T ? mem_wb_data_load : _mem_wb_data_T_6; // @[Mux.scala 98:16]
  wire [31:0] _id_rs1_data_T_8 = _id_rs1_data_T_3 ? mem_wb_data : _id_rs1_data_T_7; // @[Mux.scala 98:16]
  wire [31:0] id_rs1_data = _id_rs1_data_T ? 32'h0 : _id_rs1_data_T_8; // @[Mux.scala 98:16]
  wire  _id_rs2_data_T = id_rs2_addr == 5'h0; // @[Core.scala 130:18]
  wire  _id_rs2_data_T_3 = id_rs2_addr == mem_reg_wb_addr & _id_rs1_data_T_2; // @[Core.scala 131:40]
  wire  _id_rs2_data_T_6 = id_rs2_addr == wb_reg_wb_addr & _id_rs1_data_T_5; // @[Core.scala 132:40]
  wire [31:0] _id_rs2_data_T_7 = _id_rs2_data_T_6 ? wb_reg_wb_data : regfile_id_rs2_data_MPORT_data; // @[Mux.scala 98:16]
  wire [31:0] _id_rs2_data_T_8 = _id_rs2_data_T_3 ? mem_wb_data : _id_rs2_data_T_7; // @[Mux.scala 98:16]
  wire [31:0] id_rs2_data = _id_rs2_data_T ? 32'h0 : _id_rs2_data_T_8; // @[Mux.scala 98:16]
  wire [11:0] id_imm_i = id_inst[31:20]; // @[Core.scala 135:25]
  wire [19:0] id_imm_i_sext_hi = id_imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_i_sext = {id_imm_i_sext_hi,id_imm_i}; // @[Cat.scala 30:58]
  wire [6:0] id_imm_s_hi = id_inst[31:25]; // @[Core.scala 137:29]
  wire [11:0] id_imm_s = {id_imm_s_hi,id_wb_addr}; // @[Cat.scala 30:58]
  wire [19:0] id_imm_s_sext_hi = id_imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_s_sext = {id_imm_s_sext_hi,id_imm_s_hi,id_wb_addr}; // @[Cat.scala 30:58]
  wire  id_imm_b_hi_hi = id_inst[31]; // @[Core.scala 139:29]
  wire  id_imm_b_hi_lo = id_inst[7]; // @[Core.scala 139:42]
  wire [5:0] id_imm_b_lo_hi = id_inst[30:25]; // @[Core.scala 139:54]
  wire [3:0] id_imm_b_lo_lo = id_inst[11:8]; // @[Core.scala 139:71]
  wire [11:0] id_imm_b = {id_imm_b_hi_hi,id_imm_b_hi_lo,id_imm_b_lo_hi,id_imm_b_lo_lo}; // @[Cat.scala 30:58]
  wire [18:0] id_imm_b_sext_hi_hi = id_imm_b[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_b_sext = {id_imm_b_sext_hi_hi,id_imm_b_hi_hi,id_imm_b_hi_lo,id_imm_b_lo_hi,id_imm_b_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [7:0] id_imm_j_hi_lo = id_inst[19:12]; // @[Core.scala 141:42]
  wire  id_imm_j_lo_hi = id_inst[20]; // @[Core.scala 141:59]
  wire [9:0] id_imm_j_lo_lo = id_inst[30:21]; // @[Core.scala 141:72]
  wire [19:0] id_imm_j = {id_imm_b_hi_hi,id_imm_j_hi_lo,id_imm_j_lo_hi,id_imm_j_lo_lo}; // @[Cat.scala 30:58]
  wire [10:0] id_imm_j_sext_hi_hi = id_imm_j[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_j_sext = {id_imm_j_sext_hi_hi,id_imm_b_hi_hi,id_imm_j_hi_lo,id_imm_j_lo_hi,id_imm_j_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [19:0] id_imm_u = id_inst[31:12]; // @[Core.scala 143:25]
  wire [31:0] id_imm_u_shifted = {id_imm_u,12'h0}; // @[Cat.scala 30:58]
  wire [31:0] id_imm_z_uext = {27'h0,id_rs1_addr}; // @[Cat.scala 30:58]
  wire [31:0] _csignals_T = id_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_1 = 32'h3 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h4003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_5 = 32'h23 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_7 = 32'h1003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_9 = 32'h5003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_11 = 32'h1023 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_13 = 32'h2003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_15 = 32'h2023 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_16 = id_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_17 = 32'h33 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_19 = 32'h13 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_21 = 32'h40000033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_23 = 32'h7033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_25 = 32'h6033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_27 = 32'h4033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_29 = 32'h7013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_31 = 32'h6013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_33 = 32'h4013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_35 = 32'h1033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_37 = 32'h5033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_39 = 32'h40005033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_41 = 32'h1013 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_43 = 32'h5013 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_45 = 32'h40005013 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_47 = 32'h2033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_49 = 32'h3033 == _csignals_T_16; // @[Lookup.scala 31:38]
  wire  _csignals_T_51 = 32'h2013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_53 = 32'h3013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_55 = 32'h63 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_57 = 32'h1063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_59 = 32'h5063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_61 = 32'h7063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_63 = 32'h4063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_65 = 32'h6063 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_66 = id_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _csignals_T_67 = 32'h6f == _csignals_T_66; // @[Lookup.scala 31:38]
  wire  _csignals_T_69 = 32'h67 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_71 = 32'h37 == _csignals_T_66; // @[Lookup.scala 31:38]
  wire  _csignals_T_73 = 32'h17 == _csignals_T_66; // @[Lookup.scala 31:38]
  wire  _csignals_T_75 = 32'h1073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_77 = 32'h5073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_79 = 32'h2073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_81 = 32'h6073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_83 = 32'h3073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_85 = 32'h7073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_87 = 32'h73 == id_inst; // @[Lookup.scala 31:38]
  wire [4:0] _csignals_T_89 = _csignals_T_85 ? 5'h12 : 5'h0; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_90 = _csignals_T_83 ? 5'h12 : _csignals_T_89; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_91 = _csignals_T_81 ? 5'h12 : _csignals_T_90; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_92 = _csignals_T_79 ? 5'h12 : _csignals_T_91; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_93 = _csignals_T_77 ? 5'h12 : _csignals_T_92; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_94 = _csignals_T_75 ? 5'h12 : _csignals_T_93; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_95 = _csignals_T_73 ? 5'h1 : _csignals_T_94; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_96 = _csignals_T_71 ? 5'h1 : _csignals_T_95; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_97 = _csignals_T_69 ? 5'h11 : _csignals_T_96; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_98 = _csignals_T_67 ? 5'h1 : _csignals_T_97; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_99 = _csignals_T_65 ? 5'hf : _csignals_T_98; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_100 = _csignals_T_63 ? 5'hd : _csignals_T_99; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_101 = _csignals_T_61 ? 5'h10 : _csignals_T_100; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_102 = _csignals_T_59 ? 5'he : _csignals_T_101; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_103 = _csignals_T_57 ? 5'hc : _csignals_T_102; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_104 = _csignals_T_55 ? 5'hb : _csignals_T_103; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_105 = _csignals_T_53 ? 5'ha : _csignals_T_104; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_106 = _csignals_T_51 ? 5'h9 : _csignals_T_105; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_107 = _csignals_T_49 ? 5'ha : _csignals_T_106; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_108 = _csignals_T_47 ? 5'h9 : _csignals_T_107; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_109 = _csignals_T_45 ? 5'h8 : _csignals_T_108; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_110 = _csignals_T_43 ? 5'h7 : _csignals_T_109; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_111 = _csignals_T_41 ? 5'h6 : _csignals_T_110; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_112 = _csignals_T_39 ? 5'h8 : _csignals_T_111; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_113 = _csignals_T_37 ? 5'h7 : _csignals_T_112; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_114 = _csignals_T_35 ? 5'h6 : _csignals_T_113; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_115 = _csignals_T_33 ? 5'h5 : _csignals_T_114; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_116 = _csignals_T_31 ? 5'h4 : _csignals_T_115; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_117 = _csignals_T_29 ? 5'h3 : _csignals_T_116; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_118 = _csignals_T_27 ? 5'h5 : _csignals_T_117; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_119 = _csignals_T_25 ? 5'h4 : _csignals_T_118; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_120 = _csignals_T_23 ? 5'h3 : _csignals_T_119; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_121 = _csignals_T_21 ? 5'h2 : _csignals_T_120; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_122 = _csignals_T_19 ? 5'h1 : _csignals_T_121; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_123 = _csignals_T_17 ? 5'h1 : _csignals_T_122; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_124 = _csignals_T_15 ? 5'h1 : _csignals_T_123; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_125 = _csignals_T_13 ? 5'h1 : _csignals_T_124; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_126 = _csignals_T_11 ? 5'h1 : _csignals_T_125; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_127 = _csignals_T_9 ? 5'h1 : _csignals_T_126; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_128 = _csignals_T_7 ? 5'h1 : _csignals_T_127; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_129 = _csignals_T_5 ? 5'h1 : _csignals_T_128; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_131 = _csignals_T_87 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_132 = _csignals_T_85 ? 2'h3 : _csignals_T_131; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_133 = _csignals_T_83 ? 2'h0 : _csignals_T_132; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_134 = _csignals_T_81 ? 2'h3 : _csignals_T_133; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_135 = _csignals_T_79 ? 2'h0 : _csignals_T_134; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_136 = _csignals_T_77 ? 2'h3 : _csignals_T_135; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_137 = _csignals_T_75 ? 2'h0 : _csignals_T_136; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_138 = _csignals_T_73 ? 2'h1 : _csignals_T_137; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_139 = _csignals_T_71 ? 2'h2 : _csignals_T_138; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_140 = _csignals_T_69 ? 2'h0 : _csignals_T_139; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_141 = _csignals_T_67 ? 2'h1 : _csignals_T_140; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_142 = _csignals_T_65 ? 2'h0 : _csignals_T_141; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_143 = _csignals_T_63 ? 2'h0 : _csignals_T_142; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_144 = _csignals_T_61 ? 2'h0 : _csignals_T_143; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_145 = _csignals_T_59 ? 2'h0 : _csignals_T_144; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_146 = _csignals_T_57 ? 2'h0 : _csignals_T_145; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_147 = _csignals_T_55 ? 2'h0 : _csignals_T_146; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_148 = _csignals_T_53 ? 2'h0 : _csignals_T_147; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_149 = _csignals_T_51 ? 2'h0 : _csignals_T_148; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_150 = _csignals_T_49 ? 2'h0 : _csignals_T_149; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_151 = _csignals_T_47 ? 2'h0 : _csignals_T_150; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_152 = _csignals_T_45 ? 2'h0 : _csignals_T_151; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_153 = _csignals_T_43 ? 2'h0 : _csignals_T_152; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_154 = _csignals_T_41 ? 2'h0 : _csignals_T_153; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_155 = _csignals_T_39 ? 2'h0 : _csignals_T_154; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_156 = _csignals_T_37 ? 2'h0 : _csignals_T_155; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_157 = _csignals_T_35 ? 2'h0 : _csignals_T_156; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_158 = _csignals_T_33 ? 2'h0 : _csignals_T_157; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_159 = _csignals_T_31 ? 2'h0 : _csignals_T_158; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_160 = _csignals_T_29 ? 2'h0 : _csignals_T_159; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_161 = _csignals_T_27 ? 2'h0 : _csignals_T_160; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_162 = _csignals_T_25 ? 2'h0 : _csignals_T_161; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_163 = _csignals_T_23 ? 2'h0 : _csignals_T_162; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_164 = _csignals_T_21 ? 2'h0 : _csignals_T_163; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_165 = _csignals_T_19 ? 2'h0 : _csignals_T_164; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_166 = _csignals_T_17 ? 2'h0 : _csignals_T_165; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_167 = _csignals_T_15 ? 2'h0 : _csignals_T_166; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_168 = _csignals_T_13 ? 2'h0 : _csignals_T_167; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_169 = _csignals_T_11 ? 2'h0 : _csignals_T_168; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_170 = _csignals_T_9 ? 2'h0 : _csignals_T_169; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_171 = _csignals_T_7 ? 2'h0 : _csignals_T_170; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_172 = _csignals_T_5 ? 2'h0 : _csignals_T_171; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_173 = _csignals_T_3 ? 2'h0 : _csignals_T_172; // @[Lookup.scala 33:37]
  wire [1:0] csignals_1 = _csignals_T_1 ? 2'h0 : _csignals_T_173; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_174 = _csignals_T_87 ? 3'h0 : 3'h1; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_175 = _csignals_T_85 ? 3'h0 : _csignals_T_174; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_176 = _csignals_T_83 ? 3'h0 : _csignals_T_175; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_177 = _csignals_T_81 ? 3'h0 : _csignals_T_176; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_178 = _csignals_T_79 ? 3'h0 : _csignals_T_177; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_179 = _csignals_T_77 ? 3'h0 : _csignals_T_178; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_180 = _csignals_T_75 ? 3'h0 : _csignals_T_179; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_181 = _csignals_T_73 ? 3'h5 : _csignals_T_180; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_182 = _csignals_T_71 ? 3'h5 : _csignals_T_181; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_183 = _csignals_T_69 ? 3'h2 : _csignals_T_182; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_184 = _csignals_T_67 ? 3'h4 : _csignals_T_183; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_185 = _csignals_T_65 ? 3'h1 : _csignals_T_184; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_186 = _csignals_T_63 ? 3'h1 : _csignals_T_185; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_187 = _csignals_T_61 ? 3'h1 : _csignals_T_186; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_188 = _csignals_T_59 ? 3'h1 : _csignals_T_187; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_189 = _csignals_T_57 ? 3'h1 : _csignals_T_188; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_190 = _csignals_T_55 ? 3'h1 : _csignals_T_189; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_191 = _csignals_T_53 ? 3'h2 : _csignals_T_190; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_192 = _csignals_T_51 ? 3'h2 : _csignals_T_191; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_193 = _csignals_T_49 ? 3'h1 : _csignals_T_192; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_194 = _csignals_T_47 ? 3'h1 : _csignals_T_193; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_195 = _csignals_T_45 ? 3'h2 : _csignals_T_194; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_196 = _csignals_T_43 ? 3'h2 : _csignals_T_195; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_197 = _csignals_T_41 ? 3'h2 : _csignals_T_196; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_198 = _csignals_T_39 ? 3'h1 : _csignals_T_197; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_199 = _csignals_T_37 ? 3'h1 : _csignals_T_198; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_200 = _csignals_T_35 ? 3'h1 : _csignals_T_199; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_201 = _csignals_T_33 ? 3'h2 : _csignals_T_200; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_202 = _csignals_T_31 ? 3'h2 : _csignals_T_201; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_203 = _csignals_T_29 ? 3'h2 : _csignals_T_202; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_204 = _csignals_T_27 ? 3'h1 : _csignals_T_203; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_205 = _csignals_T_25 ? 3'h1 : _csignals_T_204; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_206 = _csignals_T_23 ? 3'h1 : _csignals_T_205; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_207 = _csignals_T_21 ? 3'h1 : _csignals_T_206; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_208 = _csignals_T_19 ? 3'h2 : _csignals_T_207; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_209 = _csignals_T_17 ? 3'h1 : _csignals_T_208; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_210 = _csignals_T_15 ? 3'h3 : _csignals_T_209; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_211 = _csignals_T_13 ? 3'h2 : _csignals_T_210; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_212 = _csignals_T_11 ? 3'h3 : _csignals_T_211; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_213 = _csignals_T_9 ? 3'h2 : _csignals_T_212; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_214 = _csignals_T_7 ? 3'h2 : _csignals_T_213; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_215 = _csignals_T_5 ? 3'h3 : _csignals_T_214; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_216 = _csignals_T_3 ? 3'h2 : _csignals_T_215; // @[Lookup.scala 33:37]
  wire [2:0] csignals_2 = _csignals_T_1 ? 3'h2 : _csignals_T_216; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_253 = _csignals_T_15 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_254 = _csignals_T_13 ? 2'h0 : _csignals_T_253; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_255 = _csignals_T_11 ? 2'h1 : _csignals_T_254; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_256 = _csignals_T_9 ? 2'h0 : _csignals_T_255; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_257 = _csignals_T_7 ? 2'h0 : _csignals_T_256; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_258 = _csignals_T_5 ? 2'h1 : _csignals_T_257; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_261 = _csignals_T_85 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_262 = _csignals_T_83 ? 2'h1 : _csignals_T_261; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_263 = _csignals_T_81 ? 2'h1 : _csignals_T_262; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_264 = _csignals_T_79 ? 2'h1 : _csignals_T_263; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_265 = _csignals_T_77 ? 2'h1 : _csignals_T_264; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_266 = _csignals_T_75 ? 2'h1 : _csignals_T_265; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_267 = _csignals_T_73 ? 2'h1 : _csignals_T_266; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_268 = _csignals_T_71 ? 2'h1 : _csignals_T_267; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_269 = _csignals_T_69 ? 2'h1 : _csignals_T_268; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_270 = _csignals_T_67 ? 2'h1 : _csignals_T_269; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_271 = _csignals_T_65 ? 2'h0 : _csignals_T_270; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_272 = _csignals_T_63 ? 2'h0 : _csignals_T_271; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_273 = _csignals_T_61 ? 2'h0 : _csignals_T_272; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_274 = _csignals_T_59 ? 2'h0 : _csignals_T_273; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_275 = _csignals_T_57 ? 2'h0 : _csignals_T_274; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_276 = _csignals_T_55 ? 2'h0 : _csignals_T_275; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_277 = _csignals_T_53 ? 2'h1 : _csignals_T_276; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_278 = _csignals_T_51 ? 2'h1 : _csignals_T_277; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_279 = _csignals_T_49 ? 2'h1 : _csignals_T_278; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_280 = _csignals_T_47 ? 2'h1 : _csignals_T_279; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_281 = _csignals_T_45 ? 2'h1 : _csignals_T_280; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_282 = _csignals_T_43 ? 2'h1 : _csignals_T_281; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_283 = _csignals_T_41 ? 2'h1 : _csignals_T_282; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_284 = _csignals_T_39 ? 2'h1 : _csignals_T_283; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_285 = _csignals_T_37 ? 2'h1 : _csignals_T_284; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_286 = _csignals_T_35 ? 2'h1 : _csignals_T_285; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_287 = _csignals_T_33 ? 2'h1 : _csignals_T_286; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_288 = _csignals_T_31 ? 2'h1 : _csignals_T_287; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_289 = _csignals_T_29 ? 2'h1 : _csignals_T_288; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_290 = _csignals_T_27 ? 2'h1 : _csignals_T_289; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_291 = _csignals_T_25 ? 2'h1 : _csignals_T_290; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_292 = _csignals_T_23 ? 2'h1 : _csignals_T_291; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_293 = _csignals_T_21 ? 2'h1 : _csignals_T_292; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_294 = _csignals_T_19 ? 2'h1 : _csignals_T_293; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_295 = _csignals_T_17 ? 2'h1 : _csignals_T_294; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_296 = _csignals_T_15 ? 2'h0 : _csignals_T_295; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_297 = _csignals_T_13 ? 2'h1 : _csignals_T_296; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_298 = _csignals_T_11 ? 2'h0 : _csignals_T_297; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_299 = _csignals_T_9 ? 2'h1 : _csignals_T_298; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_300 = _csignals_T_7 ? 2'h1 : _csignals_T_299; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_301 = _csignals_T_5 ? 2'h0 : _csignals_T_300; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_304 = _csignals_T_85 ? 3'h3 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_305 = _csignals_T_83 ? 3'h3 : _csignals_T_304; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_306 = _csignals_T_81 ? 3'h3 : _csignals_T_305; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_307 = _csignals_T_79 ? 3'h3 : _csignals_T_306; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_308 = _csignals_T_77 ? 3'h3 : _csignals_T_307; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_309 = _csignals_T_75 ? 3'h3 : _csignals_T_308; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_310 = _csignals_T_73 ? 3'h0 : _csignals_T_309; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_311 = _csignals_T_71 ? 3'h0 : _csignals_T_310; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_312 = _csignals_T_69 ? 3'h2 : _csignals_T_311; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_313 = _csignals_T_67 ? 3'h2 : _csignals_T_312; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_314 = _csignals_T_65 ? 3'h0 : _csignals_T_313; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_315 = _csignals_T_63 ? 3'h0 : _csignals_T_314; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_316 = _csignals_T_61 ? 3'h0 : _csignals_T_315; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_317 = _csignals_T_59 ? 3'h0 : _csignals_T_316; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_318 = _csignals_T_57 ? 3'h0 : _csignals_T_317; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_319 = _csignals_T_55 ? 3'h0 : _csignals_T_318; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_320 = _csignals_T_53 ? 3'h0 : _csignals_T_319; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_321 = _csignals_T_51 ? 3'h0 : _csignals_T_320; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_322 = _csignals_T_49 ? 3'h0 : _csignals_T_321; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_323 = _csignals_T_47 ? 3'h0 : _csignals_T_322; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_324 = _csignals_T_45 ? 3'h0 : _csignals_T_323; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_325 = _csignals_T_43 ? 3'h0 : _csignals_T_324; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_326 = _csignals_T_41 ? 3'h0 : _csignals_T_325; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_327 = _csignals_T_39 ? 3'h0 : _csignals_T_326; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_328 = _csignals_T_37 ? 3'h0 : _csignals_T_327; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_329 = _csignals_T_35 ? 3'h0 : _csignals_T_328; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_330 = _csignals_T_33 ? 3'h0 : _csignals_T_329; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_331 = _csignals_T_31 ? 3'h0 : _csignals_T_330; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_332 = _csignals_T_29 ? 3'h0 : _csignals_T_331; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_333 = _csignals_T_27 ? 3'h0 : _csignals_T_332; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_334 = _csignals_T_25 ? 3'h0 : _csignals_T_333; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_335 = _csignals_T_23 ? 3'h0 : _csignals_T_334; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_336 = _csignals_T_21 ? 3'h0 : _csignals_T_335; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_337 = _csignals_T_19 ? 3'h0 : _csignals_T_336; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_338 = _csignals_T_17 ? 3'h0 : _csignals_T_337; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_339 = _csignals_T_15 ? 3'h0 : _csignals_T_338; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_340 = _csignals_T_13 ? 3'h1 : _csignals_T_339; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_341 = _csignals_T_11 ? 3'h0 : _csignals_T_340; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_342 = _csignals_T_9 ? 3'h1 : _csignals_T_341; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_343 = _csignals_T_7 ? 3'h1 : _csignals_T_342; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_344 = _csignals_T_5 ? 3'h0 : _csignals_T_343; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_346 = _csignals_T_87 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_347 = _csignals_T_85 ? 3'h3 : _csignals_T_346; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_348 = _csignals_T_83 ? 3'h3 : _csignals_T_347; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_349 = _csignals_T_81 ? 3'h2 : _csignals_T_348; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_350 = _csignals_T_79 ? 3'h2 : _csignals_T_349; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_351 = _csignals_T_77 ? 3'h1 : _csignals_T_350; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_352 = _csignals_T_75 ? 3'h1 : _csignals_T_351; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_353 = _csignals_T_73 ? 3'h0 : _csignals_T_352; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_354 = _csignals_T_71 ? 3'h0 : _csignals_T_353; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_355 = _csignals_T_69 ? 3'h0 : _csignals_T_354; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_356 = _csignals_T_67 ? 3'h0 : _csignals_T_355; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_357 = _csignals_T_65 ? 3'h0 : _csignals_T_356; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_358 = _csignals_T_63 ? 3'h0 : _csignals_T_357; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_359 = _csignals_T_61 ? 3'h0 : _csignals_T_358; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_360 = _csignals_T_59 ? 3'h0 : _csignals_T_359; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_361 = _csignals_T_57 ? 3'h0 : _csignals_T_360; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_362 = _csignals_T_55 ? 3'h0 : _csignals_T_361; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_363 = _csignals_T_53 ? 3'h0 : _csignals_T_362; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_364 = _csignals_T_51 ? 3'h0 : _csignals_T_363; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_365 = _csignals_T_49 ? 3'h0 : _csignals_T_364; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_366 = _csignals_T_47 ? 3'h0 : _csignals_T_365; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_367 = _csignals_T_45 ? 3'h0 : _csignals_T_366; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_368 = _csignals_T_43 ? 3'h0 : _csignals_T_367; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_369 = _csignals_T_41 ? 3'h0 : _csignals_T_368; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_370 = _csignals_T_39 ? 3'h0 : _csignals_T_369; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_371 = _csignals_T_37 ? 3'h0 : _csignals_T_370; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_372 = _csignals_T_35 ? 3'h0 : _csignals_T_371; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_373 = _csignals_T_33 ? 3'h0 : _csignals_T_372; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_374 = _csignals_T_31 ? 3'h0 : _csignals_T_373; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_375 = _csignals_T_29 ? 3'h0 : _csignals_T_374; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_376 = _csignals_T_27 ? 3'h0 : _csignals_T_375; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_377 = _csignals_T_25 ? 3'h0 : _csignals_T_376; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_378 = _csignals_T_23 ? 3'h0 : _csignals_T_377; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_379 = _csignals_T_21 ? 3'h0 : _csignals_T_378; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_380 = _csignals_T_19 ? 3'h0 : _csignals_T_379; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_381 = _csignals_T_17 ? 3'h0 : _csignals_T_380; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_382 = _csignals_T_15 ? 3'h0 : _csignals_T_381; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_383 = _csignals_T_13 ? 3'h0 : _csignals_T_382; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_384 = _csignals_T_11 ? 3'h0 : _csignals_T_383; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_385 = _csignals_T_9 ? 3'h0 : _csignals_T_384; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_386 = _csignals_T_7 ? 3'h0 : _csignals_T_385; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_387 = _csignals_T_5 ? 3'h0 : _csignals_T_386; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_388 = _csignals_T_3 ? 3'h0 : _csignals_T_387; // @[Lookup.scala 33:37]
  wire [2:0] csignals_6 = _csignals_T_1 ? 3'h0 : _csignals_T_388; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_425 = _csignals_T_15 ? 3'h1 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_426 = _csignals_T_13 ? 3'h1 : _csignals_T_425; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_427 = _csignals_T_11 ? 3'h2 : _csignals_T_426; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_428 = _csignals_T_9 ? 3'h4 : _csignals_T_427; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_429 = _csignals_T_7 ? 3'h2 : _csignals_T_428; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_430 = _csignals_T_5 ? 3'h3 : _csignals_T_429; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_431 = _csignals_T_3 ? 3'h5 : _csignals_T_430; // @[Lookup.scala 33:37]
  wire [2:0] csignals_7 = _csignals_T_1 ? 3'h3 : _csignals_T_431; // @[Lookup.scala 33:37]
  wire  _id_op1_data_T = csignals_1 == 2'h0; // @[Core.scala 200:17]
  wire  _id_op1_data_T_1 = csignals_1 == 2'h1; // @[Core.scala 201:17]
  wire  _id_op1_data_T_2 = csignals_1 == 2'h3; // @[Core.scala 202:17]
  wire [31:0] _id_op1_data_T_3 = _id_op1_data_T_2 ? id_imm_z_uext : 32'h0; // @[Mux.scala 98:16]
  wire  _id_op2_data_T = csignals_2 == 3'h1; // @[Core.scala 205:17]
  wire  _id_op2_data_T_1 = csignals_2 == 3'h2; // @[Core.scala 206:17]
  wire  _id_op2_data_T_2 = csignals_2 == 3'h3; // @[Core.scala 207:17]
  wire  _id_op2_data_T_3 = csignals_2 == 3'h4; // @[Core.scala 208:17]
  wire  _id_op2_data_T_4 = csignals_2 == 3'h5; // @[Core.scala 209:17]
  wire [31:0] _id_op2_data_T_5 = _id_op2_data_T_4 ? id_imm_u_shifted : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _id_op2_data_T_6 = _id_op2_data_T_3 ? id_imm_j_sext : _id_op2_data_T_5; // @[Mux.scala 98:16]
  wire [31:0] _id_op2_data_T_7 = _id_op2_data_T_2 ? id_imm_s_sext : _id_op2_data_T_6; // @[Mux.scala 98:16]
  wire  _T_2 = ~mem_stall_flg; // @[Core.scala 217:9]
  wire  _mem_reg_mem_wstrb_T = exe_reg_mem_w == 32'h3; // @[Core.scala 285:22]
  wire  _mem_reg_mem_wstrb_T_1 = exe_reg_mem_w == 32'h2; // @[Core.scala 286:22]
  wire [3:0] _mem_reg_mem_wstrb_T_4 = _mem_reg_mem_wstrb_T_1 ? 4'h3 : 4'hf; // @[Mux.scala 98:16]
  wire [3:0] _mem_reg_mem_wstrb_T_5 = _mem_reg_mem_wstrb_T ? 4'h1 : _mem_reg_mem_wstrb_T_4; // @[Mux.scala 98:16]
  wire [6:0] _GEN_39 = {{3'd0}, _mem_reg_mem_wstrb_T_5}; // @[Core.scala 288:8]
  wire [6:0] _mem_reg_mem_wstrb_T_7 = _GEN_39 << exe_alu_out[1:0]; // @[Core.scala 288:8]
  wire [94:0] _GEN_40 = {{63'd0}, mem_reg_rs2_data}; // @[Core.scala 298:38]
  wire [94:0] _io_dmem_wdata_T_2 = _GEN_40 << _mem_wb_rdata_T; // @[Core.scala 298:38]
  wire  _csr_wdata_T = mem_reg_csr_cmd == 3'h1; // @[Core.scala 305:22]
  wire  _csr_wdata_T_1 = mem_reg_csr_cmd == 3'h2; // @[Core.scala 306:22]
  wire [31:0] _csr_wdata_T_2 = csr_rdata | mem_reg_op1_data; // @[Core.scala 306:47]
  wire  _csr_wdata_T_3 = mem_reg_csr_cmd == 3'h3; // @[Core.scala 307:22]
  wire [31:0] _csr_wdata_T_4 = ~mem_reg_op1_data; // @[Core.scala 307:49]
  wire [31:0] _csr_wdata_T_5 = csr_rdata & _csr_wdata_T_4; // @[Core.scala 307:47]
  wire  _csr_wdata_T_6 = mem_reg_csr_cmd == 3'h4; // @[Core.scala 308:22]
  wire [31:0] _csr_wdata_T_7 = _csr_wdata_T_6 ? 32'hb : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _csr_wdata_T_8 = _csr_wdata_T_3 ? _csr_wdata_T_5 : _csr_wdata_T_7; // @[Mux.scala 98:16]
  wire [31:0] _csr_wdata_T_9 = _csr_wdata_T_1 ? _csr_wdata_T_2 : _csr_wdata_T_8; // @[Mux.scala 98:16]
  assign regfile_id_rs1_data_MPORT_addr = id_inst[19:15];
  assign regfile_id_rs1_data_MPORT_data = regfile[regfile_id_rs1_data_MPORT_addr]; // @[Core.scala 18:20]
  assign regfile_id_rs2_data_MPORT_addr = id_inst[24:20];
  assign regfile_id_rs2_data_MPORT_data = regfile[regfile_id_rs2_data_MPORT_addr]; // @[Core.scala 18:20]
  assign regfile_io_gp_MPORT_addr = 5'h3;
  assign regfile_io_gp_MPORT_data = regfile[regfile_io_gp_MPORT_addr]; // @[Core.scala 18:20]
  assign regfile_MPORT_data = wb_reg_wb_data;
  assign regfile_MPORT_addr = wb_reg_wb_addr;
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = wb_reg_rf_wen == 2'h1;
  assign io_imem_addr = if_reg_pc; // @[Core.scala 73:16]
  assign io_dmem_raddr = mem_reg_alu_out; // @[Core.scala 293:17]
  assign io_dmem_ren = mem_reg_wb_sel == 3'h1; // @[Core.scala 295:35]
  assign io_dmem_waddr = mem_reg_alu_out; // @[Core.scala 294:17]
  assign io_dmem_wen = mem_reg_mem_wen[0]; // @[Core.scala 296:17]
  assign io_dmem_wstrb = mem_reg_mem_wstrb; // @[Core.scala 297:17]
  assign io_dmem_wdata = _io_dmem_wdata_T_2[31:0]; // @[Core.scala 298:71]
  assign io_exit = exe_is_ecall; // @[Core.scala 359:11]
  always @(posedge clock) begin
    if(regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[Core.scala 18:20]
    end
    if (reset) begin // @[Core.scala 20:32]
      csr_trap_vector <= 32'h0; // @[Core.scala 20:32]
    end else if (mem_reg_csr_cmd > 3'h0) begin // @[Core.scala 311:30]
      if (_csr_rdata_T) begin // @[Core.scala 312:42]
        if (_csr_wdata_T) begin // @[Mux.scala 98:16]
          csr_trap_vector <= mem_reg_op1_data;
        end else begin
          csr_trap_vector <= _csr_wdata_T_9;
        end
      end
    end
    if (reset) begin // @[Core.scala 26:38]
      id_reg_pc <= 32'h0; // @[Core.scala 26:38]
    end else if (!(stall_flg)) begin // @[Core.scala 96:21]
      id_reg_pc <= if_reg_pc;
    end
    if (reset) begin // @[Core.scala 27:38]
      id_reg_inst <= 32'h0; // @[Core.scala 27:38]
    end else if (_id_reg_inst_T) begin // @[Mux.scala 98:16]
      id_reg_inst <= 32'h13;
    end else if (!(stall_flg)) begin // @[Mux.scala 98:16]
      if (io_imem_valid) begin // @[Core.scala 74:20]
        id_reg_inst <= io_imem_inst;
      end else begin
        id_reg_inst <= 32'h13;
      end
    end
    if (reset) begin // @[Core.scala 30:38]
      exe_reg_pc <= 32'h0; // @[Core.scala 30:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      exe_reg_pc <= id_reg_pc; // @[Core.scala 218:27]
    end
    if (reset) begin // @[Core.scala 31:38]
      exe_reg_wb_addr <= 5'h0; // @[Core.scala 31:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      exe_reg_wb_addr <= id_wb_addr; // @[Core.scala 222:27]
    end
    if (reset) begin // @[Core.scala 32:38]
      exe_reg_op1_data <= 32'h0; // @[Core.scala 32:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_id_op1_data_T) begin // @[Mux.scala 98:16]
        if (_id_rs1_data_T) begin // @[Mux.scala 98:16]
          exe_reg_op1_data <= 32'h0;
        end else begin
          exe_reg_op1_data <= _id_rs1_data_T_8;
        end
      end else if (_id_op1_data_T_1) begin // @[Mux.scala 98:16]
        exe_reg_op1_data <= id_reg_pc;
      end else begin
        exe_reg_op1_data <= _id_op1_data_T_3;
      end
    end
    if (reset) begin // @[Core.scala 33:38]
      exe_reg_op2_data <= 32'h0; // @[Core.scala 33:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_id_op2_data_T) begin // @[Mux.scala 98:16]
        if (_id_rs2_data_T) begin // @[Mux.scala 98:16]
          exe_reg_op2_data <= 32'h0;
        end else begin
          exe_reg_op2_data <= _id_rs2_data_T_8;
        end
      end else if (_id_op2_data_T_1) begin // @[Mux.scala 98:16]
        exe_reg_op2_data <= id_imm_i_sext;
      end else begin
        exe_reg_op2_data <= _id_op2_data_T_7;
      end
    end
    if (reset) begin // @[Core.scala 34:38]
      exe_reg_rs2_data <= 32'h0; // @[Core.scala 34:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_id_rs2_data_T) begin // @[Mux.scala 98:16]
        exe_reg_rs2_data <= 32'h0;
      end else if (_id_rs2_data_T_3) begin // @[Mux.scala 98:16]
        exe_reg_rs2_data <= mem_wb_data;
      end else begin
        exe_reg_rs2_data <= _id_rs2_data_T_7;
      end
    end
    if (reset) begin // @[Core.scala 35:38]
      exe_reg_exe_fun <= 5'h0; // @[Core.scala 35:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_exe_fun <= 5'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_exe_fun <= 5'h1;
      end else begin
        exe_reg_exe_fun <= _csignals_T_129;
      end
    end
    if (reset) begin // @[Core.scala 36:38]
      exe_reg_mem_wen <= 2'h0; // @[Core.scala 36:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_mem_wen <= 2'h0;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_mem_wen <= 2'h0;
      end else begin
        exe_reg_mem_wen <= _csignals_T_258;
      end
    end
    if (reset) begin // @[Core.scala 37:38]
      exe_reg_rf_wen <= 2'h0; // @[Core.scala 37:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_rf_wen <= 2'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_rf_wen <= 2'h1;
      end else begin
        exe_reg_rf_wen <= _csignals_T_301;
      end
    end
    if (reset) begin // @[Core.scala 38:38]
      exe_reg_wb_sel <= 3'h0; // @[Core.scala 38:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_wb_sel <= 3'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_wb_sel <= 3'h1;
      end else begin
        exe_reg_wb_sel <= _csignals_T_344;
      end
    end
    if (reset) begin // @[Core.scala 39:38]
      exe_reg_csr_addr <= 12'h0; // @[Core.scala 39:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (csignals_6 == 3'h4) begin // @[Core.scala 212:24]
        exe_reg_csr_addr <= 12'h342;
      end else begin
        exe_reg_csr_addr <= id_imm_i;
      end
    end
    if (reset) begin // @[Core.scala 40:38]
      exe_reg_csr_cmd <= 3'h0; // @[Core.scala 40:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_csr_cmd <= 3'h0;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_csr_cmd <= 3'h0;
      end else begin
        exe_reg_csr_cmd <= _csignals_T_387;
      end
    end
    if (reset) begin // @[Core.scala 43:38]
      exe_reg_imm_b_sext <= 32'h0; // @[Core.scala 43:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      exe_reg_imm_b_sext <= id_imm_b_sext; // @[Core.scala 228:27]
    end
    if (reset) begin // @[Core.scala 46:38]
      exe_reg_mem_w <= 32'h0; // @[Core.scala 46:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      exe_reg_mem_w <= {{29'd0}, csignals_7}; // @[Core.scala 234:27]
    end
    if (reset) begin // @[Core.scala 47:38]
      exe_is_ecall <= 1'h0; // @[Core.scala 47:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 217:26]
      exe_is_ecall <= _csignals_T_87; // @[Core.scala 235:27]
    end
    if (reset) begin // @[Core.scala 50:38]
      mem_reg_pc <= 32'h0; // @[Core.scala 50:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_pc <= exe_reg_pc; // @[Core.scala 272:24]
    end
    if (reset) begin // @[Core.scala 51:38]
      mem_reg_wb_addr <= 5'h0; // @[Core.scala 51:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_wb_addr <= exe_reg_wb_addr; // @[Core.scala 275:24]
    end
    if (reset) begin // @[Core.scala 52:38]
      mem_reg_op1_data <= 32'h0; // @[Core.scala 52:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_op1_data <= exe_reg_op1_data; // @[Core.scala 273:24]
    end
    if (reset) begin // @[Core.scala 53:38]
      mem_reg_rs2_data <= 32'h0; // @[Core.scala 53:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_rs2_data <= exe_reg_rs2_data; // @[Core.scala 274:24]
    end
    if (reset) begin // @[Core.scala 54:38]
      mem_reg_mem_wen <= 2'h0; // @[Core.scala 54:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_mem_wen <= exe_reg_mem_wen; // @[Core.scala 282:24]
    end
    if (reset) begin // @[Core.scala 55:38]
      mem_reg_rf_wen <= 2'h0; // @[Core.scala 55:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_rf_wen <= exe_reg_rf_wen; // @[Core.scala 277:24]
    end
    if (reset) begin // @[Core.scala 56:38]
      mem_reg_wb_sel <= 3'h0; // @[Core.scala 56:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_wb_sel <= exe_reg_wb_sel; // @[Core.scala 278:24]
    end
    if (reset) begin // @[Core.scala 57:38]
      mem_reg_csr_addr <= 12'h0; // @[Core.scala 57:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_csr_addr <= exe_reg_csr_addr; // @[Core.scala 279:24]
    end
    if (reset) begin // @[Core.scala 58:38]
      mem_reg_csr_cmd <= 3'h0; // @[Core.scala 58:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_csr_cmd <= exe_reg_csr_cmd; // @[Core.scala 280:24]
    end
    if (reset) begin // @[Core.scala 60:38]
      mem_reg_alu_out <= 32'h0; // @[Core.scala 60:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      if (_exe_alu_out_T) begin // @[Mux.scala 98:16]
        mem_reg_alu_out <= _exe_alu_out_T_2;
      end else if (_exe_alu_out_T_3) begin // @[Mux.scala 98:16]
        mem_reg_alu_out <= _exe_alu_out_T_5;
      end else begin
        mem_reg_alu_out <= _exe_alu_out_T_45;
      end
    end
    if (reset) begin // @[Core.scala 61:38]
      mem_reg_mem_w <= 32'h0; // @[Core.scala 61:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_mem_w <= exe_reg_mem_w; // @[Core.scala 283:24]
    end
    if (reset) begin // @[Core.scala 62:38]
      mem_reg_mem_wstrb <= 4'h0; // @[Core.scala 62:38]
    end else if (_T_2) begin // @[Core.scala 271:26]
      mem_reg_mem_wstrb <= _mem_reg_mem_wstrb_T_7[3:0]; // @[Core.scala 284:24]
    end
    if (reset) begin // @[Core.scala 64:38]
      wb_reg_wb_addr <= 5'h0; // @[Core.scala 64:38]
    end else begin
      wb_reg_wb_addr <= mem_reg_wb_addr; // @[Core.scala 342:18]
    end
    if (reset) begin // @[Core.scala 65:38]
      wb_reg_rf_wen <= 2'h0; // @[Core.scala 65:38]
    end else if (_T_2) begin // @[Core.scala 343:24]
      wb_reg_rf_wen <= mem_reg_rf_wen;
    end else begin
      wb_reg_rf_wen <= 2'h0;
    end
    if (reset) begin // @[Core.scala 66:38]
      wb_reg_wb_data <= 32'h0; // @[Core.scala 66:38]
    end else if (_mem_wb_data_T) begin // @[Mux.scala 98:16]
      if (_mem_wb_data_load_T) begin // @[Mux.scala 98:16]
        wb_reg_wb_data <= _mem_wb_data_load_T_5;
      end else if (_mem_wb_data_load_T_6) begin // @[Mux.scala 98:16]
        wb_reg_wb_data <= _mem_wb_data_load_T_11;
      end else begin
        wb_reg_wb_data <= _mem_wb_data_load_T_21;
      end
    end else if (_mem_wb_data_T_1) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= _mem_wb_data_T_3;
    end else if (_mem_wb_data_T_4) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= csr_rdata;
    end else begin
      wb_reg_wb_data <= mem_reg_alu_out;
    end
    if (reset) begin // @[Core.scala 72:26]
      if_reg_pc <= 32'h8000000; // @[Core.scala 72:26]
    end else if (exe_br_flg) begin // @[Mux.scala 98:16]
      if_reg_pc <= exe_br_target;
    end else if (exe_jmp_flg) begin // @[Mux.scala 98:16]
      if (_exe_alu_out_T) begin // @[Mux.scala 98:16]
        if_reg_pc <= _exe_alu_out_T_2;
      end else begin
        if_reg_pc <= _exe_alu_out_T_46;
      end
    end else if (_if_pc_next_T_1) begin // @[Mux.scala 98:16]
      if_reg_pc <= csr_trap_vector;
    end else begin
      if_reg_pc <= _if_pc_next_T_4;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"addr: %x, valid: %d\n",io_imem_addr,io_imem_valid); // @[Core.scala 75:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"if_reg_pc        : 0x%x\n",if_reg_pc); // @[Core.scala 360:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_reg_pc        : 0x%x\n",id_reg_pc); // @[Core.scala 361:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_reg_inst      : 0x%x\n",id_reg_inst); // @[Core.scala 362:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"stall_flg        : 0x%x\n",stall_flg); // @[Core.scala 363:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_inst          : 0x%x\n",id_inst); // @[Core.scala 364:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_rs1_data      : 0x%x\n",id_rs1_data); // @[Core.scala 365:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"id_rs2_data      : 0x%x\n",id_rs2_data); // @[Core.scala 366:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_reg_pc       : 0x%x\n",exe_reg_pc); // @[Core.scala 367:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_reg_op1_data : 0x%x\n",exe_reg_op1_data); // @[Core.scala 368:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_reg_op2_data : 0x%x\n",exe_reg_op2_data); // @[Core.scala 369:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"exe_alu_out      : 0x%x\n",exe_alu_out); // @[Core.scala 370:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_reg_pc       : 0x%x\n",mem_reg_pc); // @[Core.scala 371:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_wb_data      : 0x%x\n",mem_wb_data); // @[Core.scala 372:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_reg_mem_w    : 0x%x\n",mem_reg_mem_w); // @[Core.scala 373:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"mem_reg_wb_addr  : 0x%x\n",mem_reg_wb_addr); // @[Core.scala 374:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"wb_reg_wb_addr   : 0x%x\n",wb_reg_wb_addr); // @[Core.scala 375:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"wb_reg_wb_data   : 0x%x\n",wb_reg_wb_data); // @[Core.scala 376:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_1) begin
          $fwrite(32'h80000002,"---------\n"); // @[Core.scala 377:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  csr_trap_vector = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  id_reg_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  id_reg_inst = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  exe_reg_pc = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  exe_reg_wb_addr = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  exe_reg_op1_data = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  exe_reg_op2_data = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  exe_reg_rs2_data = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  exe_reg_exe_fun = _RAND_9[4:0];
  _RAND_10 = {1{`RANDOM}};
  exe_reg_mem_wen = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  exe_reg_rf_wen = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  exe_reg_wb_sel = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  exe_reg_csr_addr = _RAND_13[11:0];
  _RAND_14 = {1{`RANDOM}};
  exe_reg_csr_cmd = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  exe_reg_imm_b_sext = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  exe_reg_mem_w = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  exe_is_ecall = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  mem_reg_pc = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mem_reg_wb_addr = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  mem_reg_op1_data = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  mem_reg_rs2_data = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  mem_reg_mem_wen = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  mem_reg_rf_wen = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  mem_reg_wb_sel = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  mem_reg_csr_addr = _RAND_25[11:0];
  _RAND_26 = {1{`RANDOM}};
  mem_reg_csr_cmd = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  mem_reg_alu_out = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mem_reg_mem_w = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  mem_reg_mem_wstrb = _RAND_29[3:0];
  _RAND_30 = {1{`RANDOM}};
  wb_reg_wb_addr = _RAND_30[4:0];
  _RAND_31 = {1{`RANDOM}};
  wb_reg_rf_wen = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  wb_reg_wb_data = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  if_reg_pc = _RAND_33[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memory(
  input         clock,
  input         reset,
  input  [31:0] io_imem_addr,
  output [31:0] io_imem_inst,
  output        io_imem_valid,
  input  [31:0] io_dmem_raddr,
  output [31:0] io_dmem_rdata,
  input         io_dmem_ren,
  output        io_dmem_rvalid,
  input  [31:0] io_dmem_waddr,
  input         io_dmem_wen,
  input  [3:0]  io_dmem_wstrb,
  input  [31:0] io_dmem_wdata,
  output [8:0]  io_imemReadPort_address,
  input  [31:0] io_imemReadPort_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] dataMem_0 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_0_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_0_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_0_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_0_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_0_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_0_MPORT_en; // @[Memory.scala 53:20]
  reg [7:0] dataMem_1 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_1_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_1_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_1_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_1_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_1_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_1_MPORT_en; // @[Memory.scala 53:20]
  reg [7:0] dataMem_2 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_2_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_2_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_2_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_2_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_2_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_2_MPORT_en; // @[Memory.scala 53:20]
  reg [7:0] dataMem_3 [0:127]; // @[Memory.scala 53:20]
  wire [7:0] dataMem_3_rdata_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_3_rdata_MPORT_addr; // @[Memory.scala 53:20]
  wire [7:0] dataMem_3_MPORT_data; // @[Memory.scala 53:20]
  wire [6:0] dataMem_3_MPORT_addr; // @[Memory.scala 53:20]
  wire  dataMem_3_MPORT_mask; // @[Memory.scala 53:20]
  wire  dataMem_3_MPORT_en; // @[Memory.scala 53:20]
  reg  instIsFirst; // @[Memory.scala 37:28]
  wire [29:0] instAddr = io_imem_addr[31:2]; // @[Memory.scala 38:30]
  reg [29:0] instFetchedAddr; // @[Memory.scala 40:32]
  wire  instValid = instFetchedAddr == instAddr & ~instIsFirst; // @[Memory.scala 42:48]
  wire [29:0] _instFetchingAddr_T_1 = instFetchedAddr + 30'h1; // @[Memory.scala 47:54]
  wire [29:0] instFetchingAddr = instValid ? _instFetchingAddr_T_1 : instAddr; // @[Memory.scala 47:26]
  reg [31:0] rdata; // @[Memory.scala 58:22]
  reg  rvalid; // @[Memory.scala 59:23]
  wire  _T = ~io_dmem_wen; // @[Memory.scala 64:9]
  wire  _T_1 = ~io_dmem_wen & io_dmem_ren; // @[Memory.scala 64:22]
  wire [31:0] _rdata_T_2 = {dataMem_3_rdata_MPORT_data,dataMem_2_rdata_MPORT_data,dataMem_1_rdata_MPORT_data,
    dataMem_0_rdata_MPORT_data}; // @[Cat.scala 30:58]
  assign dataMem_0_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_0_rdata_MPORT_data = dataMem_0[dataMem_0_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_0_MPORT_data = io_dmem_wdata[7:0];
  assign dataMem_0_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_0_MPORT_mask = io_dmem_wstrb[0];
  assign dataMem_0_MPORT_en = io_dmem_wen;
  assign dataMem_1_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_1_rdata_MPORT_data = dataMem_1[dataMem_1_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_1_MPORT_data = io_dmem_wdata[15:8];
  assign dataMem_1_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_1_MPORT_mask = io_dmem_wstrb[1];
  assign dataMem_1_MPORT_en = io_dmem_wen;
  assign dataMem_2_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_2_rdata_MPORT_data = dataMem_2[dataMem_2_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_2_MPORT_data = io_dmem_wdata[23:16];
  assign dataMem_2_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_2_MPORT_mask = io_dmem_wstrb[2];
  assign dataMem_2_MPORT_en = io_dmem_wen;
  assign dataMem_3_rdata_MPORT_addr = io_dmem_raddr[8:2];
  assign dataMem_3_rdata_MPORT_data = dataMem_3[dataMem_3_rdata_MPORT_addr]; // @[Memory.scala 53:20]
  assign dataMem_3_MPORT_data = io_dmem_wdata[31:24];
  assign dataMem_3_MPORT_addr = io_dmem_waddr[8:2];
  assign dataMem_3_MPORT_mask = io_dmem_wstrb[3];
  assign dataMem_3_MPORT_en = io_dmem_wen;
  assign io_imem_inst = io_imemReadPort_data; // @[Memory.scala 39:22 Memory.scala 48:12]
  assign io_imem_valid = instFetchedAddr == instAddr & ~instIsFirst; // @[Memory.scala 42:48]
  assign io_dmem_rdata = rdata; // @[Memory.scala 60:17]
  assign io_dmem_rvalid = rvalid; // @[Memory.scala 61:18]
  assign io_imemReadPort_address = instFetchingAddr[8:0]; // @[Memory.scala 50:27]
  always @(posedge clock) begin
    if(dataMem_0_MPORT_en & dataMem_0_MPORT_mask) begin
      dataMem_0[dataMem_0_MPORT_addr] <= dataMem_0_MPORT_data; // @[Memory.scala 53:20]
    end
    if(dataMem_1_MPORT_en & dataMem_1_MPORT_mask) begin
      dataMem_1[dataMem_1_MPORT_addr] <= dataMem_1_MPORT_data; // @[Memory.scala 53:20]
    end
    if(dataMem_2_MPORT_en & dataMem_2_MPORT_mask) begin
      dataMem_2[dataMem_2_MPORT_addr] <= dataMem_2_MPORT_data; // @[Memory.scala 53:20]
    end
    if(dataMem_3_MPORT_en & dataMem_3_MPORT_mask) begin
      dataMem_3[dataMem_3_MPORT_addr] <= dataMem_3_MPORT_data; // @[Memory.scala 53:20]
    end
    instIsFirst <= reset; // @[Memory.scala 37:28 Memory.scala 37:28 Memory.scala 44:15]
    if (reset) begin // @[Memory.scala 40:32]
      instFetchedAddr <= 30'h0; // @[Memory.scala 40:32]
    end else if (instValid) begin // @[Memory.scala 47:26]
      instFetchedAddr <= _instFetchingAddr_T_1;
    end else begin
      instFetchedAddr <= instAddr;
    end
    if (reset) begin // @[Memory.scala 58:22]
      rdata <= 32'h0; // @[Memory.scala 58:22]
    end else if (~io_dmem_wen & io_dmem_ren) begin // @[Memory.scala 64:39]
      rdata <= _rdata_T_2; // @[Memory.scala 65:11]
    end
    if (reset) begin // @[Memory.scala 59:23]
      rvalid <= 1'h0; // @[Memory.scala 59:23]
    end else begin
      rvalid <= _T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_0[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_1[initvar] = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_2[initvar] = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    dataMem_3[initvar] = _RAND_3[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  instIsFirst = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  instFetchedAddr = _RAND_5[29:0];
  _RAND_6 = {1{`RANDOM}};
  rdata = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  rvalid = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SingleCycleMem(
  input  [31:0] io_mem_raddr,
  output [31:0] io_mem_rdata,
  input         io_mem_ren,
  input  [31:0] io_mem_waddr,
  input         io_mem_wen,
  input  [31:0] io_mem_wdata,
  output [8:0]  io_read_address,
  input  [31:0] io_read_data,
  output        io_read_enable,
  output [8:0]  io_write_address,
  output [31:0] io_write_data,
  output        io_write_enable
);
  assign io_mem_rdata = io_read_data; // @[Top.scala 81:16]
  assign io_read_address = io_mem_raddr[8:0]; // @[Top.scala 79:19]
  assign io_read_enable = io_mem_ren; // @[Top.scala 80:18]
  assign io_write_address = io_mem_waddr[8:0]; // @[Top.scala 84:20]
  assign io_write_data = io_mem_wdata; // @[Top.scala 86:17]
  assign io_write_enable = io_mem_wen; // @[Top.scala 85:19]
endmodule
module Gpio(
  input         clock,
  input         reset,
  input         io_mem_wen,
  input  [31:0] io_mem_wdata,
  output [31:0] io_gpio
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] output_; // @[Top.scala 61:23]
  assign io_gpio = output_; // @[Top.scala 62:11]
  always @(posedge clock) begin
    if (reset) begin // @[Top.scala 61:23]
      output_ <= 32'h0; // @[Top.scala 61:23]
    end else if (io_mem_wen) begin // @[Top.scala 67:20]
      output_ <= io_mem_wdata; // @[Top.scala 68:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  output_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DMemDecoder(
  input  [31:0] io_initiator_raddr,
  output [31:0] io_initiator_rdata,
  input         io_initiator_ren,
  output        io_initiator_rvalid,
  input  [31:0] io_initiator_waddr,
  input         io_initiator_wen,
  input  [3:0]  io_initiator_wstrb,
  input  [31:0] io_initiator_wdata,
  output [31:0] io_targets_0_raddr,
  input  [31:0] io_targets_0_rdata,
  output        io_targets_0_ren,
  output [31:0] io_targets_0_waddr,
  output        io_targets_0_wen,
  output [31:0] io_targets_0_wdata,
  output [31:0] io_targets_1_raddr,
  input  [31:0] io_targets_1_rdata,
  output        io_targets_1_ren,
  input         io_targets_1_rvalid,
  output [31:0] io_targets_1_waddr,
  output        io_targets_1_wen,
  output [3:0]  io_targets_1_wstrb,
  output [31:0] io_targets_1_wdata,
  output        io_targets_2_wen,
  output [31:0] io_targets_2_wdata
);
  wire [31:0] _raddr_T_1 = io_initiator_raddr - 32'h8000000; // @[Top.scala 40:35]
  wire [31:0] _GEN_3 = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 ? io_targets_0_rdata : 32'hdeadbeef
    ; // @[Top.scala 39:85 Top.scala 43:13]
  wire [31:0] _waddr_T_1 = io_initiator_waddr - 32'h8000000; // @[Top.scala 46:35]
  wire [31:0] _raddr_T_3 = io_initiator_raddr - 32'h20000000; // @[Top.scala 40:35]
  wire  _GEN_11 = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 ? io_targets_1_rvalid : 1'h1; // @[Top.scala 39:85 Top.scala 42:14]
  wire [31:0] _GEN_12 = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 ? io_targets_1_rdata :
    _GEN_3; // @[Top.scala 39:85 Top.scala 43:13]
  wire [31:0] _waddr_T_3 = io_initiator_waddr - 32'h20000000; // @[Top.scala 46:35]
  assign io_initiator_rdata = 32'h30000000 <= io_initiator_raddr & io_initiator_raddr < 32'h30000040 ? 32'hdeadbeef :
    _GEN_12; // @[Top.scala 39:85 Top.scala 43:13]
  assign io_initiator_rvalid = 32'h30000000 <= io_initiator_raddr & io_initiator_raddr < 32'h30000040 | _GEN_11; // @[Top.scala 39:85 Top.scala 42:14]
  assign io_targets_0_raddr = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 ? _raddr_T_1 : 32'h0; // @[Top.scala 39:85 Top.scala 40:13]
  assign io_targets_0_ren = 32'h8000000 <= io_initiator_raddr & io_initiator_raddr < 32'h8000800 & io_initiator_ren; // @[Top.scala 39:85 Top.scala 41:11]
  assign io_targets_0_waddr = 32'h8000000 <= io_initiator_waddr & io_initiator_waddr < 32'h8000800 ? _waddr_T_1 : 32'h0; // @[Top.scala 45:85 Top.scala 46:13]
  assign io_targets_0_wen = 32'h8000000 <= io_initiator_waddr & io_initiator_waddr < 32'h8000800 & io_initiator_wen; // @[Top.scala 45:85 Top.scala 47:11]
  assign io_targets_0_wdata = 32'h8000000 <= io_initiator_waddr & io_initiator_waddr < 32'h8000800 ? io_initiator_wdata
     : 32'hdeadbeef; // @[Top.scala 45:85 Top.scala 48:13]
  assign io_targets_1_raddr = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 ? _raddr_T_3 : 32'h0
    ; // @[Top.scala 39:85 Top.scala 40:13]
  assign io_targets_1_ren = 32'h20000000 <= io_initiator_raddr & io_initiator_raddr < 32'h20000200 & io_initiator_ren; // @[Top.scala 39:85 Top.scala 41:11]
  assign io_targets_1_waddr = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 ? _waddr_T_3 : 32'h0
    ; // @[Top.scala 45:85 Top.scala 46:13]
  assign io_targets_1_wen = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 & io_initiator_wen; // @[Top.scala 45:85 Top.scala 47:11]
  assign io_targets_1_wstrb = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 ?
    io_initiator_wstrb : 4'hf; // @[Top.scala 45:85 Top.scala 49:13]
  assign io_targets_1_wdata = 32'h20000000 <= io_initiator_waddr & io_initiator_waddr < 32'h20000200 ?
    io_initiator_wdata : 32'hdeadbeef; // @[Top.scala 45:85 Top.scala 48:13]
  assign io_targets_2_wen = 32'h30000000 <= io_initiator_waddr & io_initiator_waddr < 32'h30000040 & io_initiator_wen; // @[Top.scala 45:85 Top.scala 47:11]
  assign io_targets_2_wdata = 32'h30000000 <= io_initiator_waddr & io_initiator_waddr < 32'h30000040 ?
    io_initiator_wdata : 32'hdeadbeef; // @[Top.scala 45:85 Top.scala 48:13]
endmodule
module RiscV(
  input         clock,
  input         reset,
  output [7:0]  io_gpio,
  output        io_exit,
  output [8:0]  io_imem_address,
  input  [31:0] io_imem_data,
  output        io_imem_enable,
  output [8:0]  io_imemRead_address,
  input  [31:0] io_imemRead_data,
  output        io_imemRead_enable,
  output [8:0]  io_imemWrite_address,
  output [31:0] io_imemWrite_data,
  output        io_imemWrite_enable
);
  wire  core_clock; // @[Top.scala 102:20]
  wire  core_reset; // @[Top.scala 102:20]
  wire [31:0] core_io_imem_addr; // @[Top.scala 102:20]
  wire [31:0] core_io_imem_inst; // @[Top.scala 102:20]
  wire  core_io_imem_valid; // @[Top.scala 102:20]
  wire [31:0] core_io_dmem_raddr; // @[Top.scala 102:20]
  wire [31:0] core_io_dmem_rdata; // @[Top.scala 102:20]
  wire  core_io_dmem_ren; // @[Top.scala 102:20]
  wire  core_io_dmem_rvalid; // @[Top.scala 102:20]
  wire [31:0] core_io_dmem_waddr; // @[Top.scala 102:20]
  wire  core_io_dmem_wen; // @[Top.scala 102:20]
  wire [3:0] core_io_dmem_wstrb; // @[Top.scala 102:20]
  wire [31:0] core_io_dmem_wdata; // @[Top.scala 102:20]
  wire  core_io_exit; // @[Top.scala 102:20]
  wire  memory_clock; // @[Top.scala 104:22]
  wire  memory_reset; // @[Top.scala 104:22]
  wire [31:0] memory_io_imem_addr; // @[Top.scala 104:22]
  wire [31:0] memory_io_imem_inst; // @[Top.scala 104:22]
  wire  memory_io_imem_valid; // @[Top.scala 104:22]
  wire [31:0] memory_io_dmem_raddr; // @[Top.scala 104:22]
  wire [31:0] memory_io_dmem_rdata; // @[Top.scala 104:22]
  wire  memory_io_dmem_ren; // @[Top.scala 104:22]
  wire  memory_io_dmem_rvalid; // @[Top.scala 104:22]
  wire [31:0] memory_io_dmem_waddr; // @[Top.scala 104:22]
  wire  memory_io_dmem_wen; // @[Top.scala 104:22]
  wire [3:0] memory_io_dmem_wstrb; // @[Top.scala 104:22]
  wire [31:0] memory_io_dmem_wdata; // @[Top.scala 104:22]
  wire [8:0] memory_io_imemReadPort_address; // @[Top.scala 104:22]
  wire [31:0] memory_io_imemReadPort_data; // @[Top.scala 104:22]
  wire [31:0] imem_dbus_io_mem_raddr; // @[Top.scala 105:25]
  wire [31:0] imem_dbus_io_mem_rdata; // @[Top.scala 105:25]
  wire  imem_dbus_io_mem_ren; // @[Top.scala 105:25]
  wire [31:0] imem_dbus_io_mem_waddr; // @[Top.scala 105:25]
  wire  imem_dbus_io_mem_wen; // @[Top.scala 105:25]
  wire [31:0] imem_dbus_io_mem_wdata; // @[Top.scala 105:25]
  wire [8:0] imem_dbus_io_read_address; // @[Top.scala 105:25]
  wire [31:0] imem_dbus_io_read_data; // @[Top.scala 105:25]
  wire  imem_dbus_io_read_enable; // @[Top.scala 105:25]
  wire [8:0] imem_dbus_io_write_address; // @[Top.scala 105:25]
  wire [31:0] imem_dbus_io_write_data; // @[Top.scala 105:25]
  wire  imem_dbus_io_write_enable; // @[Top.scala 105:25]
  wire  gpio_clock; // @[Top.scala 106:20]
  wire  gpio_reset; // @[Top.scala 106:20]
  wire  gpio_io_mem_wen; // @[Top.scala 106:20]
  wire [31:0] gpio_io_mem_wdata; // @[Top.scala 106:20]
  wire [31:0] gpio_io_gpio; // @[Top.scala 106:20]
  wire [31:0] decoder_io_initiator_raddr; // @[Top.scala 108:23]
  wire [31:0] decoder_io_initiator_rdata; // @[Top.scala 108:23]
  wire  decoder_io_initiator_ren; // @[Top.scala 108:23]
  wire  decoder_io_initiator_rvalid; // @[Top.scala 108:23]
  wire [31:0] decoder_io_initiator_waddr; // @[Top.scala 108:23]
  wire  decoder_io_initiator_wen; // @[Top.scala 108:23]
  wire [3:0] decoder_io_initiator_wstrb; // @[Top.scala 108:23]
  wire [31:0] decoder_io_initiator_wdata; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_0_raddr; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_0_rdata; // @[Top.scala 108:23]
  wire  decoder_io_targets_0_ren; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_0_waddr; // @[Top.scala 108:23]
  wire  decoder_io_targets_0_wen; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_0_wdata; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_1_raddr; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_1_rdata; // @[Top.scala 108:23]
  wire  decoder_io_targets_1_ren; // @[Top.scala 108:23]
  wire  decoder_io_targets_1_rvalid; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_1_waddr; // @[Top.scala 108:23]
  wire  decoder_io_targets_1_wen; // @[Top.scala 108:23]
  wire [3:0] decoder_io_targets_1_wstrb; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_1_wdata; // @[Top.scala 108:23]
  wire  decoder_io_targets_2_wen; // @[Top.scala 108:23]
  wire [31:0] decoder_io_targets_2_wdata; // @[Top.scala 108:23]
  Core core ( // @[Top.scala 102:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_imem_addr(core_io_imem_addr),
    .io_imem_inst(core_io_imem_inst),
    .io_imem_valid(core_io_imem_valid),
    .io_dmem_raddr(core_io_dmem_raddr),
    .io_dmem_rdata(core_io_dmem_rdata),
    .io_dmem_ren(core_io_dmem_ren),
    .io_dmem_rvalid(core_io_dmem_rvalid),
    .io_dmem_waddr(core_io_dmem_waddr),
    .io_dmem_wen(core_io_dmem_wen),
    .io_dmem_wstrb(core_io_dmem_wstrb),
    .io_dmem_wdata(core_io_dmem_wdata),
    .io_exit(core_io_exit)
  );
  Memory memory ( // @[Top.scala 104:22]
    .clock(memory_clock),
    .reset(memory_reset),
    .io_imem_addr(memory_io_imem_addr),
    .io_imem_inst(memory_io_imem_inst),
    .io_imem_valid(memory_io_imem_valid),
    .io_dmem_raddr(memory_io_dmem_raddr),
    .io_dmem_rdata(memory_io_dmem_rdata),
    .io_dmem_ren(memory_io_dmem_ren),
    .io_dmem_rvalid(memory_io_dmem_rvalid),
    .io_dmem_waddr(memory_io_dmem_waddr),
    .io_dmem_wen(memory_io_dmem_wen),
    .io_dmem_wstrb(memory_io_dmem_wstrb),
    .io_dmem_wdata(memory_io_dmem_wdata),
    .io_imemReadPort_address(memory_io_imemReadPort_address),
    .io_imemReadPort_data(memory_io_imemReadPort_data)
  );
  SingleCycleMem imem_dbus ( // @[Top.scala 105:25]
    .io_mem_raddr(imem_dbus_io_mem_raddr),
    .io_mem_rdata(imem_dbus_io_mem_rdata),
    .io_mem_ren(imem_dbus_io_mem_ren),
    .io_mem_waddr(imem_dbus_io_mem_waddr),
    .io_mem_wen(imem_dbus_io_mem_wen),
    .io_mem_wdata(imem_dbus_io_mem_wdata),
    .io_read_address(imem_dbus_io_read_address),
    .io_read_data(imem_dbus_io_read_data),
    .io_read_enable(imem_dbus_io_read_enable),
    .io_write_address(imem_dbus_io_write_address),
    .io_write_data(imem_dbus_io_write_data),
    .io_write_enable(imem_dbus_io_write_enable)
  );
  Gpio gpio ( // @[Top.scala 106:20]
    .clock(gpio_clock),
    .reset(gpio_reset),
    .io_mem_wen(gpio_io_mem_wen),
    .io_mem_wdata(gpio_io_mem_wdata),
    .io_gpio(gpio_io_gpio)
  );
  DMemDecoder decoder ( // @[Top.scala 108:23]
    .io_initiator_raddr(decoder_io_initiator_raddr),
    .io_initiator_rdata(decoder_io_initiator_rdata),
    .io_initiator_ren(decoder_io_initiator_ren),
    .io_initiator_rvalid(decoder_io_initiator_rvalid),
    .io_initiator_waddr(decoder_io_initiator_waddr),
    .io_initiator_wen(decoder_io_initiator_wen),
    .io_initiator_wstrb(decoder_io_initiator_wstrb),
    .io_initiator_wdata(decoder_io_initiator_wdata),
    .io_targets_0_raddr(decoder_io_targets_0_raddr),
    .io_targets_0_rdata(decoder_io_targets_0_rdata),
    .io_targets_0_ren(decoder_io_targets_0_ren),
    .io_targets_0_waddr(decoder_io_targets_0_waddr),
    .io_targets_0_wen(decoder_io_targets_0_wen),
    .io_targets_0_wdata(decoder_io_targets_0_wdata),
    .io_targets_1_raddr(decoder_io_targets_1_raddr),
    .io_targets_1_rdata(decoder_io_targets_1_rdata),
    .io_targets_1_ren(decoder_io_targets_1_ren),
    .io_targets_1_rvalid(decoder_io_targets_1_rvalid),
    .io_targets_1_waddr(decoder_io_targets_1_waddr),
    .io_targets_1_wen(decoder_io_targets_1_wen),
    .io_targets_1_wstrb(decoder_io_targets_1_wstrb),
    .io_targets_1_wdata(decoder_io_targets_1_wdata),
    .io_targets_2_wen(decoder_io_targets_2_wen),
    .io_targets_2_wdata(decoder_io_targets_2_wdata)
  );
  assign io_gpio = gpio_io_gpio[7:0]; // @[Top.scala 125:11]
  assign io_exit = core_io_exit; // @[Top.scala 124:11]
  assign io_imem_address = memory_io_imemReadPort_address; // @[Top.scala 118:26]
  assign io_imem_enable = 1'h1; // @[Top.scala 118:26]
  assign io_imemRead_address = imem_dbus_io_read_address; // @[Top.scala 121:21]
  assign io_imemRead_enable = imem_dbus_io_read_enable; // @[Top.scala 121:21]
  assign io_imemWrite_address = imem_dbus_io_write_address; // @[Top.scala 122:22]
  assign io_imemWrite_data = imem_dbus_io_write_data; // @[Top.scala 122:22]
  assign io_imemWrite_enable = imem_dbus_io_write_enable; // @[Top.scala 122:22]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_imem_inst = memory_io_imem_inst; // @[Top.scala 117:16]
  assign core_io_imem_valid = memory_io_imem_valid; // @[Top.scala 117:16]
  assign core_io_dmem_rdata = decoder_io_initiator_rdata; // @[Top.scala 120:16]
  assign core_io_dmem_rvalid = decoder_io_initiator_rvalid; // @[Top.scala 120:16]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_imem_addr = core_io_imem_addr; // @[Top.scala 117:16]
  assign memory_io_dmem_raddr = decoder_io_targets_1_raddr; // @[Top.scala 114:25]
  assign memory_io_dmem_ren = decoder_io_targets_1_ren; // @[Top.scala 114:25]
  assign memory_io_dmem_waddr = decoder_io_targets_1_waddr; // @[Top.scala 114:25]
  assign memory_io_dmem_wen = decoder_io_targets_1_wen; // @[Top.scala 114:25]
  assign memory_io_dmem_wstrb = decoder_io_targets_1_wstrb; // @[Top.scala 114:25]
  assign memory_io_dmem_wdata = decoder_io_targets_1_wdata; // @[Top.scala 114:25]
  assign memory_io_imemReadPort_data = io_imem_data; // @[Top.scala 118:26]
  assign imem_dbus_io_mem_raddr = decoder_io_targets_0_raddr; // @[Top.scala 113:25]
  assign imem_dbus_io_mem_ren = decoder_io_targets_0_ren; // @[Top.scala 113:25]
  assign imem_dbus_io_mem_waddr = decoder_io_targets_0_waddr; // @[Top.scala 113:25]
  assign imem_dbus_io_mem_wen = decoder_io_targets_0_wen; // @[Top.scala 113:25]
  assign imem_dbus_io_mem_wdata = decoder_io_targets_0_wdata; // @[Top.scala 113:25]
  assign imem_dbus_io_read_data = io_imemRead_data; // @[Top.scala 121:21]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_io_mem_wen = decoder_io_targets_2_wen; // @[Top.scala 115:25]
  assign gpio_io_mem_wdata = decoder_io_targets_2_wdata; // @[Top.scala 115:25]
  assign decoder_io_initiator_raddr = core_io_dmem_raddr; // @[Top.scala 120:16]
  assign decoder_io_initiator_ren = core_io_dmem_ren; // @[Top.scala 120:16]
  assign decoder_io_initiator_waddr = core_io_dmem_waddr; // @[Top.scala 120:16]
  assign decoder_io_initiator_wen = core_io_dmem_wen; // @[Top.scala 120:16]
  assign decoder_io_initiator_wstrb = core_io_dmem_wstrb; // @[Top.scala 120:16]
  assign decoder_io_initiator_wdata = core_io_dmem_wdata; // @[Top.scala 120:16]
  assign decoder_io_targets_0_rdata = imem_dbus_io_mem_rdata; // @[Top.scala 113:25]
  assign decoder_io_targets_1_rdata = memory_io_dmem_rdata; // @[Top.scala 114:25]
  assign decoder_io_targets_1_rvalid = memory_io_dmem_rvalid; // @[Top.scala 114:25]
endmodule
