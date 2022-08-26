`include "../param_define.v"


module scratchpad (
	input	clk,
	input	rst,
	input	[`SPM_INST-1:0]	inst,
    input   init,
    input   run,
	input	[`EX_bus-1 :0]	ex_bus,
	input	[`L_C_bus-1:0]	switch_in_3,
	input	[`L_C_bus-1:0]	switch_in_2,
	input	[`L_C_bus-1:0]	switch_in_1,
	input	[`L_C_bus-1:0]	switch_in_0,
	
	output	[`C_L_bus-1:0]	switch_out_3,
	output	[`C_L_bus-1:0]	switch_out_2,
	output	[`C_L_bus-1:0]	switch_out_1,
	output	[`C_L_bus-1:0]	switch_out_0
);
	wire 	BG0_sel,BG1_sel,BG2_sel,BG3_sel;
	wire 	BG0_mode,BG1_mode,BG2_mode,BG3_mode;
	wire 	BG0_wen,BG1_wen,BG2_wen,BG3_wen;
	wire 	BG0_ren,BG1_ren,BG2_ren,BG3_ren;
	wire 	BG0_en,BG1_en,BG2_en,BG3_en;
	wire	[`A_W-1:0]	BG0_addr,BG1_addr,BG2_addr,BG3_addr;
	
	wire	[31:0]		ex_data;
	wire	[`A_W-1:0]	ex_addr;
	wire	ex_wen,ex_ren;

	wire	[`A_W-1:0]	sin_0_addr,sin_1_addr,sin_2_addr,sin_3_addr;
	wire	[31:0]	sin_0_data,sin_1_data,sin_2_data,sin_3_data;
	wire	sin_0_wen,sin_1_wen,sin_2_wen,sin_3_wen;
	wire	sin_0_ren,sin_1_ren,sin_2_ren,sin_3_ren;
	wire	[1:0]	BG_0_fifo_sel,BG_1_fifo_sel,BG_2_fifo_sel,BG_3_fifo_sel;
	assign	{
		ex_wen,		//43:43
		ex_ren,		//42:42
		ex_addr,	//41:32
		ex_data		//31:0
	}	=	ex_bus;

	assign	{
		sin_0_wen,		//43:43
		sin_0_data,	
        sin_0_ren,		//42:42
		sin_0_addr	//31:0
	}	=	switch_in_0;

	assign	{
		sin_1_wen,		//43:43
		sin_1_data,	
        sin_1_ren,		//42:42
		sin_1_addr
	}	=	switch_in_1;

	assign	{
		sin_2_wen,		//43:43
		sin_2_data,	
        sin_2_ren,		//42:42
		sin_2_addr
	}	=	switch_in_2;

	assign	{
		sin_3_wen,		//43:43
		sin_3_data,	
        sin_3_ren,		//42:42
		sin_3_addr
	}	=	switch_in_3;

