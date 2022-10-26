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
`define A_W             8 //address_width
`define F_D             10        //fifo_depth
`define L_I_W           11    //lsu_inst_width
`define L_C_bus         33 + 1+ 8    //lsu_to_CBG_bus
`define C_L_bus         33    //CBG_to_lsu_bus  
`define Config_W        48 * 4 + 13  //config_buffer_width
`define EX_in_bus       44     //external_memory_in_bus
`define EX_out_bus      32     //external_memory_in_bus

`define R_Q             3            //read_request
`define W_Q             35            //write_request
`define SPM_INST        24
// `define H_C_W           (48 * 4 + 13) * 4 //host_controller_width
`define PE_5x4          12
`define PE_7x6          18
`define FU              4
`define PE_inst         28
`define A_bus           8+2
`define W_d             33
`define H_C_W           39 //host_controller_width
`define RAM_DEEP        128
`define Init_PE_A       9
`define buffer_depth    10
