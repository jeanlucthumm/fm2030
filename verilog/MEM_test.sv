module MEM_test();

reg clk;
reg memWrite;
reg memRead;
reg[7:0] addr;
reg[7:0] dataIn;

wire[7:0] dataOut;

memory s(
	.clk(clk),
	.memWrite(memWrite),
	.memRead(memRead),
	.addr(addr),
	.dataIn(dataIn),
	.dataOut(dataOut)
);

always
begin
	#5 clk = ~clk;
end

initial begin
	integer index;
	// setup 
	memWrite = 0;
	addr = 0;
	clk = 0;
	dataIn = 0;

	// write all 8 register values
	for(index = 0; index < 8; index = index + 1) begin
		addr = index;
		dataIn = index;
		memWrite = 1;
		#10
		memWrite = 0;
		#5;
	end

	// read all 8 register values for each selector
	for(index = 0; index < 8; index = index + 1) begin
		addr = index;
		#10;
	end
	addr = 0;

	for(index = 0; index < 8; index = index + 1) begin
		addr = index;
		#10;
	end
	addr = 0;

	$stop;
end

endmodule
