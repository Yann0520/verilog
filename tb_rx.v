`timescale 1ns/1ps
module tb_rx();
	reg        clock;
    reg        reset;
    wire       rx;
    wire [7:0] rx_data;
    reg [7:0]  tx_data;
    reg        tx_ready;
	
	rx RX(
	.clock(clock),
	.reset(reset),
	.rx(rx),
	.rx_data(rx_data)
	);
	
	initial begin
		clock		= 0;
        reset		= 0;
        tx_data		= 0;
        tx_ready	= 0;
	end
	
	always
		#41.65 clock <= ~clock;
		
	initial begin
		#10 reset = 1;
		
		#985126 tx_ready = 0;
		#1 tx_data = 8'h0d;
		#1 tx_ready = 1;
		
		#10500000 tx_ready = 0;
		#1 tx_data = 8'haa;
		#1 tx_ready = 1;
		
		#9851260 tx_ready = 0;
		#1 tx_data = 8'h0d;
		#1 tx_ready = 1;
		
		#10407840 tx_ready = 0;
		#1 tx_data = 8'hbb;
		#1 tx_ready = 1;
	end
	
	uart_encoder encoder(clock, tx_data, tx_ready, rx);

endmodule

module uart_encoder(
    input       clock,
    input [7:0] tx_data,
    input       tx_ready,
    output reg  rx = 1);

    parameter uart_wait = 105000;
    always @(posedge tx_ready)
        uart_encoder;

    task uart_encoder;
        begin
					   rx = 0;
            #uart_wait rx = tx_data[0];
            #uart_wait rx = tx_data[1];
            #uart_wait rx = tx_data[2];
            #uart_wait rx = tx_data[3];
            #uart_wait rx = tx_data[4];
            #uart_wait rx = tx_data[5];
            #uart_wait rx = tx_data[6];
            #uart_wait rx = tx_data[7];
            #uart_wait rx = 1;
        end
    endtask
endmodule
		
		
		
