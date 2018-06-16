
module SV_3x1_Mux_test();

reg in_0;
reg in_1;
reg in_2;
reg[1:0] ctrl;

wire out;

mux_3x1 s(
	.in_0(in_0),
	.in_1(in_1),
	.in_2(in_2),
	.ctrl(ctrl),
	.out(out)
);

initial begin
	// setup
	
	ctrl = 0;
	in_0 = 1;
	in_1 = 0;
	in_2 = 0;

	#50;

	ctrl = 1;
	in_0 = 0;
	in_1 = 1;
	in_2 = 0;

	#50

	ctrl = 2;
	in_0 = 1;
	in_1 = 1;
	in_2 = 0;

	#50

	$stop;
end

endmodule 