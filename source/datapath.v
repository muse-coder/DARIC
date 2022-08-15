`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/05 20:44:12
// Design Name: 
// Module Name: datapath
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


module datapath(
    input   clk,
    input   rst,
    output  [31:0] lsu1_to_pe,
    output  [31:0] lsu2_to_pe,
    output  [31:0] lsu3_to_pe,
    output  [31:0] lsu4_to_pe
    );
	
    wire  [51:0] lsu1_bus;
	wire  [51:0] lsu2_bus;
	wire  [51:0] lsu3_bus;
	wire  [51:0] lsu4_bus;

    wire  [52:0] off_chip_bus; 
    wire  [32:0] bank_to_lsu1_bus;
    wire  [32:0] bank_to_lsu2_bus;
    wire  [32:0] bank_to_lsu3_bus;
    wire  [32:0] bank_to_lsu4_bus;
    
    wire  [17:0] lsu1_inst;
    // wire  [31:0] lsu1_to_pe;
    
    wire  [17:0] lsu2_inst;
    // wire  [31:0] lsu2_to_pe;
    
    wire  [17:0] lsu3_inst;
    // wire  [31:0] lsu3_to_pe;
    
    wire  [17:0] lsu4_inst;
    // wire  [31:0] lsu4_to_pe;

    wire  [31:0] pe1_data;
    wire  [31:0] pe2_data;
    wire  [31:0] pe3_data;
    wire  [31:0] pe4_data;
    wire  [31:0] pe5_data;
    wire  [31:0] pe6_data;
    wire  [31:0] pe7_data;
    wire  [31:0] pe8_data;
    wire  [31:0] pe9_data;
    wire  [31:0] pe10_data;
    wire  [31:0] pe11_data;
    wire  [31:0] pe12_data;
    wire  [31:0] pe13_data;
    wire  [31:0] pe14_data;
    wire  [31:0] pe15_data;
    wire  [31:0] pe16_data;

    scratchpad scr(
        .clk(clk),
        .rst(rst),
        .lsu1_bus       (lsu1_bus),
        .lsu2_bus       (lsu2_bus),
        .lsu3_bus       (lsu3_bus),
        .lsu4_bus       (lsu4_bus),
        .off_chip_bus   (off_chip_bus),
	    .read_out1_bus  (bank_to_lsu1_bus),
	    .read_out2_bus  (bank_to_lsu2_bus),
	    .read_out3_bus  (bank_to_lsu3_bus),
	    .read_out4_bus  (bank_to_lsu4_bus)
    );
    
    lsu lsu1(
        .clk    (clk),
        .rst    (rst),
        .pe1    (pe1_data),
        .pe2    (pe2_data),
        .pe3    (pe3_data),
        .pe4    (pe4_data),
        .inst_in   (lsu1_inst),
        .bank_readin_bus    (bank_to_lsu1_bus),         
        .lsu_to_pe          (lsu1_to_pe),
        .lsu_bus            (lsu1_bus)
    );

    lsu lsu2(
        .clk    (clk),
        .rst    (rst),
        .pe1    (pe5_data),
        .pe2    (pe6_data),
        .pe3    (pe7_data),
        .pe4    (pe8_data),
        .inst_in   (lsu2_inst),
        .bank_readin_bus    (bank_to_lsu2_bus),         
        .lsu_to_pe          (lsu2_to_pe),
        .lsu_bus            (lsu2_bus)
    );

    lsu lsu3(
        .clk    (clk),
        .rst    (rst),
        .pe1    (pe9_data),
        .pe2    (pe10_data),
        .pe3    (pe11_data),
        .pe4    (pe12_data),
        .inst_in   (lsu3_inst),
        .bank_readin_bus    (bank_to_lsu3_bus),         
        .lsu_to_pe          (lsu3_to_pe),
        .lsu_bus            (lsu3_bus)
    );

    lsu lsu4(
        .clk              (clk),
        .rst              (rst),
        .pe1              (pe13_data),
        .pe2              (pe14_data),
        .pe3              (pe15_data),
        .pe4              (pe16_data),
        .inst_in          (lsu4_inst),
        .bank_readin_bus  (bank_to_lsu4_bus),         
        .lsu_to_pe        (lsu4_to_pe),
        .lsu_bus          (lsu4_bus)
    );


endmodule
