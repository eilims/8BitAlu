`include "bit_adder.sv"
`include "test_functions.sv"

module bit_adder_tb();

// Inputs
reg a;
reg b;
reg carry_in;
// Outputs
wire result;
wire carry_out;

initial
begin
	$dumpfile("bit_adder.vvp");
	$dumpvars(0, bit_adder_tb);
	$display("Time\t A\t B\t C\t C_O\t R");
	$monitor("%g\t %b\t %b\t %b\t %b\t %b",$time,a,b,carry_in,carry_out,result);
	
	a = 1'b0;
	b = 1'b0;
	carry_in = 1'b0;

	#1 `ASSERT(result, 1'b0);
	`ASSERT(carry_out, 1'b0);

	#1 a = 1'b1;

	#1 `ASSERT(result, 1'b1);
	`ASSERT(carry_out, 1'b0);

	#1 a = 1'b0;
	b = 1'b1;

	#1 `ASSERT(result, 1'b1);
	`ASSERT(carry_out, 1'b0);

	#1 b = 1'b0;
	carry_in = 1'b1;

	#1 `ASSERT(result, 1'b1);
	`ASSERT(carry_out, 1'b0);

	#1 carry_in = 1'b0;

	#1 `ASSERT(result, 1'b0);
	`ASSERT(carry_out, 1'b0);

	#1 a = 1'b1;
	b = 1'b1;

	#1 `ASSERT(result, 1'b0);
	`ASSERT(carry_out, 1'b1);

	#1 a =1'b0;
	carry_in = 1'b1;

	#1 `ASSERT(result, 1'b0);
	`ASSERT(carry_out, 1'b1);

	#1 b = 1'b0;
	a = 1'b1;

	#1 `ASSERT(result, 1'b0);
	`ASSERT(carry_out, 1'b1);

	#1 a = 1'b1;
	b = 1'b1;
	carry_in = 1'b1;

	#1 `ASSERT(result, 1'b1);
	`ASSERT(carry_out, 1'b1);

	 #1 $finish;
end

bit_adder uut(
	a,
	b,
	carry_in,
	result,
	carry_out
);
endmodule
