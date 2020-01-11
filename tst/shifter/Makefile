all: run_test

build_test:
	iverilog -I ../../src/shifter -I ../ -o shifter_2.o shifter_2_tb.sv

run_test: build_test
	vvp shifter_2.o

clean:
	rm -f *.o
	rm -f *.vvp
