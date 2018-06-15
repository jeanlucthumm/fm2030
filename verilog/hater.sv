module  Hater(
	input[0:7]  PC_Curr    , // Current PC counter value 
	input[0:7]  PC_End     , //  PC counter value upon program completion
	//input[1:0]  wire  ctrl,

	output logic halt      //Halt signal
);

always_comb
begin

	if(PC_Curr == PC_End) begin 
		halt = 1;
		
	end else begin
		halt = 0; 
	end	
end 

endmodule 