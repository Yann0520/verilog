module FIFObuffer( 
	input			clock, 
	input	[7:0]	dataIn, 
	input			RD, 
	input			WR, 
	input			EN, 
	output	reg	[7:0]	dataOut, 
	output	reg	[7:0]	dataOut2,
	input			reset,
	output			EMPTY, 
	output			FULL 
	); 

	reg	[4:0]	Count = 0; 
	reg	[7:0]	FIFO [0:31]; 
	reg	[4:0]	readCounter = 0, 
				writeCounter = 0; 
	reg	[12:0]	clock_counter = 0; 
	wire[12:0]	clock_div;
	reg			bit_clock = 0;
			   
	assign	EMPTY = (Count==0)? 1'b1:1'b0; 
	assign	FULL = (Count==32)? 1'b1:1'b0;
	assign 	clock_div = 625;	
	
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
		if(dataOut === 8'hxx)
			dataOut2 <= 8'h00;
		else
			dataOut2 <= dataOut;
			
	always@(posedge clock)
		if(!reset)
			bit_clock <= 0;
		else if (clock_counter == clock_div)
			bit_clock <= ~bit_clock;
		else
			bit_clock <= bit_clock;
			
	
	always @ (posedge bit_clock) 
	begin 
		if (EN==0); 
		else begin 
			if (!reset) begin 
				readCounter = 0; 
				writeCounter = 0; 
			end 
			else if (RD ==1'b1 && Count!=0) begin 
				dataOut  = FIFO[readCounter]; 
				readCounter = readCounter+1; 
			end 
			else if (WR==1'b1 && Count<32) begin
				FIFO[writeCounter]  = dataIn; 
				writeCounter  = writeCounter+1; 
			end 
		else; 
	 end 
	 
	 if (writeCounter==32) 
			writeCounter=0; 
	 else if (readCounter==32) 
		readCounter=0; 
	 else;
		 if (readCounter > writeCounter) begin 
			Count=readCounter-writeCounter;
		 end 
		 else if (writeCounter > readCounter) 
			Count=writeCounter-readCounter; 
		 else;
	end 
endmodule