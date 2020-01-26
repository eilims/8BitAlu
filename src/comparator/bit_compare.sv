
module bit_compare
(
	input wire a,
	input wire b,
	input wire a_skip,
	input wire b_skip,
	output wire a_g,
	output wire b_g
);

assign a_g = (((a^b) && (a)) || (a_skip)) && (~b_skip);
assign b_g = (((a^b) && (b)) || (b_skip)) && (~a_skip);

endmodule
