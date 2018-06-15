module memory(
	input clk,
	input memWrite,
	input memRead,
	input[7:0] addr,
	input[7:0] dataIn,

	output logic[7:0] dataOut
);

logic[7:0] memArr[256];

always_comb begin
	if(memRead == 1)
	begin
		dataOut = memArr[addr];
	end
	else 
	begin
		dataOut = 8'b0;
	end
end

always_ff @(posedge clk) begin
	if (memWrite) begin
		memArr[addr] <= dataIn;
	end
end
endmodule
