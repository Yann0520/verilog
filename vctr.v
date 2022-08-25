module vctr(
	input		nrst,
	input		clock,
	input		rx,
	output	[7:0]	rx_data,
	output	[7:0]	rx_data_out,
	output	[7:0]	rx_data_in,
	output	[7:0]	vctrin
	);
	wire rx_vctr_comp;
	wire vctr_complete;
	wire [7:0]	vctr_data_out;
	wire [7:0]	vctr_data_in;
	
	rx RX(
	.nrst(nrst),
	.clock(clock),
	.rx(rx),
	.rx_data(rx_data),
	.rx_data_out(rx_data_out),
	.rx_data_in(rx_data_in),
	.vctr_out(vctr_out),
	.vctr_in(vctr_in),
//	.vctr_complete(vctr_complete),
	.rx_vctr_comp(rx_vctr_comp),
	.rx_vctr_comp_out(rx_vctr_comp_out),
	.rx_vctr_comp_in(rx_vctr_comp_in)
	);
	
	
	vctrin VECTOR_IN(
	.clock(clock),
	.nrst(nrst),
	.vctr_data_in(vctr_data_in),
	.vctr_comp_in(vctr_comp_in),
	.vctrin(vctrin),
	.vctr_comp_out(vctr_comp_out),
	.vctr_data_out(vctr_data_out)
	);
	
	assign vctr_data_out = rx_data_out;
	assign vctr_data_in = rx_data_in;
	assign rx_vctr_comp_in = vctr_comp_in;
	assign rx_vctr_comp_out = vctr_comp_out;
	
endmodule
	
	
