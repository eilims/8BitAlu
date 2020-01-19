INCLUDES = -I ../ -I ../../src/multiplier -I ../../src/adder 

build_test:
	iverilog $(INCLUDES) -o multiplier_2.o multiplier_2_tb.sv
	iverilog $(INCLUDES) -o multiplier_4.o multiplier_4_tb.sv
	iverilog $(INCLUDES) -o tree_multiplier_2.o tree_multiplier_2_tb.sv
	iverilog $(INCLUDES) -o tree_multiplier_4.o tree_multiplier_4_tb.sv

run_test: build_test
	vvp tree_multiplier_2.o
	vvp tree_multiplier_4.o
	vvp multiplier_2.o
	vvp multiplier_4.o

clean:
	rm -f *.o
	rm -f *.vvp

