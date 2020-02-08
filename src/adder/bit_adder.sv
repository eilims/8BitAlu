`ifndef BIT_ADDER_SV
`define BIT_ADDER_SV

module bit_adder 
(
	input wire a,
	input wire b,
	input wire carry_in,
	output wire result,
	output wire carry_out
);

assign result = a ^ b ^ carry_in;
assign carry_out = (a & b) || (a & carry_in) || (b & carry_in);

endmodule
`endif

