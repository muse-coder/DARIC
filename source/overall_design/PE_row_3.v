`timescale 1ns / 1ps
`include "../param_define.v"

module PE_row_3(
    input   clk,
    input   rst,
    input   init_en,
    input   run,
    input   [`PE_inst   -1:     0]  PE_config ,
    input   [`C_L_bus   -1:     0]  CBG_to_LSU_bus,
    input   [ 4:                0]  init_sel,
    input   [31:                0]  PE_0_Nin,
    input   [31:                0]  PE_1_Nin,
    input   [31:                0]  PE_2_Nin,
    input   [31:                0]  PE_3_Nin,
        
        
    output  [31:                0]  PE_0_Nout,
    output  [31:                0]  PE_1_Nout,
    output  [31:                0]  PE_2_Nout,
    output  [31:                0]  PE_3_Nout,

    output  [`R_Q   -1          :0]  R_request,
    output  [`W_Q   -1          :0]  W_request, 
    output  [`A_bus -1          :0]  LSU_addr_bus
);
    
    wire    [31:0]  PE_0_Win ;
    wire    [31:0]  PE_0_Ein ;        
    wire    [31:0]  PE_1_Win ;
    wire    [31:0]  PE_1_Ein ;        
    wire    [31:0]  PE_2_Win ;
    wire    [31:0]  PE_2_Ein ;
    wire    [31:0]  PE_3_Win ;
    
    wire    [31:0]  PE_0_Wout ;
    wire    [31:0]  PE_0_Eout ;        
    wire    [31:0]  PE_1_Wout ;
    wire    [31:0]  PE_1_Eout ;        
    wire    [31:0]  PE_2_Wout ;
    wire    [31:0]  PE_2_Eout ;
    wire    [31:0]  PE_3_Wout ;

    wire    [31:0]  LSU_to_PE;
    
    assign  PE_0_Ein = PE_1_Wout;
    assign  PE_0_Win = LSU_to_PE;

    assign  PE_1_Ein = PE_2_Wout;        
    assign  PE_1_Win = PE_0_Eout;

    assign  PE_2_Ein = PE_3_Wout;        
    assign  PE_2_Win = PE_1_Eout;
    
    assign  PE_3_Win = PE_2_Eout;
 

    wire    [`L_I_W  -1:0]  LSU_inst;
    wire    init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3;    
    assign  {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3} = init_sel ;
    
    assign  LSU_inst = PE_config [`L_I_W  -1:0] ;
    assign  result  = LSU_to_PE ;
    LSU LSU(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .LSU_inst       (LSU_inst               ),
        .init           (init_LSU & init_en     ),
        .run            (run                    ),
        .PE_in          (PE_0_Wout              ),
        .CBG_to_LSU_bus (CBG_to_LSU_bus         ),
        .LSU_to_PE      (LSU_to_PE              ),
        .R_request      (R_request              ),
        .W_request      (W_request              ), 
        .LSU_addr_bus   (LSU_addr_bus           ) 
    );


    PE_E  PE_0(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (PE_config              ),
        .init           (init_PE_0 & init_en    ),
        .run            (run                    ),
        .din_N          (PE_0_Nin               ),//上
        .din_W          (PE_0_Win               ),//左
        .din_E          (PE_0_Ein               ),//右
        .dout_N         (PE_0_Nout              ),
        .dout_W         (PE_0_Wout              ),
        .dout_E         (PE_0_Eout              )
        );

    PE_E  PE_1(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (PE_config              ),
        .init           (init_PE_1 & init_en    ),
        .run            (run                    ),
        .din_N          (PE_1_Nin               ),//上
        .din_W          (PE_1_Win               ),//左
        .din_E          (PE_1_Ein               ),//右
        .dout_N         (PE_1_Nout              ),
        .dout_W         (PE_1_Wout              ),
        .dout_E         (PE_1_Eout              )
        );


    PE_E  PE_2(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (PE_config              ),
        .init           (init_PE_2 & init_en    ),
        .run            (run                    ),
        .din_N          (PE_2_Nin               ),//上
        .din_W          (PE_2_Win               ),//左
        .din_E          (PE_2_Ein               ),//右
        .dout_N         (PE_2_Nout              ),
        .dout_W         (PE_2_Wout              ),
        .dout_E         (PE_2_Eout              )
        );
    

    PE_F  PE_3(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .PE_inst        (PE_config              ),
        .init           (init_PE_3 & init_en    ),
        .run            (run                    ),
        .din_N          (PE_3_Nin               ),//上
        .din_W          (PE_3_Win               ),//左
        .dout_N         (PE_3_Nout              ),
        .dout_W         (PE_3_Wout              )
        );

endmodule