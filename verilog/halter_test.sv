module halter_test();

reg clk;
reg[7:0] endState, pc;
wire halt;

halter h(
  .clk(clk),
  .endState(endState),
  .pc(pc),
  .halt(halt)
);

always begin
  #5 clk = !clk;
end

initial begin
  // setup
  clk = 0;
  endState = 20;
  pc = 5;
  #10
  pc = 10;
  #10
  pc = 20;
  #10

  $stop;
end

endmodule
