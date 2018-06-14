module register_file(
	input clk,
	input writeEn,
	input[2:0] rsAddr,
	input[2:0] rdAddr,
	input[2:0] dest,
	input[7:0] data,
	output logic[7:0] r0,
	output logic[7:0] rsOut,
	output logic[7:0] rdOut
);

reg[7:0] array[0:7]; // an array of 8 bytes

always_comb begin
	r0 = array[0];
	rsOut = array[rsAddr];
	rdOut = array[rdAddr];
end

always_ff @(posedge clk) begin
	if (writeEn)
		array[dest] <= data;
end

endmodule
