`include "../param_define.v"
`timescale 1ns / 1ps

module testbench (

);
    parameter cycle = 10;
    reg clk;
    reg rst;

//-----------Host_controller--------//
    wire    [`SPM_INST  -1:0]       scr_config;
    wire    [`H_C_W     -1:0]       host_controller;  
    reg     [`PE_inst   -1:0]       inst;
    wire    [`L_I_W     -1:0]       LSU_inst;
    wire    [`Init_PE_A -1:0]       init_PE_array;   
    wire    [4            :0]       init_LSU_PE;
    reg     init_SPM;
    reg     init_row_0,init_row_1,init_row_2,init_row_3;
    reg     init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3;
    
    assign  init_LSU_PE = {
        init_LSU,
        init_PE_0,
        init_PE_1,
        init_PE_2,
        init_PE_3
    } ;

    assign init_PE_array = {
        init_row_0  ,//8:8
        init_row_1  ,//7:7
        init_row_2  ,//6:6
        init_row_3  ,//5:5
        init_LSU_PE  //4:0
    } ;
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
    reg init,run;
    wire    init_valid;
    wire    run_valid;
    wire    [`H_C_W-1:0]    host_controller_valid;
    wire    [`EX_bus-1 :0]	ex_bus_valid;
    reg     run_SPM;
    wire     [4:0]   run_PE_array;
    
    assign  host_controller = {
        init_SPM,
        init_PE_array,
        inst
    } ;
    wire    [31:0]  result;
    Delay d(
        .run_i               (run                   ),
        .host_controller_i   (host_controller       ),
        .ex_bus_i            (ex_bus                ),
        .host_controller     (host_controller_valid ),
		.ex_bus              (ex_bus_valid          )
    );

    TCAD    tcad(
        .clk                (clk                    ),
        .rst                (rst                    ),
        .host_controller    (host_controller_valid  ),
	    .ex_bus             (ex_bus_valid           ),
        .TCAD_result        (result                 )
    );

    reg BG0_en , BG1_en , BG2_en , BG3_en ;
    reg BG0_sel, BG1_sel, BG2_sel, BG3_sel;
    reg BG0_mode, BG1_mode, BG2_mode, BG3_mode;
    reg BG0_fifo_sel ,BG1_fifo_sel ,BG2_fifo_sel ,BG3_fifo_sel ;
    
    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        BG3_en  =  1'b0 ;   BG3_sel  =  1'b0 ;    BG3_mode  =  1'b0 ; BG3_fifo_sel ='b0 ;   //  19:18
	    BG2_en  =  1'b0 ;   BG2_sel  =  1'b0 ;    BG2_mode  =  1'b0 ; BG2_fifo_sel ='b0 ;   //  17:16
	    BG1_en  =  1'b0 ;   BG1_sel  =  1'b0 ;    BG1_mode  =  1'b0 ; BG1_fifo_sel ='b0 ;   //  15:14
	    BG0_en  =  1'b0 ;   BG0_sel  =  1'b0 ;    BG0_mode  =  1'b0 ; BG0_fifo_sel ='b0 ;   //  13:12
       
        ex_wen      = 'b0 ;    init_row_0 = 'b0 ;   
	    ex_ren      = 'b0 ;    init_row_1 = 'b0 ;
	    ex_addr     = 'b0 ;    init_row_2 = 'b0 ; 
	    ex_data     = 'b0 ;    init_row_3 = 'b0 ;
        init_SPM    = 'b0 ;
        init_LSU    = 'b0 ;    
        init_PE_0   = 'b0 ;    init_PE_1  = 'b0 ;
        init_PE_2   = 'b0 ;    init_PE_3  = 'b0 ;
  
    #30 rst = 'b0;
        {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b1000};
        inst = 'h004708078d9f;//PE0
        {init_PE_0 , init_PE_1 , init_PE_2 , init_PE_3  } = {4'b1000};
    
    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b1000};
        inst = 'h00000700002f;//PE1
        {init_PE_0 , init_PE_1 , init_PE_2 , init_PE_3  } = {4'b0100};
    
    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0100};
        inst = 'h07074807883f;//PE4
        {init_PE_0 , init_PE_1 , init_PE_2 , init_PE_3  } = {4'b1000};
    
    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0100};
        inst = 'h00000070218f;//PE5
        {init_PE_0 , init_PE_1 , init_PE_2 , init_PE_3  } = {4'b0100};

    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0010};
        inst = 'h07700807054f;//PE8
        {init_PE_0 , init_PE_1 , init_PE_2 , init_PE_3  } = {4'b1000};

    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b1000};
        inst = 'h0401;//LSU0
        {init_PE_0 , init_PE_1 , init_PE_2 , init_PE_3  } = {4'b0000};
        init_LSU = 1'b1;

    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b1000};
        inst = 'h0621;//LSU0
        
    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0100};
        inst = 'h00c0;//LSU1

    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0100};
        inst = 'h02c0;//LSU1
    
    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0010};
        inst = 'h0100;//LSU2

    #10 {init_row_0 , init_row_1 , init_row_2 , init_row_3 } = {4'b0000};
        init_LSU = 'b0;
        init_SPM = 'b1;
        inst = 'h00100;
    #10 inst = 'h00110;
    #10 inst = 'h00776;
        init_SPM = 'b0;
//------------------启动------------------//

    #30 init = 1'b0;
        run  = 1'b1;
        // BG0_en      =   1'b1;
        for ( i=0 ;i<100 ;i=i+1 ) begin
    		#10 ex_wen    <=   1'b1;
                ex_addr   <= 'b0 +i   ;	//41:32
    		    ex_data   <= 'b1 +i   ;  		//31:0
                run       <= 'b0;
        end
        ex_wen      =   1'b1;
    #10  run  = 1'b1;   
    #10  run  = 1'b0;
    #30  run  = 1'b1;
    #10  run  = 1'b0;
    #130 run = 1'b1;
    #10  run = 1'b0;
    end


endmodule