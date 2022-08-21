`include "../param_define.v"
`timescale 1ns / 1ps

module testbench (

);
    parameter cycle = 10;
    reg clk;
    reg rst;

//-----------Host_controller--------//
    wire    [`H_C_W -1  :0]     Host_Config;

// -----------LSU_INST-----------//
    
    reg    ren,wen,store_sel;
    reg    [1:0]   w_sel,pe_sel;
    wire   [`L_I_W-1  :0]  LSU_inst;
    assign LSU_inst = {
        ren,      //6:6
        wen,      //5:5
        w_sel,    //4:3
        pe_sel,   //2:1
        store_sel //0:0
    };

// ------------end-----------//

// ---------------SPM----------------//
	reg 	BG0_sel,BG1_sel,BG2_sel,BG3_sel;
	reg 	BG0_mode,BG1_mode,BG2_mode,BG3_mode;
	reg 	BG0_en,BG1_en,BG2_en,BG3_en;
    wire    [11:0]  SPM_inst;
    
    assign SPM_inst  =  {
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

    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        BG3_en  =  1'b0 ;   BG3_sel  =  1'b0 ;    BG3_mode  =  1'b0 ; 
	    BG2_en  =  1'b0 ;   BG2_sel  =  1'b0 ;    BG2_mode  =  1'b0 ; 
	    BG1_en  =  1'b0 ;   BG1_sel  =  1'b0 ;    BG1_mode  =  1'b0 ; 
	    BG0_en  =  1'b0 ;   BG0_sel  =  1'b0 ;    BG0_mode  =  1'b0 ; 
        ex_wen  =  'b0;  ren      ='b0 ; 
	    ex_ren  =  'b0;  wen      ='b0 ; 
	    ex_addr =  'b0;  w_sel    ='b0 ;
	    ex_data =  'b1;  pe_sel   ='b0 ;  
                        store_sel='b0 ;  

    #40 BG0_en      =   1'b1;
        ex_wen      =   1'b1;
        for ( i=1 ;i<=10 ;i=i+1 ) begin
    		#10 ex_addr   <= 'b0 +i   ;	//41:32
    		    ex_data   <= 'b1 +i   ;  		//31:0
        end
    end

    assign  Host_Config ={
        SPM_inst  ,
        ex_bus    ,
        LSU_inst  
    } ;
    
    wire    [`SPM_INST-1:0]   SPM_inst_valid ;
    wire    [`EX_bus-1  :0]	  ex_bus_valid   ;
    wire    [`L_I_W-1   :0]   LSU_inst_valid ;


    Host_Controller hconf(
        .clk                (clk            ),
        .rst                (rst            ),
        .Host_Config        (Host_Config    ),
        .SPM_inst           (SPM_inst_valid ),
        .ex_bus             (ex_bus_valid   ),
        .LSU_inst           (LSU_inst_valid )
    );


    wire    [`L_C_bus-1:0]      crossbar_BG3_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG2_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG1_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG0_out ;
    wire    [`C_L_bus-1:0]      crossbar_BG3_in  ;
    wire    [`C_L_bus-1:0]      crossbar_BG2_in  ;
    wire    [`C_L_bus-1:0]      crossbar_BG1_in  ;
    wire    [`C_L_bus-1:0]      crossbar_BG0_in  ;

    wire    [`L_C_bus-1:0]      crossbar_LSU3_in ; 
    wire    [`L_C_bus-1:0]      crossbar_LSU2_in ;
    wire    [`L_C_bus-1:0]      crossbar_LSU1_in ;
    wire    [`L_C_bus-1:0]      crossbar_LSU0_in ;

    wire    [`C_L_bus-1:0]      crossbar_LSU3_out;
    wire    [`C_L_bus-1:0]      crossbar_LSU2_out;
    wire    [`C_L_bus-1:0]      crossbar_LSU1_out;
    wire    [`C_L_bus-1:0]      crossbar_LSU0_out;

    scratchpad  s(
        .rst            (rst                ),
        .clk            (clk                ),
        .inst           (SPM_inst_valid     ),
        .ex_bus         (ex_bus_valid       ),
        .switch_in_3    (crossbar_BG3_out   ),
        .switch_in_2    (crossbar_BG2_out   ),
        .switch_in_1    (crossbar_BG1_out   ),
        .switch_in_0    (crossbar_BG0_out   ),
	
	    .switch_out_3   (crossbar_BG3_in   ),
	    .switch_out_2   (crossbar_BG2_in   ),
	    .switch_out_1   (crossbar_BG1_in   ),
	    .switch_out_0   (crossbar_BG0_in   )
    );

    wire    [`R_Q    -1:0]  LSU_3_R_request;
    wire    [`R_Q    -1:0]  LSU_2_R_request;
    wire    [`R_Q    -1:0]  LSU_1_R_request;
    wire    [`R_Q    -1:0]  LSU_0_R_request;

    wire    [`W_Q    -1:0]  LSU_3_W_request;
    wire    [`W_Q    -1:0]  LSU_2_W_request;
    wire    [`W_Q    -1:0]  LSU_1_W_request;
    wire    [`W_Q    -1:0]  LSU_0_W_request;

    wire    [31:0]  LSU_3_to_PE;
    wire    [31:0]  LSU_2_to_PE;
    wire    [31:0]  LSU_1_to_PE;
    wire    [31:0]  LSU_0_to_PE;
    LSU lsu0(
        .clk                (clk                ),
        .rst                (rst                ),
        .LSU_inst           (LSU_inst_valid     ),
        .PE_0               (                   ),
        .PE_1               (                   ),
        .PE_2               (                   ),
        .PE_3               (                   ),
        .LSU_to_PE          (LSU_0_to_PE        ),
        .R_request          (LSU_0_R_request    ),
        .W_request          (LSU_0_W_request    )  
    );



    BG_LSU_independent_crossbar_4x4 cross_4x4 (
        .R_request_3        (LSU_3_R_request    ),
        .R_request_2        (LSU_2_R_request    ),
        .R_request_1        (LSU_1_R_request    ),
        .R_request_0        (LSU_0_R_request    ),

        .W_request_3        (LSU_3_W_request    ),
        .W_request_2        (LSU_2_W_request    ),
        .W_request_1        (LSU_1_W_request    ),
        .W_request_0        (LSU_0_W_request    ),

        .R_reponse_3        (crossbar_BG3_in    ), 
        .R_reponse_2        (crossbar_BG2_in    ),
        .R_reponse_1        (crossbar_BG1_in    ),
        .R_reponse_0        (crossbar_BG0_in    ),

        .BG_3_out           (crossbar_BG3_out   ),
        .BG_2_out           (crossbar_BG2_out   ),
        .BG_1_out           (crossbar_BG1_out   ),
        .BG_0_out           (crossbar_BG0_out   ),

        .LSU3_out           (crossbar_LSU3_out  ),
        .LSU2_out           (crossbar_LSU2_out  ),
        .LSU1_out           (crossbar_LSU1_out  ),
        .LSU0_out           (crossbar_LSU0_out  )
        );


endmodule