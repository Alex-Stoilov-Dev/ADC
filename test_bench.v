module test_bench();

	real reference_voltage = 1.2;
	real analog_input;
	real step;
	real temp_step;

	assign step = reference_voltage/16.0;

	reg [3:0] digital_output;

	adc my_adc(
		.reference(reference_voltage),
		.analog_in(analog_input),
		.digital_out(digital_output)
	);

	initial begin
		forever begin
			analog_input = 0;
			#5;
			analog_input = step;
			#5;
			analog_input = step * 2.0;
			#5;
			analog_input = step * 3.0;
			#5;
			analog_input = step * 4.0;
			#5;
			analog_input = step * 5.0;
			#5;
			analog_input = step * 6.0;
			#5;
			analog_input = step * 7.0;
			#5;
			analog_input = step * 8.0;
			#5;
			analog_input = step * 9.0;
			#5;
			analog_input = step * 10.0;
			#5;
			analog_input = step * 11.0;
			#5;
			analog_input = step * 12.0;
			#5;
			analog_input = step * 13.0;
			#5;
			analog_input = step * 14.0;
			#5;
			analog_input = step * 15.0;
			#5;
			analog_input = step * 16.0;
		end
	end

	initial begin
		#1500 $finish;
	end

endmodule
