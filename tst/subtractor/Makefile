INCLUDES = -I ../ -I ../../src/comparator -I ../../src/adder -I ../../src/twos_comp -I ../../src/subtractor

build_test:
	iverilog ${INCLUDES} -o subtractor.o subtractor_tb.sv

run_test: build_test
	vvp subtractor.o

clean:
	rm -f *.o
	rm -f *.vvp
