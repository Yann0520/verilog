module rx (
	input		reset,
	input		clock,
	input		rx,
	output	reg	[7:0]	rx_data
	);
	
	reg [1:0] 	rx_state = 0;
	reg	[12:0]	clock_counter = 0; 
	wire[12:0]	clock_div;
	reg			bit_clock = 0;
	reg [4:0]	i = 0;
	reg			rx_complete = 1;
	reg	[7:0]	rx_data2 = 0;
	reg	[10:0]	clocker = 0;
	assign 		clock_div = 625;
	reg	[7:0]	rx_data3 = 0;
	
	parameter	idle	=	0;
	parameter	start	=	1;
	parameter	data	=	2;
	parameter	stop	=	3;
	
	always@(posedge clock)
		if(!reset) begin
			clock_counter <= 0;
			end
		else if (clock_counter == clock_div) begin
			clock_counter <= 0;
			end
		else begin
			clock_counter <= clock_counter + 1;
			end
			
	always@(posedge clock)
		if(!reset)
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
		if(rx_state == idle || rx_state == start)
			if(clocker != 20)
				clocker <= clocker + 1;
			else
				clocker <= clocker;
		else 
			clocker <= -1;
	
	always@(posedge bit_clock)
		if(rx_complete)
			rx_data <= 8'h00;
		else
			rx_data <= rx_data3;
			
	always@(posedge bit_clock)
		begin
			if(!reset)
				begin
					rx_state <= idle;
				end
			else
				begin
					case(rx_state)
						idle:
						begin
							rx_state <= start;
						end
						
						start:
						begin
							if(rx == 0)
								rx_state <= data;
							else
								rx_state <= start;
						end
						
						data:
						begin
							rx_data2[i] <= rx;
							if(i<7)
								begin
									i <= i + 1;
									rx_state <= data;
									
								end
							else
								begin
									i <= 0;
									rx_state <= stop;
									
									
								end
						end
						stop:
							begin
								rx_data3 <= rx_data2;
								rx_state <= idle;
							end
					endcase
				end				
		end				
endmodule