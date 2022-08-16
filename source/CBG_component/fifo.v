`include "../param_define.v"
module fifo (
	input	en,
	input	RE,
	input	WE,
	input   clk,
	input	rst,
	input	flush,
//----------single port ram_0 signal----------//
 	output 	ENABLE_0,
	output	WE_0,
	output	[`A_W -2:0] A_0,
//----------single port ram_1 signal----------//
 	output 	ENABLE_1,
	output	WE_1,
	output	[`A_W -2:0] A_1
);

	wire	we_n;
	wire	re_n;
	wire	[`A_W -1:0]  r_adr;
	wire	[`A_W -1:0]  w_adr;	

    address_update lut1(
	    .clk        (clk        ),
	    .rst        (rst        ),
		.en         (en		    ),
		.we         (we         ),
		.re         (re         ),
		.flush      (flush      ),
        .we_n       (we_n	    ),
        .re_n       (re_n	    ),
	    .rd_addr    (r_adr),
	    .wr_addr    (w_adr)
    );

	part_sel lut2    (
		.WE_N		(we_n	),
		.RE_N		(re_n	),
		.R_ADR		(r_adr	),
		.W_ADR		(w_adr	),
//----------single port ram_0 signal----------//
 		.ENABLE_0	(ENABLE_0),
		.WE_0		(WE_0),
		.A_0		(A_0),
//----------single port ram_0 signal----------//
 		.ENABLE_1	(ENABLE_1),
		.WE_1		(WE_1),
		.A_1		(A_1)
	);


endmodule

