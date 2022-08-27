`include "../param_define.v"
`timescale 1ns / 1ps

module testbench (

);
    parameter cycle = 10;
    reg clk;
    reg rst;

//-----------Host_controller--------//
    wire    [`Array     -1:0]       pe_config;
    wire    [`SPM_INST  -1:0]       scr_config;
    wire    [`H_C_W     -1:0]       host_controller;
    wire    [`Config_W  -1:0]       config_buffer_0;
    wire    [`Config_W  -1:0]       config_buffer_1;
    wire    [`Config_W  -1:0]       config_buffer_2;
    wire    [`Config_W  -1:0]       config_buffer_3;
  
    assign  {
        config_buffer_3,
        config_buffer_2,
        config_buffer_1,
        config_buffer_0
    }   =   pe_config;

    wire    [`PE_inst-1:0]  pe_0_inst;
    wire    [`PE_inst-1:0]  pe_1_inst;
    wire    [`PE_inst-1:0]  pe_2_inst;
    wire    [`PE_inst-1:0]  pe_3_inst;

    wire    [`PE_inst-1:0]  pe_4_inst;
    wire    [`PE_inst-1:0]  pe_5_inst;
    wire    [`PE_inst-1:0]  pe_6_inst;
    wire    [`PE_inst-1:0]  pe_7_inst;

    wire    [`PE_inst-1:0]  pe_8_inst;
    wire    [`PE_inst-1:0]  pe_9_inst;
    wire    [`PE_inst-1:0]  pe_10_inst;
    wire    [`PE_inst-1:0]  pe_11_inst;

    wire    [`PE_inst-1:0]  pe_12_inst;
    wire    [`PE_inst-1:0]  pe_13_inst;
    wire    [`PE_inst-1:0]  pe_14_inst;
    wire    [`PE_inst-1:0]  pe_15_inst;

    wire   [`L_I_W-1  :0]  LSU_0_inst;
    wire   [`L_I_W-1  :0]  LSU_1_inst;
    wire   [`L_I_W-1  :0]  LSU_2_inst;
    wire   [`L_I_W-1  :0]  LSU_3_inst;
    
    assign  {
        LSU_0_inst ,
        pe_0_inst,
        pe_1_inst,
        pe_2_inst,
        pe_3_inst //
    }   =   config_buffer_0;

    assign  {
        LSU_1_inst ,
        pe_4_inst,
        pe_5_inst,
        pe_6_inst,
        pe_7_inst //
    }   =   config_buffer_1;

    assign  {
        LSU_2_inst ,
        pe_8_inst,
        pe_9_inst,
        pe_10_inst,
        pe_11_inst //
    }   =   config_buffer_2;

    assign  {
        LSU_3_inst ,
        pe_12_inst,
        pe_13_inst,
        pe_14_inst,
        pe_15_inst //
    }   =   config_buffer_3;

    assign  {scr_config , pe_config } = host_controller ;


// -----------LSU_INST-----------//

    reg    [1:0]    LSU_0_r_sel,        LSU_1_r_sel,    LSU_2_r_sel,    LSU_3_r_sel ;
    reg    [1:0]    LSU_0_addr_sel,     LSU_1_addr_sel, LSU_2_addr_sel, LSU_3_addr_sel ;
    reg             LSU_0_ren,      LSU_0_wen,LSU_0_store_sel;
    reg    [1:0]   LSU_0_w_sel,LSU_0_pe_sel;
    assign LSU_0_inst = {
        LSU_0_ren,      //6:6
        LSU_0_wen,      //5:5
        LSU_0_r_sel,
        LSU_0_w_sel,
        LSU_0_addr_sel,    //4:3
        LSU_0_pe_sel,   //2:1
        LSU_0_store_sel //0:0
    };

    reg    LSU_1_ren,LSU_1_wen,LSU_1_store_sel;
    reg    [1:0]   LSU_1_w_sel,LSU_1_pe_sel;
    assign LSU_1_inst = {
        LSU_1_ren,      //6:6
        LSU_1_wen,      //5:5
        LSU_1_r_sel,
        LSU_1_w_sel,
        LSU_1_addr_sel,    //4:3
        LSU_1_pe_sel,   //2:1
        LSU_1_store_sel //0:0
    };

    reg    LSU_2_ren,LSU_2_wen,LSU_2_store_sel;
    reg    [1:0]   LSU_2_w_sel,LSU_2_pe_sel;
    assign LSU_2_inst = {
        LSU_2_ren,      //6:6
        LSU_2_wen,      //5:5
        LSU_2_r_sel,
        LSU_2_w_sel,
        LSU_2_addr_sel,    //4:3
        LSU_2_pe_sel,   //2:1
        LSU_2_store_sel //0:0
    };

    reg    LSU_3_ren,LSU_3_wen,LSU_3_store_sel;
    reg    [1:0]   LSU_3_w_sel,LSU_3_pe_sel;
    assign LSU_3_inst = {
        LSU_3_ren,      //6:6
        LSU_3_wen,      //5:5
        LSU_3_r_sel,
        LSU_3_w_sel,
        LSU_3_addr_sel,    //4:3
        LSU_3_pe_sel,   //2:1
        LSU_3_store_sel //0:0
    };
// ------------end-----------//


// ---------------SPM----------------//
	reg 	BG0_sel,BG1_sel,BG2_sel,BG3_sel;
	reg 	BG0_mode,BG1_mode,BG2_mode,BG3_mode;
	reg 	BG0_en,BG1_en,BG2_en,BG3_en;
    reg     [1:0]   BG3_fifo_sel, BG2_fifo_sel, BG1_fifo_sel,  BG0_fifo_sel;   //  13:12
	

    
    assign scr_config  =  {
        BG3_fifo_sel,   //  19:18
		BG2_fifo_sel,   //  17:16
		BG1_fifo_sel,   //  15:14
        BG0_fifo_sel,   //  13:12
		BG3_en,//	11:11
		BG2_en,// 	10:10
		BG1_en,//   9:9
		BG0_en,//   8:8

		BG3_sel,//	7:7
		BG2_sel,// 	6:6
		BG1_sel,//  5:5
		BG0_sel,//  4:4
		
		BG3_mode,// 3:3
		BG2_mode,//	2:2
		BG1_mode,//	1:1
		BG0_mode//	0:0
	} ;
//-----------------end--------------//

//---------ex_bus-----------//
    reg [31:0]  ex_data;
    reg ex_wen,ex_ren;
    reg [`A_W-1:0]  ex_addr;

	wire	[`EX_bus-1 :0]	ex_bus;

	assign	ex_bus  =  {
		ex_wen,
		ex_ren,
		ex_addr,	//41:32
		ex_data		//31:0
	}	;    
// ---------end-----------//

    TCAD    tcad(
        .clk                (clk                ),
        .rst                (rst                ),
        .init               (init               ),
        .run                (run                ),
        .host_controller    (host_controller    ),
	    .ex_bus             (ex_bus             )
    );

    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        BG3_en  =  1'b0 ;   BG3_sel  =  1'b0 ;    BG3_mode  =  1'b0 ; BG3_fifo_sel ='b0 ;   //  19:18
	    BG2_en  =  1'b0 ;   BG2_sel  =  1'b0 ;    BG2_mode  =  1'b0 ; BG2_fifo_sel ='b0 ;   //  17:16
	    BG1_en  =  1'b0 ;   BG1_sel  =  1'b0 ;    BG1_mode  =  1'b0 ; BG1_fifo_sel ='b0 ;   //  15:14
	    BG0_en  =  1'b0 ;   BG0_sel  =  1'b0 ;    BG0_mode  =  1'b0 ; BG0_fifo_sel ='b0 ;   //  13:12
        ex_wen  =  'b0;   
	    ex_ren  =  'b0;   
	    ex_addr =  'b0;  
	    ex_data =  'b1;  
        //LSU initial   
        LSU_0_ren      ='b0 ;   LSU_1_ren      ='b0 ;   LSU_2_ren      ='b0 ;   LSU_3_ren      ='b0 ;
        LSU_0_wen      ='b0 ;   LSU_1_wen      ='b0 ;   LSU_2_wen      ='b0 ;   LSU_3_wen      ='b0 ;
        LSU_0_w_sel    ='b0 ;   LSU_1_w_sel    ='b0 ;   LSU_2_w_sel    ='b0 ;   LSU_3_w_sel    ='b0 ;
        LSU_0_pe_sel   ='b0 ;   LSU_1_pe_sel   ='b0 ;   LSU_2_pe_sel   ='b0 ;   LSU_3_pe_sel   ='b0 ;
        LSU_0_store_sel='b0 ;   LSU_1_store_sel='b0 ;   LSU_2_store_sel='b0 ;   LSU_3_store_sel='b0 ;
        LSU_0_r_sel    ='b00;   LSU_1_r_sel    ='b00;   LSU_2_r_sel    ='b00;
        LSU_0_addr_sel ='b00;   LSU_1_addr_sel ='b00;   LSU_2_addr_sel ='b00;                              
//-------------配置初始化---------------//
    #40 rst=1'b0;
        

    end







// //--------向BG0写入20个数据-----------------//
//     #40 rst = 1'b0;
//         BG0_en      =   1'b1;
//         ex_wen      =   1'b1;
//         for ( i=1 ;i<=20 ;i=i+1 ) begin
//     		#10 ex_addr   <= 'b0 +i   ;	//41:32
//     		    ex_data   <= 'b1 +i   ;  		//31:0
//         end
//         BG0_en      =   1'b1;
//         ex_wen      =   1'b0;
// // -------------end------------------//

// //  BG0停止写数据  LSU0发出读指令 读出10个数据(LSU和external读写需要切换模式 BG_sel)--------//
//         LSU_0_ren    =   1'b1   ;      
//         BG0_sel      =   1'b1   ;    
// //  LSU0发出写FIFO模式指令 向BG1的FIFO0写入10个数据,LSU0连接BG1 修改crossbar指令
//     #30  BG1_en      =   1'b1   ;
//          BG1_mode    =   1'b1   ;    
//          BG1_sel     =   1'b1   ;  
//          LSU_0_w_sel =   2'b01  ;
//          LSU_0_wen   =   1'b1   ;
// //  LSU0向PE0写入load数据至R0
    
// //  LSU0停止写FIFO   LSU1开始读BG1的FIFO0 且将读出的数据写入到BG2的FIFO0         
//     #100 LSU_0_wen   =   1'b0   ;
//          LSU_1_ren   =   1'b1   ;
         
//     #30  LSU_1_wen   =   1'b1   ;
//          LSU_1_w_sel =   2'b10  ;
//          BG2_mode    =   1'b1   ;
//          BG2_en      =   1'b1   ;
//          BG2_sel     =   1'b1   ;
// //  LSU2开始读BG2中的FIFO0数据 
//     #10  LSU_2_ren   =   1'b1   ;
//     end 



//     assign  Host_Config ={
//         SPM_inst    ,
//         ex_bus      ,
//         LSU_3_inst  ,
//         LSU_2_inst  ,
//         LSU_1_inst  ,
//         LSU_0_inst  
//     } ;

endmodule