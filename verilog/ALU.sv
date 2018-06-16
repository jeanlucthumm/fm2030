module ALU(
	input[7:0] r0_rd,
	input[7:0] rs,
	input[1:0] control,

	output logic[7:0] result

);

always_comb
begin

	if(control == 0) 
	begin
		result = r0_rd + rs;
	end

	else if(control == 1)
	begin
		result = r0_rd - rs;
	end
	else if(control == 2)
	begin
		result = r0_rd + 1; 
	end
	else
	begin
		result = r0_rd ^ rs;
	end
end

endmodule 
