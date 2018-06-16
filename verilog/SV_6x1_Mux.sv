module  mux_6x1(
input  [7:0]  in_0      , // Mux first input
input  [7:0]  in_1     , // Mux Second input
input  [7:0]  in_2     , // Mux Second input
input  [7:0]  in_3     , // Mux Second input
input  [7:0]  in_4     , // Mux Second input
input  [7:0]  in_5     , // Mux Second input
input  [2:0]  ctrl,

output logic[7:0] out      // Mux output
);

always_comb 
begin

	if(ctrl == 3'b000) begin 
		out = in_0;
	end
	
	else if(ctrl == 3'b001) begin 
		out = in_1;
	end
	
	else if(ctrl == 3'b010) begin 
		out = in_2;
	end
	
	else if(ctrl == 3'b011) begin 
		out = in_3;
	end
	
	else if(ctrl == 3'b100) begin 
		out = in_4;	
	end 
	
	else begin
		out = in_5; 
	end	
end 
endmodule 