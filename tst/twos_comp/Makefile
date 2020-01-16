INCLUDES = -I ../ -I ../../src/twos_comp -I ../../src/adder 

build_test:
	iverilog $(INCLUDES) -o twos_comp_4.o twos_comp_4_tb.sv

run_test: build_test
	vvp twos_comp_4.o

clean:
	rm -f *.o
	rm -f *.vvp

