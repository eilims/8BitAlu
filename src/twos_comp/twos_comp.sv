`include "rca.sv"


module twos_complementor
#(
	parameter integer SIZE = 1
)
(
	input wire [SIZE-1:0] a,
	output wire [SIZE-1:0] b
);

wire[SIZE:0] result;
assign b = result[SIZE-1:0];


RCA
#(
	SIZE
)
adder
(
	~a,
	{{SIZE-1{1'b0}}, 1'b1},
	result
);

endmodule

