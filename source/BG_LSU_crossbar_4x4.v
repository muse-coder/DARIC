module BG_LSU_crossbar_4x4 (
    input   [31:0]  BG3_in,
    input   [31:0]  BG2_in,
    input   [31:0]  BG1_in,
    input   [31:0]  BG0_in,
    input   [31:0]  LSU3_in, 
    input   [31:0]  LSU2_in,
    input   [31:0]  LSU1_in,
    input   [31:0]  LSU0_in,
    
    input       mode,// 0: BG->LSU  1:LSU->BG
    input       [7:0]swich,
    
    output   [31:0]  BG3_out,
    output   [31:0]  BG2_out,
    output   [31:0]  BG1_out,
    output   [31:0]  BG0_out,
    output   [31:0]  LSU3_out, 
    output   [31:0]  LSU2_out,
    output   [31:0]  LSU1_out,
    output   [31:0]  LSU0_out
    // output  swich_confict
);
    wire [1:0]  BG3_sel;
    wire [1:0]  BG2_sel;
    wire [1:0]  BG1_sel;
    wire [1:0]  BG0_sel;

    assign  {
        BG3_sel,//7:6
        BG2_sel,//5:4
        BG1_sel,//3:2
        BG0_sel//1:0
    }   = swich ; 


    assign  BG0_out = (BG0_sel == 2'b00) ? LSU0_in :
                      (BG0_sel == 2'b01) ? LSU1_in :
                      (BG0_sel == 2'b10) ? LSU2_in :
                      (BG0_sel == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  BG1_out = (BG1_sel == 2'b00) ? LSU0_in :
                      (BG1_sel == 2'b01) ? LSU1_in :
                      (BG1_sel == 2'b10) ? LSU2_in :
                      (BG1_sel == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  BG2_out = (BG2_sel == 2'b00) ? LSU0_in :
                      (BG2_sel == 2'b01) ? LSU1_in :
                      (BG2_sel == 2'b10) ? LSU2_in :
                      (BG2_sel == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  BG3_out = (BG3_sel == 2'b00) ? LSU0_in :
                      (BG3_sel == 2'b01) ? LSU1_in :
                      (BG3_sel == 2'b10) ? LSU2_in :
                      (BG3_sel == 2'b11) ? LSU3_in :
                                          32'b0;

    assign  LSU0_out = (BG0_sel == 2'b00) ? BG0_in :
                       (BG1_sel == 2'b00) ? BG1_in :
                       (BG2_sel == 2'b00) ? BG2_in :
                       (BG3_sel == 2'b00) ? BG3_in :
                                           32'b0;

    assign  LSU1_out = (BG0_sel == 2'b01) ? BG0_in :
                       (BG1_sel == 2'b01) ? BG1_in :
                       (BG2_sel == 2'b01) ? BG2_in :
                       (BG3_sel == 2'b01) ? BG3_in :
                                           32'b0;

    assign  LSU2_out = (BG0_sel == 2'b10) ? BG0_in :
                       (BG1_sel == 2'b10) ? BG1_in :
                       (BG2_sel == 2'b10) ? BG2_in :
                       (BG3_sel == 2'b10) ? BG3_in :
                                           32'b0;

    assign  LSU3_out = (BG0_sel == 2'b11) ? BG0_in :
                       (BG1_sel == 2'b11) ? BG1_in :
                       (BG2_sel == 2'b11) ? BG2_in :
                       (BG3_sel == 2'b11) ? BG3_in :
                                           32'b0;

endmodule