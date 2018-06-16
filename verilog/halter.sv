// halter compares the incoming pc to a specified
// end state, and outputs a halting signal if it has been reached

module halter(
  input clk,
  input[7:0] endState,
  input[7:0] pc,
  output logic halt
);

always @(posedge clk) begin
  if (pc >= endState)
    halt = 1;
  else
    halt = 0;
end

endmodule
