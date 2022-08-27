`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 17:39:06
// Design Name: 
// Module Name: crossbar_6x2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "../param_define.v"
module PE_crossbar_5x4(
    input   [31         :0]  din_N,
    input   [31         :0]  din_S,
    input   [31         :0]  din_W,
    input   [31         :0]  din_E,
    input   [31         :0]  din_LSU,
    input   [`PE_5x4    -1:0]  switch,
    output  [31         :0]  to_R0,
    output  [31         :0]  to_R1,
    output  [31         :0]  to_R2,
    output  [31         :0]  to_R3
    );

    wire [2:0]  to_R0_sel;
    wire [2:0]  to_R1_sel;
    wire [2:0]  to_R2_sel;
    wire [2:0]  to_R3_sel;

    assign {
        to_R0_sel,//11:9
        to_R1_sel,//8:6
        to_R2_sel,//5:3
        to_R3_sel //2:0
    } = switch;

    assign  to_R0 = (to_R0_sel == 3'd0) ? din_N  :
                     (to_R0_sel == 3'd1) ? din_S  :
                     (to_R0_sel == 3'd2) ? din_W  :
                     (to_R0_sel == 3'd3) ? din_E  :
                                            din_LSU; //3'd4                   

    assign  to_R1 = (to_R1_sel == 3'd0) ? din_N  :
                     (to_R1_sel == 3'd1) ? din_S  :
                     (to_R1_sel == 3'd2) ? din_W  :
                     (to_R1_sel == 3'd3) ? din_E  :
                                            din_LSU;

    assign  to_R2 = (to_R2_sel == 3'd0) ? din_N  :
                     (to_R2_sel == 3'd1) ? din_S  :
                     (to_R2_sel == 3'd2) ? din_W  :
                     (to_R2_sel == 3'd3) ? din_E  :
                                            din_LSU;
                                
    assign  to_R3 = (to_R3_sel == 3'd0) ? din_N  :
                     (to_R3_sel == 3'd1) ? din_S  :
                     (to_R3_sel == 3'd2) ? din_W  :
                     (to_R3_sel == 3'd3) ? din_E  :
                                            din_LSU;
                                        
endmodule