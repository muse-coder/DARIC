`include "../param_define.v"

module PEs_array (
    input   clk     ,
    input   rst     ,
    input   init    ,
    input   run     ,
    input   [`Array     -1:0    ]    pe_config ,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_0,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_1,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_2,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_3,

    output  [`R_Q   -1          :0]  R_request_0,
    output  [`R_Q   -1          :0]  R_request_1,
    output  [`R_Q   -1          :0]  R_request_2,
    output  [`R_Q   -1          :0]  R_request_3,

    output  [`W_Q   -1          :0]  W_request_0, 
    output  [`W_Q   -1          :0]  W_request_1, 
    output  [`W_Q   -1          :0]  W_request_2, 
    output  [`W_Q   -1          :0]  W_request_3, 
    
    output  [`A_bus -1          :0]  LSU_addr_bus_0, 
    output  [`A_bus -1          :0]  LSU_addr_bus_1, 
    output  [`A_bus -1          :0]  LSU_addr_bus_2, 
    output  [`A_bus -1          :0]  LSU_addr_bus_3
);
    wire    [31:0]  row_0_0_Sout;
    wire    [31:0]  row_0_1_Sout;
    wire    [31:0]  row_0_2_Sout;
    
    wire    [31:0]  row_1_0_Nout;
    wire    [31:0]  row_1_1_Nout;
    wire    [31:0]  row_1_2_Nout;

    wire    [31:0]  row_1_0_Sout;
    wire    [31:0]  row_1_1_Sout;
    wire    [31:0]  row_1_2_Sout;

    wire    [31:0]  row_2_0_Nout;
    wire    [31:0]  row_2_1_Nout;
    wire    [31:0]  row_2_2_Nout;

    wire    [31:0]  row_3_0_Nout;
    wire    [31:0]  row_3_1_Nout;
    wire    [31:0]  row_3_2_Nout;


    wire    [`Config_W-1:0]  config_buffer_0;
    wire    [`Config_W-1:0]  config_buffer_1;
    wire    [`Config_W-1:0]  config_buffer_2;
    wire    [`Config_W-1:0]  config_buffer_3;
  
    assign  {
        config_buffer_3,
        config_buffer_2,
        config_buffer_1,
        config_buffer_0
    }   =   pe_config;
    PE_row pe_row_0(
        .clk                (clk                ),
        .rst                (rst                ),
        .init               (init               ),
        .run                (run                ),
        .pe_0_Nin           (                   ),
        .pe_1_Nin           (                   ),
        .pe_2_Nin           (                   ),

        .pe_0_Sin           (row_1_0_Nout       ),
        .pe_1_Sin           (row_1_1_Nout       ),
        .pe_2_Sin           (row_1_2_Nout       ),

        .config_buffer      (config_buffer_0    ),
        .CBG_to_LSU_bus     (CBG_to_LSU_bus_0   ),
    
        .PE_0_Nout          (                   ),
        .PE_1_Nout          (                   ),
        .PE_2_Nout          (                   ),

        .PE_0_Sout          (row_0_0_Sout       ),
        .PE_1_Sout          (row_0_1_Sout       ),
        .PE_2_Sout          (row_0_2_Sout       ),
        .R_request          (R_request_0        ),
        .W_request          (W_request_0        ), 
        .LSU_addr_bus       (LSU_addr_bus_0     )
    );

    PE_row pe_row_1(
        .clk                (clk                ),
        .rst                (rst                ),
        .init               (init               ),
        .run                (run                ),
        .pe_0_Nin           (row_0_0_Sout       ),
        .pe_1_Nin           (row_0_1_Sout       ),
        .pe_2_Nin           (row_0_2_Sout       ),

        .pe_0_Sin           (row_2_0_Nout       ),
        .pe_1_Sin           (row_2_1_Nout       ),
        .pe_2_Sin           (row_2_2_Nout       ),

        .config_buffer      (config_buffer_1    ),
        .CBG_to_LSU_bus     (CBG_to_LSU_bus_1   ),
    
        .PE_0_Nout          (row_1_0_Nout       ),
        .PE_1_Nout          (row_1_1_Nout       ),
        .PE_2_Nout          (row_1_2_Nout       ),

        .PE_0_Sout          (row_1_0_Sout       ),
        .PE_1_Sout          (row_1_1_Sout       ),
        .PE_2_Sout          (row_1_2_Sout       ),
        .R_request          (R_request_1        ),
        .W_request          (W_request_1        ), 
        .LSU_addr_bus       (LSU_addr_bus_1     )
    );
    
    PE_row pe_row_2(
        .clk                (clk                ),
        .rst                (rst                ),
        .init               (init               ),
        .run                (run                ),
        .pe_0_Nin           (row_1_0_Sout       ),
        .pe_1_Nin           (row_1_1_Sout       ),
        .pe_2_Nin           (row_1_2_Sout       ),

        .pe_0_Sin           (row_3_0_Nout       ),
        .pe_1_Sin           (row_3_1_Nout       ),
        .pe_2_Sin           (row_3_2_Nout       ),

        .config_buffer      (config_buffer_2    ),
        .CBG_to_LSU_bus     (CBG_to_LSU_bus_2   ),
    
        .PE_0_Nout          (row_2_0_Nout       ),
        .PE_1_Nout          (row_2_1_Nout       ),
        .PE_2_Nout          (row_2_2_Nout       ),

        .PE_0_Sout          (row_2_0_Sout       ),
        .PE_1_Sout          (row_2_1_Sout       ),
        .PE_2_Sout          (row_2_2_Sout       ),
        .R_request          (R_request_2        ),
        .W_request          (W_request_2        ), 
        .LSU_addr_bus       (LSU_addr_bus_2     )
    );

    PE_row pe_row_3(
        .clk                (clk                ),
        .rst                (rst                ),
        .init               (init               ),
        .run                (run                ),
        .pe_0_Nin           (row_2_0_Sout       ),
        .pe_1_Nin           (row_2_1_Sout       ),
        .pe_2_Nin           (row_2_2_Sout       ),

        .pe_0_Sin           (                   ),
        .pe_1_Sin           (                   ),
        .pe_2_Sin           (                   ),

        .config_buffer      (config_buffer_3    ),
        .CBG_to_LSU_bus     (CBG_to_LSU_bus_3   ),
    
        .PE_0_Nout          (row_3_0_Nout       ),
        .PE_1_Nout          (row_3_1_Nout       ),
        .PE_2_Nout          (row_3_2_Nout       ),

        .PE_0_Sout          (                   ),
        .PE_1_Sout          (                   ),
        .PE_2_Sout          (                   ),
        .R_request          (R_request_3        ),
        .W_request          (W_request_3        ), 
        .LSU_addr_bus       (LSU_addr_bus_3     )
    );

endmodule