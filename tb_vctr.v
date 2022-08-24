`timescale 1ns/1ps
module tb_vctr ();
	reg		nrst;
	reg		clock;
	wire	rx;
	wire	[7:0]	rx_data;
	wire	[7:0]	rx_data_out;
	wire	[7:0]	rx_data_in;
	wire	[7:0]	vctr_data_out;
	reg 	[7:0]  tx_d;
    reg        		tx_r;
	
	vctr VECTOR(
	.nrst(nrst),
	.clock(clock),
	.rx(rx),
	.rx_data(rx_data),
	.rx_data_out(rx_data_out),
	.rx_data_in(rx_data_in),
	.vctr_data_out(vctr_data_out)
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
		#1 tx_d = 8'h02;
		#1 tx_r = 1;
		
		#1970252 tx_r = 0;
		#1 tx_d = 8'hAB;
		#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd4;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd5;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd6;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd7;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd8;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd9;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd10;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd11;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd12;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd13;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd14;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd15;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd16;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd17;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd18;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd19;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd20;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd21;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd22;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd23;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd24;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd25;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd26;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd27;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd28;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd29;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd30;
		//#1 tx_r = 1;
		
		//#1970252 tx_r = 0;
		//#1 tx_d = 8'd31;
		//#1 tx_r = 1;
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