`include "multiplier.sv"
`include "test_functions.sv"

module multiplier_tb();

localparam integer SIZE = 2;

reg[SIZE-1:0] a;
reg[SIZE-1:0] b;
wire[(SIZE*2)-1:0] c;
wire over;

initial
begin
	$dumpfile("multiplier_2.vvp");
	$dumpvars(0, multiplier_tb);
	$display("Time\t a\t b\t over\t c\t");
	$monitor("%g\t %b\t %b\t %b\t %b\t",$time,a,b,over,c);

	a = 2'b00;
	b = 2'b00;

	#1
	a = 2'b11;
	b = 2'b00;
	#1 `ASSERT(c, 4'b0000);

	#1
	a = 2'b11;
	b = 2'b01;
	#1 `ASSERT(c, 4'b0011);

	#1
	a = 2'b11;
	b = 2'b10;
	#1 `ASSERT(c, 4'b0110);

	#1
	a = 2'b11;
	b = 2'b11;
	#1 `ASSERT(c, 4'b1001);

	#1 $finish;
end

multiplier
#(
	SIZE
)
uut
(
	a,
	b,
	over,
	c
);

endmodule
