module special_extender_test();

bit sp;
reg[1:0] in;
wire[2:0] out;

special_extender s (
	.sp(sp),
	.in(in),
	.out(out)
);

initial begin
	// setup
	sp = '0;
	in = '0;
	#10

	// test
	// 0 special bit
	in = 2'h0;
	#10
	in = 2'h1;
	#10
	in = 2'h2;
	#10
	in = 2'h3;
	#10

	// 1 special bit
	sp = 1;
	#10
	in = 2'h0;
	#10
	in = 2'h1;
	#10
	in = 2'h2;
	#10
	in = 2'h3;
	#10

	$stop;
end

endmodule

