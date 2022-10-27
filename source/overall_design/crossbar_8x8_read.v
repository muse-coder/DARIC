`include "../param_define.v"

module crossbar_8x8_read_data (
    input    [`R_Q    -1:0]  LSU_R_req_7,
    input    [`R_Q    -1:0]  LSU_R_req_6,
    input    [`R_Q    -1:0]  LSU_R_req_5,
    input    [`R_Q    -1:0]  LSU_R_req_4,
    input    [`R_Q    -1:0]  LSU_R_req_3,
    input    [`R_Q    -1:0]  LSU_R_req_2,
    input    [`R_Q    -1:0]  LSU_R_req_1,
    input    [`R_Q    -1:0]  LSU_R_req_0,

    output   to_CBG_7,
    output   to_CBG_6,
    output   to_CBG_5,
    output   to_CBG_4,
    output   to_CBG_3,
    output   to_CBG_2,
    output   to_CBG_1,
    output   to_CBG_0,

    input   [`C_L_bus-1:0]  R_response_7, 
    input   [`C_L_bus-1:0]  R_response_6,
    input   [`C_L_bus-1:0]  R_response_5,
    input   [`C_L_bus-1:0]  R_response_4,
    input   [`C_L_bus-1:0]  R_response_3, 
    input   [`C_L_bus-1:0]  R_response_2,
    input   [`C_L_bus-1:0]  R_response_1,
    input   [`C_L_bus-1:0]  R_response_0,

    output   [`C_L_bus-1:0]  to_LSU_7, 
    output   [`C_L_bus-1:0]  to_LSU_6,
    output   [`C_L_bus-1:0]  to_LSU_5,
    output   [`C_L_bus-1:0]  to_LSU_4,
    output   [`C_L_bus-1:0]  to_LSU_3, 
    output   [`C_L_bus-1:0]  to_LSU_2,
    output   [`C_L_bus-1:0]  to_LSU_1,
    output   [`C_L_bus-1:0]  to_LSU_0
);
    wire [2:0]   LSU_7_R_sel;
    wire [2:0]   LSU_6_R_sel;
    wire [2:0]   LSU_5_R_sel;
    wire [2:0]   LSU_4_R_sel;
    wire [2:0]   LSU_3_R_sel;
    wire [2:0]   LSU_2_R_sel;
    wire [2:0]   LSU_1_R_sel;
    wire [2:0]   LSU_0_R_sel;
    
    wire               Ren_0,Ren_1,Ren_2,Ren_3,Ren_4,Ren_5,Ren_6,Ren_7;
    wire    [31:0]     R_data_0,R_data_1,R_data_2,R_data_3,R_data_4,R_data_5,R_data_6,R_data_7;
    assign {
        LSU_0_R_sel,
        Ren_0
    } = LSU_R_req_0;

    assign {
        LSU_1_R_sel,
        Ren_1
    } = LSU_R_req_1;

    assign {
        LSU_2_R_sel,
        Ren_2
    } = LSU_R_req_2;

    assign {
        LSU_3_R_sel,
        Ren_3
    } = LSU_R_req_3;

    assign {
        LSU_4_R_sel,
        Ren_4
    } = LSU_R_req_4;

    assign {
        LSU_5_R_sel,
        Ren_5
    } = LSU_R_req_5;

    assign {
        LSU_6_R_sel,
        Ren_6
    } = LSU_R_req_6;

    assign {
        LSU_7_R_sel,
        Ren_7
    } = LSU_R_req_7;

	// wire    BG_0_Ren,BG_1_Ren,BG_2_Ren,BG_3_Ren,BG_4_Ren,BG_5_Ren,BG_6_Ren,BG_7_Ren;


//-------------------read crossbar select---------------------//
    assign  {to_CBG_0,to_LSU_0}    =    (LSU_7_R_sel == 3'b000) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b000) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b000) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b000) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b000) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b000) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b000) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b000) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    
    
    assign  {to_CBG_1,to_LSU_1}    =    (LSU_7_R_sel == 3'b001) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b001) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b001) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b001) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b001) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b001) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b001) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b001) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    
       
    assign  {to_CBG_2,to_LSU_2}    =    (LSU_7_R_sel == 3'b010) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b010) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b010) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b010) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b010) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b010) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b010) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b010) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    
        
    assign  {to_CBG_3,to_LSU_3}    =    (LSU_7_R_sel == 3'b011) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b011) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b011) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b011) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b011) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b011) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b011) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b011) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    

    assign  {to_CBG_4,to_LSU_4}    =    (LSU_7_R_sel == 3'b100) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b100) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b100) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b100) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b100) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b100) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b100) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b100) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    

    assign  {to_CBG_5,to_LSU_5}    =    (LSU_7_R_sel == 3'b101) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b101) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b101) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b101) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b101) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b101) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b101) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b101) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    

    assign  {to_CBG_6,to_LSU_6}    =    (LSU_7_R_sel == 3'b110) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b110) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b110) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b110) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b110) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b110) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b110) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b110) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    

    assign  {to_CBG_7,to_LSU_7}    =    (LSU_7_R_sel == 3'b111) ? {Ren_7 ,R_response_7} :
                                        (LSU_6_R_sel == 3'b111) ? {Ren_6 ,R_response_6} :
                                        (LSU_5_R_sel == 3'b111) ? {Ren_5 ,R_response_5} :
                                        (LSU_4_R_sel == 3'b111) ? {Ren_4 ,R_response_4} :
                                        (LSU_3_R_sel == 3'b111) ? {Ren_3 ,R_response_3} :
                                        (LSU_2_R_sel == 3'b111) ? {Ren_2 ,R_response_2} :
                                        (LSU_1_R_sel == 3'b111) ? {Ren_1 ,R_response_1} :
                                        (LSU_0_R_sel == 3'b111) ? {Ren_0 ,R_response_0} :
                                                                                    'b0;    

endmodule