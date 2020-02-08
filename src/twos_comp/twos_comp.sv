`ifndef TWOS_COMP_SV
`define TWOS_COMP_SV

`include "adder.sv"

module twos_complementor
#(
	parameter integer SIZE = 1
)
(
	input wire [SIZE-1:0] a,
	output wire [SIZE-1:0] b
);

wire[SIZE:0] result;
wire dummy;
assign b = result[SIZE-1:0];


adder
#(
	SIZE
)
adder_stage
(
	~a,
	{{SIZE-1{1'b0}}, 1'b1},
	dummy,
	result
);

endmodule
`endif

