module Control_Unit(
	input[3:0] opcode,
	input sp;
	
	output logic[1:0] MUX1,
	output logic[2:0] MUX2,
	output logic MUX3,
	output logic Reg_Write,
	output logic[1:0] ALU_Op,
	output logic Tap_Write,
	output logic np,
	output logic[1:0] MUX4,
	output logic Mem_Write,
	output logic Mem_Read,
	output logic MUX5,
	output logic MUX6,
	output logic[1:0] MUX7,
	output logic Branch

);

always_comb
begin

	case(opcode)
	
		4'b0000: //add
		begin
		
			MUX1 = 1;
			MUX2 = 1;
			MUX3 = 0;
			Reg_Write = 1;
			ALU_Op = 2'b00;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0001: //cmp
		begin

			MUX1 = 1;
			MUX3 = 1;
			Reg_Write = 0;
			ALU_Op = 2'b01;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0010: //clr
		begin

			MUX1 = 0;
			MUX2 = 0;
			Reg_Write = 1;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0011: //shl
		begin

			MUX1 = 0;
			MUX2 = 2;
			Reg_Write = 1;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0100: //lfsrs
		begin

			MUX1 = 0;
			Reg_Write = 0;
			Tap_Write = 1;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0101: //lfsrn
		begin

			MUX1 = 0;
			MUX2 = 3;
			Reg_Write = 1;
			Tap_Write = 0;
			np = 1;
			MUX4 = 2;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0110: //lfsrp
		begin

			MUX1 = 0;
			MUX2 = 3;
			Reg_Write = 1;
			Tap_Write = 0;
			np = 0;
			MUX4 = 2;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b0111: //ld
		begin

			MUX1 = 1;
			MUX2 = 5;
			Reg_Write = 0;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 1;
			MUX6 = 0;
			Branch = 0;

		end

		4'b1000: //st
		begin

			MUX1 = 1;
			Reg_Write = 0;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 1;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b1001: //moved 
		begin
						
			MUX2 = 4;
			Reg_Write = 1;
			Tap_Write = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;
			if(sp)
			begin
				MUX1 = 1;	
				MUX4 = 2;
			end
			else begin
				MUX1 = 2;
				MUX4 = 1;
			end
		
		end

		4'b1010: //mover
		begin

			MUX1 = 0;
			MUX2 = 4;
			Reg_Write = 1;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0;

		end

		4'b1011: //inc
		begin

			MUX1 = 0;
			MUX2 = 1;
			MUX3 = 1;
			Reg_Write = 1;
			ALU_Op = 2'b10;
			Tap_Write = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 1;
			Branch = 0;

		end

		4'b1100: //xor
		begin

			MUX1 = 1;
			MUX2 = 1;
			MUX3 = 0;
			Reg_Write = 1;
			ALU_Op = 2'b11;
			Tap_Write = 0;
			MUX4 = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			Branch = 0; 

		end

		4'b1101: //be
		begin

			Reg_Write = 0;
			Tap_Write = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			MUX7 = 0;
			Branch = 1;

		end

		4'b1110: //bne
		begin

			Reg_Write = 0;
			Tap_Write = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			MUX7 = 1;
			Branch = 1;

		end

		4'b1111: //jump
		begin

			Reg_Write = 0;
			Tap_Write = 0;
			Mem_Write = 0;
			Mem_Read = 0;
			MUX6 = 0;
			MUX7 = 2;
			Branch = 1;

		end
	endcase
end
endmodule 
 
