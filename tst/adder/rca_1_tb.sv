`include "rca.sv"
`include "test_functions.sv"

module rca_tb();

localparam integer SIZE = 1;

// Inputs
reg a;
reg b;
// Outputs
wire overflow;
wire[SIZE:0] result;

initial
begin
	$dumpfile("rca_1.vvp");
	$dumpvars(0, rca_tb);
	$display("Time\t A\t B\t Over\t Result");
	$monitor("%g\t %b\t %b\t %b\t %b",$time,a,b,overflow,result);
	
	a = 1'b0;
	b = 1'b0;

	#1 `ASSERT(result, 2'b00);
	`ASSERT(overflow, 0);

	#1 a = 1'b1;

	#1 `ASSERT(result, 2'b01);
	`ASSERT(overflow, 0);

	#1 a = 1'b0;
	b = 1'b1;

	#1 `ASSERT(result, 2'b01);
	`ASSERT(overflow, 0);

	#1 b = 1'b0;

	#1 `ASSERT(result, 2'b00);
	`ASSERT(overflow, 0);

	#1 a = 1'b1;
	b = 1'b1;

	#1 `ASSERT(result, 2'b10);
	`ASSERT(overflow, 1);

	#1 a = 1'b0;

	#1 `ASSERT(result, 2'b01);
	`ASSERT(overflow, 0);

	#1 b = 1'b0;
	a = 1'b1;

	#1 `ASSERT(result, 2'b01);
	`ASSERT(overflow, 0);

	#1 a = 1'b1;
	b = 1'b1;

	#1 `ASSERT(result, 2'b10);
	`ASSERT(overflow, 1);

	#1 $finish;
end

RCA
#(
	SIZE
)
uut
(
	a,
	b,
	overflow,
	result
);
endmodule
