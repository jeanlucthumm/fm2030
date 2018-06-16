module program_counter_test();

reg clk, reset, halt, branch;
reg[7:0] offset;
wire[7:0] addr;

program_counter pc1 (
	.clk(clk),
	.reset(reset),
	.halt(halt),
	.branch(branch),
	.offset(offset),
	.addr(addr)
);

always begin
	#5 clk = !clk;
end

initial begin
	// setup
  clk = 0;
  reset = 1;
  halt = 0;
  branch = 0;
  offset = 0;
  
  // increment 5 times
  #10
  reset = 0;
  #50

  // branch forward 20
  branch = 1;
  offset = 20;
  #10
  branch = 0;
  #50

  // branch backward 10
  branch = 1;
  offset = -10;
  #10
  branch = 0;
  #50

  halt = 1;
  #50

  $stop;
end

endmodule
