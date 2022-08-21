`include "../param_define.v"

module BG_LSU_independent_crossbar_4x4 (
    input    [`R_Q    -1:0]  R_request_3,
    input    [`R_Q    -1:0]  R_request_2,
    input    [`R_Q    -1:0]  R_request_1,
    input    [`R_Q    -1:0]  R_request_0,

    input    [`W_Q    -1:0]  W_request_3,
    input    [`W_Q    -1:0]  W_request_2,
    input    [`W_Q    -1:0]  W_request_1,
    input    [`W_Q    -1:0]  W_request_0,

    input   [`C_L_bus-1:0]  R_reponse_3, 
    input   [`C_L_bus-1:0]  R_reponse_2,
    input   [`C_L_bus-1:0]  R_reponse_1,
    input   [`C_L_bus-1:0]  R_reponse_0,

    output   [`L_C_bus-1:0]  BG_3_out,
    output   [`L_C_bus-1:0]  BG_2_out,
    output   [`L_C_bus-1:0]  BG_1_out,
    output   [`L_C_bus-1:0]  BG_0_out,

    output   [`C_L_bus-1:0]  LSU3_out,
    output   [`C_L_bus-1:0]  LSU2_out,
    output   [`C_L_bus-1:0]  LSU1_out,
    output   [`C_L_bus-1:0]  LSU0_out
);

    wire [1:0]   LSU_3_W_sel;
    wire [1:0]   LSU_2_W_sel;
    wire [1:0]   LSU_1_W_sel;
    wire [1:0]   LSU_0_W_sel;
    wire [1:0]   LSU_3_R_sel;
    wire [1:0]   LSU_2_R_sel;
    wire [1:0]   LSU_1_R_sel;
    wire [1:0]   LSU_0_R_sel;
    
    wire   Ren_0,Ren_1,Ren_2,Ren_3;
    wire   Wen_0,Wen_1,Wen_2,Wen_3;
    wire   R_mode_0,R_mode_1,R_mode_2,R_mode_3;
    wire   W_mode_0,W_mode_1,W_mode_2,W_mode_3;
    wire [`A_W-1:0]   R_addr_0,R_addr_1,R_addr_2,R_addr_3;
    wire [`A_W-1:0]   W_addr_0,W_addr_1,W_addr_2,W_addr_3;
    wire    [31:0]     W_data_0,W_data_1,W_data_2,W_data_3;
    wire    [31:0]     BG_0_data,BG_1_data,BG_2_data,BG_3_data;
    assign  {
        Ren_0,
        R_addr_0
    }   =   R_request_0;

    assign  {
        Ren_1,
        R_addr_1
    }   =   R_request_1;

    assign  {
        Ren_2,
        R_addr_2
    }   =   R_request_2;

    assign  {
        Ren_3,
        R_addr_3
    }   =   R_request_3;

    assign {
        LSU_0_W_sel,
        Wen_0,
        W_addr_0,
        W_data_0
    } = W_request_0;

    assign {
        LSU_1_W_sel,
        Wen_1,
        W_addr_1,
        W_data_1
    } = W_request_1;

    assign {
        LSU_2_W_sel,
        Wen_2,
        W_addr_2,
        W_data_2
    } = W_request_2;

    assign {
        LSU_3_W_sel,
        Wen_3,
        W_addr_3,
        W_data_3
    } = W_request_3;

	wire    BG_0_Wen,BG_1_Wen,BG_2_Wen,BG_3_Wen;
	wire    BG_0_Ren,BG_1_Ren,BG_2_Ren,BG_3_Ren;
    wire    [`A_W-1:0]  BG_0_W_addr,BG_1_W_addr,BG_2_W_addr,BG_3_W_addr;
    wire    [`A_W-1:0]  BG_0_R_addr,BG_1_R_addr,BG_2_R_addr,BG_3_R_addr;
    wire    [`A_W-1:0]  BG_0_A,BG_1_A,BG_0_2,BG_3_A;

