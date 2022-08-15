`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 17:11:36
// Design Name: 
// Module Name: config_ctrl
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


module config_ctrl(
    input   rst,
    input   clk,
    input   wr_en,
    input   rd_en,
    input   [2:0]   wr_addr,
    input   [2:0]   rd_addr,
    input   [160:0] inst1,
    input   [160:0] inst2,
    input   [160:0] inst3,
    input   [160:0] inst4,
    output  [160:0] inst_out1,
    output  [160:0] inst_out2,
    output  [160:0] inst_out3,
    output  [160:0] inst_out4
    );

    parameter DEPTH = 8;
    integer i;

    reg [160:0] file1 [0:DEPTH-1];
    reg [160:0] file2 [0:DEPTH-1];
    reg [160:0] file3 [0:DEPTH-1];
    reg [160:0] file4 [0:DEPTH-1];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for ( i=0 ;i<DEPTH ;i=i+1 ) begin
                file1[i] <= 161'b0;
                file2[i] <= 161'b0;
                file3[i] <= 161'b0;
                file4[i] <= 161'b0;
            end
        end
        else if (wr_en) begin
            file1[wr_addr]  <= inst1;
            file2[wr_addr]  <= inst2;
            file3[wr_addr]  <= inst3;
            file4[wr_addr]  <= inst4;
        end//存在latch吗？
    end
    assign    inst_out1 = rd_en ? file1[rd_addr] : 161'b0; 
    assign    inst_out2 = rd_en ? file2[rd_addr] : 161'b0;
    assign    inst_out3 = rd_en ? file3[rd_addr] : 161'b0;
    assign    inst_out4 = rd_en ? file4[rd_addr] : 161'b0;

endmodule
