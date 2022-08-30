`include "../param_define.v"

module PEs_array (
    input   clk     ,
    input   rst     ,
    input   [4:0    ]    run_PE_array   ,
    input   [4:0    ]    init_PE_array   ,
    input   [`PE_inst   -1:0    ]    pe_config ,
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
    
    wire    [31:0]  row_0_0_Nout;
    wire    [31:0]  row_0_1_Nout;
    wire    [31:0]  row_0_2_Nout;

    wire    [31:0]  row_1_0_Nout;
    wire    [31:0]  row_1_1_Nout;
    wire    [31:0]  row_1_2_Nout;

    wire    [31:0]  row_1_0_Sout;
    wire    [31:0]  row_1_1_Sout;
    wire    [31:0]  row_1_2_Sout;

    wire    [31:0]  row_2_0_Nout;
    wire    [31:0]  row_2_1_Nout;
    wire    [31:0]  row_2_2_Nout;

    wire    [31:0]  row_2_0_Sout;
    wire    [31:0]  row_2_1_Sout;
    wire    [31:0]  row_2_2_Sout;

    wire    [31:0]  row_3_0_Nout;
    wire    [31:0]  row_3_1_Nout;
    wire    [31:0]  row_3_2_Nout;

    wire    [31:0]  row_0_0_Sin;
    wire    [31:0]  row_0_1_Sin;
    wire    [31:0]  row_0_2_Sin;
    
    wire    [31:0]  row_0_0_Nin;
    wire    [31:0]  row_0_1_Nin;
    wire    [31:0]  row_0_2_Nin;

    wire    [31:0]  row_1_0_Nin;
    wire    [31:0]  row_1_1_Nin;
    wire    [31:0]  row_1_2_Nin;

    wire    [31:0]  row_1_0_Sin;
    wire    [31:0]  row_1_1_Sin;
    wire    [31:0]  row_1_2_Sin;

    wire    [31:0]  row_2_0_Nin;
    wire    [31:0]  row_2_1_Nin;
    wire    [31:0]  row_2_2_Nin;

    wire    [31:0]  row_2_0_Sin;
    wire    [31:0]  row_2_1_Sin;
    wire    [31:0]  row_2_2_Sin;

    wire    [31:0]  row_3_0_Nin;
    wire    [31:0]  row_3_1_Nin;
    wire    [31:0]  row_3_2_Nin;

    assign    row_0_0_Sin = row_1_0_Nout;
    assign    row_0_1_Sin = row_1_1_Nout;
    assign    row_0_2_Sin = row_1_2_Nout;

    assign    row_1_0_Nin = row_0_0_Sout;
    assign    row_1_1_Nin = row_0_1_Sout;
    assign    row_1_2_Nin = row_0_2_Sout;

    assign    row_1_0_Sin = row_2_0_Nout;
    assign    row_1_1_Sin = row_2_1_Nout;
    assign    row_1_2_Sin = row_2_2_Nout;

    assign    row_2_0_Nin = row_1_0_Sout;
    assign    row_2_1_Nin = row_1_1_Sout;
    assign    row_2_2_Nin = row_1_2_Sout;

    assign    row_2_0_Sin = row_3_0_Nout;
    assign    row_2_1_Sin = row_3_1_Nout;
    assign    row_2_2_Sin = row_3_2_Nout;

    assign    row_3_0_Nin = row_2_0_Sout;
    assign    row_3_1_Nin = row_2_1_Sout;
    assign    row_3_2_Nin = row_2_2_Sout;

    wire    init_row_0,init_row_1,init_row_2,init_row_3;
    wire    [2:0]init_LSU_PE;
    wire    [1:0]init_row_sel;
    assign   {init_row_sel,init_LSU_PE} = init_PE_array;

    assign    {init_row_0,init_row_1,init_row_2,init_row_3} = 4'b1000 >>init_row_sel ;

    wire    run_row_0,run_row_1,run_row_2,run_row_3;
    wire    [2:0]run_LSU_PE;
    wire    [1:0]run_row_sel;
    assign   {run_row_sel,run_LSU_PE} = run_PE_array;
    assign    {run_row_0,run_row_1,run_row_2,run_row_3} = 4'b1000 >>run_row_sel ;

    PE_row pe_row_0(
        .clk                (clk                ),
        .rst                (rst                ),
        .init_en            (init_row_0         ),
        .init_sel           (init_LSU_PE        ),
        .run_en             (run_row_0          ),
        .run_sel            (run_LSU_PE         ),
        .pe_0_Nin           (                   ),
        .pe_1_Nin           (                   ),
        .pe_2_Nin           (                   ),

        .pe_0_Sin           (row_0_0_Sin       ),
        .pe_1_Sin           (row_0_1_Sin       ),
        .pe_2_Sin           (row_0_2_Sin       ),
        .pe_config          (pe_config          ),
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
        .init_en            (init_row_1         ),
        .init_sel           (init_LSU_PE        ),
        .run_en             (run_row_1          ),
        .run_sel            (run_LSU_PE         ),
        .pe_config          (pe_config          ),
        .pe_0_Nin           (row_1_0_Nin       ),
        .pe_1_Nin           (row_1_1_Nin       ),
        .pe_2_Nin           (row_1_2_Nin       ),

        .pe_0_Sin           (row_1_0_Sin       ),
        .pe_1_Sin           (row_1_1_Sin       ),
        .pe_2_Sin           (row_1_2_Sin       ),
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
        .init_en            (init_row_2         ),
        .init_sel           (init_LSU_PE        ),
        .pe_config          (pe_config          ),
        .run_en             (run_row_2          ),
        .run_sel            (run_LSU_PE         ),
        .pe_0_Nin           (row_2_0_Nin       ),
        .pe_1_Nin           (row_2_1_Nin       ),
        .pe_2_Nin           (row_2_2_Nin       ),

        .pe_0_Sin           (row_2_0_Sin       ),
        .pe_1_Sin           (row_2_1_Sin       ),
        .pe_2_Sin           (row_2_2_Sin       ),
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
        .init_en            (init_row_3         ),
        .pe_config          (pe_config          ),
        .init_sel           (init_LSU_PE        ),
        .run_en             (run_row_3          ),
        .run_sel            (run_LSU_PE         ),
        .pe_0_Nin           (row_3_0_Nin       ),
        .pe_1_Nin           (row_3_1_Nin       ),
        .pe_2_Nin           (row_3_2_Nin       ),

        .pe_0_Sin           (                   ),
        .pe_1_Sin           (                   ),
        .pe_2_Sin           (                   ),
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