//--------------------read bus connect--------------//
    assign  {BG_3_Ren , BG_3_R_addr} = {Ren_3 , R_addr_3} ;
    assign  {BG_2_Ren , BG_2_R_addr} = {Ren_2 , R_addr_2} ;
    assign  {BG_1_Ren , BG_1_R_addr} = {Ren_1 , R_addr_1} ;
    assign  {BG_0_Ren , BG_0_R_addr} = {Ren_0 , R_addr_0} ;

    assign  LSU3_out = R_reponse_3;
    assign  LSU2_out = R_reponse_2;
    assign  LSU1_out = R_reponse_1;
    assign  LSU0_out = R_reponse_0;
//-------------------end-----------------------//


//-------------------write crossbar select---------------------//
    assign  {BG_0_Wen , BG_0_W_addr , BG_0_data}   =    (LSU_0_W_sel == 2'b00) ? {Wen_0 , W_addr_0 , W_data_0} :
                                                        (LSU_1_W_sel == 2'b00) ? {Wen_1 , W_addr_1 , W_data_1} :
                                                        (LSU_2_W_sel == 2'b00) ? {Wen_2 , W_addr_2 , W_data_2} :
                                                        (LSU_3_W_sel == 2'b00) ? {Wen_3 , W_addr_3 , W_data_3} :
                                                                            'b0;    
    
    assign  {BG_1_Wen , BG_1_W_addr , BG_1_data}   =    (LSU_0_W_sel == 2'b01) ? {Wen_0 , W_addr_0 , W_data_0} :
                                                        (LSU_1_W_sel == 2'b01) ? {Wen_1 , W_addr_1 , W_data_1} :
                                                        (LSU_2_W_sel == 2'b01) ? {Wen_2 , W_addr_2 , W_data_2} :
                                                        (LSU_3_W_sel == 2'b01) ? {Wen_3 , W_addr_3 , W_data_3} :
                                                                            'b0;    
       
    assign  {BG_2_Wen , BG_2_W_addr , BG_2_data}   =    (LSU_0_W_sel == 2'b10) ? {Wen_0 , W_addr_0 , W_data_0} : 
                                                        (LSU_1_W_sel == 2'b10) ? {Wen_1 , W_addr_1 , W_data_1} :
                                                        (LSU_2_W_sel == 2'b10) ? {Wen_2 , W_addr_2 , W_data_2} :
                                                        (LSU_3_W_sel == 2'b10) ? {Wen_3 , W_addr_3 , W_data_3} :
                                                                            'b0;    
     
    assign  {BG_3_Wen , BG_3_W_addr , BG_3_data}   =    (LSU_0_W_sel == 2'b11) ? {Wen_0 , W_addr_0 , W_data_0} :
                                                        (LSU_1_W_sel == 2'b11) ? {Wen_1 , W_addr_1 , W_data_1} :
                                                        (LSU_2_W_sel == 2'b11) ? {Wen_2 , W_addr_2 , W_data_2} :
                                                        (LSU_3_W_sel == 2'b11) ? {Wen_3 , W_addr_3 , W_data_3} :
                                                                            'b0;    
    assign  BG_0_A = BG_0_Ren ? BG_0_R_addr :
                     BG_0_Wen ? BG_0_W_addr :
                                'b0;

    assign  BG_1_A = BG_1_Ren ? BG_1_R_addr :
                     BG_1_Wen ? BG_1_W_addr :
                                'b0;

    assign  BG_2_A = BG_2_Ren ? BG_2_R_addr :
                     BG_2_Wen ? BG_2_W_addr :
                                'b0;

    assign  BG_3_A = BG_3_Ren ? BG_3_R_addr :
                     BG_3_Wen ? BG_3_W_addr :
                                'b0;

    assign BG_0_out = {
		BG_0_Wen,		//44:44
		BG_0_Ren,		//43:43
		BG_0_A, 	//41:32
		BG_0_data		//31:0
	};

    assign BG_1_out = {
		BG_1_Wen,		//44:44
		BG_1_Ren,		//43:43
		BG_1_A, 	//41:32
		BG_1_data		//31:0
	};
    
    assign BG_2_out = {
		BG_2_Wen,		//44:44
		BG_2_Ren,		//43:43
		BG_2_A, 	//41:32
		BG_2_data		//31:0
	};
    
    assign BG_3_out = {
		BG_3_Wen,		//44:44
		BG_3_Ren,		//43:43
		BG_3_A, 	//41:32
		BG_3_data		//31:0
	};

endmodule