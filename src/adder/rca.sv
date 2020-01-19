`include "bit_adder.sv"

module RCA 
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE - 1:0] a,
	input wire[SIZE - 1:0] b,
	output wire[SIZE:0] result
);	

wire[SIZE - 1:0] carry;

generate
	genvar i;
	for(i = 0; i < SIZE; i = i + 1)
	begin
		
		if((i == 0) && (i == (SIZE - 1)))
		begin
			bit_adder bit_adder_zero_end
			(
				a[i],
				b[i],
				1'b0,
				result[i],
				result[i+1]
			);
		end
		else if(i == 0)
		begin
			bit_adder bit_adder_zero
			(
				a[i],
				b[i],
				1'b0,
				result[i],
				carry[i]
			);
		end
		else if(i == (SIZE - 1))
		begin
			bit_adder bit_adder_end
			(
				a[i],
				b[i],
				carry[i - 1],
				result[i],
				result[i+1]
			);
		end
		else
		begin
			bit_adder bit_adder_middle
			(
				a[i],
				b[i],
				carry[i - 1],
				result[i],
				carry[i]
			);
		end
	end
endgenerate
endmodule
