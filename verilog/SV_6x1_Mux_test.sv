module SV_6x1_Mux_test();

reg[7:0] in_0;
reg[7:0] in_1;
reg[7:0] in_2;
reg[7:0] in_3;
reg[7:0] in_4;
reg[7:0] in_5;
reg[2:0] ctrl;

wire[7:0] out;

mux_6x1 s(
	.in_0(in_0),
	.in_1(in_1),
	.in_2(in_2),
	.in_3(in_3),
	.in_4(in_4),
	.in_5(in_5),
	.ctrl(ctrl),
	.out(out)
);

initial begin
	// setup
	
	in_0 = 0;
	in_1 = 1;
	in_2 = 2;
	in_3 = 3;
	in_4 = 4;
	in_5 = 5;
	ctrl = 3'b000;

	#50;

	in_0 = 0;
	in_1 = 1;
	in_2 = 2;
	in_3 = 3;
	in_4 = 4;
	in_5 = 5;
	ctrl = 3'b001;

	#50

	in_0 = 0;
	in_1 = 1;
	in_2 = 2;
	in_3 = 3;
	in_4 = 4;
	in_5 = 5;
	ctrl = 3'b010;

	#50

	in_0 = 0;
	in_1 = 1;
	in_2 = 2;
	in_3 = 3;
	in_4 = 4;
	in_5 = 5;
	ctrl = 3'b011;

	#50
	
	in_0 = 0;
	in_1 = 1;
	in_2 = 2;
	in_3 = 3;
	in_4 = 4;
	in_5 = 5;
	ctrl = 3'b100;

	#50

	in_0 = 0;
	in_1 = 1;
	in_2 = 2;
	in_3 = 3;
	in_4 = 4;
	in_5 = 5;
	ctrl = 3'b101;

	#50

	$stop;
end

endmodule 
