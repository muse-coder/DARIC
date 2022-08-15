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


module PE_crossbar_4x4(
    input   [31:0]  din_N,
    input   [31:0]  din_S,
    input   [31:0]  din_W,
    input   [31:0]  din_E,
    input   [ 7:0]  switch,
    output  [31:0]  dout_N,
    output  [31:0]  dout_S,
    output  [31:0]  dout_W,
    output  [31:0]  dout_E
    );

    wire [1:0]  N_sel;
    wire [1:0]  S_sel;
    wire [1:0]  W_sel;
    wire [1:0]  E_sel;

    assign {
        N_sel,//7:6
        S_sel,//5:3
        W_sel,//3:2
        E_sel //1:0
    } = switch;

    assign  dout_N = (N_sel == 2'b00) ? din_N:
                     (S_sel == 2'b00) ? din_S:
                     (W_sel == 2'b00) ? din_W:
                     (E_sel == 2'b00) ? din_E:
                                        32'b0;                    

    assign  dout_S = (N_sel == 2'b01) ? din_N:
                     (S_sel == 2'b01) ? din_S:
                     (W_sel == 2'b01) ? din_W:
                     (E_sel == 2'b01) ? din_E:
                                        32'b0;

    assign  dout_W = (N_sel == 2'b10) ? din_N:
                     (S_sel == 2'b10) ? din_S:
                     (W_sel == 2'b10) ? din_W:
                     (E_sel == 2'b10) ? din_E:
                                        32'b0;
                                
    assign  dout_E = (N_sel == 2'b11) ? din_N:
                     (S_sel == 2'b11) ? din_S:
                     (W_sel == 2'b11) ? din_W:
                     (E_sel == 2'b11) ? din_E:
                                        32'b0;
                                        
endmodule