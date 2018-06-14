module sign_extender(
	input signed[4:0] in,
	output[7:0] out
);

assign out = {{3{in[4]}}, {in[4:0]}};

endmodule
