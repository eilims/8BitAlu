`include "bit_compare.sv"

module comparator
#(
	parameter integer SIZE = 1
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire is_a_greater,
	output wire equal
);

wire[SIZE-1:0] a_result;
wire[SIZE-1:0] b_result;

generate
genvar i;
for(i=0;i<SIZE;i=i+1)
begin
	if(i==0)
	begin
	bit_compare comparator_start
	(
		a[SIZE-1-i],
		b[SIZE-1-i],
		1'b0,
		1'b0,
		a_result[i],
		b_result[i]
	);
	end
	else
	begin
	bit_compare comparator_standard
	(
		a[SIZE-1-i],
		b[SIZE-1-i],
		a_result[i-1],
		b_result[i-1],
		a_result[i],
		b_result[i]
	);
	end
end
endgenerate

assign is_a_greater = |a_result;
assign equal = ~((|a_result) || (|b_result));

endmodule
