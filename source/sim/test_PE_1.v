`include "../param_define.v"
`timescale 1ns / 1ps

module test_PE_1 (

);
    parameter cycle = 10;
    reg clk;
    reg rst;

//---------------PE_INST----------------//
    wire   [`PE_inst -1:0]    PE_1_inst;
    wire    [3:0]              reg_file_sel;
    reg    [`FU-1:0]          fu_opcode;
    wire   [`PE_5x4  -1:0]    switch_5x4;
    wire   [`PE_9x7  -1:0]    switch_9x7;
    reg    [3:0]              _9x7_dout_N_sel    ;
    reg    [3:0]              _9x7_dout_S_sel    ;
    reg    [3:0]              _9x7_dout_W_sel    ;
    reg    [3:0]              _9x7_dout_E_sel    ;
    reg    [3:0]              _9x7_dout_LSU_sel  ;
    reg    [3:0]              _9x7_op_A_sel      ;
    reg    [3:0]              _9x7_op_B_sel      ;
    reg    [2:0]              _5x4_dout_N_sel    ;
    reg    [2:0]              _5x4_dout_S_sel    ;
    reg    [2:0]              _5x4_dout_W_sel    ;
    reg    [2:0]              _5x4_dout_E_sel    ;
    reg                         R0_sel; //3:3
    reg                         R1_sel; //2:2
    reg                         R2_sel; //1:1
    reg                         R3_sel; //0:0
    wire   [31:0]               din_N;
    wire   [31:0]               din_S;
    wire   [31:0]               din_W;
    wire   [31:0]               din_E;
    reg    [31:0]                din_N_r;
    reg    [31:0]                din_S_r;
    reg    [31:0]                din_W_r;
    reg    [31:0]                din_E_r;
    
    wire   [31:0]               PE_1_dout_N  ;
    wire   [31:0]               PE_1_dout_S  ;
    wire   [31:0]               PE_1_dout_W  ;
    wire   [31:0]               PE_1_dout_E  ;
    wire   [31:0]               PE_1_dout_LSU;
    assign      din_N = din_N_r;
    assign      din_S = din_S_r;
    assign      din_W = din_W_r;
    assign      din_E = din_E_r;  
    assign switch_9x7 =  {
        _9x7_dout_LSU_sel,   //27:24
        _9x7_op_A_sel,       //23:20
        _9x7_op_B_sel,       //19:16
        _9x7_dout_N_sel,     //15:12
        _9x7_dout_S_sel,     //11:8
        _9x7_dout_W_sel,     //7:4
        _9x7_dout_E_sel      //3:0
    } ;

    assign PE_1_inst =  {
        fu_opcode,   // 47:44  4bit
        switch_9x7,  // 43:16  28 bit
        switch_5x4,  // 15:4   12 bit
        reg_file_sel // 3:0    4 bit
    } ;

    assign  switch_5x4 = {
        _5x4_dout_N_sel ,
        _5x4_dout_S_sel ,
        _5x4_dout_W_sel ,
        _5x4_dout_E_sel 
    };

    assign reg_file_sel = {
        R0_sel, //3:3
        R1_sel, //2:2
        R2_sel, //1:1
        R3_sel  //0:0
    } ;

    reg     [31:0]      LSU_data;
//---------------end-----------------//
    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
// -----din_w输入至R3  R3输出至dout_s
// 0X0XX7XXXXXf 指令码
        #30 rst = 1'b0;
        fu_opcode           =  'd0; 
        _5x4_dout_N_sel     =  'dx;
        R0_sel              =  'd1;
        _5x4_dout_S_sel     =  'dx;
        _5x4_dout_W_sel     =  'dx;
        _5x4_dout_E_sel     =  'd2; 
        R3_sel              =  'd1; 
        R1_sel              =  'd1; 
        R2_sel              =  'd1;
        din_N_r             =  'd5;
        din_S_r             =  'd6;
        din_W_r             =  'd7;
        din_E_r             =  'd8;

        _9x7_dout_LSU_sel   = 'dx;
        _9x7_op_A_sel       = 'd0;
        _9x7_op_B_sel       = 'dx; 
        _9x7_dout_N_sel     = 'dx;  
        _9x7_dout_S_sel     = 'd7; 
        _9x7_dout_W_sel     = 'dx;
        _9x7_dout_E_sel     = 'dx;
        LSU_data            = 32'd9;
    end

    PE  pe_0(
        .clk            (clk            ),
        .rst            (rst            ),
        .inst           (PE_1_inst      ),
        .din_N          (din_N          ),//上
        .din_S          (din_S          ),//下
        .din_W          (din_W          ),//左 
        .din_E          (din_E          ),//右
        .din_LSU        (LSU_data       ),
        .dout_N         (PE_1_dout_N    ),
        .dout_S         (PE_1_dout_S    ),
        .dout_W         (PE_1_dout_W    ),
        .dout_E         (PE_1_dout_E    ),
        .dout_LSU       (PE_1_dout_LSU  )
    );

endmodule