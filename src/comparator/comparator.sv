`include "twos_comp.sv"
`include "adder.sv"

module comparator
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire is_a_greater,
	output wire equal
);

endmodule
