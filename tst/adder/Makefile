INCLUDES = -I ../../src/adder -I ../

all: run_test

build_test:
	iverilog $(INCLUDES) -o bit_adder.o bit_adder_tb.sv
	iverilog $(INCLUDES) -o rca_1.o rca_1_tb.sv
	iverilog $(INCLUDES) -o rca_2.o rca_2_tb.sv

run_test: build_test
	vvp bit_adder.o
	vvp rca_1.o
	vvp rca_2.o

clean:
	rm -f *.o
	rm -f *.vvp
