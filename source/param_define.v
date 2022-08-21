`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/03 16:42:11
// Design Name: 
// Module Name: param_define
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
`define A_W 8'd10 //address_width

`define F_D 8'd8        //fifo_depth
`define L_I_W   8'd7    //lsu_inst_width
`define L_C_bus 8'd47    //lsu_to_CBG_bus
`define C_L_bus 8'd32    //CBG_to_lsu_bus  
`define Config_W  8'd8  //config_buffer_width
`define PE_I_W  8'd45   //pe_inst_width
`define EX_bus    8'd44     //external_memory_bus
`define R_Q   10 + 1            //read_request
`define W_Q   10 + 35            //write_request
`define SPM_INST 8'd12
`define H_C_W   12 + 44 + 7  //host_controller_width
// `define H_C_W   SPM_INST + EX_bus + L_I_W  //host_controller_width
