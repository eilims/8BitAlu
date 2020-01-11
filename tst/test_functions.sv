`define ASSERT(OUTPUT, EXPECTED) 					\
	if(OUTPUT !== EXPECTED)						\
	begin								\
		$error;							\
		$display("Output: %b Expected %b", OUTPUT, EXPECTED);	\
	end								\
