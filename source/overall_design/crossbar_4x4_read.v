`include "../param_define.v"

module crossbar_4x4_read_data (
    input    [`R_Q    -1:0]  LSU_R_req_3,
    input    [`R_Q    -1:0]  LSU_R_req_2,
    input    [`R_Q    -1:0]  LSU_R_req_1,
    input    [`R_Q    -1:0]  LSU_R_req_0,

    output   to_CBG_3,
    output   to_CBG_2,
    output   to_CBG_1,
    output   to_CBG_0,

    input   [`C_L_bus-1:0]  R_response_3, 
    input   [`C_L_bus-1:0]  R_response_2,
    input   [`C_L_bus-1:0]  R_response_1,
    input   [`C_L_bus-1:0]  R_response_0,

    output   [`C_L_bus-1:0]  to_LSU_3, 
    output   [`C_L_bus-1:0]  to_LSU_2,
    output   [`C_L_bus-1:0]  to_LSU_1,
    output   [`C_L_bus-1:0]  to_LSU_0
);
    wire [1:0]   LSU_3_R_sel;
    wire [1:0]   LSU_2_R_sel;
    wire [1:0]   LSU_1_R_sel;
    wire [1:0]   LSU_0_R_sel;
    
    wire               Ren_0,Ren_1,Ren_2,Ren_3;
    wire    [31:0]     R_data_0,R_data_1,R_data_2,R_data_3;
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

	wire    BG_0_Ren,BG_1_Ren,BG_2_Ren,BG_3_Ren;


//-------------------read crossbar select---------------------//
    assign  to_CBG_0    =   (LSU_0_R_sel == 2'b00) ? Ren_0  :
                            (LSU_1_R_sel == 2'b00) ? Ren_1  :
                            (LSU_2_R_sel == 2'b00) ? Ren_2  :
                            (LSU_3_R_sel == 2'b00) ? Ren_3  :
                                                    'b0;    
    
    assign  to_CBG_1    =   (LSU_0_R_sel == 2'b01) ? Ren_0  :
                            (LSU_1_R_sel == 2'b01) ? Ren_1  :
                            (LSU_2_R_sel == 2'b01) ? Ren_2  :
                            (LSU_3_R_sel == 2'b01) ? Ren_3  :
                                                    'b0;    
       
    assign  to_CBG_2    =   (LSU_0_R_sel == 2'b10) ? Ren_0  : 
                            (LSU_1_R_sel == 2'b10) ? Ren_1  :
                            (LSU_2_R_sel == 2'b10) ? Ren_2  :
                            (LSU_3_R_sel == 2'b10) ? Ren_3  :
                                                    'b0;    
     
    assign  to_CBG_3    =   (LSU_0_R_sel == 2'b11) ? Ren_0  :
                            (LSU_1_R_sel == 2'b11) ? Ren_1  :
                            (LSU_2_R_sel == 2'b11) ? Ren_2  :
                            (LSU_3_R_sel == 2'b11) ? Ren_3  :
                                                    'b0;    

//---------------read  response-------------//
    assign  to_LSU_0    =   (LSU_0_R_sel == 2'b00) ? R_response_0  :
                            (LSU_0_R_sel == 2'b01) ? R_response_1  :
                            (LSU_0_R_sel == 2'b10) ? R_response_2  :
                            (LSU_0_R_sel == 2'b11) ? R_response_3  :
                                                    'b0;    

    assign  to_LSU_1    =   (LSU_1_R_sel == 2'b00) ? R_response_0  :
                            (LSU_1_R_sel == 2'b01) ? R_response_1  :
                            (LSU_1_R_sel == 2'b10) ? R_response_2  :
                            (LSU_1_R_sel == 2'b11) ? R_response_3  :
                                                    'b0;    

    assign  to_LSU_2    =   (LSU_2_R_sel == 2'b00) ? R_response_0  :
                            (LSU_2_R_sel == 2'b01) ? R_response_1  :
                            (LSU_2_R_sel == 2'b10) ? R_response_2  :
                            (LSU_2_R_sel == 2'b11) ? R_response_3  :
                                                    'b0;    

    assign  to_LSU_3    =   (LSU_3_R_sel == 2'b00) ? R_response_0  :
                            (LSU_3_R_sel == 2'b01) ? R_response_1  :
                            (LSU_3_R_sel == 2'b10) ? R_response_2  :
                            (LSU_3_R_sel == 2'b11) ? R_response_3  :
                                                    'b0;    

endmodule