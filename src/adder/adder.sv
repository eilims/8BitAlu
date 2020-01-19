`include "rca.sv"

module adder
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE - 1:0] a,
	input wire[SIZE - 1:0] b,
	output wire[SIZE:0] result
);

RCA
#(
	SIZE
)
adder_block
(
	a,
	b,
	result
);

endmodule
