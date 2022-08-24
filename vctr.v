module vctr(
	input		nrst,
	input		clock,
	input		rx,
	output	[7:0]	rx_data,
	output	[7:0]	rx_data_out,
	output	[7:0]	rx_data_in,
	output	[7:0]	vctr_data_out
	);
	
	rx RX(
	.nrst(nrst),
	.clock(clock),
	.rx(rx),
	.rx_data(rx_data),
	.rx_data_out(rx_data_out),
	.rx_data_in(rx_data_in)
	);
	
	vctrout VECTOR_OUT(
	.clock(clock),
	.nrst(nrst),
	.vctr_data_out(vctr_data_out)
	);
	
	assign vctr_data_out = rx_data_out;
endmodule
	
	