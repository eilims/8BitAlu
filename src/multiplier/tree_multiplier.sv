`include "adder.sv"

module tree_multiplier
#(
	parameter integer SIZE = 2
)
(
	input wire[SIZE-1:0] a,
	input wire[SIZE-1:0] b,
	output wire overflow,
	output wire[(SIZE*2)-1:0] c
);

// Adder calc function
// This function calculates the number of adders required to complete the
// multiplication. It functions by dividing the number of inputs by two, as
// each adder can take two inputs. This process is repeated until the number
// of inputs is less than one, implying no more additions can be made. If
// the number of inputs is odd for any stage, an additional adder must be
// included.
function integer calc_num_adders(input integer inputs);
integer curr_count;
begin
	curr_count = 0;
	while(inputs > 1)
	begin
		// If odd add additional slot for extra value
		if(inputs % 2 != 0)
		begin
			inputs = inputs + 1;
		end
		// Calculate number of adders needed
		inputs = inputs / 2;
		curr_count = curr_count + inputs;
	end
	calc_num_adders = curr_count;
end
endfunction

localparam integer FULL_SIZE = (SIZE*2)-1;
localparam integer number_of_adders = calc_num_adders(SIZE);

// The results array will hold all the shifted initial data and
// the addition results. The number of elements is calculated by having 
// one slot for every shifted result (See Shifted Logic creation), and one slot
// for every adder (See Adder Calc function). For implementation see the Addition logic creation
localparam integer results_size = SIZE + number_of_adders;
wire[FULL_SIZE:0] results[results_size-1:0];
wire[number_of_adders-1:0] overflow_res;

generate
genvar i;

// Shift logic creation
// Creates a seperate shift product for every bit location in the
// input factors. The shift products storage index within the results array
// corresponds to the amount the factor was shifted.
for(i = 0; i < SIZE; i = i + 1)
begin
	assign results[i] = (b[i] == 1) ? (a << i) : 0;
end

// Addition logic creation
// The result array is comprised of slots dedicated to shifted data and adder
// results. The for loop begins iterating at the first adder location, as
// there are SIZE number of shifted products already present in the array (See
// Shift logic creation). As an example, the sum of the
// first two elements in the result array are calculated and placed into the
// first adder result location. The adder index is incremented and the
// summation term indexes are incremented by two. This process is repeated 
// until all of the shifted data AND adder results have been added, and
// the result is represented within the last result index.
for(i = SIZE; i < results_size; i = i + 1)
begin
	adder
	#(
		FULL_SIZE
	)
	adder_stage
	(
		results[((i-SIZE)*2)][FULL_SIZE-1:0],
		results[((i-SIZE)*2)+1][FULL_SIZE-1:0],
		overflow_res[i-SIZE],
		results[i]
	);
end
endgenerate

assign c = results[results_size-1];
assign overflow = |results[results_size-1][FULL_SIZE:SIZE];

endmodule

