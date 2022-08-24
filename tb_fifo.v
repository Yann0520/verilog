`timescale 1ns / 1ps
module FIFObuffer_tb;
	reg		clock;
	reg 	[7:0] dataIn;
	reg 	RD;
	reg 	WR;
	reg 	EN;
	reg 	reset;
	wire 	[7:0] dataOut;
	wire 	[7:0] dataOut2;
	wire 	EMPTY;
	wire 	FULL;
	
	FIFObuffer uut (
		.clock(clock), 
		.dataIn(dataIn), 
		.RD(RD), 
		.WR(WR), 
		.EN(EN), 
		.dataOut(dataOut), 
		.dataOut2(dataOut2), 
		.reset(reset), 
		.EMPTY(EMPTY), 
		.FULL(FULL)
	);
	
	initial begin
		clock  = 1'b0;
		dataIn  = 8'h0;
		RD  = 1'b0;
		WR  = 1'b0;
		EN  = 1'b0;
		reset  = 1'b0;

		#100;        
		EN  = 1'b1;
		reset  = 1'b0;

		#104416;
		reset  = 1'b1;
		WR  = 1'b1;
		dataIn  = 8'h0;

		#104416;
		dataIn  = 8'h1;

		#104416;
		dataIn  = 8'h2;

		#104416;
		dataIn  = 8'h3;
		
		#104416;
		dataIn  = 8'h4;
		
		#104416;
		dataIn  = 8'h5;

		#104416;
		dataIn  = 8'h6;

		#104416;
		dataIn  = 8'h7;
		
		#104416;
		dataIn  = 8'h8;
		
		#104416;
		dataIn  = 8'h9;

		#104416;
		dataIn  = 8'h10;

		#104416;
		dataIn  = 8'h11;
		
		#104416;
		dataIn  = 8'h12;
		
		#104416;
		dataIn  = 8'h13;

		#104416;
		dataIn  = 8'h14;

		#104416;
		dataIn  = 8'h15;
		
		#104416;
		dataIn  = 8'h16;

		#104416;
		dataIn  = 8'h17;

		#104416;
		dataIn  = 8'h18;

		#104416;
		dataIn  = 8'h19;
		
		#104416;
		dataIn  = 8'h20;
		
		#104416;
		dataIn  = 8'h21;

		#104416;
		dataIn  = 8'h22;

		#104416;
		dataIn  = 8'h23;
		
		#104416;
		dataIn  = 8'h24;
		
		#104416;
		dataIn  = 8'h25;

		#104416;
		dataIn  = 8'h26;

		#104416;
		dataIn  = 8'h27;
		
		#104416;
		dataIn  = 8'h28;
		
		#104416;
		dataIn  = 8'h29;

		#104416;
		dataIn  = 8'h30;

		#104416;
		dataIn  = 8'h31;

		#104416;
		WR = 1'b0;
		RD = 1'b1;  

	end 

	always 
		#41.65 clock = ~clock;    

endmodule
