build_test:
	iverilog -I ../../src/adder/ -o bit_adder.o bit_adder_tb.sv
	iverilog -I ../../src/adder/ -o rca_1.o rca_1_tb.sv
	iverilog -I ../../src/adder/ -o rca_2.o rca_2_tb.sv

run_test:
	vvp bit_adder.out
	vvp rca_1.out
	vvp rca_2.out

clean:
	rm *.o
	rm *.vvp
