`include "subtractor.sv"
`include "test_functions.sv"

module subtractor_tb();

localparam integer SIZE = 4;
reg[SIZE-1:0] a;
reg[SIZE-1:0] b;
wire overflow;
wire[SIZE:0] result;

initial
begin
	$dumpfile("subtractor_4.vvp");
        $dumpvars(0, subtractor_tb);
        $display("Time\t a\t b\t over\t result");
        $monitor("%g\t %b\t %b\t %b\t %b",$time,a,b,overflow,result);

	//Positive number tests
	a = 4'h0;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h00);

	#1
	a = 4'h1;
	b = 4'h0;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h01);

	#1
	a = 4'h1;
	b = 4'h1;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h00);

	#1
	a = 4'h5;
	b = 4'h3;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h02);

	#1
	a = 4'h7;
	b = 4'h2;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h05);

	#1
	a = 4'h5;
	b = 4'h6;
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h1F);
	
	// Negative number tests
	#1
	a = 4'h9; // -7
	b = 4'hE; // -2
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h1B); // -5

	#1
	a = 4'hF; // -1
	b = 4'hF; // -1
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h00);

	#1
	a = 4'hE; // -2
	b = 4'hB; // -5
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h03);

	// Mixed testing
	#1
	a = 4'hF; // -1
	b = 4'h1; // 1
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h1E); // -2 but valid

	#1
	a = 4'hF; // -1
	b = 4'h7; // 7
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h18); // -8 but valid

	#1
	a = 4'h1; // 1
	b = 4'hA; // -6
	#1
	`ASSERT(overflow, 1'b0);
	`ASSERT(result, 5'h07); // 7 but valid    

	// Overflow testing
	#1
	a = 4'hB; // -5
	b = 4'h4;
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h17); // "-9" but invalid

	#1
	a = 4'hC; // -4
	b = 4'h5;
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h17); // "-9" but invalid

	#1
	a = 4'h4;
	b = 4'hB; // -5
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h09); // "9" but invalid

	#1
	a = 4'h1;
	b = 4'h8; // -8
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h19); // "9" but invalid

	#1
	a = 4'h1;
	b = 4'h9; // -7
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h08); // "8" but invalid

	#1
	a = 4'hE; // -2
	b = 4'h7; // 7
	#1
	`ASSERT(overflow, 1'b1);
	`ASSERT(result, 5'h17); // -2 but invalid


	#1 $finish;
end

subtractor
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
