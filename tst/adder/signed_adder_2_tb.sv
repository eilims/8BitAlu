`include "signed_adder.sv"
`include "test_functions.sv"

module signed_adder_tb();

localparam integer SIZE = 2;

// Inputs
reg[SIZE - 1:0] a;
reg [SIZE - 1:0]b;
// Outputs
wire overflow;
wire[SIZE:0] result;

initial
begin
	$dumpfile("signed_adder_2.vvp");
	$dumpvars(0, signed_adder_tb);
	$display("Time\t A\t B\t Over\t Result");
	$monitor("%g\t %b\t %b\t %b\t %b",$time,a,b,overflow,result);
	
	a = 2'b00;
	b = 2'b00;

	#1 `ASSERT(result, 4'b000);
	`ASSERT(overflow, 0);

	#1 a = 2'b01;

	#1 `ASSERT(result, 4'b001);
	`ASSERT(overflow, 0);

	#1 a = 2'b00;
	b = 2'b01;

	#1 `ASSERT(result, 4'b001);
	`ASSERT(overflow, 0);

	#1 a = 2'b10;
	b = 2'b00;

	#1 `ASSERT(result, 4'b010);
	`ASSERT(overflow, 0);

	#1 b = 2'b01;

	#1 `ASSERT(result, 4'b011);
	`ASSERT(overflow, 0);

	#1 b = 2'b10;

	#1 `ASSERT(result, 4'b100);
	`ASSERT(overflow, 1);

	#1 b = 2'b0;
	a = 2'b11;

	#1 `ASSERT(result, 4'b011);
	`ASSERT(overflow, 0);

	#1 b = 2'b01;

	#1 `ASSERT(result, 4'b100);
	`ASSERT(overflow, 1);

	#1 b = 2'b10;

	#1 `ASSERT(result, 4'b101);
	`ASSERT(overflow, 1);

	#1 b = 2'b11;

	#1 `ASSERT(result, 4'b110);
	`ASSERT(overflow, 1);

	#1 $finish;
end

signed_adder
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
