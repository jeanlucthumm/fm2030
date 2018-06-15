module ALU_test();

reg[1:0] r0_rd;
reg[1:0] rs;
reg[1:0] control;

wire[2:0] result;

ALU s(
	.r0_rd(r0_rd),
	.rs(rs),
	.control(control),
	.result(result)
);

initial begin

	// setup
	r0_rd = 3;
	rs = 3;
	control = 2'b00;
	#30;

	r0_rd = 3;
	rs = 3;
	control = 2'b01;
	#30;

	r0_rd = 3;
	rs = 2;
	control = 2'b10;
	#30;

	r0_rd = 1;
	rs = 0;
	control = 2'b11;
	#30


	$stop;
end

endmodule
