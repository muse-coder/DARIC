`include "../param_define.v"

module BG_LSU_crossbar_4x4 (
    input   [`C_L_bus-1:0]  BG3_in,
    input   [`C_L_bus-1:0]  BG2_in,
    input   [`C_L_bus-1:0]  BG1_in,
    input   [`C_L_bus-1:0]  BG0_in,
    input   [`L_C_bus-1:0]  LSU3_in, 
    input   [`L_C_bus-1:0]  LSU2_in,
    input   [`L_C_bus-1:0]  LSU1_in,
    input   [`L_C_bus-1:0]  LSU0_in,
        
    output   [`L_C_bus-1:0]  BG3_out,
    output   [`L_C_bus-1:0]  BG2_out,
    output   [`L_C_bus-1:0]  BG1_out,
    output   [`L_C_bus-1:0]  BG0_out,
    output   [`C_L_bus-1:0]  LSU3_out, 
    output   [`C_L_bus-1:0]  LSU2_out,
    output   [`C_L_bus-1:0]  LSU1_out,
    output   [`C_L_bus-1:0]  LSU0_out
    
);

    reg [1:0]   LSU_3_W_sel;
    reg [1:0]   LSU_2_W_sel;
    reg [1:0]   LSU_1_W_sel;
    reg [1:0]   LSU_0_W_sel;
    reg [1:0]   LSU_3_R_sel;
    reg [1:0]   LSU_2_R_sel;
    reg [1:0]   LSU_1_R_sel;
    reg [1:0]   LSU_0_R_sel;

    wire   



endmodule