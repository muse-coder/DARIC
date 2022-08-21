`include "../param_define.v"
`timescale 1ns / 1ps
module Host_Controller (
    input   clk,
    input   rst,
    input       [`H_C_W -1  :0]     Host_Config   ,
    output      [`SPM_INST-1:0]     SPM_inst      ,
    output	    [`EX_bus-1  :0]	    ex_bus        ,
    output      [`L_I_W-1   :0]     LSU_0_inst    , 
    output      [`L_I_W-1   :0]     LSU_1_inst    , 
    output      [`L_I_W-1   :0]     LSU_2_inst    ,
    output      [`L_I_W-1   :0]     LSU_3_inst    
);
    assign {
        SPM_inst    ,
        ex_bus      ,
        LSU_3_inst  ,
        LSU_2_inst  ,
        LSU_1_inst  ,
        LSU_0_inst  
    } = Host_Config;


endmodule