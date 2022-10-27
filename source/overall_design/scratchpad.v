`include "../param_define.v"


module scratchpad (
	input	clk,
	input	rst,
	input	[`SPM_INST-1:0]	inst,
    input   init,
    input   run,
	input	[`EX_in_bus-1  :0]	ex_in_bus,
	input	[`L_C_bus-1    :0]	switch_in_7,
	input	[`L_C_bus-1    :0]	switch_in_6,
	input	[`L_C_bus-1    :0]	switch_in_5,
	input	[`L_C_bus-1    :0]	switch_in_4,
	input	[`L_C_bus-1    :0]	switch_in_3,
	input	[`L_C_bus-1    :0]	switch_in_2,
	input	[`L_C_bus-1    :0]	switch_in_1,
	input	[`L_C_bus-1    :0]	switch_in_0,

	output	[`C_L_bus-1    :0]	switch_out_7,
	output	[`C_L_bus-1    :0]	switch_out_6,
	output	[`C_L_bus-1    :0]	switch_out_5,
	output	[`C_L_bus-1    :0]	switch_out_4,
	output	[`C_L_bus-1    :0]	switch_out_3,
	output	[`C_L_bus-1    :0]	switch_out_2,
	output	[`C_L_bus-1    :0]	switch_out_1,
	output	[`C_L_bus-1    :0]	switch_out_0,

    output  [`EX_out_bus-1 :0]  ex_out_bus
);
	wire 	BG0_sel,BG1_sel,BG2_sel,BG3_sel,BG4_sel,BG5_sel,BG6_sel,BG7_sel;
	wire 	BG0_mode,BG1_mode,BG2_mode,BG3_mode,BG4_mode,BG5_mode,BG6_mode,BG7_mode;
	wire 	BG0_wen,BG1_wen,BG2_wen,BG3_wen,BG4_wen,BG5_wen,BG6_wen,BG7_wen;
	wire 	BG0_ren,BG1_ren,BG2_ren,BG3_ren,BG4_ren,BG5_ren,BG6_ren,BG7_ren;
	wire 	BG0_en,BG1_en,BG2_en,BG3_en,BG4_en,BG5_en,BG6_en,BG7_en;
	wire	[`A_W-1:0]	BG0_addr,BG1_addr,BG2_addr,BG3_addr,BG4_addr,BG5_addr,BG6_addr,BG7_addr;
	
	wire	[`A_W-1:0]	ex_addr;
	wire	ex_wen_0,ex_wen_1,ex_wen_2,ex_wen_3,ex_wen_4,ex_wen_5,ex_wen_6,ex_wen_7;
    wire    ex_ren_0,ex_ren_1,ex_ren_2,ex_ren_3,ex_ren_4,ex_ren_5,ex_ren_6,ex_ren_7;
    wire    [2:0]   ex_read_sel;
    wire    [2:0]   ex_write_sel;
        
	wire	[`A_W-1:0]	sin_0_addr,sin_1_addr,sin_2_addr,sin_3_addr,sin_4_addr,sin_5_addr,sin_6_addr,sin_7_addr;
	wire	[31:0]	sin_0_data,sin_1_data,sin_2_data,sin_3_data,sin_4_data,sin_5_data,sin_6_data,sin_7_data;
	wire	sin_0_wen,sin_1_wen,sin_2_wen,sin_3_wen,sin_4_wen,sin_5_wen,sin_6_wen,sin_7_wen;
	wire	sin_0_ren,sin_1_ren,sin_2_ren,sin_3_ren,sin_4_ren,sin_5_ren,sin_6_ren,sin_7_ren;
	wire	[1:0]	BG_0_fifo_sel,BG_1_fifo_sel,BG_2_fifo_sel,BG_3_fifo_sel;
    wire	[1:0]	BG_4_fifo_sel,BG_5_fifo_sel,BG_6_fifo_sel,BG_7_fifo_sel;
    
    wire    [31:0]  ex_data;
    assign	{	            
		ex_write_sel,		//44:42
		ex_read_sel,		//41:39
		ex_addr,	    //38:32
		ex_data 		//31:0
    }	=	ex_in_bus;

    assign  {ex_wen_0,ex_wen_1,ex_wen_2,ex_wen_3,ex_wen_4,ex_wen_5,ex_wen_6,ex_wen_7} = {8'b10000000} >> ex_write_sel;
    assign  {ex_ren_0,ex_ren_1,ex_ren_2,ex_ren_3,ex_ren_4,ex_ren_5,ex_ren_6,ex_ren_7} = {8'b10000000} >> ex_read_sel;

    assign ex_out_bus =  ex_read_sel == 'b000 ? switch_out_0[31:0]:
                         ex_read_sel == 'b001 ? switch_out_1[31:0]:
                         ex_read_sel == 'b010 ? switch_out_2[31:0]:
                         ex_read_sel == 'b011 ? switch_out_3[31:0]:
                         ex_read_sel == 'b100 ? switch_out_4[31:0]:
                         ex_read_sel == 'b101 ? switch_out_5[31:0]:
                         ex_read_sel == 'b110 ? switch_out_6[31:0]:
                                                switch_out_7[31:0];



	assign	{
		sin_0_wen,		//41:41
		sin_0_data,	    //40:9
        sin_0_ren,		//8:8
		sin_0_addr	    //7:0
	}	=	switch_in_0;

	assign	{
		sin_1_wen,		
		sin_1_data,	
        sin_1_ren,		
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

	assign	{
		sin_4_wen,		//41:41
		sin_4_data,	    //40:9
        sin_4_ren,		//8:8
		sin_4_addr	    //7:0
	}	=	switch_in_4;

	assign	{
		sin_5_wen,		
		sin_5_data,	
        sin_5_ren,		
		sin_5_addr
	}	=	switch_in_5;

	assign	{
		sin_6_wen,		//43:43
		sin_6_data,	
        sin_6_ren,		//42:42
		sin_6_addr
	}	=	switch_in_6;

	assign	{
		sin_7_wen,		//43:43
		sin_7_data,	
        sin_7_ren,		//42:42
		sin_7_addr
	}	=	switch_in_7;


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
	wire    [31:0] BG4_feed_data,BG5_feed_data,BG6_feed_data,BG7_feed_data;
    wire    [1:0] BG0_fifo_sel,BG1_fifo_sel,BG2_fifo_sel,BG3_fifo_sel;
    wire    [1:0] BG4_fifo_sel,BG5_fifo_sel,BG6_fifo_sel,BG7_fifo_sel;
	wire    flush_0,flush_1,flush_2,flush_3,flush_4,flush_5,flush_6,flush_7;
    assign {
        flush_7,        //  3
        flush_6,        //  2
        flush_5,        //  1
        flush_4,        //  0
        flush_3,        //  3
        flush_2,        //  2
        flush_1,        //  1
        flush_0,        //  0
        BG7_fifo_sel,   //  8
		BG6_fifo_sel,   //  6
		BG5_fifo_sel,   //  4
        BG4_fifo_sel,   //  2
		BG3_fifo_sel,   //  8
		BG2_fifo_sel,   //  6
		BG1_fifo_sel,   //  4
        BG0_fifo_sel,   //  2
		BG7_en,         //	1
		BG6_en,         // 	0
		BG5_en,         //  
		BG4_en,         //  
		BG3_en,         //	1
		BG2_en,         // 	0
		BG1_en,         //  
		BG0_en,         //  

		BG7_sel,//	
		BG6_sel,// 	
		BG5_sel,//  
		BG4_sel,//  
		BG3_sel,//	
		BG2_sel,// 	
		BG1_sel,// 
		BG0_sel,// 
		
		BG7_mode,//
		BG6_mode,//
		BG5_mode,//
		BG4_mode,//
		BG3_mode,//
		BG2_mode,//
		BG1_mode,//
		BG0_mode//
	} = inst_r;

	assign	BG7_feed_data = BG7_sel ? sin_7_data :	ex_data ;
	assign	BG6_feed_data = BG6_sel ? sin_6_data :	ex_data ;
	assign	BG5_feed_data = BG5_sel ? sin_5_data :	ex_data ;
	assign	BG4_feed_data = BG4_sel ? sin_4_data :	ex_data ;
	assign	BG3_feed_data = BG3_sel ? sin_3_data :	ex_data ;
	assign	BG2_feed_data = BG2_sel ? sin_2_data :	ex_data ;
	assign	BG1_feed_data = BG1_sel ? sin_1_data :	ex_data ;
	assign	BG0_feed_data = BG0_sel ? sin_0_data :	ex_data ;


	assign	BG7_addr  =  BG7_sel ?  sin_7_addr	:	ex_addr	;	
	assign	BG6_addr  =  BG6_sel ?  sin_6_addr	:	ex_addr	;
	assign	BG5_addr  =  BG5_sel ?  sin_5_addr	:	ex_addr	;	
	assign	BG4_addr  =  BG4_sel ?  sin_4_addr	:	ex_addr	;
	assign	BG3_addr  =  BG3_sel ?  sin_3_addr	:	ex_addr	;	
	assign	BG2_addr  =  BG2_sel ?  sin_2_addr	:	ex_addr	;
	assign	BG1_addr  =  BG1_sel ?  sin_1_addr	:	ex_addr	;	
	assign	BG0_addr  =  BG0_sel ?  sin_0_addr	:	ex_addr	;

	assign	BG7_wen	  =  BG7_sel ?	sin_7_wen	:	ex_wen_7	;
	assign	BG6_wen	  =  BG6_sel ?	sin_6_wen	:	ex_wen_6	;
	assign	BG5_wen	  =  BG5_sel ?	sin_5_wen	:	ex_wen_5	;
	assign	BG4_wen	  =  BG4_sel ?	sin_4_wen	:	ex_wen_4	;
	assign	BG3_wen	  =  BG3_sel ?	sin_3_wen	:	ex_wen_3	;
	assign	BG2_wen	  =  BG2_sel ?	sin_2_wen	:	ex_wen_2	;
	assign	BG1_wen	  =  BG1_sel ?	sin_1_wen	:	ex_wen_1	;
	assign	BG0_wen	  =  BG0_sel ?	sin_0_wen	:	ex_wen_0	;

	assign	BG7_ren	  =  BG7_sel ?	sin_7_ren	:	ex_ren_7	;
	assign	BG6_ren	  =  BG6_sel ?	sin_6_ren	:	ex_ren_6	;
	assign	BG5_ren	  =  BG5_sel ?	sin_5_ren	:	ex_ren_5	;
	assign	BG4_ren	  =  BG4_sel ?	sin_4_ren	:	ex_ren_4	;
	assign	BG3_ren	  =  BG3_sel ?	sin_3_ren	:	ex_ren_3	;
	assign	BG2_ren	  =  BG2_sel ?	sin_2_ren	:	ex_ren_2	;
	assign	BG1_ren	  =  BG1_sel ?	sin_1_ren	:	ex_ren_1	;
	assign	BG0_ren	  =  BG0_sel ?	sin_0_ren	:	ex_ren_0	;

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

	bankgroup	BG4(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG4_en 		),		
    	.din_i		    (BG4_feed_data	),
    	.pattern_i	    (BG4_mode		),
    	.addr_i		    (BG4_addr       ),
    	.we_i			(BG4_wen        ),
    	.re_i			(BG4_ren        ),
    	.fifo_sel_i	    (BG4_fifo_sel	),
    	.flush_i		(flush_4        ),
    	.dout_bus		(switch_out_4	)
	);

	bankgroup	BG5(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG5_en 		),		
    	.din_i		    (BG5_feed_data	),
    	.pattern_i	    (BG5_mode		),
    	.addr_i		    (BG5_addr       ),
    	.we_i			(BG5_wen        ),
    	.re_i			(BG5_ren        ),
    	.fifo_sel_i	    (BG5_fifo_sel	),
    	.flush_i		(flush_5        ),
    	.dout_bus		(switch_out_5	)
	);

	bankgroup	BG6(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG6_en 		),		
    	.din_i		    (BG6_feed_data	),
    	.pattern_i	    (BG6_mode		),
    	.addr_i		    (BG6_addr       ),
    	.we_i			(BG6_wen        ),
    	.re_i			(BG6_ren        ),
    	.fifo_sel_i	    (BG6_fifo_sel	),
    	.flush_i		(flush_6        ),
    	.dout_bus		(switch_out_6	)
	);

	bankgroup	BG7(
    	.clk		    (clk			),
    	.rst		    (rst			),
    	.en_i			(BG7_en 		),		
    	.din_i		    (BG7_feed_data	),
    	.pattern_i	    (BG7_mode		),
    	.addr_i		    (BG7_addr       ),
    	.we_i			(BG7_wen        ),
    	.re_i			(BG7_ren        ),
    	.fifo_sel_i	    (BG7_fifo_sel	),
    	.flush_i		(flush_7        ),
    	.dout_bus		(switch_out_7	)
	);



endmodule