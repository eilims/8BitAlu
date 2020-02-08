`include "adder.sv"
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
	output wire[(2*SIZE)-1:0] result
);


wire[SIZE-1:0] comb_results[11:0];

assign overflow = 0;
assign result = 0;

endmodule
