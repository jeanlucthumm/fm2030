module ALU(
	input[7:0] r0_rd,
	input[7:0] rs,
	input[1:0] control,

	output logic[7:0] result,
  output logic z
);

always_comb
begin

	if(control == 0) 
	begin
		result = r0_rd + rs;
    z = 0;
	end

	else if(control == 1)
	begin
		result = r0_rd - rs;
    if (result == 0)
      z = 1;
    else
      z = 0;
	end
	else if(control == 2)
	begin
		result = r0_rd + 1; 
    z = 0;
	end
	else
	begin
		result = r0_rd ^ rs;
    z = 0;
	end
end

endmodule 
