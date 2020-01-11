`include "rca.sv"


module multiplier
#(
	parameter integer SIZE = 2
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire[(SIZE*2)-1:0] c
);

localparam integer FULL_SIZE = (SIZE*2)-1;

wire[FULL_SIZE-1:0] shift_results[SIZE-1:0];
wire[FULL_SIZE:0] add_results[SIZE-2:0];

generate
genvar i;

// Shift logic creation
for(i = 0; i < SIZE; i = i + 1)
begin
	assign shift_results[i] = (b[i] == 1) ? (a << i) : 0;
end

// Addition logic creation
for(i = 0; i < SIZE-1; i = i + 1)
begin
	if(i == 0)
	begin
		RCA
		#(
			FULL_SIZE
		)
		adder
		(
			shift_results[0],
			shift_results[1],
			add_results[0]
		);
		// Additional increment to skip shift slot 1
	end
	else
	begin
		RCA
		#(
			FULL_SIZE
		)
		adder
		(
			shift_results[i+1],
			add_results[i-1][FULL_SIZE-1:0],
			add_results[i]
		);	
	end
end
endgenerate

assign c = add_results[SIZE-2];

endmodule

