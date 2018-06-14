module register_file_test();

bit clk, writeEn;
reg[2:0] rsAddr, rdAddr, dest;
reg[7:0] data;
wire[7:0] r0, rsOut, rdOut;

register_file r (
	.clk(clk),
	.writeEn(writeEn),
	.rsAddr(rsAddr),
	.rdAddr(rdAddr),
	.dest(dest),
	.data(data),
	.r0(r0),
	.rsOut(rsOut),
	.rdOut(rdOut)
);

always begin
	#5 clk = ~clk;
end

initial begin
	integer index;

	// setup 
	writeEn = 0;
	rsAddr = 0;
	rdAddr = 0;
	dest = 0;
	clk = 0;
	data = 0;

	// write all 8 register values
	for(index = 0; index < 8; index = index + 1) begin
		dest = index;
		data = index;
		writeEn = 1;
		#10
		writeEn = 0;
		#5;
	end

	// read all 8 register values for each selector
	for(index = 0; index < 8; index = index + 1) begin
		rsAddr = index;
		#10;
	end
	rsAddr = 0;

	for(index = 0; index < 8; index = index + 1) begin
		rdAddr = index;
		#10;
	end
	rdAddr = 0;

	$stop;
end

endmodule
