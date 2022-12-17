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
    input   [31:0]  din_0,
    input   [31:0]  din_1,
    input   [31:0]  din_2,
    input   [31:0]  din_3,
    (* DONT_TOUCH = "1" *)     input   [3:0]   reg_file_inst,

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

    wire [31:0]  R0_in;
    wire [31:0]  R1_in;
    wire [31:0]  R2_in;
    wire [31:0]  R3_in;

    assign  R0_in   = R0_sel ? din_0 : din_res ;
    assign  R1_in   = R1_sel ? din_1 : R0      ;
    assign  R2_in   = R2_sel ? din_2 : R1      ;
    assign  R3_in   = R3_sel ? din_3 : R2      ;
    
// mux  0 上 1下
    always @(posedge clk ) begin
        if(rst) begin
            R0 <=  'b0   ;//mux 上0 下1
            R1 <=  'b0   ; 
            R2 <=  'b0   ;
            R3 <=  'b0   ;         
        end
        else begin
            R0 <=  R0_in   ;//mux 上0 下1
            R1 <=  R1_in   ; 
            R2 <=  R2_in   ;
            R3 <=  R3_in   ; 
        end
    end

    assign  dout_R0 = R0 ;
    assign  dout_R1 = R1 ;
    assign  dout_R2 = R2 ;
    assign  dout_R3 = R3 ;

 endmodule
