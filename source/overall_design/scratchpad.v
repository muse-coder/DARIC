`include "../param_define.v"


module scratchpad (
	input	clk,
	input	rst,
	input	[`SPM_INST-1:0]	inst,
    input   init,
    input   run,
	input	[`EX_in_bus-1  :0]	ex_in_bus,
	input	[`L_C_bus-1    :0]	switch_in_3,
	input	[`L_C_bus-1    :0]	switch_in_2,
	input	[`L_C_bus-1    :0]	switch_in_1,
	input	[`L_C_bus-1    :0]	switch_in_0,
	
	output	[`C_L_bus-1    :0]	switch_out_3,
	output	[`C_L_bus-1    :0]	switch_out_2,
	output	[`C_L_bus-1    :0]	switch_out_1,
	output	[`C_L_bus-1    :0]	switch_out_0,
    output  [`EX_out_bus-1 :0]  ex_out_bus
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
		ex_wen,		//41:41
		ex_ren,		//40:40
		ex_addr,	//39:32
		ex_data		//31:0
    }	=	ex_in_bus;

    assign ex_out_bus ={
        switch_out_3[31:0],
        switch_out_2[31:0],
        switch_out_1[31:0],
        switch_out_0[31:0]
    };
	assign	{
		sin_0_wen,		//41:41
		sin_0_data,	    //40:9
        sin_0_ren,		//8:8
		sin_0_addr	    //7:0
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
    reg     [`SPM_INST-1:0]    config_buffer [`buffer_depth-1:0]  ;
    reg     [31:0]  init_count;
    reg     [31:0]  run_count;
    integer i = 0;
    reg     [`SPM_INST-1:0]     inst_r;
//-------------初始化-------------------//
    always @(posedge clk ) begin
        if(rst) begin
            init_count  <=  'b0;
            run_count   <=  'b0;
            for (i = 0; i <`buffer_depth ; i = i + 1) begin
                config_buffer[i] <='b0;
            end
            inst_r <= 'b0;
        end

        else if(init) begin
            config_buffer[init_count] <= inst;
            init_count <= init_count +1'b1;
        end

        else if(run) begin
            run_count <= run_count +1'b1;
            inst_r  <= config_buffer[run_count];
        end
    end
//------------------运行时---------------//

//-----------------end-----------------//


	wire    [31:0] BG0_feed_data,BG1_feed_data,BG2_feed_data,BG3_feed_data;
    wire    [1:0] BG0_fifo_sel,BG1_fifo_sel,BG2_fifo_sel,BG3_fifo_sel;
	wire    flush_0,flush_1,flush_2,flush_3;
    assign {
        flush_3,        //  23:23
        flush_2,        //  22:22
        flush_1,        //  21:21
        flush_0,        //  20:20
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
	} = inst_r;

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
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG0_en 		),		
    	.din_i		    (BG0_feed_data	),
    	.pattern_i	    (BG0_mode		),
    	.addr_i		    (BG0_addr		),
    	.we_i			(BG0_wen		),
    	.re_i			(BG0_ren		),
		.fifo_sel_i	    (BG0_fifo_sel	),
    	.flush_i		(flush_0        ),
    	.dout_bus		(switch_out_0   )
	);

	bankgroup	BG1(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG1_en 		),		
    	.din_i		    (BG1_feed_data	),
    	.pattern_i	    (BG1_mode		),
    	.addr_i		    (BG1_addr       ),
    	.we_i			(BG1_wen        ),
    	.re_i			(BG1_ren        ),
    	.fifo_sel_i	    (BG1_fifo_sel	),
    	.flush_i		(flush_1        ),
    	.dout_bus		(switch_out_1	)
	);

	bankgroup	BG2(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG2_en 		),		
    	.din_i		    (BG2_feed_data	),
    	.pattern_i	    (BG2_mode		),
    	.addr_i		    (BG2_addr       ),
    	.we_i			(BG2_wen        ),
    	.re_i			(BG2_ren        ),
    	.fifo_sel_i	    (BG2_fifo_sel	),
    	.flush_i		(flush_2        ),
    	.dout_bus		(switch_out_2	)
	);

	bankgroup	BG3(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG3_en 		),		
    	.din_i		    (BG3_feed_data	),
    	.pattern_i	    (BG3_mode		),
    	.addr_i		    (BG3_addr       ),
    	.we_i			(BG3_wen        ),
    	.re_i			(BG3_ren        ),
    	.fifo_sel_i	    (BG3_fifo_sel	),
    	.flush_i		(flush_3        ),
    	.dout_bus		(switch_out_3	)
	);

endmodule