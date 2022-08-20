`include "../param_define.v"
`timescale 1ns / 1ps

module testbench (

);
    parameter cycle = 10;
    reg clk;
    reg rst;
    reg [31:0]  ex_data;
    reg ex_wen,ex_ren;
    reg [`A_W-1:0]  ex_addr;
	reg 	BG0_sel,BG1_sel,BG2_sel,BG3_sel;
	reg 	BG0_mode,BG1_mode,BG2_mode,BG3_mode;
	reg 	BG0_en,BG1_en,BG2_en,BG3_en;
    wire    [11:0]  inst;
	wire	[`EX_bus-1 :0]	ex_bus;

    reg     [1:0]   BG3_switch;
    reg     [1:0]   BG2_switch;
    reg     [1:0]   BG1_switch;
    reg     [1:0]   BG0_switch;
    wire    [7:0]   cross_4x4_switch;
    assign  cross_4x4_switch = {
        BG3_switch,//7:6
        BG2_switch,//5:4
        BG1_switch,//3:2
        BG0_switch//1:0
    };


    assign inst  =  {
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
	} ;

	assign	ex_bus  =  {
		ex_wen,
		ex_ren,
		ex_addr,	//41:32
		ex_data		//31:0
	}	;    


    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        BG3_en    = 1'b0;//	11:11
		BG2_en    = 1'b0;// 	10:10
		BG1_en    = 1'b0;//  9:9
		BG0_en    = 1'b0;//  8:8
		BG3_sel   = 1'b1;//	7:7
		BG2_sel   = 1'b1;// 	6:6
		BG1_sel   = 1'b1;//  5:5
		BG0_sel   = 1'b1;//  4:4
		BG3_mode  = 1'b0    ;// 3:3
		BG2_mode  = 1'b0    ;//	2:2
		BG1_mode  = 1'b0    ;//	1:1
		BG0_mode  = 1'b0    ;//	0:0

        BG3_switch = 2'b11  ;  //7:6
        BG2_switch = 2'b10  ; //5:4
        BG1_switch = 2'b01  ; //3:2
        BG0_switch = 2'b00  ;   //1:0
    
   		ex_wen    = 1'b0    ;
		ex_ren    = 1'b0    ;
		ex_addr   = 10'b0   ;	//41:32
		ex_data   = 32'b0   ;   //31:0
        
    #50 BG0_en      = 1'b1;
        BG0_sel     = 1'b0;
        BG0_mode    = 1'b0;
        ex_wen      =1'b1;
        rst         =1'b0;
		ex_addr   = 10'b1   ;	//41:32
		ex_data   = 32'b1   ;  		//31:0

        for ( i=1 ;i<=10 ;i=i+1 ) begin
    		#10 ex_addr   = 10'b1 +i   ;	//41:32
    		    ex_data   = 32'b1 +i   ;  		//31:0
        end
    end

    wire    [`L_C_bus-1:0]      crossbar_BG3_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG2_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG1_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG0_out ;
    wire    [`C_L_bus-1:0]      corssbar_BG3_in  ;
    wire    [`C_L_bus-1:0]      corssbar_BG2_in  ;
    wire    [`C_L_bus-1:0]      corssbar_BG1_in  ;
    wire    [`C_L_bus-1:0]      corssbar_BG0_in  ;

    wire    [`L_C_bus-1:0]      corssbar_LSU3_in ; 
    wire    [`L_C_bus-1:0]      corssbar_LSU2_in ;
    wire    [`L_C_bus-1:0]      corssbar_LSU1_in ;
    wire    [`L_C_bus-1:0]      corssbar_LSU0_in ;

    wire    [`C_L_bus-1:0]      corssbar_LSU3_out;
    wire    [`C_L_bus-1:0]      corssbar_LSU2_out;
    wire    [`C_L_bus-1:0]      corssbar_LSU1_out;
    wire    [`C_L_bus-1:0]      corssbar_LSU0_out;

    scratchpad  s(
        .rst            (rst        ),
        .clk            (clk        ),
        .inst           (inst       ),
        .ex_bus         (ex_bus     ),
        .switch_in_3    ('b0        ),
        .switch_in_2    ('b0        ),
        .switch_in_1    ('b0        ),
        .switch_in_0    ('b0        ),
	
	    .switch_out_3   (corssbar_BG3_in   ),
	    .switch_out_2   (corssbar_BG2_in   ),
	    .switch_out_1   (corssbar_BG1_in   ),
	    .switch_out_0   (corssbar_BG0_in   )
    );

    BG_LSU_crossbar_4x4 crossbar_4x4(
        .BG3_in             (corssbar_BG3_in    ),
        .BG2_in             (corssbar_BG2_in    ),
        .BG1_in             (corssbar_BG1_in    ),
        .BG0_in             (corssbar_BG0_in    ),
        .LSU3_in            (corssbar_LSU3_in   ), 
        .LSU2_in            (corssbar_LSU2_in   ),
        .LSU1_in            (corssbar_LSU1_in   ),
        .LSU0_in            (corssbar_LSU0_in   ),
    
        .switch             (cross_switch       ),
    
        .BG3_out            (crossbar_BG3_out   ),
        .BG2_out            (crossbar_BG2_out   ),
        .BG1_out            (crossbar_BG1_out   ),
        .BG0_out            (crossbar_BG0_out   ),
        .LSU3_out           (corssbar_LSU3_out  ), 
        .LSU2_out           (corssbar_LSU2_out  ),
        .LSU1_out           (corssbar_LSU1_out  ),
        .LSU0_out           (corssbar_LSU0_out  )
    );



    



endmodule