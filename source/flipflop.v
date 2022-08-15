`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 16:43:21
// Design Name: 
// Module Name: flipflop
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


module flipflop(
        input               rst,
        input               clk,
        input   [31:0]      data, 
        output  reg [31:0]  result
    );
    always @(posedge clk ) begin
        if(rst) begin
            result <= 31'b0;
        end
        else begin
            result <= data;
        end
    end
    
endmodule
