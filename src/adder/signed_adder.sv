`ifndef SIGNED_ADDER_SV
`define SIGNED_ADDER_SV

`include "twos_comp.sv"
`include "adder.sv"
`include "comparator.sv"

module signed_adder
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire overflow,
	output wire[SIZE:0] result
);

wire dummy;
wire is_a_negative;

wire is_a_greater;
wire is_a_b_equal;

wire[SIZE-1:0] a_inv;
wire[SIZE-1:0] b_inv;

wire[SIZE-1:0] a_add;
wire[SIZE-1:0] b_add;
wire overflow_add;
wire[SIZE:0] result_add;
wire[SIZE:0] result_add_inv;

wire both_pos = ((is_a_negative == 1'b0) && (is_a_b_equal == 1'b1));
wire use_inv = ((is_a_negative == 1'b1) && (is_a_b_equal == 1'b1));

wire inter_overflow;

comparator
#(
	1
)
a_negative_check
(
	a[SIZE-1],
	1'b1,
	dummy,
	is_a_negative
);

comparator
#(
	1
)
sign_a_v_b
(
	a[SIZE-1],
	b[SIZE-1],
	is_a_greater,
	is_a_b_equal
);

twos_complementor
#(
	SIZE
)
a_complementor
(
	a,
	a_inv
);

twos_complementor
#(
	SIZE
)
b_complementor
(
	b,
	b_inv
);

assign a_add = (use_inv == 1'b1) ? a_inv : a;
assign b_add = (use_inv == 1'b1) ? b_inv : b;

adder
#(
	SIZE
)
adder_stage
(
	a_add,
	b_add,
	overflow_add,
	result_add
);

twos_complementor
#(
	SIZE+1
)
result_complementor
(
	result_add,
	result_add_inv
);

assign inter_overflow = (both_pos == 1'b1) ? result_add[SIZE-1] : 0;
assign overflow = (use_inv == 1'b1) ? result_add_inv[SIZE] : inter_overflow;
assign result = (use_inv == 1'b1) ? result_add_inv : result_add;

endmodule

`endif
