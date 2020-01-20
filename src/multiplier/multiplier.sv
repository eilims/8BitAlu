`include "tree_multiplier.sv"

module multiplier
#(
	parameter integer SIZE = 2
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire overflow,
	output wire[(SIZE*2)-1:0] c
);

tree_multiplier
#(
	SIZE
)
multiplier_block
(
	a,
	b,
	overflow,
	c
);

endmodule
