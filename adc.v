module adc(
	input real reference,
	input real analog_in,
	output [3:0] digital_out
);

	real step;
	wire [15:0] comparator_bus;

	genvar i;
	generate
		for(i = 0; i <= 15; i = i + 1) begin: comparator_gen_block
			comparator comp0(
				.positive_in(step*i), 
				.negative_in(analog_in), 
				.comparator_out(comparator_bus[i])
				); 
		end
	endgenerate

	always@(*) begin
		step = reference/16.0;
	end

	decoder #(.DATA_WIDTH(16)) my_decoder(
		.in(comparator_bus),
		.out(digital_out)
	);

endmodule
