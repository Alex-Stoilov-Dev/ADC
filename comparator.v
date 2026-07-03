module comparator(
	input real positive_in,
	input real negative_in,
	output reg comparator_out
);

	always@(*) begin
		if(negative_in > positive_in) begin
			comparator_out = 1;
		end
		else begin
			comparator_out = 0;
		end	
	end

endmodule
