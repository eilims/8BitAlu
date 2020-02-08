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
