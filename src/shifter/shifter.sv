`default_nettype none

module shifter
#(
	parameter integer SIZE = 2
)
(
	input wire is_left_shift,
	input wire shift_in,
	input wire[SIZE-1:0] data,
	output wire[SIZE-1:0] data_out,
	output wire shift_out
);

if(SIZE > 1)
begin
	assign data_out = (is_left_shift ? 
	{data[SIZE-2:0], shift_in} :
	{shift_in, data[SIZE-1:1]});

	assign shift_out = (is_left_shift ? data[SIZE-1] : data[0]);
end
else
begin
	assign data_out = shift_in;

	assign shift_out = data[0];
end

endmodule
