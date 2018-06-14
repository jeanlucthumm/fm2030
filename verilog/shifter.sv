module shifter(
	input[7:0] in,
	input[1:0] amt,
	output logic[7:0] out
);

always_comb case(amt)
	2'h0: out = in;
	2'h1: out = {{in[6:0]}, 1'b0};
	2'h2: out = {{in[5:0]}, 1'b0, 1'b0};
	2'h3: out = {{in[4:0]}, 1'b0, 1'b0, 1'b0};
	default: out = in;
endcase

endmodule
