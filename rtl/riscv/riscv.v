module Core(
  input         clock,
  input         reset,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_inst,
  output [31:0] io_dmem_addr,
  input  [31:0] io_dmem_rdata,
  output        io_dmem_ren,
  input         io_dmem_rvalid,
  output [1:0]  io_dmem_wen,
  output [31:0] io_dmem_wdata,
  output [15:0] io_led
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile [0:31]; // @[Core.scala 18:20]
  wire [31:0] regfile_id_rs1_data_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_id_rs1_data_MPORT_addr; // @[Core.scala 18:20]
  wire [31:0] regfile_id_rs2_data_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_id_rs2_data_MPORT_addr; // @[Core.scala 18:20]
  wire [31:0] regfile_io_led_MPORT_data; // @[Core.scala 18:20]
  wire [4:0] regfile_io_led_MPORT_addr; // @[Core.scala 18:20]
  wire [31:0] regfile_MPORT_1_data; // @[Core.scala 18:20]
  wire [4:0] regfile_MPORT_1_addr; // @[Core.scala 18:20]
  wire  regfile_MPORT_1_mask; // @[Core.scala 18:20]
  wire  regfile_MPORT_1_en; // @[Core.scala 18:20]
  reg [31:0] csr_regfile [0:4095]; // @[Core.scala 19:24]
  wire [31:0] csr_regfile_if_pc_next_MPORT_data; // @[Core.scala 19:24]
  wire [11:0] csr_regfile_if_pc_next_MPORT_addr; // @[Core.scala 19:24]
  wire [31:0] csr_regfile_csr_rdata_data; // @[Core.scala 19:24]
  wire [11:0] csr_regfile_csr_rdata_addr; // @[Core.scala 19:24]
  wire [31:0] csr_regfile_MPORT_data; // @[Core.scala 19:24]
  wire [11:0] csr_regfile_MPORT_addr; // @[Core.scala 19:24]
  wire  csr_regfile_MPORT_mask; // @[Core.scala 19:24]
  wire  csr_regfile_MPORT_en; // @[Core.scala 19:24]
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
  reg [31:0] mem_reg_pc; // @[Core.scala 48:38]
  reg [4:0] mem_reg_wb_addr; // @[Core.scala 49:38]
  reg [31:0] mem_reg_op1_data; // @[Core.scala 50:38]
  reg [31:0] mem_reg_rs2_data; // @[Core.scala 51:38]
  reg [1:0] mem_reg_mem_wen; // @[Core.scala 52:38]
  reg [1:0] mem_reg_rf_wen; // @[Core.scala 53:38]
  reg [2:0] mem_reg_wb_sel; // @[Core.scala 54:38]
  reg [11:0] mem_reg_csr_addr; // @[Core.scala 55:38]
  reg [2:0] mem_reg_csr_cmd; // @[Core.scala 56:38]
  reg [31:0] mem_reg_alu_out; // @[Core.scala 58:38]
  reg [4:0] wb_reg_wb_addr; // @[Core.scala 61:38]
  reg [1:0] wb_reg_rf_wen; // @[Core.scala 62:38]
  reg [31:0] wb_reg_wb_data; // @[Core.scala 63:38]
  reg [31:0] if_reg_pc; // @[Core.scala 69:26]
  wire [31:0] if_pc_plus4 = if_reg_pc + 32'h4; // @[Core.scala 80:31]
  wire  _if_pc_next_T_1 = 32'h73 == io_imem_inst; // @[Core.scala 85:14]
  wire  _id_rs1_data_hazard_T = exe_reg_rf_wen == 2'h1; // @[Core.scala 109:44]
  wire [4:0] id_rs1_addr_b = id_reg_inst[19:15]; // @[Core.scala 105:34]
  wire  id_rs1_data_hazard = exe_reg_rf_wen == 2'h1 & id_rs1_addr_b != 5'h0 & id_rs1_addr_b == exe_reg_wb_addr; // @[Core.scala 109:82]
  wire [4:0] id_rs2_addr_b = id_reg_inst[24:20]; // @[Core.scala 106:34]
  wire  id_rs2_data_hazard = _id_rs1_data_hazard_T & id_rs2_addr_b != 5'h0 & id_rs2_addr_b == exe_reg_wb_addr; // @[Core.scala 110:82]
  wire  mem_stall_flg = io_dmem_ren & ~io_dmem_rvalid; // @[Core.scala 280:32]
  wire  stall_flg = id_rs1_data_hazard | id_rs2_data_hazard | mem_stall_flg; // @[Core.scala 111:57]
  wire [31:0] _if_pc_next_T_2 = stall_flg ? if_reg_pc : if_pc_plus4; // @[Mux.scala 98:16]
  wire  exe_jmp_flg = exe_reg_wb_sel == 3'h2; // @[Core.scala 257:34]
  wire  _exe_alu_out_T = exe_reg_exe_fun == 5'h1; // @[Core.scala 232:22]
  wire [31:0] _exe_alu_out_T_2 = exe_reg_op1_data + exe_reg_op2_data; // @[Core.scala 232:58]
  wire  _exe_alu_out_T_3 = exe_reg_exe_fun == 5'h2; // @[Core.scala 233:22]
  wire [31:0] _exe_alu_out_T_5 = exe_reg_op1_data - exe_reg_op2_data; // @[Core.scala 233:58]
  wire  _exe_alu_out_T_6 = exe_reg_exe_fun == 5'h3; // @[Core.scala 234:22]
  wire [31:0] _exe_alu_out_T_7 = exe_reg_op1_data & exe_reg_op2_data; // @[Core.scala 234:58]
  wire  _exe_alu_out_T_8 = exe_reg_exe_fun == 5'h4; // @[Core.scala 235:22]
  wire [31:0] _exe_alu_out_T_9 = exe_reg_op1_data | exe_reg_op2_data; // @[Core.scala 235:58]
  wire  _exe_alu_out_T_10 = exe_reg_exe_fun == 5'h5; // @[Core.scala 236:22]
  wire [31:0] _exe_alu_out_T_11 = exe_reg_op1_data ^ exe_reg_op2_data; // @[Core.scala 236:58]
  wire  _exe_alu_out_T_12 = exe_reg_exe_fun == 5'h6; // @[Core.scala 237:22]
  wire [62:0] _GEN_37 = {{31'd0}, exe_reg_op1_data}; // @[Core.scala 237:58]
  wire [62:0] _exe_alu_out_T_14 = _GEN_37 << exe_reg_op2_data[4:0]; // @[Core.scala 237:58]
  wire  _exe_alu_out_T_16 = exe_reg_exe_fun == 5'h7; // @[Core.scala 238:22]
  wire [31:0] _exe_alu_out_T_18 = exe_reg_op1_data >> exe_reg_op2_data[4:0]; // @[Core.scala 238:58]
  wire  _exe_alu_out_T_19 = exe_reg_exe_fun == 5'h8; // @[Core.scala 239:22]
  wire [31:0] _exe_alu_out_T_23 = $signed(exe_reg_op1_data) >>> exe_reg_op2_data[4:0]; // @[Core.scala 239:100]
  wire  _exe_alu_out_T_24 = exe_reg_exe_fun == 5'h9; // @[Core.scala 240:22]
  wire  _exe_alu_out_T_27 = $signed(exe_reg_op1_data) < $signed(exe_reg_op2_data); // @[Core.scala 240:67]
  wire  _exe_alu_out_T_28 = exe_reg_exe_fun == 5'ha; // @[Core.scala 241:22]
  wire  _exe_alu_out_T_29 = exe_reg_op1_data < exe_reg_op2_data; // @[Core.scala 241:58]
  wire  _exe_alu_out_T_30 = exe_reg_exe_fun == 5'h11; // @[Core.scala 242:22]
  wire [31:0] _exe_alu_out_T_34 = _exe_alu_out_T_2 & 32'hfffffffe; // @[Core.scala 242:79]
  wire  _exe_alu_out_T_35 = exe_reg_exe_fun == 5'h12; // @[Core.scala 243:22]
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
  wire  _exe_br_flg_T = exe_reg_exe_fun == 5'hb; // @[Core.scala 248:22]
  wire  _exe_br_flg_T_1 = exe_reg_op1_data == exe_reg_op2_data; // @[Core.scala 248:57]
  wire  _exe_br_flg_T_2 = exe_reg_exe_fun == 5'hc; // @[Core.scala 249:22]
  wire  _exe_br_flg_T_4 = ~_exe_br_flg_T_1; // @[Core.scala 249:38]
  wire  _exe_br_flg_T_5 = exe_reg_exe_fun == 5'hd; // @[Core.scala 250:22]
  wire  _exe_br_flg_T_9 = exe_reg_exe_fun == 5'he; // @[Core.scala 251:22]
  wire  _exe_br_flg_T_13 = ~_exe_alu_out_T_27; // @[Core.scala 251:38]
  wire  _exe_br_flg_T_14 = exe_reg_exe_fun == 5'hf; // @[Core.scala 252:22]
  wire  _exe_br_flg_T_16 = exe_reg_exe_fun == 5'h10; // @[Core.scala 253:22]
  wire  _exe_br_flg_T_18 = ~_exe_alu_out_T_29; // @[Core.scala 253:38]
  wire  _exe_br_flg_T_20 = _exe_br_flg_T_14 ? _exe_alu_out_T_29 : _exe_br_flg_T_16 & _exe_br_flg_T_18; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_21 = _exe_br_flg_T_9 ? _exe_br_flg_T_13 : _exe_br_flg_T_20; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_22 = _exe_br_flg_T_5 ? _exe_alu_out_T_27 : _exe_br_flg_T_21; // @[Mux.scala 98:16]
  wire  _exe_br_flg_T_23 = _exe_br_flg_T_2 ? _exe_br_flg_T_4 : _exe_br_flg_T_22; // @[Mux.scala 98:16]
  wire  exe_br_flg = _exe_br_flg_T ? _exe_br_flg_T_1 : _exe_br_flg_T_23; // @[Mux.scala 98:16]
  wire [31:0] exe_br_target = exe_reg_pc + exe_reg_imm_b_sext; // @[Core.scala 255:31]
  wire  _id_reg_inst_T = exe_br_flg | exe_jmp_flg; // @[Core.scala 96:17]
  wire [31:0] id_inst = _id_reg_inst_T | stall_flg ? 32'h13 : id_reg_inst; // @[Core.scala 114:20]
  wire [4:0] id_rs1_addr = id_inst[19:15]; // @[Core.scala 116:28]
  wire [4:0] id_rs2_addr = id_inst[24:20]; // @[Core.scala 117:28]
  wire [4:0] id_wb_addr = id_inst[11:7]; // @[Core.scala 118:28]
  wire  _id_rs1_data_T = id_rs1_addr == 5'h0; // @[Core.scala 122:18]
  wire  _id_rs1_data_T_2 = mem_reg_rf_wen == 2'h1; // @[Core.scala 123:59]
  wire  _id_rs1_data_T_3 = id_rs1_addr == mem_reg_wb_addr & mem_reg_rf_wen == 2'h1; // @[Core.scala 123:40]
  wire  _id_rs1_data_T_5 = wb_reg_rf_wen == 2'h1; // @[Core.scala 124:59]
  wire  _id_rs1_data_T_6 = id_rs1_addr == wb_reg_wb_addr & wb_reg_rf_wen == 2'h1; // @[Core.scala 124:40]
  wire [31:0] _id_rs1_data_T_7 = _id_rs1_data_T_6 ? wb_reg_wb_data : regfile_id_rs1_data_MPORT_data; // @[Mux.scala 98:16]
  wire  _mem_wb_data_T = mem_reg_wb_sel == 3'h1; // @[Core.scala 301:21]
  wire  _mem_wb_data_T_1 = mem_reg_wb_sel == 3'h2; // @[Core.scala 302:21]
  wire [31:0] _mem_wb_data_T_3 = mem_reg_pc + 32'h4; // @[Core.scala 302:48]
  wire  _mem_wb_data_T_4 = mem_reg_wb_sel == 3'h3; // @[Core.scala 303:21]
  wire [31:0] _mem_wb_data_T_5 = _mem_wb_data_T_4 ? csr_regfile_csr_rdata_data : mem_reg_alu_out; // @[Mux.scala 98:16]
  wire [31:0] _mem_wb_data_T_6 = _mem_wb_data_T_1 ? _mem_wb_data_T_3 : _mem_wb_data_T_5; // @[Mux.scala 98:16]
  wire [31:0] mem_wb_data = _mem_wb_data_T ? io_dmem_rdata : _mem_wb_data_T_6; // @[Mux.scala 98:16]
  wire [31:0] _id_rs1_data_T_8 = _id_rs1_data_T_3 ? mem_wb_data : _id_rs1_data_T_7; // @[Mux.scala 98:16]
  wire  _id_rs2_data_T = id_rs2_addr == 5'h0; // @[Core.scala 127:18]
  wire  _id_rs2_data_T_3 = id_rs2_addr == mem_reg_wb_addr & _id_rs1_data_T_2; // @[Core.scala 128:40]
  wire  _id_rs2_data_T_6 = id_rs2_addr == wb_reg_wb_addr & _id_rs1_data_T_5; // @[Core.scala 129:40]
  wire [31:0] _id_rs2_data_T_7 = _id_rs2_data_T_6 ? wb_reg_wb_data : regfile_id_rs2_data_MPORT_data; // @[Mux.scala 98:16]
  wire [31:0] _id_rs2_data_T_8 = _id_rs2_data_T_3 ? mem_wb_data : _id_rs2_data_T_7; // @[Mux.scala 98:16]
  wire [11:0] id_imm_i = id_inst[31:20]; // @[Core.scala 132:25]
  wire [19:0] id_imm_i_sext_hi = id_imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_i_sext = {id_imm_i_sext_hi,id_imm_i}; // @[Cat.scala 30:58]
  wire [6:0] id_imm_s_hi = id_inst[31:25]; // @[Core.scala 134:29]
  wire [11:0] id_imm_s = {id_imm_s_hi,id_wb_addr}; // @[Cat.scala 30:58]
  wire [19:0] id_imm_s_sext_hi = id_imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_s_sext = {id_imm_s_sext_hi,id_imm_s_hi,id_wb_addr}; // @[Cat.scala 30:58]
  wire  id_imm_b_hi_hi = id_inst[31]; // @[Core.scala 136:29]
  wire  id_imm_b_hi_lo = id_inst[7]; // @[Core.scala 136:42]
  wire [5:0] id_imm_b_lo_hi = id_inst[30:25]; // @[Core.scala 136:54]
  wire [3:0] id_imm_b_lo_lo = id_inst[11:8]; // @[Core.scala 136:71]
  wire [11:0] id_imm_b = {id_imm_b_hi_hi,id_imm_b_hi_lo,id_imm_b_lo_hi,id_imm_b_lo_lo}; // @[Cat.scala 30:58]
  wire [18:0] id_imm_b_sext_hi_hi = id_imm_b[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_b_sext = {id_imm_b_sext_hi_hi,id_imm_b_hi_hi,id_imm_b_hi_lo,id_imm_b_lo_hi,id_imm_b_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [7:0] id_imm_j_hi_lo = id_inst[19:12]; // @[Core.scala 138:42]
  wire  id_imm_j_lo_hi = id_inst[20]; // @[Core.scala 138:59]
  wire [9:0] id_imm_j_lo_lo = id_inst[30:21]; // @[Core.scala 138:72]
  wire [19:0] id_imm_j = {id_imm_b_hi_hi,id_imm_j_hi_lo,id_imm_j_lo_hi,id_imm_j_lo_lo}; // @[Cat.scala 30:58]
  wire [10:0] id_imm_j_sext_hi_hi = id_imm_j[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] id_imm_j_sext = {id_imm_j_sext_hi_hi,id_imm_b_hi_hi,id_imm_j_hi_lo,id_imm_j_lo_hi,id_imm_j_lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [19:0] id_imm_u = id_inst[31:12]; // @[Core.scala 140:25]
  wire [31:0] id_imm_u_shifted = {id_imm_u,12'h0}; // @[Cat.scala 30:58]
  wire [31:0] id_imm_z_uext = {27'h0,id_rs1_addr}; // @[Cat.scala 30:58]
  wire [31:0] _csignals_T = id_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_1 = 32'h2003 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_3 = 32'h2023 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_4 = id_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _csignals_T_5 = 32'h33 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_7 = 32'h13 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_9 = 32'h40000033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_11 = 32'h7033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_13 = 32'h6033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_15 = 32'h4033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_17 = 32'h7013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_19 = 32'h6013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_21 = 32'h4013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_23 = 32'h1033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_25 = 32'h5033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_27 = 32'h40005033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_29 = 32'h1013 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_31 = 32'h5013 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_33 = 32'h40005013 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_35 = 32'h2033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_37 = 32'h3033 == _csignals_T_4; // @[Lookup.scala 31:38]
  wire  _csignals_T_39 = 32'h2013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_41 = 32'h3013 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_43 = 32'h63 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_45 = 32'h1063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_47 = 32'h5063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_49 = 32'h7063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_51 = 32'h4063 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_53 = 32'h6063 == _csignals_T; // @[Lookup.scala 31:38]
  wire [31:0] _csignals_T_54 = id_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _csignals_T_55 = 32'h6f == _csignals_T_54; // @[Lookup.scala 31:38]
  wire  _csignals_T_57 = 32'h67 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_59 = 32'h37 == _csignals_T_54; // @[Lookup.scala 31:38]
  wire  _csignals_T_61 = 32'h17 == _csignals_T_54; // @[Lookup.scala 31:38]
  wire  _csignals_T_63 = 32'h1073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_65 = 32'h5073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_67 = 32'h2073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_69 = 32'h6073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_71 = 32'h3073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_73 = 32'h7073 == _csignals_T; // @[Lookup.scala 31:38]
  wire  _csignals_T_75 = 32'h73 == id_inst; // @[Lookup.scala 31:38]
  wire [4:0] _csignals_T_77 = _csignals_T_73 ? 5'h12 : 5'h0; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_78 = _csignals_T_71 ? 5'h12 : _csignals_T_77; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_79 = _csignals_T_69 ? 5'h12 : _csignals_T_78; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_80 = _csignals_T_67 ? 5'h12 : _csignals_T_79; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_81 = _csignals_T_65 ? 5'h12 : _csignals_T_80; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_82 = _csignals_T_63 ? 5'h12 : _csignals_T_81; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_83 = _csignals_T_61 ? 5'h1 : _csignals_T_82; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_84 = _csignals_T_59 ? 5'h1 : _csignals_T_83; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_85 = _csignals_T_57 ? 5'h11 : _csignals_T_84; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_86 = _csignals_T_55 ? 5'h1 : _csignals_T_85; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_87 = _csignals_T_53 ? 5'hf : _csignals_T_86; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_88 = _csignals_T_51 ? 5'hd : _csignals_T_87; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_89 = _csignals_T_49 ? 5'h10 : _csignals_T_88; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_90 = _csignals_T_47 ? 5'he : _csignals_T_89; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_91 = _csignals_T_45 ? 5'hc : _csignals_T_90; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_92 = _csignals_T_43 ? 5'hb : _csignals_T_91; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_93 = _csignals_T_41 ? 5'ha : _csignals_T_92; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_94 = _csignals_T_39 ? 5'h9 : _csignals_T_93; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_95 = _csignals_T_37 ? 5'ha : _csignals_T_94; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_96 = _csignals_T_35 ? 5'h9 : _csignals_T_95; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_97 = _csignals_T_33 ? 5'h8 : _csignals_T_96; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_98 = _csignals_T_31 ? 5'h7 : _csignals_T_97; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_99 = _csignals_T_29 ? 5'h6 : _csignals_T_98; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_100 = _csignals_T_27 ? 5'h8 : _csignals_T_99; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_101 = _csignals_T_25 ? 5'h7 : _csignals_T_100; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_102 = _csignals_T_23 ? 5'h6 : _csignals_T_101; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_103 = _csignals_T_21 ? 5'h5 : _csignals_T_102; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_104 = _csignals_T_19 ? 5'h4 : _csignals_T_103; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_105 = _csignals_T_17 ? 5'h3 : _csignals_T_104; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_106 = _csignals_T_15 ? 5'h5 : _csignals_T_105; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_107 = _csignals_T_13 ? 5'h4 : _csignals_T_106; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_108 = _csignals_T_11 ? 5'h3 : _csignals_T_107; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_109 = _csignals_T_9 ? 5'h2 : _csignals_T_108; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_110 = _csignals_T_7 ? 5'h1 : _csignals_T_109; // @[Lookup.scala 33:37]
  wire [4:0] _csignals_T_111 = _csignals_T_5 ? 5'h1 : _csignals_T_110; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_113 = _csignals_T_75 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_114 = _csignals_T_73 ? 2'h3 : _csignals_T_113; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_115 = _csignals_T_71 ? 2'h0 : _csignals_T_114; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_116 = _csignals_T_69 ? 2'h3 : _csignals_T_115; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_117 = _csignals_T_67 ? 2'h0 : _csignals_T_116; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_118 = _csignals_T_65 ? 2'h3 : _csignals_T_117; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_119 = _csignals_T_63 ? 2'h0 : _csignals_T_118; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_120 = _csignals_T_61 ? 2'h1 : _csignals_T_119; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_121 = _csignals_T_59 ? 2'h2 : _csignals_T_120; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_122 = _csignals_T_57 ? 2'h0 : _csignals_T_121; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_123 = _csignals_T_55 ? 2'h1 : _csignals_T_122; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_124 = _csignals_T_53 ? 2'h0 : _csignals_T_123; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_125 = _csignals_T_51 ? 2'h0 : _csignals_T_124; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_126 = _csignals_T_49 ? 2'h0 : _csignals_T_125; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_127 = _csignals_T_47 ? 2'h0 : _csignals_T_126; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_128 = _csignals_T_45 ? 2'h0 : _csignals_T_127; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_129 = _csignals_T_43 ? 2'h0 : _csignals_T_128; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_130 = _csignals_T_41 ? 2'h0 : _csignals_T_129; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_131 = _csignals_T_39 ? 2'h0 : _csignals_T_130; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_132 = _csignals_T_37 ? 2'h0 : _csignals_T_131; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_133 = _csignals_T_35 ? 2'h0 : _csignals_T_132; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_134 = _csignals_T_33 ? 2'h0 : _csignals_T_133; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_135 = _csignals_T_31 ? 2'h0 : _csignals_T_134; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_136 = _csignals_T_29 ? 2'h0 : _csignals_T_135; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_137 = _csignals_T_27 ? 2'h0 : _csignals_T_136; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_138 = _csignals_T_25 ? 2'h0 : _csignals_T_137; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_139 = _csignals_T_23 ? 2'h0 : _csignals_T_138; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_140 = _csignals_T_21 ? 2'h0 : _csignals_T_139; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_141 = _csignals_T_19 ? 2'h0 : _csignals_T_140; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_142 = _csignals_T_17 ? 2'h0 : _csignals_T_141; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_143 = _csignals_T_15 ? 2'h0 : _csignals_T_142; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_144 = _csignals_T_13 ? 2'h0 : _csignals_T_143; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_145 = _csignals_T_11 ? 2'h0 : _csignals_T_144; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_146 = _csignals_T_9 ? 2'h0 : _csignals_T_145; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_147 = _csignals_T_7 ? 2'h0 : _csignals_T_146; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_148 = _csignals_T_5 ? 2'h0 : _csignals_T_147; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_149 = _csignals_T_3 ? 2'h0 : _csignals_T_148; // @[Lookup.scala 33:37]
  wire [1:0] csignals_1 = _csignals_T_1 ? 2'h0 : _csignals_T_149; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_150 = _csignals_T_75 ? 3'h0 : 3'h1; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_151 = _csignals_T_73 ? 3'h0 : _csignals_T_150; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_152 = _csignals_T_71 ? 3'h0 : _csignals_T_151; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_153 = _csignals_T_69 ? 3'h0 : _csignals_T_152; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_154 = _csignals_T_67 ? 3'h0 : _csignals_T_153; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_155 = _csignals_T_65 ? 3'h0 : _csignals_T_154; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_156 = _csignals_T_63 ? 3'h0 : _csignals_T_155; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_157 = _csignals_T_61 ? 3'h5 : _csignals_T_156; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_158 = _csignals_T_59 ? 3'h5 : _csignals_T_157; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_159 = _csignals_T_57 ? 3'h2 : _csignals_T_158; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_160 = _csignals_T_55 ? 3'h4 : _csignals_T_159; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_161 = _csignals_T_53 ? 3'h1 : _csignals_T_160; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_162 = _csignals_T_51 ? 3'h1 : _csignals_T_161; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_163 = _csignals_T_49 ? 3'h1 : _csignals_T_162; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_164 = _csignals_T_47 ? 3'h1 : _csignals_T_163; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_165 = _csignals_T_45 ? 3'h1 : _csignals_T_164; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_166 = _csignals_T_43 ? 3'h1 : _csignals_T_165; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_167 = _csignals_T_41 ? 3'h2 : _csignals_T_166; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_168 = _csignals_T_39 ? 3'h2 : _csignals_T_167; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_169 = _csignals_T_37 ? 3'h1 : _csignals_T_168; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_170 = _csignals_T_35 ? 3'h1 : _csignals_T_169; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_171 = _csignals_T_33 ? 3'h2 : _csignals_T_170; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_172 = _csignals_T_31 ? 3'h2 : _csignals_T_171; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_173 = _csignals_T_29 ? 3'h2 : _csignals_T_172; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_174 = _csignals_T_27 ? 3'h1 : _csignals_T_173; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_175 = _csignals_T_25 ? 3'h1 : _csignals_T_174; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_176 = _csignals_T_23 ? 3'h1 : _csignals_T_175; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_177 = _csignals_T_21 ? 3'h2 : _csignals_T_176; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_178 = _csignals_T_19 ? 3'h2 : _csignals_T_177; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_179 = _csignals_T_17 ? 3'h2 : _csignals_T_178; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_180 = _csignals_T_15 ? 3'h1 : _csignals_T_179; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_181 = _csignals_T_13 ? 3'h1 : _csignals_T_180; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_182 = _csignals_T_11 ? 3'h1 : _csignals_T_181; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_183 = _csignals_T_9 ? 3'h1 : _csignals_T_182; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_184 = _csignals_T_7 ? 3'h2 : _csignals_T_183; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_185 = _csignals_T_5 ? 3'h1 : _csignals_T_184; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_186 = _csignals_T_3 ? 3'h3 : _csignals_T_185; // @[Lookup.scala 33:37]
  wire [2:0] csignals_2 = _csignals_T_1 ? 3'h2 : _csignals_T_186; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_225 = _csignals_T_73 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_226 = _csignals_T_71 ? 2'h1 : _csignals_T_225; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_227 = _csignals_T_69 ? 2'h1 : _csignals_T_226; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_228 = _csignals_T_67 ? 2'h1 : _csignals_T_227; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_229 = _csignals_T_65 ? 2'h1 : _csignals_T_228; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_230 = _csignals_T_63 ? 2'h1 : _csignals_T_229; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_231 = _csignals_T_61 ? 2'h1 : _csignals_T_230; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_232 = _csignals_T_59 ? 2'h1 : _csignals_T_231; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_233 = _csignals_T_57 ? 2'h1 : _csignals_T_232; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_234 = _csignals_T_55 ? 2'h1 : _csignals_T_233; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_235 = _csignals_T_53 ? 2'h0 : _csignals_T_234; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_236 = _csignals_T_51 ? 2'h0 : _csignals_T_235; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_237 = _csignals_T_49 ? 2'h0 : _csignals_T_236; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_238 = _csignals_T_47 ? 2'h0 : _csignals_T_237; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_239 = _csignals_T_45 ? 2'h0 : _csignals_T_238; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_240 = _csignals_T_43 ? 2'h0 : _csignals_T_239; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_241 = _csignals_T_41 ? 2'h1 : _csignals_T_240; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_242 = _csignals_T_39 ? 2'h1 : _csignals_T_241; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_243 = _csignals_T_37 ? 2'h1 : _csignals_T_242; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_244 = _csignals_T_35 ? 2'h1 : _csignals_T_243; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_245 = _csignals_T_33 ? 2'h1 : _csignals_T_244; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_246 = _csignals_T_31 ? 2'h1 : _csignals_T_245; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_247 = _csignals_T_29 ? 2'h1 : _csignals_T_246; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_248 = _csignals_T_27 ? 2'h1 : _csignals_T_247; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_249 = _csignals_T_25 ? 2'h1 : _csignals_T_248; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_250 = _csignals_T_23 ? 2'h1 : _csignals_T_249; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_251 = _csignals_T_21 ? 2'h1 : _csignals_T_250; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_252 = _csignals_T_19 ? 2'h1 : _csignals_T_251; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_253 = _csignals_T_17 ? 2'h1 : _csignals_T_252; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_254 = _csignals_T_15 ? 2'h1 : _csignals_T_253; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_255 = _csignals_T_13 ? 2'h1 : _csignals_T_254; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_256 = _csignals_T_11 ? 2'h1 : _csignals_T_255; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_257 = _csignals_T_9 ? 2'h1 : _csignals_T_256; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_258 = _csignals_T_7 ? 2'h1 : _csignals_T_257; // @[Lookup.scala 33:37]
  wire [1:0] _csignals_T_259 = _csignals_T_5 ? 2'h1 : _csignals_T_258; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_262 = _csignals_T_73 ? 3'h3 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_263 = _csignals_T_71 ? 3'h3 : _csignals_T_262; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_264 = _csignals_T_69 ? 3'h3 : _csignals_T_263; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_265 = _csignals_T_67 ? 3'h3 : _csignals_T_264; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_266 = _csignals_T_65 ? 3'h3 : _csignals_T_265; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_267 = _csignals_T_63 ? 3'h3 : _csignals_T_266; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_268 = _csignals_T_61 ? 3'h0 : _csignals_T_267; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_269 = _csignals_T_59 ? 3'h0 : _csignals_T_268; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_270 = _csignals_T_57 ? 3'h2 : _csignals_T_269; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_271 = _csignals_T_55 ? 3'h2 : _csignals_T_270; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_272 = _csignals_T_53 ? 3'h0 : _csignals_T_271; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_273 = _csignals_T_51 ? 3'h0 : _csignals_T_272; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_274 = _csignals_T_49 ? 3'h0 : _csignals_T_273; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_275 = _csignals_T_47 ? 3'h0 : _csignals_T_274; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_276 = _csignals_T_45 ? 3'h0 : _csignals_T_275; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_277 = _csignals_T_43 ? 3'h0 : _csignals_T_276; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_278 = _csignals_T_41 ? 3'h0 : _csignals_T_277; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_279 = _csignals_T_39 ? 3'h0 : _csignals_T_278; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_280 = _csignals_T_37 ? 3'h0 : _csignals_T_279; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_281 = _csignals_T_35 ? 3'h0 : _csignals_T_280; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_282 = _csignals_T_33 ? 3'h0 : _csignals_T_281; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_283 = _csignals_T_31 ? 3'h0 : _csignals_T_282; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_284 = _csignals_T_29 ? 3'h0 : _csignals_T_283; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_285 = _csignals_T_27 ? 3'h0 : _csignals_T_284; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_286 = _csignals_T_25 ? 3'h0 : _csignals_T_285; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_287 = _csignals_T_23 ? 3'h0 : _csignals_T_286; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_288 = _csignals_T_21 ? 3'h0 : _csignals_T_287; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_289 = _csignals_T_19 ? 3'h0 : _csignals_T_288; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_290 = _csignals_T_17 ? 3'h0 : _csignals_T_289; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_291 = _csignals_T_15 ? 3'h0 : _csignals_T_290; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_292 = _csignals_T_13 ? 3'h0 : _csignals_T_291; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_293 = _csignals_T_11 ? 3'h0 : _csignals_T_292; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_294 = _csignals_T_9 ? 3'h0 : _csignals_T_293; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_295 = _csignals_T_7 ? 3'h0 : _csignals_T_294; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_296 = _csignals_T_5 ? 3'h0 : _csignals_T_295; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_298 = _csignals_T_75 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_299 = _csignals_T_73 ? 3'h3 : _csignals_T_298; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_300 = _csignals_T_71 ? 3'h3 : _csignals_T_299; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_301 = _csignals_T_69 ? 3'h2 : _csignals_T_300; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_302 = _csignals_T_67 ? 3'h2 : _csignals_T_301; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_303 = _csignals_T_65 ? 3'h1 : _csignals_T_302; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_304 = _csignals_T_63 ? 3'h1 : _csignals_T_303; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_305 = _csignals_T_61 ? 3'h0 : _csignals_T_304; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_306 = _csignals_T_59 ? 3'h0 : _csignals_T_305; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_307 = _csignals_T_57 ? 3'h0 : _csignals_T_306; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_308 = _csignals_T_55 ? 3'h0 : _csignals_T_307; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_309 = _csignals_T_53 ? 3'h0 : _csignals_T_308; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_310 = _csignals_T_51 ? 3'h0 : _csignals_T_309; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_311 = _csignals_T_49 ? 3'h0 : _csignals_T_310; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_312 = _csignals_T_47 ? 3'h0 : _csignals_T_311; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_313 = _csignals_T_45 ? 3'h0 : _csignals_T_312; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_314 = _csignals_T_43 ? 3'h0 : _csignals_T_313; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_315 = _csignals_T_41 ? 3'h0 : _csignals_T_314; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_316 = _csignals_T_39 ? 3'h0 : _csignals_T_315; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_317 = _csignals_T_37 ? 3'h0 : _csignals_T_316; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_318 = _csignals_T_35 ? 3'h0 : _csignals_T_317; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_319 = _csignals_T_33 ? 3'h0 : _csignals_T_318; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_320 = _csignals_T_31 ? 3'h0 : _csignals_T_319; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_321 = _csignals_T_29 ? 3'h0 : _csignals_T_320; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_322 = _csignals_T_27 ? 3'h0 : _csignals_T_321; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_323 = _csignals_T_25 ? 3'h0 : _csignals_T_322; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_324 = _csignals_T_23 ? 3'h0 : _csignals_T_323; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_325 = _csignals_T_21 ? 3'h0 : _csignals_T_324; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_326 = _csignals_T_19 ? 3'h0 : _csignals_T_325; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_327 = _csignals_T_17 ? 3'h0 : _csignals_T_326; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_328 = _csignals_T_15 ? 3'h0 : _csignals_T_327; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_329 = _csignals_T_13 ? 3'h0 : _csignals_T_328; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_330 = _csignals_T_11 ? 3'h0 : _csignals_T_329; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_331 = _csignals_T_9 ? 3'h0 : _csignals_T_330; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_332 = _csignals_T_7 ? 3'h0 : _csignals_T_331; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_333 = _csignals_T_5 ? 3'h0 : _csignals_T_332; // @[Lookup.scala 33:37]
  wire [2:0] _csignals_T_334 = _csignals_T_3 ? 3'h0 : _csignals_T_333; // @[Lookup.scala 33:37]
  wire [2:0] csignals_6 = _csignals_T_1 ? 3'h0 : _csignals_T_334; // @[Lookup.scala 33:37]
  wire  _id_op1_data_T = csignals_1 == 2'h0; // @[Core.scala 191:17]
  wire  _id_op1_data_T_1 = csignals_1 == 2'h1; // @[Core.scala 192:17]
  wire  _id_op1_data_T_2 = csignals_1 == 2'h3; // @[Core.scala 193:17]
  wire [31:0] _id_op1_data_T_3 = _id_op1_data_T_2 ? id_imm_z_uext : 32'h0; // @[Mux.scala 98:16]
  wire  _id_op2_data_T = csignals_2 == 3'h1; // @[Core.scala 196:17]
  wire  _id_op2_data_T_1 = csignals_2 == 3'h2; // @[Core.scala 197:17]
  wire  _id_op2_data_T_2 = csignals_2 == 3'h3; // @[Core.scala 198:17]
  wire  _id_op2_data_T_3 = csignals_2 == 3'h4; // @[Core.scala 199:17]
  wire  _id_op2_data_T_4 = csignals_2 == 3'h5; // @[Core.scala 200:17]
  wire [31:0] _id_op2_data_T_5 = _id_op2_data_T_4 ? id_imm_u_shifted : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _id_op2_data_T_6 = _id_op2_data_T_3 ? id_imm_j_sext : _id_op2_data_T_5; // @[Mux.scala 98:16]
  wire [31:0] _id_op2_data_T_7 = _id_op2_data_T_2 ? id_imm_s_sext : _id_op2_data_T_6; // @[Mux.scala 98:16]
  wire  _T = ~mem_stall_flg; // @[Core.scala 208:9]
  wire  _csr_wdata_T = mem_reg_csr_cmd == 3'h1; // @[Core.scala 290:22]
  wire  _csr_wdata_T_1 = mem_reg_csr_cmd == 3'h2; // @[Core.scala 291:22]
  wire [31:0] _csr_wdata_T_2 = csr_regfile_csr_rdata_data | mem_reg_op1_data; // @[Core.scala 291:47]
  wire  _csr_wdata_T_3 = mem_reg_csr_cmd == 3'h3; // @[Core.scala 292:22]
  wire [31:0] _csr_wdata_T_4 = ~mem_reg_op1_data; // @[Core.scala 292:49]
  wire [31:0] _csr_wdata_T_5 = csr_regfile_csr_rdata_data & _csr_wdata_T_4; // @[Core.scala 292:47]
  wire  _csr_wdata_T_6 = mem_reg_csr_cmd == 3'h4; // @[Core.scala 293:22]
  wire [31:0] _csr_wdata_T_7 = _csr_wdata_T_6 ? 32'hb : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _csr_wdata_T_8 = _csr_wdata_T_3 ? _csr_wdata_T_5 : _csr_wdata_T_7; // @[Mux.scala 98:16]
  wire [31:0] _csr_wdata_T_9 = _csr_wdata_T_1 ? _csr_wdata_T_2 : _csr_wdata_T_8; // @[Mux.scala 98:16]
  assign regfile_id_rs1_data_MPORT_addr = id_inst[19:15];
  assign regfile_id_rs1_data_MPORT_data = regfile[regfile_id_rs1_data_MPORT_addr]; // @[Core.scala 18:20]
  assign regfile_id_rs2_data_MPORT_addr = id_inst[24:20];
  assign regfile_id_rs2_data_MPORT_data = regfile[regfile_id_rs2_data_MPORT_addr]; // @[Core.scala 18:20]
  assign regfile_io_led_MPORT_addr = 5'ha;
  assign regfile_io_led_MPORT_data = regfile[regfile_io_led_MPORT_addr]; // @[Core.scala 18:20]
  assign regfile_MPORT_1_data = wb_reg_wb_data;
  assign regfile_MPORT_1_addr = wb_reg_wb_addr;
  assign regfile_MPORT_1_mask = 1'h1;
  assign regfile_MPORT_1_en = wb_reg_rf_wen == 2'h1;
  assign csr_regfile_if_pc_next_MPORT_addr = 12'h305;
  assign csr_regfile_if_pc_next_MPORT_data = csr_regfile[csr_regfile_if_pc_next_MPORT_addr]; // @[Core.scala 19:24]
  assign csr_regfile_csr_rdata_addr = mem_reg_csr_addr;
  assign csr_regfile_csr_rdata_data = csr_regfile[csr_regfile_csr_rdata_addr]; // @[Core.scala 19:24]
  assign csr_regfile_MPORT_data = _csr_wdata_T ? mem_reg_op1_data : _csr_wdata_T_9;
  assign csr_regfile_MPORT_addr = mem_reg_csr_addr;
  assign csr_regfile_MPORT_mask = 1'h1;
  assign csr_regfile_MPORT_en = mem_reg_csr_cmd > 3'h0;
  assign io_imem_addr = if_reg_pc; // @[Core.scala 70:16]
  assign io_dmem_addr = mem_reg_alu_out; // @[Core.scala 282:17]
  assign io_dmem_ren = mem_reg_wb_sel == 3'h1; // @[Core.scala 281:35]
  assign io_dmem_wen = mem_reg_mem_wen; // @[Core.scala 283:17]
  assign io_dmem_wdata = mem_reg_rs2_data; // @[Core.scala 284:17]
  assign io_led = regfile_io_led_MPORT_data[15:0]; // @[Core.scala 324:24]
  always @(posedge clock) begin
    if(regfile_MPORT_1_en & regfile_MPORT_1_mask) begin
      regfile[regfile_MPORT_1_addr] <= regfile_MPORT_1_data; // @[Core.scala 18:20]
    end
    if(csr_regfile_MPORT_en & csr_regfile_MPORT_mask) begin
      csr_regfile[csr_regfile_MPORT_addr] <= csr_regfile_MPORT_data; // @[Core.scala 19:24]
    end
    if (reset) begin // @[Core.scala 26:38]
      id_reg_pc <= 32'h0; // @[Core.scala 26:38]
    end else if (!(stall_flg)) begin // @[Core.scala 93:21]
      id_reg_pc <= if_reg_pc;
    end
    if (reset) begin // @[Core.scala 27:38]
      id_reg_inst <= 32'h0; // @[Core.scala 27:38]
    end else if (_id_reg_inst_T) begin // @[Mux.scala 98:16]
      id_reg_inst <= 32'h13;
    end else if (!(stall_flg)) begin // @[Mux.scala 98:16]
      id_reg_inst <= io_imem_inst;
    end
    if (reset) begin // @[Core.scala 30:38]
      exe_reg_pc <= 32'h0; // @[Core.scala 30:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      exe_reg_pc <= id_reg_pc; // @[Core.scala 209:27]
    end
    if (reset) begin // @[Core.scala 31:38]
      exe_reg_wb_addr <= 5'h0; // @[Core.scala 31:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      exe_reg_wb_addr <= id_wb_addr; // @[Core.scala 213:27]
    end
    if (reset) begin // @[Core.scala 32:38]
      exe_reg_op1_data <= 32'h0; // @[Core.scala 32:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
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
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
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
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
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
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_exe_fun <= 5'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_exe_fun <= 5'h1;
      end else begin
        exe_reg_exe_fun <= _csignals_T_111;
      end
    end
    if (reset) begin // @[Core.scala 36:38]
      exe_reg_mem_wen <= 2'h0; // @[Core.scala 36:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_mem_wen <= 2'h0;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_mem_wen <= 2'h1;
      end else begin
        exe_reg_mem_wen <= 2'h0;
      end
    end
    if (reset) begin // @[Core.scala 37:38]
      exe_reg_rf_wen <= 2'h0; // @[Core.scala 37:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_rf_wen <= 2'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_rf_wen <= 2'h0;
      end else begin
        exe_reg_rf_wen <= _csignals_T_259;
      end
    end
    if (reset) begin // @[Core.scala 38:38]
      exe_reg_wb_sel <= 3'h0; // @[Core.scala 38:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_wb_sel <= 3'h1;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_wb_sel <= 3'h0;
      end else begin
        exe_reg_wb_sel <= _csignals_T_296;
      end
    end
    if (reset) begin // @[Core.scala 39:38]
      exe_reg_csr_addr <= 12'h0; // @[Core.scala 39:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      if (csignals_6 == 3'h4) begin // @[Core.scala 203:24]
        exe_reg_csr_addr <= 12'h342;
      end else begin
        exe_reg_csr_addr <= id_imm_i;
      end
    end
    if (reset) begin // @[Core.scala 40:38]
      exe_reg_csr_cmd <= 3'h0; // @[Core.scala 40:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      if (_csignals_T_1) begin // @[Lookup.scala 33:37]
        exe_reg_csr_cmd <= 3'h0;
      end else if (_csignals_T_3) begin // @[Lookup.scala 33:37]
        exe_reg_csr_cmd <= 3'h0;
      end else begin
        exe_reg_csr_cmd <= _csignals_T_333;
      end
    end
    if (reset) begin // @[Core.scala 43:38]
      exe_reg_imm_b_sext <= 32'h0; // @[Core.scala 43:38]
    end else if (~mem_stall_flg) begin // @[Core.scala 208:26]
      exe_reg_imm_b_sext <= id_imm_b_sext; // @[Core.scala 219:27]
    end
    if (reset) begin // @[Core.scala 48:38]
      mem_reg_pc <= 32'h0; // @[Core.scala 48:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_pc <= exe_reg_pc; // @[Core.scala 263:24]
    end
    if (reset) begin // @[Core.scala 49:38]
      mem_reg_wb_addr <= 5'h0; // @[Core.scala 49:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_wb_addr <= exe_reg_wb_addr; // @[Core.scala 266:24]
    end
    if (reset) begin // @[Core.scala 50:38]
      mem_reg_op1_data <= 32'h0; // @[Core.scala 50:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_op1_data <= exe_reg_op1_data; // @[Core.scala 264:24]
    end
    if (reset) begin // @[Core.scala 51:38]
      mem_reg_rs2_data <= 32'h0; // @[Core.scala 51:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_rs2_data <= exe_reg_rs2_data; // @[Core.scala 265:24]
    end
    if (reset) begin // @[Core.scala 52:38]
      mem_reg_mem_wen <= 2'h0; // @[Core.scala 52:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_mem_wen <= exe_reg_mem_wen; // @[Core.scala 273:24]
    end
    if (reset) begin // @[Core.scala 53:38]
      mem_reg_rf_wen <= 2'h0; // @[Core.scala 53:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_rf_wen <= exe_reg_rf_wen; // @[Core.scala 268:24]
    end
    if (reset) begin // @[Core.scala 54:38]
      mem_reg_wb_sel <= 3'h0; // @[Core.scala 54:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_wb_sel <= exe_reg_wb_sel; // @[Core.scala 269:24]
    end
    if (reset) begin // @[Core.scala 55:38]
      mem_reg_csr_addr <= 12'h0; // @[Core.scala 55:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_csr_addr <= exe_reg_csr_addr; // @[Core.scala 270:24]
    end
    if (reset) begin // @[Core.scala 56:38]
      mem_reg_csr_cmd <= 3'h0; // @[Core.scala 56:38]
    end else if (_T) begin // @[Core.scala 262:26]
      mem_reg_csr_cmd <= exe_reg_csr_cmd; // @[Core.scala 271:24]
    end
    if (reset) begin // @[Core.scala 58:38]
      mem_reg_alu_out <= 32'h0; // @[Core.scala 58:38]
    end else if (_T) begin // @[Core.scala 262:26]
      if (_exe_alu_out_T) begin // @[Mux.scala 98:16]
        mem_reg_alu_out <= _exe_alu_out_T_2;
      end else if (_exe_alu_out_T_3) begin // @[Mux.scala 98:16]
        mem_reg_alu_out <= _exe_alu_out_T_5;
      end else begin
        mem_reg_alu_out <= _exe_alu_out_T_45;
      end
    end
    if (reset) begin // @[Core.scala 61:38]
      wb_reg_wb_addr <= 5'h0; // @[Core.scala 61:38]
    end else begin
      wb_reg_wb_addr <= mem_reg_wb_addr; // @[Core.scala 309:18]
    end
    if (reset) begin // @[Core.scala 62:38]
      wb_reg_rf_wen <= 2'h0; // @[Core.scala 62:38]
    end else if (_T) begin // @[Core.scala 310:24]
      wb_reg_rf_wen <= mem_reg_rf_wen;
    end else begin
      wb_reg_rf_wen <= 2'h0;
    end
    if (reset) begin // @[Core.scala 63:38]
      wb_reg_wb_data <= 32'h0; // @[Core.scala 63:38]
    end else if (_mem_wb_data_T) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= io_dmem_rdata;
    end else if (_mem_wb_data_T_1) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= _mem_wb_data_T_3;
    end else if (_mem_wb_data_T_4) begin // @[Mux.scala 98:16]
      wb_reg_wb_data <= csr_regfile_csr_rdata_data;
    end else begin
      wb_reg_wb_data <= mem_reg_alu_out;
    end
    if (reset) begin // @[Core.scala 69:26]
      if_reg_pc <= 32'h0; // @[Core.scala 69:26]
    end else if (exe_br_flg) begin // @[Mux.scala 98:16]
      if_reg_pc <= exe_br_target;
    end else if (exe_jmp_flg) begin // @[Mux.scala 98:16]
      if (_exe_alu_out_T) begin // @[Mux.scala 98:16]
        if_reg_pc <= _exe_alu_out_T_2;
      end else begin
        if_reg_pc <= _exe_alu_out_T_46;
      end
    end else if (_if_pc_next_T_1) begin // @[Mux.scala 98:16]
      if_reg_pc <= csr_regfile_if_pc_next_MPORT_data;
    end else begin
      if_reg_pc <= _if_pc_next_T_2;
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
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    csr_regfile[initvar] = _RAND_1[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
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
  mem_reg_pc = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mem_reg_wb_addr = _RAND_17[4:0];
  _RAND_18 = {1{`RANDOM}};
  mem_reg_op1_data = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mem_reg_rs2_data = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mem_reg_mem_wen = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  mem_reg_rf_wen = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  mem_reg_wb_sel = _RAND_22[2:0];
  _RAND_23 = {1{`RANDOM}};
  mem_reg_csr_addr = _RAND_23[11:0];
  _RAND_24 = {1{`RANDOM}};
  mem_reg_csr_cmd = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  mem_reg_alu_out = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  wb_reg_wb_addr = _RAND_26[4:0];
  _RAND_27 = {1{`RANDOM}};
  wb_reg_rf_wen = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  wb_reg_wb_data = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  if_reg_pc = _RAND_29[31:0];
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
  input  [31:0] io_dmem_addr,
  output [31:0] io_dmem_rdata,
  input         io_dmem_ren,
  output        io_dmem_rvalid,
  input  [1:0]  io_dmem_wen,
  input  [31:0] io_dmem_wdata
);
initial begin
  $readmemh("/home/isaka/kivantium-core/test/test.hex", mem);
end
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem [0:16383]; // @[Memory.scala 43:16]
  wire [7:0] mem_instData_hi_hi_data; // @[Memory.scala 43:16]
  wire [13:0] mem_instData_hi_hi_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_instData_hi_lo_data; // @[Memory.scala 43:16]
  wire [13:0] mem_instData_hi_lo_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_instData_lo_hi_data; // @[Memory.scala 43:16]
  wire [13:0] mem_instData_lo_hi_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_instData_lo_lo_data; // @[Memory.scala 43:16]
  wire [13:0] mem_instData_lo_lo_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_rdata_hi_hi_data; // @[Memory.scala 43:16]
  wire [13:0] mem_rdata_hi_hi_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_rdata_hi_lo_data; // @[Memory.scala 43:16]
  wire [13:0] mem_rdata_hi_lo_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_rdata_lo_hi_data; // @[Memory.scala 43:16]
  wire [13:0] mem_rdata_lo_hi_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_rdata_lo_lo_data; // @[Memory.scala 43:16]
  wire [13:0] mem_rdata_lo_lo_addr; // @[Memory.scala 43:16]
  wire [7:0] mem_MPORT_data; // @[Memory.scala 43:16]
  wire [13:0] mem_MPORT_addr; // @[Memory.scala 43:16]
  wire  mem_MPORT_mask; // @[Memory.scala 43:16]
  wire  mem_MPORT_en; // @[Memory.scala 43:16]
  wire [7:0] mem_MPORT_1_data; // @[Memory.scala 43:16]
  wire [13:0] mem_MPORT_1_addr; // @[Memory.scala 43:16]
  wire  mem_MPORT_1_mask; // @[Memory.scala 43:16]
  wire  mem_MPORT_1_en; // @[Memory.scala 43:16]
  wire [7:0] mem_MPORT_2_data; // @[Memory.scala 43:16]
  wire [13:0] mem_MPORT_2_addr; // @[Memory.scala 43:16]
  wire  mem_MPORT_2_mask; // @[Memory.scala 43:16]
  wire  mem_MPORT_2_en; // @[Memory.scala 43:16]
  wire [7:0] mem_MPORT_3_data; // @[Memory.scala 43:16]
  wire [13:0] mem_MPORT_3_addr; // @[Memory.scala 43:16]
  wire  mem_MPORT_3_mask; // @[Memory.scala 43:16]
  wire  mem_MPORT_3_en; // @[Memory.scala 43:16]
  wire [31:0] _instData_T_1 = io_imem_addr + 32'h3; // @[Memory.scala 46:22]
  wire [31:0] _instData_T_4 = io_imem_addr + 32'h2; // @[Memory.scala 47:22]
  wire [31:0] _instData_T_7 = io_imem_addr + 32'h1; // @[Memory.scala 48:22]
  wire [15:0] instData_lo = {mem_instData_lo_hi_data,mem_instData_lo_lo_data}; // @[Cat.scala 30:58]
  wire [15:0] instData_hi = {mem_instData_hi_hi_data,mem_instData_hi_lo_data}; // @[Cat.scala 30:58]
  reg [31:0] rdata; // @[Memory.scala 51:22]
  reg  rvalid; // @[Memory.scala 52:23]
  wire  _T = io_dmem_wen == 2'h0; // @[Memory.scala 56:9]
  wire  _T_1 = io_dmem_wen == 2'h0 & io_dmem_ren; // @[Memory.scala 56:22]
  wire [31:0] _rdata_T_1 = io_dmem_addr + 32'h3; // @[Memory.scala 58:24]
  wire [31:0] _rdata_T_4 = io_dmem_addr + 32'h2; // @[Memory.scala 59:24]
  wire [31:0] _rdata_T_7 = io_dmem_addr + 32'h1; // @[Memory.scala 60:24]
  wire [31:0] _rdata_T_10 = {mem_rdata_hi_hi_data,mem_rdata_hi_lo_data,mem_rdata_lo_hi_data,mem_rdata_lo_lo_data}; // @[Cat.scala 30:58]
  assign mem_instData_hi_hi_addr = _instData_T_1[13:0];
  assign mem_instData_hi_hi_data = mem[mem_instData_hi_hi_addr]; // @[Memory.scala 43:16]
  assign mem_instData_hi_lo_addr = _instData_T_4[13:0];
  assign mem_instData_hi_lo_data = mem[mem_instData_hi_lo_addr]; // @[Memory.scala 43:16]
  assign mem_instData_lo_hi_addr = _instData_T_7[13:0];
  assign mem_instData_lo_hi_data = mem[mem_instData_lo_hi_addr]; // @[Memory.scala 43:16]
  assign mem_instData_lo_lo_addr = io_imem_addr[13:0];
  assign mem_instData_lo_lo_data = mem[mem_instData_lo_lo_addr]; // @[Memory.scala 43:16]
  assign mem_rdata_hi_hi_addr = _rdata_T_1[13:0];
  assign mem_rdata_hi_hi_data = mem[mem_rdata_hi_hi_addr]; // @[Memory.scala 43:16]
  assign mem_rdata_hi_lo_addr = _rdata_T_4[13:0];
  assign mem_rdata_hi_lo_data = mem[mem_rdata_hi_lo_addr]; // @[Memory.scala 43:16]
  assign mem_rdata_lo_hi_addr = _rdata_T_7[13:0];
  assign mem_rdata_lo_hi_data = mem[mem_rdata_lo_hi_addr]; // @[Memory.scala 43:16]
  assign mem_rdata_lo_lo_addr = io_dmem_addr[13:0];
  assign mem_rdata_lo_lo_data = mem[mem_rdata_lo_lo_addr]; // @[Memory.scala 43:16]
  assign mem_MPORT_data = io_dmem_wdata[7:0];
  assign mem_MPORT_addr = io_dmem_addr[13:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_dmem_wen == 2'h1;
  assign mem_MPORT_1_data = io_dmem_wdata[15:8];
  assign mem_MPORT_1_addr = _rdata_T_7[13:0];
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_dmem_wen == 2'h1;
  assign mem_MPORT_2_data = io_dmem_wdata[23:16];
  assign mem_MPORT_2_addr = _rdata_T_4[13:0];
  assign mem_MPORT_2_mask = 1'h1;
  assign mem_MPORT_2_en = io_dmem_wen == 2'h1;
  assign mem_MPORT_3_data = io_dmem_wdata[31:24];
  assign mem_MPORT_3_addr = _rdata_T_1[13:0];
  assign mem_MPORT_3_mask = 1'h1;
  assign mem_MPORT_3_en = io_dmem_wen == 2'h1;
  assign io_imem_inst = {instData_hi,instData_lo}; // @[Cat.scala 30:58]
  assign io_dmem_rdata = rdata; // @[Memory.scala 53:17]
  assign io_dmem_rvalid = rvalid; // @[Memory.scala 54:18]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Memory.scala 43:16]
    end
    if(mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[Memory.scala 43:16]
    end
    if(mem_MPORT_2_en & mem_MPORT_2_mask) begin
      mem[mem_MPORT_2_addr] <= mem_MPORT_2_data; // @[Memory.scala 43:16]
    end
    if(mem_MPORT_3_en & mem_MPORT_3_mask) begin
      mem[mem_MPORT_3_addr] <= mem_MPORT_3_data; // @[Memory.scala 43:16]
    end
    if (reset) begin // @[Memory.scala 51:22]
      rdata <= 32'h0; // @[Memory.scala 51:22]
    end else if (io_dmem_wen == 2'h0 & io_dmem_ren) begin // @[Memory.scala 56:39]
      rdata <= _rdata_T_10; // @[Memory.scala 57:11]
    end
    if (reset) begin // @[Memory.scala 52:23]
      rvalid <= 1'h0; // @[Memory.scala 52:23]
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
  for (initvar = 0; initvar < 16384; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  rdata = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rvalid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Top(
  input         clock,
  input         reset,
  output [15:0] io_led
);
  wire  core_clock; // @[Top.scala 13:20]
  wire  core_reset; // @[Top.scala 13:20]
  wire [31:0] core_io_imem_addr; // @[Top.scala 13:20]
  wire [31:0] core_io_imem_inst; // @[Top.scala 13:20]
  wire [31:0] core_io_dmem_addr; // @[Top.scala 13:20]
  wire [31:0] core_io_dmem_rdata; // @[Top.scala 13:20]
  wire  core_io_dmem_ren; // @[Top.scala 13:20]
  wire  core_io_dmem_rvalid; // @[Top.scala 13:20]
  wire [1:0] core_io_dmem_wen; // @[Top.scala 13:20]
  wire [31:0] core_io_dmem_wdata; // @[Top.scala 13:20]
  wire [15:0] core_io_led; // @[Top.scala 13:20]
  wire  memory_clock; // @[Top.scala 14:22]
  wire  memory_reset; // @[Top.scala 14:22]
  wire [31:0] memory_io_imem_addr; // @[Top.scala 14:22]
  wire [31:0] memory_io_imem_inst; // @[Top.scala 14:22]
  wire [31:0] memory_io_dmem_addr; // @[Top.scala 14:22]
  wire [31:0] memory_io_dmem_rdata; // @[Top.scala 14:22]
  wire  memory_io_dmem_ren; // @[Top.scala 14:22]
  wire  memory_io_dmem_rvalid; // @[Top.scala 14:22]
  wire [1:0] memory_io_dmem_wen; // @[Top.scala 14:22]
  wire [31:0] memory_io_dmem_wdata; // @[Top.scala 14:22]
  Core core ( // @[Top.scala 13:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_imem_addr(core_io_imem_addr),
    .io_imem_inst(core_io_imem_inst),
    .io_dmem_addr(core_io_dmem_addr),
    .io_dmem_rdata(core_io_dmem_rdata),
    .io_dmem_ren(core_io_dmem_ren),
    .io_dmem_rvalid(core_io_dmem_rvalid),
    .io_dmem_wen(core_io_dmem_wen),
    .io_dmem_wdata(core_io_dmem_wdata),
    .io_led(core_io_led)
  );
  Memory memory ( // @[Top.scala 14:22]
    .clock(memory_clock),
    .reset(memory_reset),
    .io_imem_addr(memory_io_imem_addr),
    .io_imem_inst(memory_io_imem_inst),
    .io_dmem_addr(memory_io_dmem_addr),
    .io_dmem_rdata(memory_io_dmem_rdata),
    .io_dmem_ren(memory_io_dmem_ren),
    .io_dmem_rvalid(memory_io_dmem_rvalid),
    .io_dmem_wen(memory_io_dmem_wen),
    .io_dmem_wdata(memory_io_dmem_wdata)
  );
  assign io_led = core_io_led; // @[Top.scala 17:12]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_imem_inst = memory_io_imem_inst; // @[Top.scala 15:16]
  assign core_io_dmem_rdata = memory_io_dmem_rdata; // @[Top.scala 16:16]
  assign core_io_dmem_rvalid = memory_io_dmem_rvalid; // @[Top.scala 16:16]
  assign memory_clock = clock;
  assign memory_reset = reset;
  assign memory_io_imem_addr = core_io_imem_addr; // @[Top.scala 15:16]
  assign memory_io_dmem_addr = core_io_dmem_addr; // @[Top.scala 16:16]
  assign memory_io_dmem_ren = core_io_dmem_ren; // @[Top.scala 16:16]
  assign memory_io_dmem_wen = core_io_dmem_wen; // @[Top.scala 16:16]
  assign memory_io_dmem_wdata = core_io_dmem_wdata; // @[Top.scala 16:16]
endmodule
