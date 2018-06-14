module shifter_test();

reg[7:0] in;
wire[7:0] out;
reg[1:0] amt;

shifter s (
	.in(in),
	.out(out),
	.amt(amt)
);

initial begin
	// setup
	in = 'hff;
	amt = '0;
	#10

	// test
	amt = 1;
	#10
	amt = 2;
	#10
	amt = 3;
	#10

	$stop;
end

endmodule
