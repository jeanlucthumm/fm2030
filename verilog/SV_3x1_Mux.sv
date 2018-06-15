module  mux_3x1(
input  logic  in_0      , // Mux first input
input  logic  in_1     , // Mux Second input
input  logic  in_2       , // Select input
input[1:0]  ctrl,

output logic out      // Mux output
);

always_comb 
begin

	if(ctrl == 0) begin 
		out = in_0;
		
	end else if(ctrl == 1) begin 
		out = in_1;
		
	end else begin
		out = in_2; 
	end	
end 

endmodule 