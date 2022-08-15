`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/24 12:24:51
// Design Name: 
// Module Name: PEs_pro
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


module PEs_pro(
        input   clk,
        input   rst,
        input   [160:0] inst1,
        input   [160:0] inst2,
        input   [160:0] inst3,
        input   [160:0] inst4,
        input   conf_wr_en,
        input   conf_rd_en,
        input   [2:0]   conf_wr_addr,
        input   [2:0]   conf_rd_addr,
        output  pea_result  
    );
    wire    [169:0] inst_out1;
    wire    [160:0] inst_out2;
    wire    [160:0] inst_out3;
    wire    [160:0] inst_out4;
    wire    [31:0]  inst_pe1;
    wire    [31:0]  inst_pe2;
    wire    [31:0]  inst_pe3;
    wire    [31:0]  inst_pe4;
    wire    [31:0]  inst_pe5;
    wire    [31:0]  inst_pe6;
    wire    [31:0]  inst_pe7;
    wire    [31:0]  inst_pe8;
    wire    [31:0]  inst_pe9;
    wire    [31:0]  inst_pe10;
    wire    [31:0]  inst_pe11;
    wire    [31:0]  inst_pe12;
    wire    [31:0]  inst_pe13;
    wire    [31:0]  inst_pe14;
    wire    [31:0]  inst_pe15;
    wire    [31:0]  inst_pe16;

    wire    [32:0]  isnt_lsu1;
    wire    [32:0]  isnt_lsu2;
    wire    [32:0]  isnt_lsu3;
    wire    [32:0]  isnt_lsu4;
    
    assign  {inst_pe1,  inst_pe2,   inst_pe3,   inst_pe4,   isnt_lsu1}  = inst_out1;
    assign  {inst_pe5,  inst_pe6,   inst_pe7,   inst_pe8,   isnt_lsu2}  = inst_out2;
    assign  {inst_pe9,  inst_pe10,  inst_pe11,  inst_pe12,  isnt_lsu3}  = inst_out3;
    assign  {inst_pe13, inst_pe14,  inst_pe15,  inst_pe16,  isnt_lsu4}  = inst_out4;

    wire    [31:0]  pe1_result;
    wire    [31:0]  pe2_result;
    wire    [31:0]  pe3_result;
    wire    [31:0]  pe4_result;
    wire    [31:0]  pe5_result;
    wire    [31:0]  pe6_result;
    wire    [31:0]  pe7_result;
    wire    [31:0]  pe8_result;
    wire    [31:0]  pe9_result;
    wire    [31:0]  pe10_result;
    wire    [31:0]  pe11_result;
    wire    [31:0]  pe12_result;
    wire    [31:0]  pe13_result;
    wire    [31:0]  pe14_result;
    wire    [31:0]  pe15_result;
    wire    [31:0]  pe16_result;

    wire    [31:0]  rf1_result;
    wire    [31:0]  rf2_result;
    wire    [31:0]  rf3_result;
    wire    [31:0]  rf4_result;
    wire    [31:0]  rf5_result;
    wire    [31:0]  rf6_result;
    wire    [31:0]  rf7_result;
    wire    [31:0]  rf8_result;
    wire    [31:0]  rf9_result;
    wire    [31:0]  rf10_result;
    wire    [31:0]  rf11_result;
    wire    [31:0]  rf12_result;
    wire    [31:0]  rf13_result;
    wire    [31:0]  rf14_result;
    wire    [31:0]  rf15_result;
    wire    [31:0]  rf16_result;

    wire    [31:0]  fu1_result;
    wire    [31:0]  fu2_result;
    wire    [31:0]  fu3_result;
    wire    [31:0]  fu4_result;
    wire    [31:0]  fu5_result;
    wire    [31:0]  fu6_result;
    wire    [31:0]  fu7_result;
    wire    [31:0]  fu8_result;
    wire    [31:0]  fu9_result;
    wire    [31:0]  fu10_result;
    wire    [31:0]  fu11_result;
    wire    [31:0]  fu12_result;
    wire    [31:0]  fu13_result;
    wire    [31:0]  fu14_result;
    wire    [31:0]  fu15_result;
    wire    [31:0]  fu16_result;
    
    wire    [31:0]  lsu1_result;
    wire    [31:0]  lsu2_result;
    wire    [31:0]  lsu3_result;
    wire    [31:0]  lsu4_result;

    wire    [31:0]  data_r1;
    wire    [31:0]  data_r2;
    wire    [31:0]  data_r3;
    wire    [31:0]  data_r4;

    wire    [13:0]  data_ra1;
    wire    [13:0]  data_ra2;
    wire    [13:0]  data_ra3;
    wire    [13:0]  data_ra4;
    
    wire    [31:0]  data_w1;
    wire    [31:0]  data_w2;
    wire    [31:0]  data_w3;
    wire    [31:0]  data_w4;
    
    wire    [13:0]  data_wa1;
    wire    [13:0]  data_wa2;
    wire    [13:0]  data_wa3;
    wire    [13:0]  data_wa4;

    wire    r1_en;
    wire    r2_en;
    wire    r3_en;
    wire    r4_en;

    wire    w1_en;
    wire    w2_en;
    wire    w3_en;
    wire    w4_en;

    assign  pea_result = pe1_result  & pe2_result  & pe3_result  & pe4_result  & 
                         pe5_result  & pe6_result  & pe7_result  & pe8_result  &
                         pe9_result  & pe10_result & pe11_result & pe12_result &
                         pe13_result & pe14_result & pe15_result & pe16_result ;


    config_ctrl conf(
        .rst        (rst),
        .clk        (clk),
        .wr_en      (conf_wr_en),
        .rd_en      (conf_rd_en),
        .wr_addr    (conf_wr_addr),
        .rd_addr    (conf_rd_addr),
        .inst1      (inst1),
        .inst2      (inst2),
        .inst3      (inst3),
        .inst4      (inst4),
        .inst_out1  (inst_out1),
        .inst_out2  (inst_out2),
        .inst_out3  (inst_out3),
        .inst_out4  (inst_out4)
    );

    mem_banks mem(
        .clk                (clk),
        .rst                (rst),
        .read_en1           (r1_en),
        .read_addr1         (data_ra1),
        .read_data1         (data_r1),
        .read_en2           (r2_en),
        .read_addr2         (data_ra2),
        .read_data2         (data_r2),
        .read_en3           (r3_en),
        .read_addr3         (data_ra3),
        .read_data3         (data_r3),
        .read_en4           (r4_en),
        .read_addr4         (data_ra4),
        .read_data4         (data_r4),
        .write_en1          (w1_en),
        .write_addr1        (data_wa1),
        .write_data1        (data_w1),
        .write_en2          (w2_en),
        .write_addr2        (data_wa2),
        .write_data2        (data_w2),
        .write_en3          (w3_en),
        .write_addr3        (data_wa3),
        .write_data3        (data_w3),
        .write_en4          (w4_en),
        .write_addr4        (data_wa4),
        .write_data4        (data_w4)

    );
    lsu lsu1(
        .inst           (isnt_lsu1)  ,
        .clk            (clk)        ,   
        .rst            (rst)        ,
        .pe1            (pe1_result) ,
        .pe2            (pe2_result) ,
        .pe3            (pe3_result) ,
        .pe4            (pe4_result) ,
//  memory access
//*** read data from memory
        .mem_read_en    (r1_en)     ,
        .mem_read_data  (data_r1)   ,
        .mem_read_addr  (data_ra1)  ,
        .lsu_to_pe      (lsu1_result),
//*** write data to memory
        .mem_write_en   (w1_en)     ,
        .mem_wirte_data (data_w1)   ,
        .mem_write_addr (data_wa1)  
    );

    pe_pro pe1(
        .inst    (inst_pe1),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe13_result),
        .pe_down     (pe5_result),
        .pe_left     (pe4_result),
        .pe_right    (pe2_result),
        .pe_rfup     (rf13_result),
        .pe_rfdown   (rf5_result),
        .pe_rfleft   (rf4_result),
        .pe_rfright  (rf2_result),
        .lsu_input   (lsu1_result),
        .fu_result   (fu1_result),
        .rf_res3     (rf1_result),    
        .pe_result   (pe1_result)
    );

    pe_pro pe2(
        .inst    (inst_pe2),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe14_result),
        .pe_down     (pe6_result),
        .pe_left     (pe1_result),
        .pe_right    (pe3_result),
        .pe_rfup     (rf14_result),
        .pe_rfdown   (rf6_result),
        .pe_rfleft   (rf1_result),
        .pe_rfright  (rf3_result),
        .lsu_input   (lsu1_result),
        .fu_result   (fu2_result),
        .rf_res3     (rf2_result),    
        .pe_result   (pe2_result)
    );

    pe_pro pe3(
        .inst    (inst_pe3),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe15_result),
        .pe_down     (pe7_result),
        .pe_left     (pe2_result),
        .pe_right    (pe4_result),
        .pe_rfup     (rf15_result),
        .pe_rfdown   (rf7_result),
        .pe_rfleft   (rf2_result),
        .pe_rfright  (rf4_result),
        .lsu_input   (lsu1_result),
        .fu_result   (fu3_result),
        .rf_res3     (rf3_result),    
        .pe_result   (pe3_result)
    );

    pe_pro pe4(
        .inst    (inst_pe4),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe16_result),
        .pe_down     (pe8_result),
        .pe_left     (pe3_result),
        .pe_right    (pe1_result),
        .pe_rfup     (rf16_result),
        .pe_rfdown   (rf8_result),
        .pe_rfleft   (rf3_result),
        .pe_rfright  (rf1_result),
        .lsu_input   (lsu1_result),
        .fu_result   (fu4_result),
        .rf_res3     (rf4_result),    
        .pe_result   (pe4_result)
    );

    lsu lsu2(
        .inst           (isnt_lsu2)  ,
        .clk            (clk)        ,   
        .rst            (rst)        ,
        .pe1            (pe5_result) ,
        .pe2            (pe6_result) ,
        .pe3            (pe7_result) ,
        .pe4            (pe8_result) ,
//  memory access
//*** read data from memory
        .mem_read_en    (r2_en)     ,
        .mem_read_data  (data_r2)   ,
        .mem_read_addr  (data_ra2)  ,
        .lsu_to_pe      (lsu2_result),
//*** write data to memory
        .mem_write_en   (w2_en)     ,
        .mem_wirte_data (data_w2)   ,
        .mem_write_addr (data_wa2)  
    );

    pe_pro pe5(
        .inst    (inst_pe5),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe1_result),
        .pe_down     (pe9_result),
        .pe_left     (pe8_result),
        .pe_right    (pe6_result),
        .pe_rfup     (rf1_result),
        .pe_rfdown   (rf9_result),
        .pe_rfleft   (rf8_result),
        .pe_rfright  (rf6_result),
        .lsu_input   (lsu2_result),
        .fu_result   (fu5_result),
        .rf_res3     (rf5_result),    
        .pe_result   (pe5_result)
    );

    pe_pro pe6(
        .inst    (inst_pe6),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe2_result),
        .pe_down     (pe10_result),
        .pe_left     (pe5_result),
        .pe_right    (pe7_result),
        .pe_rfup     (rf2_result),
        .pe_rfdown   (rf10_result),
        .pe_rfleft   (rf5_result),
        .pe_rfright  (rf7_result),
        .lsu_input   (lsu2_result),
        .fu_result   (fu6_result),
        .rf_res3     (rf6_result),    
        .pe_result   (pe6_result)
    );

    pe_pro pe7(
        .inst    (inst_pe7),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe3_result),
        .pe_down     (pe11_result),
        .pe_left     (pe6_result),
        .pe_right    (pe8_result),
        .pe_rfup     (rf3_result),
        .pe_rfdown   (rf11_result),
        .pe_rfleft   (rf6_result),
        .pe_rfright  (rf8_result),
        .lsu_input   (lsu2_result),
        .fu_result   (fu7_result),
        .rf_res3     (rf7_result),    
        .pe_result   (pe7_result)
    );

    pe_pro pe8(
        .inst    (inst_pe8),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe4_result),
        .pe_down     (pe12_result),
        .pe_left     (pe7_result),
        .pe_right    (pe5_result),
        .pe_rfup     (rf4_result),
        .pe_rfdown   (rf12_result),
        .pe_rfleft   (rf7_result),
        .pe_rfright  (rf5_result),
        .lsu_input   (lsu2_result),
        .fu_result   (fu8_result),
        .rf_res3     (rf8_result),    
        .pe_result   (pe8_result)
    );

    lsu lsu3(
        .inst           (isnt_lsu3)  ,
        .clk            (clk)        ,   
        .rst            (rst)        ,
        .pe1            (pe9_result) ,
        .pe2            (pe10_result) ,
        .pe3            (pe11_result) ,
        .pe4            (pe12_result) ,
//  memory access
//*** read data from memory
        .mem_read_en    (r3_en)     ,
        .mem_read_data  (data_r3)   ,
        .mem_read_addr  (data_ra3)  ,
        .lsu_to_pe      (lsu3_result),
//*** write data to memory
        .mem_write_en   (w3_en)     ,
        .mem_wirte_data (data_w3)   ,
        .mem_write_addr (data_wa3)  
    );

    pe_pro pe9(
        .inst    (inst_pe9),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe5_result),
        .pe_down     (pe13_result),
        .pe_left     (pe12_result),
        .pe_right    (pe10_result),
        .pe_rfup     (rf5_result),
        .pe_rfdown   (rf13_result),
        .pe_rfleft   (rf12_result),
        .pe_rfright  (rf10_result),
        .lsu_input   (lsu3_result),
        .fu_result   (fu9_result),
        .rf_res3     (rf9_result),    
        .pe_result   (pe9_result)
    );

    pe_pro pe10(
        .inst    (inst_pe10),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe6_result),
        .pe_down     (pe14_result),
        .pe_left     (pe9_result),
        .pe_right    (pe11_result),
        .pe_rfup     (rf6_result),
        .pe_rfdown   (rf14_result),
        .pe_rfleft   (rf9_result),
        .pe_rfright  (rf11_result),
        .lsu_input   (lsu3_result),
        .fu_result   (fu10_result),
        .rf_res3     (rf10_result),    
        .pe_result   (pe10_result)
    );

    pe_pro pe11(
        .inst    (inst_pe11),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe7_result),
        .pe_down     (pe15_result),
        .pe_left     (pe10_result),
        .pe_right    (pe12_result),
        .pe_rfup     (rf7_result),
        .pe_rfdown   (rf15_result),
        .pe_rfleft   (rf10_result),
        .pe_rfright  (rf12_result),
        .lsu_input   (lsu3_result),
        .fu_result   (fu7_result),
        .rf_res3     (rf11_result),    
        .pe_result   (pe11_result)
    );

    pe_pro pe12(
        .inst    (inst_pe12),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe8_result),
        .pe_down     (pe16_result),
        .pe_left     (pe11_result),
        .pe_right    (pe9_result),
        .pe_rfup     (rf8_result),
        .pe_rfdown   (rf16_result),
        .pe_rfleft   (rf11_result),
        .pe_rfright  (rf9_result),
        .lsu_input   (lsu3_result),
        .fu_result   (fu12_result),
        .rf_res3     (rf12_result),    
        .pe_result   (pe12_result)
    );

    lsu lsu4(
        .inst           (isnt_lsu4)  ,
        .clk            (clk)        ,   
        .rst            (rst)        ,
        .pe1            (pe13_result) ,
        .pe2            (pe14_result) ,
        .pe3            (pe15_result) ,
        .pe4            (pe16_result) ,
//  memory access
//*** read data from memory
        .mem_read_en    (r4_en)     ,
        .mem_read_data  (data_r4)   ,
        .mem_read_addr  (data_ra4)  ,
        .lsu_to_pe      (lsu4_result),
//*** write data to memory
        .mem_write_en   (w4_en)     ,
        .mem_wirte_data (data_w4)   ,
        .mem_write_addr (data_wa4)  
    );

    pe_pro pe13(
        .inst    (inst_pe13),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe9_result),
        .pe_down     (pe1_result),
        .pe_left     (pe16_result),
        .pe_right    (pe14_result),
        .pe_rfup     (rf9_result),
        .pe_rfdown   (rf1_result),
        .pe_rfleft   (rf16_result),
        .pe_rfright  (rf14_result),
        .lsu_input   (lsu4_result),
        .fu_result   (fu13_result),
        .rf_res3     (rf13_result),    
        .pe_result   (pe13_result)
    );

    pe_pro pe14(
        .inst    (inst_pe14),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe10_result),
        .pe_down     (pe2_result),
        .pe_left     (pe13_result),
        .pe_right    (pe15_result),
        .pe_rfup     (rf10_result),
        .pe_rfdown   (rf2_result),
        .pe_rfleft   (rf13_result),
        .pe_rfright  (rf15_result),
        .lsu_input   (lsu4_result),
        .fu_result   (fu14_result),
        .rf_res3     (rf14_result),    
        .pe_result   (pe14_result)
    );

    pe_pro pe15(
        .inst    (inst_pe15),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe11_result),
        .pe_down     (pe3_result),
        .pe_left     (pe14_result),
        .pe_right    (pe16_result),
        .pe_rfup     (rf11_result),
        .pe_rfdown   (rf3_result),
        .pe_rfleft   (rf14_result),
        .pe_rfright  (rf16_result),
        .lsu_input   (lsu4_result),
        .fu_result   (fu15_result),
        .rf_res3     (rf15_result),    
        .pe_result   (pe15_result)
    );

    pe_pro pe16(
        .inst    (inst_pe16),
        .clk     (clk),
        .rst     (rst),
        .pe_up       (pe12_result),
        .pe_down     (pe4_result),
        .pe_left     (pe15_result),
        .pe_right    (pe13_result),
        .pe_rfup     (rf12_result),
        .pe_rfdown   (rf4_result),
        .pe_rfleft   (rf15_result),
        .pe_rfright  (rf13_result),
        .lsu_input   (lsu4_result),
        .fu_result   (fu16_result),
        .rf_res3     (rf16_result),    
        .pe_result   (pe16_result)
    );


endmodule
