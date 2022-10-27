`timescale 1ns / 1ps
`include "../param_define.v"
// complete data port
module PE_F(
    input   clk,
    input   rst,
    input   [`PE_inst-1:0]  PE_inst,
    input   init,
    input   run,
    input   [31:0]  din_N,//上
    // input   [31:0]  din_S,//下
    input   [31:0]  din_W,//左 
    // input   [31:0]  din_E,//右

    output  [31:0]  dout_N,
    // output  [31:0]  dout_S,
    output  [31:0]  dout_W
    // output  [31:0]  dout_E
    );
    
    wire     [31:0]  din_0;
    wire     [31:0]  din_1;
    wire     [31:0]  din_2;
    wire     [31:0]  din_3;

    wire     [31:0]  dout_R0;
    wire     [31:0]  dout_R1;
    wire     [31:0]  dout_R2;
    wire     [31:0]  dout_R3;

    wire    [31:0]  din_S='b0;
    wire    [31:0]  din_E='b0;
    wire    [31:0]  dout_S;
    wire    [31:0]  dout_E;

    wire    c1,c2;
    assign  din_0 = c1 ? din_N : din_W;
    assign  din_1 = c1 ? din_W : din_N;
    assign  din_2 = c2 ? 'b0 : 'b0;
    assign  din_3 = c2 ? 'b0 : 'b0;

    wire    [3:0]   reg_file_sel;
    wire    [`FU-1:0]   fu_opcode;
    wire    [`PE_7x6-1:0]  switch_7x6;
    reg     [31:0]  res;
    wire    [31:0]  OP_A; 
    wire    [31:0]  OP_B;   
    wire    [31:0]  fu_result;
//------------configuration buffer-------------//
    reg     [`PE_inst-1:0]    config_buffer [`buffer_depth-1:0]  ;
    reg     [31:0]  init_count;
    reg     [31:0]  run_count;
    integer i ;
    reg     [`PE_inst-1:0]    PE_inst_r;

//-------------初始化-------------------//
    always @(posedge clk ) begin
        if(rst) begin
            init_count  <=  'b0;
            run_count   <=  'b0;
            for (i = 0; i <`buffer_depth ; i = i + 1) begin
                config_buffer[i] <='b0;
            end
            PE_inst_r   <= 'b0;
        end
        else if(init) begin
            config_buffer[init_count] <= PE_inst;
            init_count <= init_count +1'b1;
        end

        else if(run) begin
            run_count   <= run_count +1'b1;
            PE_inst_r   <= config_buffer[run_count]; 
        end
    end

    assign  {
        fu_opcode,   // 27:24  4bit
        switch_7x6,  // 23:6  18 bit
        c2,          // 5:5
        c1,          // 4:4
        reg_file_sel // 3:0    4 bit
    } = PE_inst_r;

    reg_file    reg_file_lut(
        .rst            (rst            ),
        .clk            (clk            ),
        .din_res        (res            ),
        .din_0          (din_0          ),
        .din_1          (din_1          ),
        .din_2          (din_2          ),
        .din_3          (din_3          ),
        .reg_file_inst  (reg_file_sel   ),

        .dout_R0        (dout_R0    ),
        .dout_R1        (dout_R1    ),
        .dout_R2        (dout_R2    ),
        .dout_R3        (dout_R3    )    
    );


 PE_crossbar_7x6 PE_crossbar_7x6_inst(
    .switch_7x6     (switch_7x6 ),
    .din_0          (din_0      ),
    .din_1          (din_1      ),
    .dout_R0        (dout_R0    ),
    .dout_R1        (dout_R1    ),
    .dout_R2        (dout_R2    ),
    .dout_R3        (dout_R3    ),
    .din_res        (res        ),
    .operand_A      (OP_A       ),  
    .operand_B      (OP_B       ),
    .dout_N         (dout_N     ),
    .dout_S         (dout_S     ),
    .dout_W         (dout_W     ),
    .dout_E         (dout_E     )
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
            res <= 'b0;
        end
        else begin
            res <= fu_result;
        end
    end

endmodule
