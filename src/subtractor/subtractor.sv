`ifndef SUBTRACTOR_SV
`define SUBTRACTOR_SV

`include "adder.sv"
`include "twos_comp.sv"
`include "comparator.sv"

module subtractor
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire overflow,
	output wire[SIZE:0] result
);

wire sign_result_eq;
wire sign_result_a_g;

wire[SIZE-1:0] b_twos_comp;

wire adder_overflow;
wire dummy_val;

wire is_a_g;
wire is_a_b_eq;
wire internal_overflow;

comparator
#(
	1'b1
)
sign_results
(
	a[SIZE-1],
	b[SIZE-1],
	sign_result_a_g,
	sign_result_eq
);

twos_complementor
#(
	SIZE
)
b_inversion
(
	b,
	b_twos_comp
);

adder
#(
	SIZE+1
)
adder_stage
(
	{a[SIZE-1], a},
	{b_twos_comp[SIZE-1], b_twos_comp},
	adder_overflow,
	{dummy_val, result}
);

comparator
#(
	SIZE
)
compare_inputs
(
	a,
	b,
	is_a_g,
	is_a_b_eq
);

// If the minuend (a) is positive, we overflow if the result is negative
// If the minuend (a) is negative, we overflow if the the adder overflows
assign internal_overflow = (a[SIZE-1]) ? adder_overflow : result[SIZE-1];
// If the minuend (a) and the subtrahend (b) are the same signs the result
// cannot overflow
assign overflow = (sign_result_eq) ? 1'b0 : internal_overflow;

endmodule
`endif

