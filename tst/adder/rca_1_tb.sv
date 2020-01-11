`include "rca.sv"
`include "test_functions.sv"

module rca_tb();

localparam integer SIZE = 1;

// Inputs
reg a;
reg b;
// Outputs
wire[SIZE:0] result;

initial
begin
	$dumpfile("rca_1.vvp");
	$dumpvars(0, rca_tb);
	$display("Time\t A\t B\t Result");
	$monitor("%g\t %b\t %b\t %b",$time,a,b,result);
	
	a = 1'b0;
	b = 1'b0;

	#1 `ASSERT(result, 2'b00);

	#1 a = 1'b1;

	#1 `ASSERT(result, 2'b01);

	#1 a = 1'b0;
	b = 1'b1;

	#1 `ASSERT(result, 2'b01);

	#1 b = 1'b0;

	#1 `ASSERT(result, 2'b00);

	#1 a = 1'b1;
	b = 1'b1;

	#1 `ASSERT(result, 2'b10);

	#1 a = 1'b0;

	#1 `ASSERT(result, 2'b01);

	#1 b = 1'b0;
	a = 1'b1;

	#1 `ASSERT(result, 2'b01);

	#1 a = 1'b1;
	b = 1'b1;

	#1 `ASSERT(result, 2'b10);

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
	result
);
endmodule
