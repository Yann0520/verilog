`timescale 1ns/1ps
module tb_rx_fifo();
	reg		reset;
	reg		clock;
	wire	rx;
	reg 	[7:0]  tx_d;
    reg		tx_r;
	wire	tx;
	wire	tx2;
	
	FIFObuffer rx_fifo(
	.reset(reset),
	.clock(clock),
	.rx(rx),
	.tx(tx),
	.tx2(tx2)
	);
	
	initial begin
		clock		= 0;
        reset		= 0;
        tx_d		= 0;
        tx_r		= 0;
	end
	
	always
		#41.65 clock <= ~clock;
		
	initial begin
		#10 reset	= 1;
		
		#985126 tx_r = 0;
		#1 tx_d = 8'd1;
		#1 tx_r = 1;
		
		#10500000 tx_r = 0;
		#1 tx_d = 8'd2;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd3;
		#1 tx_r = 1;
		
		#10407840 tx_r = 0;
		#1 tx_d = 8'd4;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd5;
		#1 tx_r = 1;
		
		#10500000 tx_r = 0;
		#1 tx_d = 8'd6;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd7;
		#1 tx_r = 1;
		
		#20407840 tx_r = 0;
		#1 tx_d = 8'd8;
		#1 tx_r = 1;
		
		#20407840 tx_r = 0;
		#1 tx_d = 8'd9;
		#1 tx_r = 1;
		
		#20407840 tx_r = 0;
		#1 tx_d = 8'd10;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd11;
		#1 tx_r = 1;
		
		#10407840 tx_r = 0;
		#1 tx_d = 8'd12;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd13;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd14;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd15;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd16;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd17;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd18;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd19;
		#1 tx_r = 1;
		
		#10407840 tx_r = 0;
		#1 tx_d = 8'd20;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd21;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd22;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd23;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd24;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd25;
		#1 tx_r = 1;
		
		#409170746 tx_r = 0;
		#1 tx_d = 8'd26;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd27;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd28;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd29;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd30;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd31;
		#1 tx_r = 1;
		
		#9851260 tx_r = 0;
		#1 tx_d = 8'd32;
		#1 tx_r = 1;

		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd33;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd34;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd35;
		//#1 tx_r = 1;
		
		//#10407840 tx_r = 0;
		//#1 tx_d = 8'd36;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd37;
		//#1 tx_r = 1;
		
		//#10500000 tx_r = 0;
		//#1 tx_d = 8'd38;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd39;
		//#1 tx_r = 1;
		
		//#20407840 tx_r = 0;
		//#1 tx_d = 8'd40;
		//#1 tx_r = 1;
		
		//#20407840 tx_r = 0;
		//#1 tx_d = 8'd41;
		//#1 tx_r = 1;
		
		//#20407840 tx_r = 0;
		//#1 tx_d = 8'd42;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd43;
		//#1 tx_r = 1;
		
		//#10407840 tx_r = 0;
		//#1 tx_d = 8'd44;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd45;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd46;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd47;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd48;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd49;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd50;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd51;
		//#1 tx_r = 1;
		
		//#10407840 tx_r = 0;
		//#1 tx_d = 8'd52;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd53;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd54;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd55;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd56;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd57;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd58;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd59;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd60;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd61;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd62;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd63;
		//#1 tx_r = 1;
		
		//#9851260 tx_r = 0;
		//#1 tx_d = 8'd64;
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