`include "shifter.sv"
`include "test_functions.sv"

module shifter_2_tb ();

localparam integer SIZE = 2;

reg is_left_shift;
reg shift_in;
reg[SIZE-1:0] data;
wire[SIZE-1:0] data_out;
wire shift_out;

initial
begin
	$dumpfile("shifter_2.vvp");
	$dumpvars(0, shifter_2_tb);
	$display("Time\t L_Sft\t In\t D\t D_Out\t Out");
	$monitor("%g\t %b\t %b\t %b\t %b\t %b",$time,is_left_shift,shift_in,
		data,data_out,shift_out);

	is_left_shift = 1'b0;
	shift_in = 1'b0;
	data = 2'b00;
	
	#1 
	`ASSERT(data_out, 2'b00);
	`ASSERT(shift_out, 1'b0);

	#1 data = 2'b01;

	#1 
	`ASSERT(data_out, 2'b00);
	`ASSERT(shift_out, 1'b1);

	#1 data = 2'b11;

	#1 
	`ASSERT(data_out, 2'b01);
	`ASSERT(shift_out, 1'b1);

	#1 is_left_shift = 1'b1;

	#1 
	`ASSERT(data_out, 2'b10);
	`ASSERT(shift_out, 1'b1);

	#1 data = 2'b00;
	shift_in = 1'b1;

	#1 
	`ASSERT(data_out, 2'b01);
	`ASSERT(shift_out, 1'b0);

	#1 is_left_shift = 1'b0;

	#1 
	`ASSERT(data_out, 2'b10);
	`ASSERT(shift_out, 1'b0);

	#1 $finish;
end

shifter
#(
	SIZE
)
uut
(
	is_left_shift,
	shift_in,
	data,
	data_out,
	shift_out
);

endmodule
