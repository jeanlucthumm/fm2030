// program_counter maintains and incremenrets a PC and allows
// branching and halting

module program_counter(
	input clk,
	input reset,
	input halt,					// do not increment pc if high
	input branch,				// enable branching
	input[7:0] offset,	// how far from current pc to branch
	output logic[7:0] addr		// current pc
);

reg[7:0] pc;

always_ff @(posedge clk) begin
	if (reset) begin
		pc <= 1;
	end else if (!halt) begin 
		if (branch)
			pc <= pc + offset;
		else
			pc <= pc + 1;
	end
end

always_comb begin
	addr = pc;
end



endmodule
