`include "comparator.sv"

module signed_comparator
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire is_a_greater,
	output wire equal
);

wire signed_a_g;
wire signed_equal;

wire num_a_g;
wire num_equal;

// Compares only the sign bit
comparator
#(
	1
)
sign_compare
(
	a[SIZE-1],
	b[SIZE-1],
	signed_a_g,
	signed_equal
);

// Compare the actual number portions (exludes the sign bit)
comparator
#(
	SIZE-1
)
num_compare
(
	a[SIZE-2:0],
	b[SIZE-2:0],
	num_a_g,
	num_equal
);

// If the sign bits differ we use those results, otherwise we use the number
// results.

// We must negate the results of the sign bit comparison as a one indicates
// a negative number.
assign is_a_greater = signed_equal ? num_a_g : (~signed_a_g);

// If the signed bit comparison is not equal the final comparison will never
// be equal
assign equal = signed_equal ? num_equal : 1'b0;

endmodule
