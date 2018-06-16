module lfsr_test();

reg clk, tapEn, np;
reg[7:0] in, taps;
wire[7:0] out;

lfsr l0 (
  .clk(clk),
  .in(in),
	.np(np),
  .out(out),
  .tapData(taps),
  .tapEn(tapEn)
);

always begin
  #5 clk = !clk;
end

initial begin
	// setup
  tapEn = 0;
  clk = 0;
  taps = 'h5c;
	in = 'hff;
	np = 1;
	#10
	tapEn = 1;
	#10
	tapEn = 0;

	// test next
	#10
	in = out;
	#10
	in = out;
	#10
	in = out;
	#10
	in = out;
	#10
	in = out;
	#10
	in = out;
	#20

	// test previous normal taps
	np = 0;
	#10
	in = 'hfe;
	#20

	// test previous problem taps (tapped shifted away)
	taps = 'h9c;
	tapEn = 1;
	#10
	tapEn = 0;
	#10

	in = 'hfe;
	#10
	in = 'hff;
	#10

  $stop;
end

endmodule
