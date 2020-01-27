`include "signed_comparator.sv"
`include "test_functions.sv"

module signed_comparator_tb();

localparam integer SIZE = 4;

reg[SIZE-1:0] a;
reg[SIZE-1:0] b;
wire is_a_greater;
wire equal;

initial
begin
	$dumpfile("signed_comparator.vvp");
	$dumpvars(0, signed_comparator_tb);
	$display("Time\t a\t b\t a_g\t equal\t");
	$monitor("%g\t %b\t %b\t %b\t %b\t",$time,a,b,is_a_greater,equal);

	a = 4'h0;
	b = 4'h0;
	#1
	`ASSERT(is_a_greater, 1'b0);
	`ASSERT(equal, 1'b1);

	a = 4'h1;
	b = 4'h0;
	#1
	`ASSERT(is_a_greater, 1'b1);
	`ASSERT(equal, 1'b0);

	a = 4'h0;
	b = 4'h1;
	#1
	`ASSERT(is_a_greater, 1'b0);
	`ASSERT(equal, 1'b0);

	a = 4'hF;
	b = 4'h0;
	#1
	`ASSERT(is_a_greater, 1'b0);
	`ASSERT(equal, 1'b0);

	a = 4'hF;
	b = 4'hF;
	#1
	`ASSERT(is_a_greater, 1'b0);
	`ASSERT(equal, 1'b1);

	a = 4'h8;
	b = 4'h2;
	#1
	`ASSERT(is_a_greater, 1'b0);
	`ASSERT(equal, 1'b0);

	a = 4'h0;
	b = 4'hF;
	#1
	`ASSERT(is_a_greater, 1'b1);
	`ASSERT(equal, 1'b0);

	a = 4'hE;
	b = 4'hE;
	#1
	`ASSERT(is_a_greater, 1'b0);
	`ASSERT(equal, 1'b1);


	#1 $finish;

end

signed_comparator
#(
	SIZE
)
uut
(
	a,
	b,
	is_a_greater,
	equal
);

endmodule
