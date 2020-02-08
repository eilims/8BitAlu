INCLUDES = -I ../ -I ../../src/alu -I ../../src/adder -I ../../src/comparator -I ../../src/multiplier -I ../../src/shifter -I ../../src/subtractor -I ../../src/twos_comp

build_test:
	iverilog ${INCLUDES} -o alu.o alu_tb.sv

run_test: build_test
	vvp alu.o

clean:
	rm -f *.o
	rm -f *.vvp
