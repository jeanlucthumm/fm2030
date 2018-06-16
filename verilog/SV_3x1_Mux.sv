module  mux_3x1(
input  in_0      , // Mux first input
input  in_1     , // Mux Second input
input  in_2       , // Select input
input[1:0] ctrl,

output logic out      // Mux output
);

always_comb 
begin

	if(ctrl == 2'b00) begin 
		out = in_0;
		
	end else if(ctrl == 2'b01) begin 
		out = in_1;
		
	end else begin
		out = in_2; 
	end	
end 

endmodule 