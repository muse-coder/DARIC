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
    
    input       [7:0]switch,
    
    output   [`L_C_bus-1:0]  BG3_out,
    output   [`L_C_bus-1:0]  BG2_out,
    output   [`L_C_bus-1:0]  BG1_out,
    output   [`L_C_bus-1:0]  BG0_out,
    output   [`C_L_bus-1:0]  LSU3_out, 
    output   [`C_L_bus-1:0]  LSU2_out,
    output   [`C_L_bus-1:0]  LSU1_out,
    output   [`C_L_bus-1:0]  LSU0_out
    // output  swich_confict
);
    wire [1:0]  BG3_switch;
    wire [1:0]  BG2_switch;
    wire [1:0]  BG1_switch;
    wire [1:0]  BG0_switch;

    assign  {
        BG3_switch,//7:6
        BG2_switch,//5:4
        BG1_switch,//3:2
        BG0_switch//1:0
    }   = switch ; 


    assign  BG0_out = (BG0_switch == 2'b00) ? LSU0_in :
                      (BG0_switch == 2'b01) ? LSU1_in :
                      (BG0_switch == 2'b10) ? LSU2_in :
                      (BG0_switch == 2'b11) ? LSU3_in :
                                          32'b0;
    
    assign  BG1_out = (BG1_switch == 2'b00) ? LSU0_in :
                      (BG1_switch == 2'b01) ? LSU1_in :
                      (BG1_switch == 2'b10) ? LSU2_in :
                      (BG1_switch == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  BG2_out = (BG2_switch == 2'b00) ? LSU0_in :
                      (BG2_switch == 2'b01) ? LSU1_in :
                      (BG2_switch == 2'b10) ? LSU2_in :
                      (BG2_switch == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  BG3_out = (BG3_switch == 2'b00) ? LSU0_in :
                      (BG3_switch == 2'b01) ? LSU1_in :
                      (BG3_switch == 2'b10) ? LSU2_in :
                      (BG3_switch == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  LSU0_out = (BG0_switch == 2'b00) ? BG0_in :
                       (BG1_switch == 2'b00) ? BG1_in :
                       (BG2_switch == 2'b00) ? BG2_in :
                       (BG3_switch == 2'b00) ? BG3_in :
                                           32'b0;

    assign  LSU1_out = (BG0_switch == 2'b01) ? BG0_in :
                       (BG1_switch == 2'b01) ? BG1_in :
                       (BG2_switch == 2'b01) ? BG2_in :
                       (BG3_switch == 2'b01) ? BG3_in :
                                           32'b0;

    assign  LSU2_out = (BG0_switch == 2'b10) ? BG0_in :
                       (BG1_switch == 2'b10) ? BG1_in :
                       (BG2_switch == 2'b10) ? BG2_in :
                       (BG3_switch == 2'b10) ? BG3_in :
                                           32'b0;

    assign  LSU3_out = (BG0_switch == 2'b11) ? BG0_in :
                       (BG1_switch == 2'b11) ? BG1_in :
                       (BG2_switch == 2'b11) ? BG2_in :
                       (BG3_switch == 2'b11) ? BG3_in :
                                           32'b0;

endmodule