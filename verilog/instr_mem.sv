module instr_mem (
	input reg[7:0] addr,
	output logic[4:0] imm,
	output logic[1:0] rs,
	output logic[1:0] rd,
	output logic[3:0] op,
	output logic sp,
  output logic[7:0] first
);

reg[8:0] array[1024];

wire[8:0] instr = array[addr];

always_comb begin
	imm = instr[4:0];
	rs = instr[2:1];
	rd = instr[4:3];
	op = instr[8:5];
	sp = instr[0];
  first = array[0][7:0];
end

endmodule
