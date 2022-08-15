`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 18:46:50
// Design Name: 
// Module Name: pe_pro
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


module pe_pro(
    input   clk,
    input   rst,
    input   [34:0]  inst,
    input   [31:0]  din_N,
    input   [31:0]  din_S,
    input   [31:0]  din_W,
    input   [31:0]  din_E,

    output  [31:0]  dout_N,
    output  [31:0]  dout_S,
    output  [31:0]  dout_W,
    output  [31:0]  dout_E 
    );
    
    wire    [31:0]  din_N_tmp;
    wire    [31:0]  din_S_tmp;
    wire    [31:0]  din_W_tmp;
    wire    [31:0]  din_E_tmp;

    wire    [31:0]  dout_N_tmp;
    wire    [31:0]  dout_S_tmp;
    wire    [31:0]  dout_W_tmp;
    wire    [31:0]  dout_E_tmp;

    wire    [31:0]  dout_R0_tmp;
    wire    [31:0]  dout_R1_tmp;
    wire    [31:0]  dout_R2_tmp;
    wire    [31:0]  dout_R3_tmp;
    
    wire    [3:0]   reg_file_sel;
    wire    [4:0]   fu_opcode;
    wire    [7:0]   switch_4x4;
    wire    [23:0]  switch_9x6;
    reg     [31:0]  res;
    wire    [31:0]  OP_A; 
    wire    [31:0]  OP_B;   
    wire    [31:0]  fu_result;

    assign  {
        fu_opcode,   // 40:36  5bit
        switch_9x6,  // 35:12  24 bit
        switch_4x4,  // 11:4   8 bit
        reg_file_sel // 3:0    4 bit
    }   = inst;

    PE_crossbar_4x4 PE_crossbar_4x4_inst(
        .din_N      (din_N      ),
        .din_S      (din_S      ),
        .din_W      (din_W      ),
        .din_E      (din_E      ),
        .switch     (switch_4x4 ),
        .dout_N     (din_N_tmp  ),
        .dout_S     (din_S_tmp  ),
        .dout_W     (din_W_tmp  ),
        .dout_E     (din_E_tmp  )
    );    

    reg_file    reg_file_lut(
        .rst            (rst        ),
        .clk            (clk        ),
        .din_res        (res        ),
        .din_N          (din_N_tmp  ),
        .din_S          (din_S_tmp  ),
        .din_W          (din_W_tmp  ),
        .din_E          (din_E_tmp  ),
        .reg_file_inst  (reg_file_sel),

        .dout_R0        (dout_R0_tmp),
        .dout_R1        (dout_R1_tmp),
        .dout_R2        (dout_R2_tmp),
        .dout_R3        (dout_R3_tmp),    
        .dout_N         (dout_N_tmp ),
        .dout_S         (dout_S_tmp ),
        .dout_W         (dout_W_tmp ),
        .dout_E         (dout_E_tmp )
    );


    PE_crossbar_9x6 PE_crossbar_9x6_inst(
        .din_N          (dout_N_tmp       ),
        .din_S          (dout_S_tmp       ),
        .din_W          (dout_W_tmp       ),
        .din_E          (dout_E_tmp       ),
        .din_R0         (dout_R0_tmp      ),
        .din_R1         (dout_R1_tmp      ),
        .din_R2         (dout_R2_tmp      ),
        .din_R3         (dout_R3_tmp      ),
        .switch         (switch_9x6       ),
        .operand_A      (OP_A             ),  
        .operand_B      (OP_B             ),
        .dout_N         (dout_N           ),
        .dout_S         (dout_S           ),
        .dout_W         (dout_W           ),
        .dout_E         (dout_E           )
    );

    fu  fu_lut(
        .a          (OP_A       ),
        .b          (OP_B       ),
        .fu_opcode  (fu_opcode  ),
        .fu_result  (fu_result  )
    );

    always @(posedge clk ) begin
        if(rst) begin
            //待定
        end
        else begin
            res <= fu_result;
        end
    end

endmodule
