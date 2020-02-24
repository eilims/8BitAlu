`include "adder.sv"
`include "signed_adder.sv"
`include "subtractor.sv"
`include "multiplier.sv"
`include "comparator.sv"
`include "signed_comparator.sv"
`include "shifter.sv"

module alu
#(
	parameter integer SIZE = 2
)
(
	input wire enable,
	input wire[3:0] command,
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire overflow,
	output wire[RESULT_SIZE-1:0] result
);

localparam integer RESULT_SIZE = (2*SIZE);


wire over_results[11:0];
wire[(2*SIZE)-1:0] comb_results[11:0];

// AND
assign over_results[0] = 0;
assign comb_results[0] = a & b;

// OR
assign over_results[1] = 0;
assign comb_results[1] = a | b;

// XOR
assign over_results[2] = 0;
assign comb_results[2] = a ^ b;

// NOT
assign over_results[3] = 0;
assign comb_results[3][RESULT_SIZE-1:SIZE] = 0;
assign comb_results[3][SIZE-1:0] = ~a;

// Unsigned Addition
adder
#(
	SIZE
)
unsigned_adder_stage
(
	a,
	b,
	over_results[4],
	comb_results[4]
);

// Signed Addition
signed_adder
#(
	SIZE
)
signed_adder_stage
(
	a,
	b,
	over_results[5],
	comb_results[5]
);

// Final assignment
assign overflow = enable ? over_results[command] : 0;
assign result = enable ? comb_results[command] : 0;

endmodule
