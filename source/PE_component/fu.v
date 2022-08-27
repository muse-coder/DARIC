`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 16:55:18
// Design Name: 
// Module Name: fu
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

module fu(
        input   [31:0]      a,
        input   [31:0]      b,
        input   [`FU-1:0]       fu_opcode,
        output  reg [31:0]  fu_result//reg??????
    );
    parameter ADD   =   4'd0 ;
    parameter SUB   =   4'd1 ;
    parameter MULT  =   4'd2 ;
    parameter SLL   =   4'd3 ;
    parameter SRL   =   4'd4 ;
    parameter AND   =   4'd5 ;
    parameter OR    =   4'd6 ;
    parameter NOT   =   4'd7 ;
    parameter XOR   =   4'd8 ;
    // parameter ADDI  =   5'd9 ;
    // parameter SUBI  =   5'd10;
    always @(*) begin
        case (fu_opcode)
            ADD   :     fu_result = a + b   ; 
            SUB   :     fu_result = a - b   ;
            MULT  :     fu_result = a * b   ;
            SLL   :     fu_result = a << b  ;
            SRL   :     fu_result = a >> b  ;
            AND   :     fu_result = a & b   ;
            OR    :     fu_result = a | b   ;
            NOT   :     fu_result = ~a      ;
            XOR   :     fu_result = a ^ b   ; 
            default:    fu_result = 'b0     ;
        endcase
    end

endmodule
