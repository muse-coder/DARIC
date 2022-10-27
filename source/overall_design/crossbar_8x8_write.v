`include "../param_define.v"

module crossbar_8x8_write_data (
    input    [`W_Q    -1:0]  LSU_W_req_7,
    input    [`W_Q    -1:0]  LSU_W_req_6,
    input    [`W_Q    -1:0]  LSU_W_req_5,
    input    [`W_Q    -1:0]  LSU_W_req_4,
    input    [`W_Q    -1:0]  LSU_W_req_3,
    input    [`W_Q    -1:0]  LSU_W_req_2,
    input    [`W_Q    -1:0]  LSU_W_req_1,
    input    [`W_Q    -1:0]  LSU_W_req_0,
    output   [`W_d-1:0]  W_BG_7,
    output   [`W_d-1:0]  W_BG_6,
    output   [`W_d-1:0]  W_BG_5,
    output   [`W_d-1:0]  W_BG_4,
    output   [`W_d-1:0]  W_BG_3,
    output   [`W_d-1:0]  W_BG_2,
    output   [`W_d-1:0]  W_BG_1,
    output   [`W_d-1:0]  W_BG_0
);

    wire [2:0]   LSU_7_W_sel;
    wire [2:0]   LSU_6_W_sel;
    wire [2:0]   LSU_5_W_sel;
    wire [2:0]   LSU_4_W_sel;
    wire [2:0]   LSU_3_W_sel;
    wire [2:0]   LSU_2_W_sel;
    wire [2:0]   LSU_1_W_sel;
    wire [2:0]   LSU_0_W_sel;
    
    wire               Wen_0,Wen_1,Wen_2,Wen_3,Wen_4,Wen_5,Wen_6,Wen_7;
    wire    [31:0]     W_data_0,W_data_1,W_data_2,W_data_3,W_data_4,W_data_5,W_data_6,W_data_7;
    
    assign {
        LSU_0_W_sel,
        Wen_0,
        W_data_0
    } = LSU_W_req_0;

    assign {
        LSU_1_W_sel,
        Wen_1,
        W_data_1
    } = LSU_W_req_1;

    assign {
        LSU_2_W_sel,
        Wen_2,
        W_data_2
    } = LSU_W_req_2;

    assign {
        LSU_3_W_sel,
        Wen_3,
        W_data_3
    } = LSU_W_req_3;


    assign {
        LSU_4_W_sel,
        Wen_4,
        W_data_4
    } = LSU_W_req_4;

    assign {
        LSU_5_W_sel,
        Wen_5,
        W_data_5
    } = LSU_W_req_5;

    assign {
        LSU_6_W_sel,
        Wen_6,
        W_data_6
    } = LSU_W_req_6;

    assign {
        LSU_7_W_sel,
        Wen_7,
        W_data_7
    } = LSU_W_req_7;

	wire    BG_0_Wen,BG_1_Wen,BG_2_Wen,BG_3_Wen,BG_4_Wen,BG_5_Wen,BG_6_Wen,BG_7_Wen;


//-------------------write crossbar select---------------------//
    assign  W_BG_0   =  (LSU_0_W_sel == 3'b000) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b000) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b000) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b000) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b000) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b000) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b000) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b000) ? {Wen_7 , W_data_7} :
                                                                            'b0;    
    
    assign  W_BG_1   =  (LSU_0_W_sel == 3'b001) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b001) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b001) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b001) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b001) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b001) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b001) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b001) ? {Wen_7 , W_data_7} :
                                                                            'b0;    
       
    assign  W_BG_2   =  (LSU_0_W_sel == 3'b010) ? {Wen_0 , W_data_0} : 
                        (LSU_1_W_sel == 3'b010) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b010) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b010) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b010) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b010) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b010) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b010) ? {Wen_7 , W_data_7} :
                                                                            'b0;    
     
    assign  W_BG_3   =  (LSU_0_W_sel == 3'b011) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b011) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b011) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b011) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b011) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b011) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b011) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b011) ? {Wen_7 , W_data_7} :
                                                                            'b0;    

    assign  W_BG_4   =  (LSU_0_W_sel == 3'b100) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b100) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b100) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b100) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b100) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b100) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b100) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b100) ? {Wen_7 , W_data_7} :
                                                                            'b0;    

    assign  W_BG_5   =  (LSU_0_W_sel == 3'b101) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b101) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b101) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b101) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b101) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b101) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b101) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b101) ? {Wen_7 , W_data_7} :
                                                                            'b0;    

    assign  W_BG_6   =  (LSU_0_W_sel == 3'b110) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b110) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b110) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b110) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b110) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b110) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b110) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b110) ? {Wen_7 , W_data_7} :
                                                                            'b0;    

    assign  W_BG_7   =  (LSU_0_W_sel == 3'b111) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 3'b111) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 3'b111) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 3'b111) ? {Wen_3 , W_data_3} :
                        (LSU_4_W_sel == 3'b111) ? {Wen_4 , W_data_4} :
                        (LSU_5_W_sel == 3'b111) ? {Wen_5 , W_data_5} :
                        (LSU_6_W_sel == 3'b111) ? {Wen_6 , W_data_6} :
                        (LSU_7_W_sel == 3'b111) ? {Wen_7 , W_data_7} :
                                                                            'b0;    


endmodule