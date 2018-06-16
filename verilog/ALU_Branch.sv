module ALU_Branch(
	input[7:0] PC_Curr,
	input[7:0] offset,

	output logic[7:0] PC_New
);

always_comb
begin

	PC_New = (PC_Curr + offset);

end
endmodule 
