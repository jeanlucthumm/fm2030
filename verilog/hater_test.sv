module hater_test();

reg[7:0] PC_Curr;
reg[7:0] PC_End;
reg clk;
reg reset;

wire halt;

Hater s(
	.PC_Curr(PC_Curr),
	.PC_End(PC_End),
	.clk(clk),
	.reset(reset)
);

always begin
	#5 clk = ~clk;
end

initial begin
	
	integer i;
	PC_Curr = 0;
	PC_End = 250;
	reset = 1;
	clk = 0;
	
	for(i=0;i<255;i = i+1)begin
		#5;
		PC_Curr = PC_Curr+1;
	end

	PC_Curr = 0;
	PC_End = 120;
	reset = 1;

	for(i=0;i<140;i=i+1)begin
		#5;
		PC_Curr = PC_Curr+1;
	end
	
	$stop;
end

endmodule
