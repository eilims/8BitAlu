`include "multiplier.sv"
`include "test_functions.sv"

module multiplier_tb();

localparam integer SIZE = 4;

reg[SIZE-1:0] a;
reg[SIZE-1:0] b;
wire[(SIZE*2)-1:0] c;
wire over;

initial
begin
	$dumpfile("multiplier_4.vvp");
	$dumpvars(0, multiplier_tb);
	$display("Time\t a\t b\t over\t c\t");
	$monitor("%g\t %b\t %b\t %b\t %b\t",$time,a,b,over,c);

	a = 4'b0000;
	b = 4'b0000;

	#1
	a = 4'b1111;
	b = 4'b0000;
	#1 `ASSERT(c, 8'b00000000);

	#1
	a = 4'b1111;
	b = 4'b0001;
	#1 `ASSERT(c, 8'b00001111);

	#1
	a = 4'b1111;
	b = 4'b0010;
	#1 `ASSERT(c, 8'b00011110);

	#1
	a = 4'b1111;
	b = 4'b0011;
	#1 `ASSERT(c, 8'b00101101);

	#1
	a = 4'b1111;
	b = 4'b0100;
	#1 `ASSERT(c, 8'b00111100);

	#1
	a = 4'b1111;
	b = 4'b1001;
	#1 `ASSERT(c, 8'b10000111);
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
