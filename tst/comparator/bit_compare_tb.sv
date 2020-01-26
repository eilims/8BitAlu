`include "bit_compare.sv"
`include "test_functions.sv"

module bit_compare_tb();

reg a;
reg b;
reg a_skip;
reg b_skip;
wire a_g;
wire b_g;

initial
begin
	$dumpfile("bit_compare.vvp");
	$dumpvars(0, bit_compare_tb);
	$display("Time\t a\t b\t a_skip\t b_skip\t a_g\t b_g\t");
	$monitor("%g\t %b\t %b\t %b\t %b\t %b\t %b\t",$time,a,b,a_skip,b_skip,a_g,b_g);

	a = 1'b0;
	b = 1'b0;
	a_skip = 1'b0;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b0);
	`ASSERT(b_g, 1'b0);

	a = 1'b1;
	b = 1'b0;
	a_skip = 1'b0;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b1);
	`ASSERT(b_g, 1'b0);

	a = 1'b0;
	b = 1'b1;
	a_skip = 1'b0;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b0);
	`ASSERT(b_g, 1'b1);

	a = 1'b1;
	b = 1'b1;
	a_skip = 1'b0;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b0);
	`ASSERT(b_g, 1'b0);

	a = 1'b0;
	b = 1'b0;
	a_skip = 1'b1;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b1);
	`ASSERT(b_g, 1'b0);

	a = 1'b1;
	b = 1'b0;
	a_skip = 1'b1;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b1);
	`ASSERT(b_g, 1'b0);

	a = 1'b0;
	b = 1'b1;
	a_skip = 1'b1;
	b_skip = 1'b0;
	#1 
	`ASSERT(a_g, 1'b1);
	`ASSERT(b_g, 1'b0);

	a = 1'b1;
	b = 1'b0;
	a_skip = 1'b0;
	b_skip = 1'b1;
	#1 
	`ASSERT(a_g, 1'b0);
	`ASSERT(b_g, 1'b1);
end

bit_compare
uut
(
	a,
	b,
	a_skip,
	b_skip,
	a_g,
	b_g
);

endmodule
