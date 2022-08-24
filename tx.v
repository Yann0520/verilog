module tx(
	input	clock,
	input	reset,
	output	reg	tx = 1,
	input	[7:0]	tx_data,
	output  tx2
	);
	
	reg		[1:0]	tx_state = 0;
	reg		[12:0]	clock_counter = 0;
	wire	[12:0]	clock_div;
	reg		bit_clock = 0;
	reg		[2:0] i = 0;
	reg 	tx_complete = 1;
	//reg	[7:0]	tx_data;
	reg	[30:0] clocker = -1;
	//integer	j;
	
	
	assign clock_div = 625;
	assign tx2 = tx;
	
	parameter	idle	=	0;
	parameter	start	=	1;
	parameter	data	=	2;
	parameter	stop	=	3;
	
	always@(posedge clock)
		if(!reset) begin
			clock_counter <= 0;
			end
		else if (clock_counter == clock_div)
			clock_counter <= 0;
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
	
	always@(posedge bit_clock)
		if(clocker < 11)
			tx_complete <=0;
		else if(tx_state == stop)
			tx_complete <= 1;
		else
			tx_complete <= 1;
			
		
	always@(posedge bit_clock)
		if(!reset)
			clocker <= -1;
		else if(tx_data == 8'h00)
			clocker <= -1;
		else
			if(clocker != 20)
				clocker <= clocker + 1;
			else
				clocker <= clocker;
			

	always@(posedge bit_clock)
		begin
			if(!reset)
				begin
					tx_state	<= idle;
					tx			<= 1;
				end
			else
				begin
					case(tx_state)
						idle:
						begin
							tx <= 1;
							if(tx_complete)
								tx_state <= idle;
							else 
								tx_state <= start;
						end
						
						
						start:
						begin
							tx <= 0;
							tx_state <= data;
						end
						
						
						data:
						begin
							tx <= tx_data[i];
							if(i < 7)
								begin
									i <= i + 1;
									tx_state <= data;
								end
							else
								begin
								i <= 0;
								tx_state <= stop;
								end
						end
						stop:
						begin
							tx <= 1;
							tx_state <= idle;
						end
					endcase
				end
		end
endmodule