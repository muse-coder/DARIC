`include "../param_define.v"
`timescale 1ns / 1ps
module Host_Controller (
    input   clk,
    input   rst,
    input       [`H_C_W -1  :0]     Host_Config   ,
    output      [`SPM_INST-1:0]     SPM_inst ,
    output	    [`EX_bus-1  :0]	    ex_bus   ,
    output      [`L_I_W-1   :0]     LSU_inst 
);
    assign {
        SPM_inst ,
        ex_bus   ,
        LSU_inst 
    } = Host_Config;


endmodule