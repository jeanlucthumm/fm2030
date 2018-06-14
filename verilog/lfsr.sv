module lfsr (
  clock,
  in,     // previous state of LFSR
  out,    // final state of LFSR
  tapIn,  // desired state of taps
  tapEn,  // tap write enable
);

input wire[7:0] in, tapIn;
input clock, tapEn;

output wire[7:0] out;

reg[7:0] taps;

assign out = {in[6], in[5],
         in[4], in[3],
         in[2], in[1],
         in[0], ^(in & taps)};

always_ff @(posedge clock) begin
  if (tapEn) begin
    taps <= tapIn;
  end
end

endmodule
