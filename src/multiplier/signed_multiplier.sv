`ifndef SIGNED_MULTIPLIER
`define SIGNED_MULTIPLIER

`include "multiplier.sv"
`include "twos_comp.sv"

module signed_multiplier
#(
	parameter integer SIZE = 2
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire overflow,
	output wire[(2*SIZE)-1:0] c
);

// The complementary version of the inputs
wire[SIZE-1:0] a_comp;
wire[SIZE-1:0] b_comp;
// The inputs into the multiplier
wire[SIZE-1:0] a_operand;
wire[SIZE-1:0] b_operand;
// The actual multiplier result
wire[(2*SIZE)-1:0] result;
// Complementary version of the multiplier result
wire[(2*SIZE)-1:0] result_comp;

twos_complementor
#(
	SIZE
)
a_complementor
(
	a,
	a_comp
);

twos_complementor
#(
	SIZE
)
b_complementor
(
	b,
	b_comp
);

// If the input is negative get the complementary version of it
assign a_operand = a[SIZE-1] ? a_comp : a;
assign b_operand = b[SIZE-1] ? b_comp : b;

wire[SIZE-3:0] dummy_val;
assign result[(2*SIZE)-1:SIZE] = 0;
multiplier
#(
	SIZE-1
)
multiplier_stage
(
	a_operand[SIZE-2:0],
	b_operand[SIZE-2:0],
	overflow,
	{dummy_val, result[SIZE-1:0]}
);

assign result_comp[(2*SIZE)-1:SIZE] = 0;
twos_complementor
#(
	SIZE
)
result_complementor
(
	result[SIZE-1:0],
	result_comp[SIZE-1:0]
);

// If one input is negative the result will be negative
assign c = (a[SIZE-1] ^ b[SIZE-1]) ? result_comp : result;

endmodule

`endif
