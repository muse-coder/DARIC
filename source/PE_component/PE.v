`timescale 1ns / 1ps
`include "../param_define.v"

module PE(
    input   clk,
    input   rst,
    input   [`PE_inst-1:0]  inst,
    input   [31:0]  din_N,//上
    input   [31:0]  din_S,//下
    input   [31:0]  din_W,//左 
    input   [31:0]  din_E,//右
    input   [31:0]  din_LSU,
    output  [31:0]  dout_N,
    output  [31:0]  dout_S,
    output  [31:0]  dout_W,
    output  [31:0]  dout_E,
    output  [31:0]  dout_LSU
    );
    
    wire    [31:0]  din_N_tmp;
    wire    [31:0]  din_S_tmp;
    wire    [31:0]  din_W_tmp;
    wire    [31:0]  din_E_tmp;

    wire    [31:0]  dout_R0_tmp;
    wire    [31:0]  dout_R1_tmp;
    wire    [31:0]  dout_R2_tmp;
    wire    [31:0]  dout_R3_tmp;
    
    wire    [3:0]   reg_file_sel;
    wire    [`FU-1:0]   fu_opcode;
    wire    [`PE_5x4-1:0]   switch_5x4;
    wire    [`PE_9x7-1:0]  switch_9x7;
    reg     [31:0]  res;
    wire    [31:0]  OP_A; 
    wire    [31:0]  OP_B;   
    wire    [31:0]  fu_result;

    assign  {
        fu_opcode,   // 47:44  4bit
        switch_9x7,  // 43:16  28 bit
        switch_5x4,  // 15:4   12 bit
        reg_file_sel // 3:0    4 bit
    }   = inst;

    PE_crossbar_5x4 PE_crossbar_5x4_inst(
        .din_N      (din_N      ),
        .din_S      (din_S      ),
        .din_W      (din_W      ),
        .din_E      (din_E      ),
        .din_LSU    (din_LSU    ),
        .switch     (switch_5x4 ),
        .dout_N     (din_N_tmp  ),
        .dout_S     (din_S_tmp  ),
        .dout_W     (din_W_tmp  ),
        .dout_E     (din_E_tmp  )
    );    

    reg_file    reg_file_lut(
        .rst            (rst            ),
        .clk            (clk            ),
        .din_res        (res            ),
        .din_N          (din_N_tmp      ),
        .din_S          (din_S_tmp      ),
        .din_W          (din_W_tmp      ),
        .din_E          (din_E_tmp      ),
        .reg_file_inst  (reg_file_sel   ),

        .dout_R0        (dout_R0_tmp    ),
        .dout_R1        (dout_R1_tmp    ),
        .dout_R2        (dout_R2_tmp    ),
        .dout_R3        (dout_R3_tmp    )    
    );


    PE_crossbar_9x7 PE_crossbar_9x7_inst(
        .din_N          (din_N_tmp        ),
        .din_S          (din_S_tmp        ),
        .din_W          (din_W_tmp        ),
        .din_E          (din_E_tmp        ),
        .din_R0         (dout_R0_tmp      ),
        .din_R1         (dout_R1_tmp      ),
        .din_R2         (dout_R2_tmp      ),
        .din_R3         (dout_R3_tmp      ),
        .fu_res         (fu_result        ),
        .switch         (switch_9x7       ),
        .operand_A      (OP_A             ),  
        .operand_B      (OP_B             ),
        .dout_N         (dout_N           ),
        .dout_S         (dout_S           ),
        .dout_W         (dout_W           ),
        .dout_E         (dout_E           ),
        .dout_LSU       (dout_LSU         )
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
