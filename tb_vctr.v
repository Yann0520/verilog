`timescale 1ns/1ps
module tb_vctr ();
	reg		nrst;
	reg		clock;
	wire	rx;
	wire	[7:0]	rx_data;
	wire	[7:0]	rx_data_out;
	wire	[7:0]	rx_data_in;
	reg 	[7:0]  tx_d;
    reg        		tx_r;
	wire	[7:0]	vctrin;
	
	vctr VECTOR(
	.nrst(nrst),
	.clock(clock),
	.rx(rx),
	.rx_data(rx_data),
	.rx_data_out(rx_data_out),
	.rx_data_in(rx_data_in),
	.vctrin(vctrin)
	);
	
	
initial begin
		clock		= 0;
        nrst		= 0;
        tx_d		= 0;
        tx_r		= 0;
	end
	
	always
		#41.65 clock <= ~clock;
		
	initial begin
		#10 nrst = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hA5;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h01;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hAA;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h00;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h01;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hA5;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h02;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hCC;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hA5;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h01;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hdd;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hA5;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h00;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hee;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hA5;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'h02;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hff;
		#1 tx_r = 1;
		
		
	end
	
	uart_encoder encoder(clock, tx_d, tx_r, rx);

endmodule

module uart_encoder(
    input       clock,
    input [7:0] tx_d,
    input       tx_r,
    output reg  rx = 1);

    parameter uart_wait = 105000;
    always @(posedge tx_r)
        uart_encoder;

    task uart_encoder;
        begin
					   rx = 0;
            #uart_wait rx = tx_d[0];
            #uart_wait rx = tx_d[1];
            #uart_wait rx = tx_d[2];
            #uart_wait rx = tx_d[3];
            #uart_wait rx = tx_d[4];
            #uart_wait rx = tx_d[5];
            #uart_wait rx = tx_d[6];
            #uart_wait rx = tx_d[7];
            #uart_wait rx = 1;
        end
    endtask
endmodule
