`include "adder.sv"
`include "signed_adder.sv"
`include "subtractor.sv"
`include "multiplier.sv"
`include "signed_multiplier.sv"
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

wire[1:0] dummy;

wire over_results[15:0];
wire[(2*SIZE)-1:0] comb_results[15:0];

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
assign comb_results[4][RESULT_SIZE-1:SIZE] = 0;
adder
#(
	SIZE
)
unsigned_adder_stage
(
	a,
	b,
	over_results[4],
	{dummy[0], comb_results[4][SIZE-1:0]}
);

// Signed Addition
assign comb_results[5][RESULT_SIZE-1:SIZE] = 0;
signed_adder
#(
	SIZE
)
signed_adder_stage
(
	a,
	b,
	over_results[5],
	{dummy[0], comb_results[5][SIZE-1:0]}
);

// Unsigned sub
assign comb_results[6][RESULT_SIZE-1:SIZE] = 0;
subtractor
#(
	SIZE+1
)
unsigned_subtractor_stage
(
	{1'b0, a},
	{1'b0, b},
	over_results[6],
	{dummy, comb_results[6][SIZE-1:0]}
);

// Signed subtraction
assign comb_results[7][RESULT_SIZE-1:SIZE] = 0;
subtractor
#(
	SIZE
)
signed_subtractor_stage
(
	a,
	b,
	over_results[7],
	{dummy[0], comb_results[7][SIZE-1:0]}
);

// Unsigned multiplication
multiplier
#(
	SIZE
)
unsigned_multiplier_stage
(
	a,
	b,
	over_results[8],
	comb_results[8]
);

// Signed Multiplication
signed_multiplier
#(
	SIZE
)
signed_multiplier_stage
(
	a,
	b,
	over_results[9],
	comb_results[9]
);

assign over_results[10] = 0;
assign comb_results[10][RESULT_SIZE-1:2] = 0;
comparator
#(
	SIZE
)
unsigned_comparator_stage
(
	a,
	b,
	comb_results[10][0],
	comb_results[10][1]
);

assign over_results[11] = 0;
assign comb_results[11][RESULT_SIZE-1:2] = 0;
signed_comparator
#(
	SIZE
)
signed_comparator_stage
(
	a,
	b,
	comb_results[11][0],
	comb_results[11][1]
);

assign over_results[12] = 0;
assign comb_results[12][RESULT_SIZE-1:SIZE] = 0;
wire dummy2;
shifter
#(
	SIZE
)
shift
(
	b[0],
	b[1],
	a,
	comb_results[12][SIZE-1:0],
	dummy2
);

// Final assignment
assign overflow = enable ? over_results[command] : 0;
assign result = enable ? comb_results[command] : 0;

endmodule
