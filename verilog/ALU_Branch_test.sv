module ALU_Branch_test();

reg[7:0] PC_Curr;
reg[7:0] offset;

wire[7:0] PC_New;

ALU_Branch s(
	.PC_Curr(PC_Curr),
	.offset(offset),
	.PC_New(PC_New)
);

initial begin
	// setup
	PC_Curr = 8'b00010000;
	offset = 8'b00010000; 
	#50

	PC_Curr = 8'b00000100;
	offset = 8'b00000000; 
	#50

	PC_Curr = 8'b00000010;
	offset = 8'b00000101; 
	#50

	PC_Curr = 8'b00001111;
	offset = 8'b00000001; 
	#50

	PC_Curr = 8'b00000010;
	offset = 8'b00010001;
	#50

	$stop;
end

endmodule
