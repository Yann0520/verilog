`timescale 1ns/1ps
module tx_tb();
	reg		clock;
	reg		reset;
	reg		[7:0]	tx_data;
	wire	tx;
	
	tx TX(
	.clock(clock),
	.reset(reset),
	.tx_data(tx_data),
	.tx2(),
	.tx(tx)
	);
	
initial begin
	clock = 0;
	reset = 0;
	tx_data = 0;
	end

always
#5 clock = ~clock;
initial begin
	#500100 reset = 1;
	#500100 tx_data = 8'haa;
	#500100 tx_data = 8'hbb;
	#500100 tx_data = 8'hcc;
	#500100 tx_data = 8'hdd;
	#500100 tx_data = 8'h00;
end

endmodule
