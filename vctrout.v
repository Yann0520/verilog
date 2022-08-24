module vctrout(
	input			clock,
	input			nrst,
	input	[7:0]	vctr_data_out
	);
	
	reg	[7:0]	vctrout_ch0	= 0;
	reg	[7:0]	vctrout_ch1	= 0;
	reg	[7:0]	vctrout_ch2	= 0;
	reg	[1:0] 	rx_state	= 0;
	reg	[12:0]	clock_counter = 0; 
	reg			bit_clock = 0;
	reg	[5:0]	clocker = 0;
	
	
	localparam clock_div = 625;
	
	always@(posedge clock)
		if(!nrst) begin
			clock_counter <= 0;
			end
		else if (clock_counter == clock_div) begin
			clock_counter <= 0;
			end
		else begin
			clock_counter <= clock_counter + 1;
			end
			
	always@(posedge clock)
		if(!nrst)
			bit_clock <= 0;
		else if (clock_counter == clock_div)
			bit_clock <= ~bit_clock;
		else
			bit_clock <= bit_clock;
			
	always@(posedge bit_clock)
		if(vctr_data_out == 8'h00)
			clocker <= 0;
		else if(vctr_data_out == 8'h01)
			clocker <= 20;
		else if(vctr_data_out == 8'h02)
			clocker <= 40;
		else
			if(clocker !=19 || clocker !=39 || clocker !=59)
				clocker <= clocker + 1;
			else
				clocker <= clocker;
				
	always@(posedge bit_clock)
		if(clocker <= 19)
			vctrout_ch0 <= vctr_data_out;
		else if(clocker <= 39)
			vctrout_ch1 <= vctr_data_out;
		else if(clocker <= 59)
			vctrout_ch2 <= vctr_data_out;
		else	
			begin
				vctrout_ch0 <= 0;
				vctrout_ch1 <= 0;
				vctrout_ch2 <= 0;
			end
		
endmodule