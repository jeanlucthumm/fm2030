test: lfsr_test

lfsr_test: lfsr.sv lfsr_test.sv
	iverilog -o lfsr.vvp lfsr.sv lfsr_test.sv
	vvp lfsr.vvp
