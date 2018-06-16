// top level

module main(
  input clk,
  input reset,
  output done
);

wire halt;    // high when halted
wire branch;  // high when should branch
wire[7:0] offset;  // offset for branching
wire[7:0] pc_addr; // current PC address

assign done = halt;

// let's start with a program counter
program_counter pc (
  .clk(clk),
  .reset(reset),
  .halt(halt),
  .branch(branch),
  .offset(offset),
  .addr(pc_addr)
);

wire end_pc;  // always contains ending program counter

// halter tells program counter when to stop
halter Halter (
  .clk(clk),
  .endState(end_pc),
  .pc(pc_addr),
  .halt(halt)
);

wire[4:0] imm;      // immediate value from instruction
wire[1:0] rs_addr;  // selector for rs from instruction
wire[1:0] rd_addr;  // selector for rd from instruction
wire[1:0] op;       // op code
wire sp;            // sp bit from instruction

// program counter needs sign extended offset
sign_extender se (
  .in(imm),
  .out(offset)
);

// instruction memory is selected by program counter
// and outputs all the components of the instruction
instr_mem im (
  .addr(pc_addr),
  .imm(imm),
  .rs(rs_addr),
  .rd(rd_addr),
  .op(op),
  .sp(sp),
  .first(end_pc)
);

reg zero;   // always outputs one 0 bit
reg one;    // always outputs one 1 bit
wire mux4_out;    // output line for mux 4
wire mux1_out;    // output line for mux 1
wire[1:0] ctrl4;  // control line for mux 4
wire[1:0] ctrl1;  // control line for mux 1
wire[2:0] rs_addr_sp; // rs_addr extended with sp bit
wire[2:0] rd_addr_sp; // rd_addr extended with sp bit


// before we can move to register file, we need to 
// transform the addresses with the special bit
mux_3x1 mux4 (
  .in_0(sp),
  .in_1(zero),
  .in_2(one),
  .ctrl(ctrl4),
  .out(mux4_out)
);

mux_3x1 mux1 (
  .in_0(sp),
  .in_1(zero),
  .in_2(one),
  .ctrl(ctrl1),
  .out(mux1_out)
);

special_extender rs_sp_ext (
  .sp(mux4_out),
  .in(rs_addr),
  .out(rs_addr_sp)
);

special_extender rd_sp_ext (
  .sp(mux1_out),
  .in(rd_addr),
  .out(rd_addr_sp)
);

wire regWriteEn;      // enables writing to register file
wire[7:0] r0_data;    // data contained in r0 register
wire[7:0] rs_data;    // data contained in rs register
wire[7:0] rd_data;    // data contained in rd register

reg[7:0] zero8;       // contains 0 byte
wire[7:0] mux2_out;   // output line for mux 2
wire[7:0] alu_out;    // output line for ALU
wire[7:0] shift_out;  // output line for shifter
wire[7:0] lfsr_out;   // output line for LFSR
wire[7:0] mem_out;    // output line for memory
wire[2:0] ctrl2;      // control line for mux 2

// the register file outputs and writes to extended register addresses
mux_6x1 mux2 (
  .in_0(zero8),
  .in_1(alu_out),
  .in_2(shift_out),
  .in_3(lfsr_out),
  .in_4(rs_data),
  .in_5(mem_out),
  .ctrl(ctrl2),
  .out(mux2_out)
);

register_file rf (
  .clk(clk),
  .writeEn(regWriteEn),
  .rsAddr(rs_addr_sp),
  .rdAddr(rd_addr_sp),
  .dest(rd_addr_sp),
  .data(mux2_out),
  .r0(r0_data),
  .rsOut(rs_data),
  .rdOut(rd_data)
);

wire ctrl3;         // control line for mux 3
wire z;             // ALU Z flag for zero results
wire[7:0] mux3_out; // output line for mux 3
wire[1:0] ctrl_alu; // control line for ALU

// the ALU takes its data from the register file or constants
// and computes a result
mux_2x1 mux3 (
  .in_0(r0_data),
  .in_1(rd_data),
  .ctrl(ctrl4),
  .out(mux3_out)
);

ALU alu (
  .r0_rd(mux3_out),
  .rs(rs_data),
  .control(ctrl_alu),
  .result(alu_out),
  .z(z)
);

wire ctrl_np;     // control line for prev / next lfsr
wire lfsrWriteEn; // tap writing enable

// LFSR reads from the register file and writes back to it
lfsr LFSR (
  .clk(clk),
  .in(rs_data),
  .np(ctrl_np),
  .tapEn(lfsrWriteEn),
  .tapData(rd_data),
  .out(lfsr_out)
);

// shifter reads from register file and write back to it
shifter Shifter (
  .in(rd_data),
  .amt(rs_addr),
  .out(shift_out)
);

wire memWriteEn;
wire memReadEn;
wire ctrl5;
wire[7:0] mux5_out;

// main memory is self explanatory
mux_2x1 mux5 (
  .in_0(rs_data),
  .in_1(rd_data),
  .ctrl(ctrl5),
  .out(mux5_out)
);

memory mem (
  .clk(clk),
  .memWrite(memWriteEn),
  .memRead(memReadEn),
  .addr(mux5_out),
  .dataIn(rs_data),
  .dataOut(mem_out)
);

wire oppZ;
wire mux7_out;
wire[1:0] ctrl7;

assign oppZ = ~z;

// we need control for branching
mux_3x1 mux7 (
  .in_0(z),
  .in_1(oppZ),
  .in_2(one),
  .ctrl(ctrl7),
  .out(mux7_out)
);

wire ctrl_branch;
assign branch = ctrl_branch & mux7_out;

wire ctrl6;

// finally, the controller
Control_Unit controller (
  .opcode(op),
  .sp(sp),
  .MUX1(ctrl1),
  .MUX2(ctrl2),
  .MUX3(ctrl3),
  .Reg_Write(regWriteEn),
  .ALU_Op(ctrl_alu),
  .Tap_Write(lfsrWriteEn),
  .np(ctrl_np),
  .MUX4(ctrl4),
  .Mem_Write(memWriteEn),
  .Mem_Read(memReadEn),
  .MUX5(ctrl5),
  .MUX6(ctrl6),
  .MUX7(ctrl7),
  .Branch(ctrl_branch)
);

endmodule
