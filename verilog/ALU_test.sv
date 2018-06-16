module ALU_test();

reg[7:0] r0_rd;
reg[7:0] rs;
reg[1:0] control;

wire[7:0] result;
wire z;

ALU s(
	.r0_rd(r0_rd),
	.rs(rs),
	.control(control),
	.result(result),
  .z(z)
);

initial begin

	// setup
	r0_rd = 3;
	rs = 3;
	control = 0;
	#30;

	r0_rd = 3;
	rs = 3;
	control = 1;
	#30;

	r0_rd = 3;
	rs = 2;
	control = 2;
	#30;

	r0_rd = 1;
	rs = 0;
	control = 3;
	#30


	$stop;
end

endmodule
