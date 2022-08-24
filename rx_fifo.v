module FIFObuffer( 
	input			clock,  
	input			rx,
	input			reset,
	output			tx ,
	output			tx2
	); 

	reg	[5:0]	Count = 0; 
	reg	[7:0]	FIFO [0:31]; 
	reg	[4:0]	readCounter = 0; 
	reg	[5:0]	writeCounter = 0; 
	reg	[12:0]	clock_counter = 0; 
	reg			bit_clock = 0;
	reg			WR = 0;
	reg			RD = 0;
	reg	[7:0]	dataOut = 0;
	wire[7:0]	rx_data;
	wire[7:0]	dataIn;
	wire		EMPTY;
	wire		FULL;
	reg [2:0]	bit_counter = 0;
	reg			byte_clock = 0;
	wire[3:0]	comp_count;
	reg	[6:0]	comp_counter = 0;
	reg	[6:0]	comp_counter2 = 0;
	reg	[5:0]	RD_count = 0;
	reg			byte_clock2 = 0;
	reg			byte_clock3 = 0;
	wire[7:0]  tx_data;
	reg	[9:0]	bit_count = 0;
			   
	assign	EMPTY = (Count==0)? 1'b1:1'b0; 
	assign	FULL = (Count==32)? 1'b1:1'b0;	
	assign	dataIn = rx_data;
	assign	tx_data = dataOut;
	
	localparam 	clock_div = 625;
	
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
			
	always@(posedge bit_clock)
		if(!reset)
			bit_counter <= 0;
		else
			bit_counter <= bit_counter + 1;
			
	always@(posedge bit_clock)
		if(!reset)
			bit_count <= 0;
		else if(dataIn != 8'h00)
			bit_count <= 0;
		else
			if(bit_count != 959)
				bit_count <= bit_count + 1;
			else
				bit_count <= bit_count;
			
	always@(posedge bit_clock)
		if(!reset)
			byte_clock<= 0;
		else if(bit_counter == 7)
			byte_clock <= ~byte_clock;
		else
			byte_clock <= byte_clock;
		
	always @ (posedge bit_clock) 
	begin 
		if (!reset) begin 
			writeCounter <= 0; 
		end 
		else if (WR==1'b1 && Count<32) begin
			FIFO[writeCounter]  <= dataIn; 
				if(comp_count == 4)
					writeCounter <= writeCounter + 1;
				else
					writeCounter <= writeCounter;
			end 
		else if(bit_count == 959 && RD_count == writeCounter + 1)
			writeCounter <= 0;
		else
			writeCounter <= writeCounter;

		if(!reset)
			Count <= 0;
		else if (readCounter > writeCounter) begin 
			Count<=readCounter-writeCounter;
			end 
		else if (writeCounter > readCounter) 
			Count<=writeCounter-readCounter; 
		else if (writeCounter == readCounter) 
			Count <= 0;
		else
			Count <= Count;
	end 
	always@(posedge byte_clock3)
		if(!reset)
			readCounter <= 0;
		else if (RD ==1'b1 && Count!=0) begin 
			readCounter <= readCounter+1;
			dataOut <= FIFO[readCounter];
			end
		else if(RD == 0) begin
			dataOut <= 8'h00;
			readCounter <= 0;
			end
		else
			readCounter <= 0;
		
	always @(posedge bit_clock)
		if(!reset)
			comp_counter <= 0;
		else if(comp_count == 4)
			comp_counter <= comp_counter + 1;
		else if(comp_counter == 32 && RD_count == 31)
			comp_counter <= 0;
		else
			comp_counter <= comp_counter;
	
	always@(posedge byte_clock3)
		if(!reset)
			RD_count <= 0;
		else if(!WR)
			if(writeCounter != 0)
				RD_count <= RD_count + 1;
			else
				RD_count <= 0;
		else
			RD_count <= 0;
	
	always @(posedge bit_clock)
		if(!reset) begin
			RD <= 0;
			WR <= 0;
			end
		else if(bit_count == 959 && writeCounter != RD_count)
			begin
				RD <= 1;
				WR <= 0;
			end
		else if(bit_count != 959)
			WR <= 1;
		else if(RD_count == writeCounter) 
			begin
				RD <= 0;
			end
		else
			begin
				RD <= RD;
				WR <= ~RD;
			end
	always @(posedge bit_clock)
		if(!reset)
			comp_counter2 <= 0;
		else if(comp_counter <= 32)
			comp_counter2 <= comp_counter;
		else
			comp_counter2 <= comp_counter2;
			
			
	always @(posedge byte_clock)
		if(!reset)
			byte_clock2 <= 0;
		else
		byte_clock2 <= ~byte_clock2;
		
	always @(posedge byte_clock2)
		if(!reset)
			byte_clock3 <= 0;
		else
			byte_clock3 <= ~byte_clock3;
	
	tx TX(clock, reset,tx,tx_data,tx2);	
	rx RX(reset,clock,rx,rx_data,comp_count);
endmodule
module tx(
	input	clock,
	input	reset,
	output	reg	tx = 1,
	input	[7:0]	tx_data,
	output  tx2
	);
	
	reg		[1:0]	tx_state = 0;
	reg		[12:0]	clock_counter = 0;
	reg		bit_clock = 0;
	reg		[2:0] i = 0;
	reg 	tx_complete = 1;
	reg [2:0]	bit_counter = 0;
	reg			byte_clock = 0;
	reg			byte_clock2 = 0;
	reg			byte_clock3 = 0;
	reg	[5:0]	tx_count	= -1;
	
	
	localparam clock_div = 625;
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
		if(!reset) begin
			bit_counter <= 0;
		end
		else
			bit_counter <= bit_counter + 1;
			
	always@(posedge bit_clock)
		if(!reset)
			byte_clock <= 0;
		else if(bit_counter == 7)
			byte_clock <= ~byte_clock;
		else
			byte_clock <= byte_clock;
			
	always@(posedge byte_clock)
		if(!reset)
			byte_clock2 <= 0;
		else
			byte_clock2 <= ~byte_clock2;
		
	always @(posedge byte_clock2)
		if(!reset)
			byte_clock3 <= 0;
		else
			byte_clock3 <= ~byte_clock3;
		
	always@(posedge bit_clock)
		if(!reset)
			tx_count <= -1;
		else if(byte_clock3)
			tx_count <= tx_count + 1;
		else
			tx_count <= -1;
			
	always@(posedge bit_clock)
		if(!reset)
			tx_complete <= 1;
		else if(tx_data != 8'h00 && tx_count <11)
			tx_complete <= 0;
		else if(tx_state == stop)
			tx_complete <= 1;
		else
			tx_complete <= tx_complete;


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
module rx (
	input		reset,
	input		clock,
	input		rx,
	output	reg	[7:0]	rx_data,
	output	reg	[3:0]	comp_count = -1
	);
	
	reg [1:0] 	rx_state = 0;
	reg	[12:0]	clock_counter = 0;
	reg			bit_clock = 0;
	reg [4:0]	i = 0;
	reg	[7:0]	rx_data2 = 0;
	reg	[10:0]	clocker = 0;
	reg	[7:0]	rx_data3 = 0;
	reg			rx_complete = 1;
	
	parameter	idle	=	0;
	parameter	start	=	1;
	parameter	data	=	2;
	parameter	stop	=	3;
	
	localparam clock_div = 625;
	
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
		if(!reset)
			rx_complete <= 1;
		else if(clocker < 10)
			rx_complete <= 0;
		else
			rx_complete <= 1;
			
	
	always@(posedge bit_clock)
		if(!reset)
			clocker <= -1;
		else if(rx_state == idle || rx_state == start)
			if(clocker != 20)
				clocker <= clocker + 1;
			else
				clocker <= clocker;
		else 
			clocker <= -1;
	
	always@(posedge clock)
		if(!reset)
			rx_data <= 8'h00;
		else if(rx_complete)
			rx_data <= 8'h00;
		else
			rx_data <= rx_data3;
			
	always@(posedge bit_clock)
		if(!reset)
			comp_count <= 0;
		else if(rx_data == 8'h00 || 8'hxx)
			comp_count <= -1;
		else 
			comp_count <= comp_count + 1;
			
		
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
