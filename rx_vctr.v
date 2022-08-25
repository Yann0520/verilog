module rx (
	input		nrst,
	input		clock,
	input		rx,
	input		rx_vctr_comp_out,
	input		rx_vctr_comp_in,
	output	reg	[7:0]	rx_data,
	output	reg			vctr_out = 0,
	output	reg			vctr_in = 0,
	output	reg	[7:0]	rx_data_out,
	output	reg	[7:0]	rx_data_in,
	output		rx_vctr_comp,
	input		rx_ch_comp
	);
	
	reg [3:0] 	rx_state = 0;
	reg	[31:0]	clock_counter = 0; 
	wire[12:0]	clock_div;
	reg			bit_clock = 0;
	reg [2:0]	i = 0;
	reg			rx_complete = 1;
	reg [07:0] rx_buffer;

	reg	[10:0]	clocker = 0;
	assign 		clock_div = 625;
	assign 		rx_vctr_comp = rx_vctr_comp_in & rx_vctr_comp_out;

	
	parameter	idle	=	0;
	parameter	s00		=	1;
	parameter	s01		=	2;
	parameter	s02		=	3;
	parameter	s03		=	4;
	parameter	s04		=	5;
	parameter	s05		=	6;
	parameter	s06		=	7;
	parameter	s07		=	8;
	parameter	stop	=	9;
	
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
						
	
	always@(posedge clock)
		if(clocker < 10)
			rx_complete <= 0;
		else
			rx_complete <= 1;
			
	
	always@(posedge bit_clock)
		if(rx_state == idle)
			if(clocker != 20)
				clocker <= clocker + 1;
			else
				clocker <= clocker;
		else 
			clocker <= -1;
			
	always@(posedge clock)
		if(rx_data == 8'hA5 && rx_vctr_comp_in == 1)
			begin
				vctr_out <= 1;
				vctr_in <= 0;
			end
		else if(rx_data == 8'h00 && rx_vctr_comp_out == 1)
			begin
				vctr_in <= 1;
				vctr_out <= 0;
			end
		else if(rx_vctr_comp)
			begin
				vctr_in <= 0;
				vctr_out <= 0;
			end
		else
			begin
				vctr_out <= vctr_out;
				vctr_in <= vctr_in;
			end

			
	always@(posedge bit_clock)
		if(vctr_out)
			rx_data_out <= rx_data;
		else if(vctr_in)
			rx_data_in <= rx_data;
		else
			begin
				rx_data_out <= rx_data_out;
				rx_data_in <= rx_data_in;
			end
	
			
	always@(posedge bit_clock)
		begin
			if(!nrst)
				begin
					rx_state <= idle;
				end
			else
				begin
					case(rx_state)
                idle:
                begin
                    if (rx == 0)
                        rx_state <= s00;
                end

                s00:
                begin
                    rx_buffer[0] <= rx;
                    rx_state     <= s01;
                end

                s01:
                begin
                    rx_buffer[1] <= rx;
                    rx_state     <= s02;
                end

                s02:
                begin
                    rx_buffer[2] <= rx;
                    rx_state     <= s03;
                end

                s03:
                begin
                    rx_buffer[3] <= rx;
                    rx_state     <= s04;
                end

                s04:
                begin
                    rx_buffer[4] <= rx;
                    rx_state     <= s05;
                end

                s05:
                begin
                    rx_buffer[5] <= rx;
                    rx_state     <= s06;
                end

                s06:
                begin
                    rx_buffer[6] <= rx;
                    rx_state     <= s07;
                end

                s07:
                begin
                    rx_buffer[7] <= rx;
                    rx_state     <= stop;
                end

                stop:
                begin
                    rx_data  <= rx_buffer;
                    rx_state <= idle;
                end

                default:
                begin
                    rx_state <= idle;
                end
            endcase
				end				
		end				
endmodule
