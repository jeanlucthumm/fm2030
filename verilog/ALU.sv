module ALU(
	input[1:0] r0_rd,
	input[1:0] rs,
	input[1:0] control,

	output logic[2:0] result

);

always_comb
begin

	if(control == 2'b00) 
	begin
		result = r0_rd + rs;
	end

	else if(control == 2'b01)
	begin
		result = r0_rd - rs;
	end
	else if(control == 2'b10)
	begin
		result = r0_rd + 1; 
	end
	else
	begin
		result = r0_rd ^ rs;
	end
end

endmodule 
