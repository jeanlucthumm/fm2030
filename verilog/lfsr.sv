module lfsr(
	input clk,
	input[7:0] in,
	input np, 			// 1 is next 
	input tapEn,
	input[7:0] tapData,
	output logic[7:0] out
);

reg[7:0] taps;

// tap updates
always_ff @(posedge clk) begin 
	if (tapEn) begin
		taps <= tapData;
	end
end

// state calculation
always_comb begin
	bit b;
	if (np == 1) begin
		out = {{in[6:0]}, ^(in & taps)};
	end else begin
		// check if first value is tapped,
		// since it was shifted away
		if (taps & 8'h80) begin
			b = (^((taps << 1) & in)) ^ in[0];
			out = {b, in[7:1]};
		end else begin
			out = {1'b0, in[7:1]};
		end
	end
end

endmodule
