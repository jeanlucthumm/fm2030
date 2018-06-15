module inverter_test();

reg inBit;
wire outBit;

inverter s(
	.inBit(inBit),
	.outBit(outBit)
);

initial begin
	// setup
	inBit = 0;
	#10
	// test
	inBit = 0;
	#10
	inBit = 1;
	#10
	inBit = 1;
	#10
	inBit = 0;
	#10
	inBit = 1;
	#10

	$stop;
end

endmodule
