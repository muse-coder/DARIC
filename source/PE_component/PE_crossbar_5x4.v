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
    output  [31         :0]  dout_N,
    output  [31         :0]  dout_S,
    output  [31         :0]  dout_W,
    output  [31         :0]  dout_E
    );

    wire [2:0]  dout_N_sel;
    wire [2:0]  dout_S_sel;
    wire [2:0]  dout_W_sel;
    wire [2:0]  dout_E_sel;

    assign {
        dout_N_sel,//11:9
        dout_S_sel,//8:6
        dout_W_sel,//5:3
        dout_E_sel //2:0
    } = switch;

    assign  dout_N = (dout_N_sel == 3'd0) ? din_N  :
                     (dout_N_sel == 3'd1) ? din_S  :
                     (dout_N_sel == 3'd2) ? din_W  :
                     (dout_N_sel == 3'd3) ? din_E  :
                                            din_LSU; //3'd4                   

    assign  dout_S = (dout_S_sel == 3'd0) ? din_N  :
                     (dout_S_sel == 3'd1) ? din_S  :
                     (dout_S_sel == 3'd2) ? din_W  :
                     (dout_S_sel == 3'd3) ? din_E  :
                                            din_LSU;

    assign  dout_W = (dout_W_sel == 3'd0) ? din_N  :
                     (dout_W_sel == 3'd1) ? din_S  :
                     (dout_W_sel == 3'd2) ? din_W  :
                     (dout_W_sel == 3'd3) ? din_E  :
                                            din_LSU;
                                
    assign  dout_E = (dout_E_sel == 3'd0) ? din_N  :
                     (dout_E_sel == 3'd1) ? din_S  :
                     (dout_E_sel == 3'd2) ? din_W  :
                     (dout_E_sel == 3'd3) ? din_E  :
                                            din_LSU;
                                        
endmodule