module SV_2x1_Mux_test();

reg[7:0] in_0;
reg[7:0] in_1;
reg ctrl;

wire[7:0] out;

mux_2x1 s(
	.in_0(in_0),
	.in_1(in_1),
	.ctrl(ctrl),
	.out(out)
);

initial begin
	// setup
	
	ctrl = 0;
	in_0 = 8'b00000000;
	in_1 = 8'b11111111;

	#50;

	ctrl = 1;
	in_0 = 8'b11110000;
	in_1 = 8'b00001111;

	#50

	ctrl = 0;
	in_0 = 8'b11111111;
	in_1 = 8'b00000000;

	#50

	$stop;
end

endmodule 