//------------configuration buffer-------------//
    reg     [`SPM_INST-1:0]    config_buffer [31:0]  ;
    reg     [31:0]  init_count;
    reg     [31:0]  run_count;
    integer i = 0;
//-------------初始化-------------------//
    always @(posedge clk ) begin
        if(rst) begin
            init_count  <=  'b0;
            for (i = 0; i <32 ; i = i + 1) begin
                config_buffer[i] <='b0;
            end
        end
        else if(init) begin
            config_buffer[init_count] <= inst;
            init_count <= init_count +1'b1;
        end
    end
//------------------运行时---------------//
    always @(posedge clk ) begin
        if(rst) begin
            run_count   <=  'b0;
        end
        else if(run) begin
            run_count <= run_count +1'b1;
        end
    end
//-----------------end-----------------//


	wire    [31:0] BG0_feed_data,BG1_feed_data,BG2_feed_data,BG3_feed_data;
    wire    [1:0] BG0_fifo_sel,BG1_fifo_sel,BG2_fifo_sel,BG3_fifo_sel;
	assign {
        BG3_fifo_sel,   //  19:18
		BG2_fifo_sel,   //  17:16
		BG1_fifo_sel,   //  15:14
        BG0_fifo_sel,   //  13:12
		BG3_en,         //	11:11
		BG2_en,         // 	10:10
		BG1_en,         //  9:9
		BG0_en,         //  8:8

		BG3_sel,//	7:7
		BG2_sel,// 	6:6
		BG1_sel,//  5:5
		BG0_sel,//  4:4
		
		BG3_mode,// 3:3
		BG2_mode,//	2:2
		BG1_mode,//	1:1
		BG0_mode//	0:0
	} = inst;

    


	assign	BG3_feed_data = BG3_sel ? sin_3_data :	ex_data ;
	assign	BG2_feed_data = BG2_sel ? sin_2_data :	ex_data ;
	assign	BG1_feed_data = BG1_sel ? sin_1_data :	ex_data ;
	assign	BG0_feed_data = BG0_sel ? sin_0_data :	ex_data ;
	
	assign	BG3_addr  =  BG3_sel ?  sin_3_addr	:	ex_addr	;	
	assign	BG2_addr  =  BG2_sel ?  sin_2_addr	:	ex_addr	;
	assign	BG1_addr  =  BG1_sel ?  sin_1_addr	:	ex_addr	;	
	assign	BG0_addr  =  BG0_sel ?  sin_0_addr	:	ex_addr	;

	assign	BG3_wen	  =  BG3_sel ?	sin_3_wen	:	ex_wen	;
	assign	BG2_wen	  =  BG2_sel ?	sin_2_wen	:	ex_wen	;
	assign	BG1_wen	  =  BG1_sel ?	sin_1_wen	:	ex_wen	;
	assign	BG0_wen	  =  BG0_sel ?	sin_0_wen	:	ex_wen	;

	assign	BG3_ren	  =  BG3_sel ?	sin_3_ren	:	ex_ren	;
	assign	BG2_ren	  =  BG2_sel ?	sin_2_ren	:	ex_ren	;
	assign	BG1_ren	  =  BG1_sel ?	sin_1_ren	:	ex_ren	;
	assign	BG0_ren	  =  BG0_sel ?	sin_0_ren	:	ex_ren	;



	bankgroup	BG0(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG0_en 		),		
    	.din		(BG0_feed_data	),
    	.pattern	(BG0_mode		),
    	.addr		(BG0_addr		),
    	.we			(BG0_wen		),
    	.re			(BG0_ren		),
		.fifo_sel	(BG0_fifo_sel	),
    	.flush		(	1'b0			),
    	.dout_bus		(switch_out_0)
	);

	bankgroup	BG1(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG1_en 		),		
    	.din		(BG1_feed_data	),
    	.pattern	(BG1_mode		),
    	.addr		(BG1_addr),
    	.we			(BG1_wen),
    	.re			(BG1_ren),
    	.fifo_sel	(BG1_fifo_sel	),
    	.flush		(1'b0),
    	.dout_bus		(switch_out_1	)
	);

	bankgroup	BG2(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG2_en 		),		
    	.din		(BG2_feed_data	),
    	.pattern	(BG2_mode		),
    	.addr		(BG2_addr       ),
    	.we			(BG2_wen        ),
    	.re			(BG2_ren        ),
    	.fifo_sel	(BG2_fifo_sel	),
    	.flush		(1'b0),
    	.dout_bus		(switch_out_2	)
	);

	bankgroup	BG3(
    	.clk		(clk			),
    	.rst		(rst			),
    	.en			(BG3_en 		),		
    	.din		(BG3_feed_data	),
    	.pattern	(BG3_mode		),
    	.addr		(BG3_addr),
    	.we			(BG3_wen),
    	.re			(BG3_ren),
    	.fifo_sel	(BG3_fifo_sel	),
    	.flush		(1'b0),
    	.dout_bus		(switch_out_3	)
	);

endmodule