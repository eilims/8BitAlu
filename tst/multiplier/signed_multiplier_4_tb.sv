`include "signed_multiplier.sv"
`include "test_functions.sv"

module multiplier_tb();

localparam integer SIZE = 4;

reg[SIZE-1:0] a;
reg[SIZE-1:0] b;
wire[(SIZE*2)-1:0] c;
wire over;

initial
begin
	$dumpfile("signed_multiplier_4.vvp");
	$dumpvars(0, multiplier_tb);
	$display("Time\t a\t b\t over\t c\t");
	$monitor("%g\t %b\t %b\t %b\t %b\t",$time,a,b,over,c);

	a = 4'b0000; //0
	b = 4'b0000; //0
	#1
	`ASSERT(c, 8'h00); //0
	`ASSERT(over, 1'h0);

	a = 4'hF; //-1
	b = 4'h0; //0
	#1
	`ASSERT(c, 8'h00); //0
	`ASSERT(over, 1'h0);

	a = 4'hF; //-1
	b = 4'h1; //1
	#1
	`ASSERT(c, 8'h0F); //-1
	`ASSERT(over, 1'h0);
	
	a = 4'hF; //-1
	b = 4'h2; //2
	#1
	`ASSERT(c, 8'hE); //-2
	`ASSERT(over, 1'h0);

	a = 4'hF; //-1
	b = 4'h3; //3
	#1
	`ASSERT(c, 8'hD); //-3
	`ASSERT(over, 1'h0);

	a = 4'hF; //-1
	b = 4'h4; //4
	#1
	`ASSERT(c, 8'hC); //-4
	`ASSERT(over, 1'h0);

	a = 4'hF; //-1
	b = 4'h9; //-7
	#1
	`ASSERT(c, 8'h7); //4
	`ASSERT(over, 1'h0);

	a = 4'h2; //2
	b = 4'h3; //3
	#1
	`ASSERT(c, 8'h6); //6
	`ASSERT(over, 1'h0);

	a = 4'h3; //3
	b = 4'h3; //3
	#1
	`ASSERT(c, 8'h9); // Invalid
	`ASSERT(over, 1'h1);

	#1 $finish;
end

signed_multiplier
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
