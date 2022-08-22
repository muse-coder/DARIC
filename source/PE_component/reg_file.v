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
    output  [31:0]  dout_R3
    );

    wire    R0_sel,R1_sel,R2_sel,R3_sel;
    assign  {
        R0_sel, //3:3
        R1_sel, //2:2
        R2_sel, //1:1
        R3_sel  //0:0
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
            R0 <= R0_sel ? din_N : din_res ;//mux 上0 下1
            R1 <= R1_sel ? din_S : R0      ; 
            R2 <= R1_sel ? din_W : R1      ;
            R3 <= R1_sel ? din_E : R2      ; 
        end
    end

    assign  dout_R0 = R0 ;
    assign  dout_R1 = R1 ;
    assign  dout_R2 = R2 ;
    assign  dout_R3 = R3 ;

 endmodule
