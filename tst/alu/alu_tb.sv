`include "alu.sv"
`include "test_functions.sv"

module alu_tb();

localparam integer SIZE = 4;

reg enable;
reg[3:0] command;
reg[SIZE-1:0] a;
reg[SIZE-1:0] b;
wire overflow;
wire[(2*SIZE)-1:0] result;

initial
begin
	$dumpfile("alu.vvp");
	$dumpvars(0, alu_tb);
	$display("Time\t en\t com\t a\t b\t over\t r\t");
	$monitor("%g\t %b\t %b\t %b\t %b\t %b\t %b\t",$time,enable,command,a,b,overflow,result);

	// AND Test
	$display("AND Test");
	enable = 1'b1;
	command = 4'b0;
	a = 4'h1;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h1);

	enable = 1'b1;
	command = 4'b0;
	a = 4'h5;
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h5);

	enable = 1'b1;
	command = 4'b0;
	a = 4'hF;
	b = 4'hF;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hF);

	enable = 1'b1;
	command = 4'b0;
	a = 4'hA;
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'b0;
	a = 4'h7;
	b = 4'h3;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h3);

	// OR Test
	$display("OR Test");
	enable = 1'b1;
	command = 4'h1;
	a = 4'h1;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h1);

	enable = 1'b1;
	command = 4'h1;
	a = 4'h5;
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h5);

	enable = 1'b1;
	command = 4'h1;
	a = 4'hF;
	b = 4'hF;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hF);

	enable = 1'b1;
	command = 4'h1;
	a = 4'hA;
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hF);

	enable = 1'b1;
	command = 4'h1;
	a = 4'h7;
	b = 4'h3;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h7);

	// XOR Test
	$display("XOR Test");
	enable = 1'b1;
	command = 4'h2;
	a = 4'h1;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'h2;
	a = 4'h5;
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'h2;
	a = 4'hF;
	b = 4'hF;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'h2;
	a = 4'hA;
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hF);

	enable = 1'b1;
	command = 4'h2;
	a = 4'h7;
	b = 4'h3;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h4);

	// NOT Test
	$display("NOT Test");
	enable = 1'b1;
	command = 4'h3;
	a = 4'h1;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hE);

	enable = 1'b1;
	command = 4'h3;
	a = 4'h5;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hA);

	enable = 1'b1;
	command = 4'h3;
	a = 4'hF;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'h3;
	a = 4'hA;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h5);

	enable = 1'b1;
	command = 4'h3;
	a = 4'h7;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h8);

	$display("Unsigned Adder Test");
	enable = 1'b1;
	command = 4'h4;
	a = 4'h0;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'h4;
	a = 4'h1;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h1);

	enable = 1'b1;
	command = 4'h4;
	a = 4'h7;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h8);

	enable = 1'b1;
	command = 4'h4;
	a = 4'hF;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hF);

	enable = 1'b1;
	command = 4'h4;
	a = 4'hF;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h10);

	$display("Signed Adder Test");
	enable = 1'b1;
	command = 4'h5;
	a = 4'h0;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h0);

	enable = 1'b1;
	command = 4'h5;
	a = 4'h1;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'h1);

	enable = 1'b1;
	command = 4'h5;
	a = 4'h7;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 4'h8);

	enable = 1'b1;
	command = 4'h5;
	a = 4'hF;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 4'hF);

	enable = 1'b1;
	command = 4'h5;
	a = 4'hF;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h10);

	enable = 1'b1;
	command = 4'h5;
	a = 4'h8;
	b = 4'hF;
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h17);

end

alu
#(
	SIZE
)
uut
(
	enable,
	command,
	a,
	b,
	overflow,
	result
);

endmodule
