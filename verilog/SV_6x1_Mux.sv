module  mux_6x1(
input  logic  in_0      , // Mux first input
input  logic  in_1     , // Mux Second input
input  logic  in_2     , // Mux Second input
input  logic  in_3     , // Mux Second input
input  logic  in_4     , // Mux Second input
input  logic[7:0]  in_5     , // Mux Second input
input[0:2]  ctrl,

output logic[7:0] out      // Mux output
);

always_comb 
begin

	if(ctrl == 0) begin 
		out = in_0;
	end
	
	if(ctrl == 1) begin 
		out = in_1;
	end
	
	if(ctrl == 2) begin 
		out = in_2;
	end
	
	if(ctrl == 3) begin 
		out = in_3;
	end
	
	if(ctrl == 4) begin 
		out = in_4;	
	end 
	
	else begin
		out = in_5; 
	end	
end 
endmodule 