`include "twos_comp.sv"
`include "test_functions.sv"

module twos_comp_tb();

localparam integer SIZE = 4;

reg[SIZE-1:0] a;
wire[SIZE-1:0] b;


initial begin
	$dumpfile("twos_comp_4.vvp");
	$dumpvars(0, twos_comp_tb);
	$display("Time\t a\t b\t");
	$monitor("%g\t %b\t %b\t",$time,a,b);

	a = 4'h0;
	#1 `ASSERT(b, 4'h0);

	#1
	a = 4'h4;
	#1 `ASSERT(b, 4'hC);

	#1
	a = 4'h1;
	#1 `ASSERT(b, 4'hF);

	#1
	a = 4'h6;
	#1 `ASSERT(b, 4'hA);

	#1
	a = 4'h7;
	#1 `ASSERT(b, 4'h9);

	#1 $finish;
end


twos_complementor
#(
	SIZE
)
uut
(
	a,
	b
);

endmodule
