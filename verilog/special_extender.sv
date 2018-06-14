module special_extender(
	input sp,
	input[1:0] in,
	output[2:0] out
);

assign out = {sp, {in[1:0]}};

endmodule
