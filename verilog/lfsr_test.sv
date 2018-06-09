`include "lfsr.sv"
module lfsr_test();

reg clock, tapEn;
reg[7:0] lfsr_regi, taps;
wire[7:0] lfsr_rego;

lfsr l0 (
  .clock(clock),
  .in(lfsr_regi),
  .out(lfsr_rego),
  .tapIn(taps),
  .tapEn(tapEn)
);

always begin
  #5 clock = !clock;
end

initial begin
  $monitor($time, "clock=%b, taps=%X, in=%X, out=%X",
    clock, taps, lfsr_regi, lfsr_rego);
  tapEn = 0;
  clock = 0;
  taps = '0;

  $display("Hello World")
  $finish
end

endmodule
