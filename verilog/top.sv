module top();

reg clk;
reg reset;
wire done;

main m (
  .clk(clk),
  .reset(reset),
  .done(done)
);

always begin
  #10 clk = !clk;
end

initial begin
  clk = 0;

  #200
  $stop;
end

endmodule
