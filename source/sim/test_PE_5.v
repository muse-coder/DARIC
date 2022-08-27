`include "../param_define.v"
`timescale 1ns / 1ps

module test_PE_5 (

);
    parameter cycle = 10;
    reg clk;
    reg rst;

//---------------PE_INST----------------//
    wire   [`PE_inst -1:0]    PE_5_inst;
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
    
    wire   [31:0]               PE_5_dout_N  ;
    wire   [31:0]               PE_5_dout_S  ;
    wire   [31:0]               PE_5_dout_W  ;
    wire   [31:0]               PE_5_dout_E  ;
    wire   [31:0]               PE_5_dout_LSU;
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

    assign PE_5_inst =  {
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
//      din_N输入R3  R3输出dou_W
// inst 0XX0X7XX21af
        #30 rst = 1'b0;
        fu_opcode           =  'd0;
        R0_sel              =  'd1; 
        _5x4_dout_N_sel     =  'd1;
        _5x4_dout_S_sel     =  'd0;
        _5x4_dout_W_sel     =  'd3;
        _5x4_dout_E_sel     =  'd0; 
        R3_sel              =  'd1; 
        R1_sel              =  'd1; 
        R2_sel              =  'd1;
        din_N_r             =  'd2;
        din_S_r             =  'd6;
        din_W_r             =  'd7;
        din_E_r             =  'd8;

        _9x7_dout_LSU_sel   = 'd0;
        _9x7_op_A_sel       = 'd0;
        _9x7_op_B_sel       = 'd0; 
        _9x7_dout_N_sel     = 'd0;  
        _9x7_dout_S_sel     = 'd0; 
        _9x7_dout_W_sel     = 'd7;
        _9x7_dout_E_sel     = 'd0;
        LSU_data            = 32'd3;
    end


endmodule