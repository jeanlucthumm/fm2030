module  inverter(
input inBit,     

output logic outBit      //Inverted output
);

always_comb
begin
	outBit = !inBit;
end 

endmodule