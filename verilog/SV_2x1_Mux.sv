module  mux_2x1(
input  logic  in_0      , // Mux first input
input  logic  in_1     , // Mux Second input
input  logic  ctrl,

output logic out      // Mux output
);

always_comb
begin

	if(ctrl == 0) begin 
		out = in_0;
		
	end else begin
		out = in_1; 
	end	
end 
endmodule
