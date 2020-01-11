`include "rca.sv"
`include "test_functions.sv"

module rca_tb();

localparam integer SIZE = 2;

// Inputs
reg[SIZE - 1:0] a;
reg [SIZE - 1:0]b;
// Outputs
wire[SIZE:0] result;

initial
begin
	$dumpfile("rca_22tb.vvp");
	$dumpvars(0, rca_tb);
	$display("Time\t A\t B\t Result");
	$monitor("%g\t %b\t %b\t %b",$time,a,b,result);
	
	a = 2'b00;
	b = 2'b00;

	#1 `ASSERT(result, 4'b000);

	#1 a = 2'b01;

	#1 `ASSERT(result, 4'b001);

	#1 a = 2'b00;
	b = 2'b01;

	#1 `ASSERT(result, 4'b001);

	#1 a = 2'b10;
	b = 2'b00;

	#1 `ASSERT(result, 4'b010);

	#1 b = 2'b01;

	#1 `ASSERT(result, 4'b011);

	#1 b = 2'b10;

	#1 `ASSERT(result, 4'b100);

	#1 b = 2'b0;
	a = 2'b11;

	#1 `ASSERT(result, 4'b011);

	#1 b = 2'b01;

	#1 `ASSERT(result, 4'b100);

	#1 b = 2'b10;

	#1 `ASSERT(result, 4'b101);

	#1 b = 2'b11;

	#1 `ASSERT(result, 4'b110);

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
