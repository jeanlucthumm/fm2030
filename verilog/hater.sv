module  Hater(
input[7:0]  PC_Curr       , // Current PC counter value 
input[7:0]  PC_End     , //  PC counter value upon program completion
input clk,
input reset,

output logic halt      //Halt signal
);

reg set;
reg[7:0] endState; 

always_ff @ (posedge clk)
begin
	if(set == 0) 
	begin
		endState <= PC_End;
		set <= 1;
	end
	else if(reset == 1)
	begin
		set <= 0;
	end
end

always_comb
begin

	if(PC_Curr == endState) begin 
		
		halt = 1;
		
	end else begin
		halt = 0; 
	end	
end 

endmodule 