`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 17:45:04
// Design Name: 
// Module Name: lsu
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
module lsu(
    input   [17:0]  inst_in,
    input           clk,
    input           rst,
    input   [31:0]  pe1,
    input   [31:0]  pe2,
    input   [31:0]  pe3,
    input   [31:0]  pe4,
    input   [32:0]  bank_readin_bus,
    output  [31:0]  lsu_to_pe,
    output  [42:0]  lsu_bus
    );

    
endmodule