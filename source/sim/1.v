`include "../param_define.v"
module moduleName (
    
);
    wire   [`PE_I_W -1:0]  PE_0_inst;
    reg    [3:0]           reg_file_sel;
    reg    [4:0]           fu_opcode;
    reg    [11:0]          switch_5x4;
    wire   [23:0]         switch_9x6;

    reg    [3:0]   _9x7_dout_N_sel    ;
    reg    [3:0]   _9x7_dout_S_sel    ;
    reg    [3:0]   _9x7_dout_W_sel    ;
    reg    [3:0]   _9x7_dout_E_sel    ;
    reg    [3:0]   _9x7_dout_LSU_sel  ;
    reg    [3:0]   _9x7_op_A_sel      ;
    reg    [3:0]   _9x7_op_B_sel      ;
    
    always @(*) begin
        switch_5x4   = 12'b1100_0000;//LSU进入N->R0
        reg_file_sel = 4'b1000;
        _9x7_dout_N_sel     = 'd0;  
        _9x7_dout_S_sel     = 'd8; 
        _9x7_dout_W_sel     = 'd0;
        _9x7_dout_E_sel     = 'd7;
        _9x7_dout_LSU_sel   = 'd0;
        _9x7_op_A_sel       = 'd4;
        _9x7_op_B_sel       = 'd7;
    end

    
    
    assign switch_9x6 =  {
        _9x7_dout_LSU_sel,   //27:24
        _9x7_op_A_sel,       //23:20
        _9x7_op_B_sel,       //19:16
        _9x7_dout_N_sel,     //15:12
        _9x7_dout_S_sel,     //11:8
        _9x7_dout_W_sel,     //7:4
        _9x7_dout_E_sel      //3:0
    } ;


    

endmodule