module ALU_Branch_test();

reg[7:0] PC_Curr;
reg[4:0] offset;

wire[7:0] PC_New;

ALU_Branch s(
	.PC_Curr(PC_Curr),
	.offset(offset),
	.PC_New(PC_New)
);

initial begin
	// setup
	PC_Curr = 8'b00010000;
	offset = 5'b10000; 
	#50

	PC_Curr = 8'b00000100;
	offset = 5'b00000; 
	#50

	PC_Curr = 8'b00000010;
	offset = 5'b00101; 
	#50

	PC_Curr = 8'b00001111;
	offset = 5'b00001; 
	#50

	PC_Curr = 8'b00000010;
	offset = 5'b10001;
	#50

	$stop;
end

endmodule
