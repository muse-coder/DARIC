`timescale 1ns / 1ps
`include "../param_define.v"

module PE_row (
    input   clk,
    input   rst,
    input   init_en,
    input   run_en,
    input   [2 :                0]  run_sel,
    input   [2 :                0]  init_sel,
    input   [31:                0]  pe_0_Nin,
    input   [31:                0]  pe_1_Nin,
    input   [31:                0]  pe_2_Nin,
    
    input   [31:                0]  pe_0_Sin,
    input   [31:                0]  pe_1_Sin,
    input   [31:                0]  pe_2_Sin,       
    input   [`PE_inst   -1:     0]  pe_config ,
    input   [`C_L_bus   -1:     0]  CBG_to_LSU_bus,
        
    output  [31:                0]  PE_0_Nout,
    output  [31:                0]  PE_1_Nout,
    output  [31:                0]  PE_2_Nout,

    output  [31:                0]  PE_0_Sout,
    output  [31:                0]  PE_1_Sout,
    output  [31:                0]  PE_2_Sout,

    output  [`R_Q   -1          :0]  R_request,
    output  [`W_Q   -1          :0]  W_request, 
    output  [`A_bus -1          :0]  LSU_addr_bus,
    output  [31:                 0]  result
);
//-----------------end-------------------//
    wire    [31:0]  PE_0_Win;
    wire    [31:0]  PE_0_Ein;

    wire    [31:0]  PE_1_Win;
    wire    [31:0]  PE_1_Ein;
    
    wire    [31:0]  PE_2_Win;
    wire    [31:0]  PE_2_Ein;

    wire    [31:0]  PE_3_Win;
    wire    [31:0]  PE_3_Ein;
    
    wire    [31:0]  PE_0_Wout;
    wire    [31:0]  PE_0_Eout;
    wire    [31:0]  PE_0_Lout;
    
    wire    [31:0]  PE_1_Wout;
    wire    [31:0]  PE_1_Eout;
    wire    [31:0]  PE_1_Lout;

    wire    [31:0]  PE_2_Wout;
    wire    [31:0]  PE_2_Eout;
    wire    [31:0]  PE_2_Lout;

    wire    [31:0]  PE_3_Wout;
    wire    [31:0]  PE_3_Eout;
    wire    [31:0]  PE_3_Lout;

//--------------------end---------------//
    wire    [31:0]  lsu_to_pe;

    wire    [`L_I_W  -1:0]  LSU_inst;
    
    wire    init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3;    
    wire    run_LSU,run_PE_0,run_PE_1,run_PE_2,run_PE_3;    
    assign  {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3} = 5'b10000 >> init_sel ;
    assign  {run_LSU,run_PE_0,run_PE_1,run_PE_2,run_PE_3} = 5'b10000 >> run_sel ;
    
    assign  LSU_inst = pe_config [`L_I_W  -1:0] ;
    assign  result  = lsu_to_pe ;
    LSU lsu(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .LSU_inst       (LSU_inst               ),
        .init           (init_LSU & init_en     ),
        .run            (run_LSU  & run_en      ),
        .PE_0           (PE_0_Lout              ),
        .PE_1           (PE_1_Lout              ),
        .PE_2           (PE_2_Lout              ),
        .PE_3           (PE_3_Lout              ),
        .CBG_to_LSU_bus (CBG_to_LSU_bus         ),
        .LSU_to_PE      (lsu_to_pe              ),
        .R_request      (R_request              ),
        .W_request      (W_request              ), 
        .LSU_addr_bus   (LSU_addr_bus           ) 
    );

        


    PE  pe_0(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (pe_config              ),
        .init           (init_PE_0 & init_en    ),
        .run            (run_PE_0  & run_en     ),
        .din_N          (pe_0_Nin               ),//上
        .din_S          (pe_0_Sin               ),//下
        .din_W          (                       ),//左
        .din_E          (PE_1_Wout              ),//右
        .din_LSU        (lsu_to_pe              ),
        .dout_N         (PE_0_Nout              ),
        .dout_S         (PE_0_Sout              ),
        .dout_W         (PE_0_Wout              ),
        .dout_E         (PE_0_Eout              ),
        .dout_LSU       (PE_0_Lout              ) 
        );

    PE  pe_1(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (pe_config              ),
        .init           (init_PE_1 & init_en    ),
        .run            (run_PE_1  & run_en      ),
        .din_N          (pe_1_Nin               ),//上
        .din_S          (pe_1_Sin               ),//下
        .din_W          (PE_0_Eout              ),//左
        .din_E          (PE_2_Wout              ),//右
        .din_LSU        (lsu_to_pe              ),
        .dout_N         (PE_1_Nout              ),
        .dout_S         (PE_1_Sout              ),
        .dout_W         (PE_1_Wout              ),
        .dout_E         (PE_1_Eout              ),
        .dout_LSU       (PE_1_Lout              ) 
        );

    PE  pe_2(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (pe_config              ),
        .init           (init_PE_2 & init_en    ),
        .run            (run_PE_2  & run_en    ),
        .din_N          (pe_2_Nin               ),//上
        .din_S          (pe_2_Sin               ),//下
        .din_W          (PE_1_Eout              ),//左
        .din_E          (PE_3_Wout              ),//右
        .din_LSU        (lsu_to_pe              ),
        .dout_N         (PE_2_Nout              ),
        .dout_S         (PE_2_Sout              ),
        .dout_W         (PE_2_Wout              ),
        .dout_E         (PE_2_Eout              ),
        .dout_LSU       (PE_2_Lout              ) 
        );

    PE  pe_3(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (pe_config              ),
        .init           (init_PE_3 & init_en    ),
        .run            (run_PE_3  & run_en     ),
        .din_N          (                       ),//上
        .din_S          (                       ),//下
        .din_W          (PE_2_Eout              ),//左
        .din_E          (                       ),//右
        .din_LSU        (lsu_to_pe              ),
        .dout_N         (                       ),
        .dout_S         (                       ),
        .dout_W         (PE_3_Wout              ),
        .dout_E         (                       ),
        .dout_LSU       (PE_3_Lout              ) 
        );


endmodule