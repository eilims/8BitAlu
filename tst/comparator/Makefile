INCLUDES = -I ../ -I ../../src/comparator

build_test:
	iverilog ${INCLUDES} -o bit_compare.o bit_compare_tb.sv
	iverilog ${INCLUDES} -o comparator.o comparator_tb.sv
	iverilog ${INCLUDES} -o signed_comparator.o signed_comparator_tb.sv

run_test: build_test
	vvp bit_compare.o
	vvp comparator.o
	vvp signed_comparator.o

clean:
	rm -f *.o
	rm -f *.vvp
