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


module fu(
        input   [31:0]      a,
        input   [31:0]      b,
        input   [4:0]       fu_opcode,
        output  reg [31:0]  fu_result//reg??????
    );
    parameter ADD   =   5'd0 ;
    parameter SUB   =   5'd1 ;
    parameter MULT  =   5'd2 ;
    parameter SLL   =   5'd3 ;
    parameter SRL   =   5'd4 ;
    parameter AND   =   5'd5 ;
    parameter OR    =   5'd6 ;
    parameter NOT   =   5'd7 ;
    parameter XOR   =   5'd8 ;
    // parameter ADDI  =   5'd9 ;
    // parameter SUBI  =   5'd10;
    always @(*) begin
        case (fu_opcode)
            ADD   : fu_result = a + b   ; 
            SUB   : fu_result = a - b   ;
            MULT  : fu_result = a * b   ;
            SLL   : fu_result = a << b  ;
            SRL   : fu_result = a >> b  ;
            AND   : fu_result = a & b   ;
            OR    : fu_result = a | b   ;
            NOT   : fu_result = ~a      ;
            XOR   : fu_result = a ^ b   ; 
            // default: 
        endcase
    end

endmodule
