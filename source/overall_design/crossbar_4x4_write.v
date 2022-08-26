`include "../param_define.v"

module crossbar_4x4_write_data (
    input    [`W_Q    -1:0]  LSU_W_req_3,
    input    [`W_Q    -1:0]  LSU_W_req_2,
    input    [`W_Q    -1:0]  LSU_W_req_1,
    input    [`W_Q    -1:0]  LSU_W_req_0,

    output   [`W_d-1:0]  W_BG_3,
    output   [`W_d-1:0]  W_BG_2,
    output   [`W_d-1:0]  W_BG_1,
    output   [`W_d-1:0]  W_BG_0
);

    wire [1:0]   LSU_3_W_sel;
    wire [1:0]   LSU_2_W_sel;
    wire [1:0]   LSU_1_W_sel;
    wire [1:0]   LSU_0_W_sel;
    
    wire               Wen_0,Wen_1,Wen_2,Wen_3;
    wire    [31:0]     W_data_0,W_data_1,W_data_2,W_data_3;
    
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

	wire    BG_0_Wen,BG_1_Wen,BG_2_Wen,BG_3_Wen;


//-------------------write crossbar select---------------------//
    assign  W_BG_0   =  (LSU_0_W_sel == 2'b00) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 2'b00) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 2'b00) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 2'b00) ? {Wen_3 , W_data_3} :
                                                                            'b0;    
    
    assign  W_BG_1   =  (LSU_0_W_sel == 2'b01) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 2'b01) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 2'b01) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 2'b01) ? {Wen_3 , W_data_3} :
                                                                            'b0;    
       
    assign  W_BG_2   =  (LSU_0_W_sel == 2'b10) ? {Wen_0 , W_data_0} : 
                        (LSU_1_W_sel == 2'b10) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 2'b10) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 2'b10) ? {Wen_3 , W_data_3} :
                                                                            'b0;    
     
    assign  W_BG_3   =  (LSU_0_W_sel == 2'b11) ? {Wen_0 , W_data_0} :
                        (LSU_1_W_sel == 2'b11) ? {Wen_1 , W_data_1} :
                        (LSU_2_W_sel == 2'b11) ? {Wen_2 , W_data_2} :
                        (LSU_3_W_sel == 2'b11) ? {Wen_3 , W_data_3} :
                                                                            'b0;    
endmodule