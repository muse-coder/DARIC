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
`define A_W             10 //address_width
`define F_D             6        //fifo_depth
`define L_I_W           13    //lsu_inst_width
`define L_C_bus         33 + 1+ 10    //lsu_to_CBG_bus
`define C_L_bus         33    //CBG_to_lsu_bus  
`define Config_W        48 * 4 + 13  //config_buffer_width
`define EX_bus          44     //external_memory_bus
`define R_Q             3            //read_request
`define W_Q             35            //write_request
`define SPM_INST        20
// `define H_C_W           (48 * 4 + 13) * 4 //host_controller_width
`define PE_5x4          12
`define PE_9x7          28
`define FU              4
`define PE_inst         48
`define A_bus           10+2
`define W_d             33
`define Array           (48 * 4 + 13) * 4 //host_controller_width
`define H_C_W           (48 * 4 + 13) * 4 + 20 //host_controller_width
`define RAM_DEEP        128