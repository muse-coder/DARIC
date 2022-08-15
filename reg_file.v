`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 19:34:02
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input   rst,
    input   clk,
    input   [31:0]  din_res,
    input   [31:0]  din_N,
    input   [31:0]  din_S,
    input   [31:0]  din_W,
    input   [31:0]  din_E,
    input   [3:0]   reg_file_inst,

    output  [31:0]  dout_R0,
    output  [31:0]  dout_R1,
    output  [31:0]  dout_R2,
    output  [31:0]  dout_R3,
    
    output  [31:0]  dout_N,
    output  [31:0]  dout_S,
    output  [31:0]  dout_W,
    output  [31:0]  dout_E
    );

    wire    R0_sel,R1_sel,R2_sel,R3_sel;
    assign  {
        R3_sel, //3:3
        R2_sel, //2:2
        R1_sel, //1:1
        R0_sel  //0:0
    }   = reg_file_inst;
    reg [31:0]  R0;
    reg [31:0]  R1;
    reg [31:0]  R2;
    reg [31:0]  R3;
// mux  0 上 1下
    always @(posedge clk ) begin
        if(rst) begin
            // 待定
        end

        else begin
            R0 <= R0_sel ? din_N : din_res ;
            R1 <= R1_sel ? din_S : R0      ; 
            R2 <= R1_sel ? din_W : R1      ;
            R3 <= R1_sel ? din_E : R2      ; 
        end
    end

    assign  dout_R0 = R0 ;
    assign  dout_R1 = R1 ;
    assign  dout_R2 = R2 ;
    assign  dout_R3 = R3 ;

    assign  dout_N = din_N ; 
    assign  dout_S = din_S ;
    assign  dout_W = din_W ;
    assign  dout_E = din_E ;
 
 endmodule
