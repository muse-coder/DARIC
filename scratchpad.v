module scratchpad (
	input	clk,
	input	rst,
	input	[11:0]host_controller,
	input	[31:0]external_memory,
	input	[31:0]switch_in_3,
	input	[31:0]switch_in_2,
	input	[31:0]switch_in_1,
	input	[31:0]switch_in_0,
	
	output	[31:0]switch_out_3,
	output	[31:0]switch_out_2,
	output	[31:0]switch_out_1,
	output	[31:0]switch_out_0
);
	wire BG0_sel,BG1_sel,BG2_sel,BG3_sel;
	wire BG0_mode,BG1_mode,BG2_mode,BG3_mode;
	wire BG0_en,BG1_en,BG2_en,BG3_en;
	
	wire [31:0] BG0_feed_data,BG1_feed_data,BG2_feed_data,BG3_feed_data;
	assign {
		BG3_en,//	11:11
		BG2_en,// 	10:10
		BG1_en,//  9:9
		BG0_en,//  8:8

		BG3_sel,//	7:7
		BG2_sel,// 	6:6
		BG1_sel,//  5:5
		BG0_sel,//  4:4
		
		BG3_mode,// 3:3
		BG2_mode,//	2:2
		BG1_mode,//	1:1
		BG0_mode//	0:0
	} = host_controller;

	assign BG3_feed_data = BG3_sel ? switch_in_3 :external_memory ;
	assign BG2_feed_data = BG2_sel ? switch_in_2 :external_memory ;
	assign BG1_feed_data = BG1_sel ? switch_in_1 :external_memory ;
	assign BG0_feed_data = BG0_sel ? switch_in_0 :external_memory ;
	
	bankgroup	BG0(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG0_en 		),		
    	.din		(BG0_feed_data	),
    	.pattern	(BG0_mode		),
    	.addr		(),
    	.we			(),
    	.re			(),
    	.flush		(),
    	.dout		(switch_out_0)
	);

	bankgroup	BG1(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG1_en 		),		
    	.din		(BG1_feed_data	),
    	.pattern	(BG1_mode		),
    	.addr		(),
    	.we			(),
    	.re			(),
    	.flush		(),
    	.dout		(switch_out_1	)
	);

	bankgroup	BG2(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG2_en 		),		
    	.din		(BG2_feed_data	),
    	.pattern	(BG2_mode		),
    	.addr		(),
    	.we			(),
    	.re			(),
    	.flush		(),
    	.dout		(switch_out_2	)
	);

	bankgroup	BG3(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG3_en 		),		
    	.din		(BG3_feed_data	),
    	.pattern	(BG3_mode		),
    	.addr		(),
    	.we			(),
    	.re			(),
    	.flush		(),
    	.dout		(switch_out_3	)
	);

endmodule