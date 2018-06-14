module sign_extender_test();

reg[4:0] in;
wire[7:0] out;

sign_extender s(
	.in(in),
	.out(out)
);

initial begin
	// setup
	in = 0;
	#10

	// test
	in = 5'b00001;
	#10
	in = 5'b00011;
	#10
	in = 5'b00111;
	#10
	in = 5'b01111;
	#10
	in = 5'b11111;
	#10

	$stop;
end

endmodule
