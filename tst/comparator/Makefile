INCLUDES = -I ../ -I ../../src/comparator

build_test:
	iverilog ${INCLUDES} -o bit_compare.o bit_compare_tb.sv

run_test: build_test
	vvp bit_compare.o

clean:
	rm -f *.o
	rm -f *.vvp
