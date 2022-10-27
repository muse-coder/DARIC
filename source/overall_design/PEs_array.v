`include "../param_define.v"

module PEs_array (
    input   clk     ,
    input   rst     ,
    input   run     ,
    input   [12:0    ]                init_PE_array   ,
    input   [`PE_inst   -1:0    ]    PE_config       ,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_0,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_1,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_2,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_3,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_4,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_5,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_6,
    input   [`C_L_bus   -1:0    ]    CBG_to_LSU_bus_7,

    output  [`R_Q   -1          :0]  R_request_0,
    output  [`R_Q   -1          :0]  R_request_1,
    output  [`R_Q   -1          :0]  R_request_2,
    output  [`R_Q   -1          :0]  R_request_3,
    output  [`R_Q   -1          :0]  R_request_4,
    output  [`R_Q   -1          :0]  R_request_5,
    output  [`R_Q   -1          :0]  R_request_6,
    output  [`R_Q   -1          :0]  R_request_7,

    output  [`W_Q   -1          :0]  W_request_0, 
    output  [`W_Q   -1          :0]  W_request_1, 
    output  [`W_Q   -1          :0]  W_request_2, 
    output  [`W_Q   -1          :0]  W_request_3, 
    output  [`W_Q   -1          :0]  W_request_4, 
    output  [`W_Q   -1          :0]  W_request_5, 
    output  [`W_Q   -1          :0]  W_request_6, 
    output  [`W_Q   -1          :0]  W_request_7, 
    
    output  [`A_bus -1          :0]  LSU_addr_bus_0, 
    output  [`A_bus -1          :0]  LSU_addr_bus_1, 
    output  [`A_bus -1          :0]  LSU_addr_bus_2, 
    output  [`A_bus -1          :0]  LSU_addr_bus_3,
    output  [`A_bus -1          :0]  LSU_addr_bus_4, 
    output  [`A_bus -1          :0]  LSU_addr_bus_5, 
    output  [`A_bus -1          :0]  LSU_addr_bus_6, 
    output  [`A_bus -1          :0]  LSU_addr_bus_7
);
    // row 0
    wire    [31:0]  row_0_0_Sout;
    wire    [31:0]  row_0_1_Sout;
    wire    [31:0]  row_0_2_Sout;
    wire    [31:0]  row_0_3_Sout;
    
    wire    [31:0]  row_0_0_Nin;
    wire    [31:0]  row_0_1_Nin;
    wire    [31:0]  row_0_2_Nin;
    wire    [31:0]  row_0_3_Nin;

    wire    [31:0]  row_0_0_Nout;
    wire    [31:0]  row_0_1_Nout;
    wire    [31:0]  row_0_2_Nout;
    wire    [31:0]  row_0_3_Nout;

    wire    [31:0]  row_0_0_Sin;
    wire    [31:0]  row_0_1_Sin;
    wire    [31:0]  row_0_2_Sin;
    wire    [31:0]  row_0_3_Sin;
    // row 1
    wire    [31:0]  row_1_0_Nout;
    wire    [31:0]  row_1_1_Nout;
    wire    [31:0]  row_1_2_Nout;
    wire    [31:0]  row_1_3_Nout;

    wire    [31:0]  row_1_0_Sout;
    wire    [31:0]  row_1_1_Sout;
    wire    [31:0]  row_1_2_Sout;
    wire    [31:0]  row_1_3_Sout;

    wire    [31:0]  row_1_0_Nin;
    wire    [31:0]  row_1_1_Nin;
    wire    [31:0]  row_1_2_Nin;
    wire    [31:0]  row_1_3_Nin;

    wire    [31:0]  row_1_0_Sin;
    wire    [31:0]  row_1_1_Sin;
    wire    [31:0]  row_1_2_Sin;
    wire    [31:0]  row_1_3_Sin;
    // row 2
    wire    [31:0]  row_2_0_Nin;
    wire    [31:0]  row_2_1_Nin;
    wire    [31:0]  row_2_2_Nin;
    wire    [31:0]  row_2_3_Nin;

    wire    [31:0]  row_2_0_Nout;
    wire    [31:0]  row_2_1_Nout;
    wire    [31:0]  row_2_2_Nout;
    wire    [31:0]  row_2_3_Nout;

    wire    [31:0]  row_2_0_Sout;
    wire    [31:0]  row_2_1_Sout;
    wire    [31:0]  row_2_2_Sout;
    wire    [31:0]  row_2_3_Sout;

    wire    [31:0]  row_2_0_Sin;
    wire    [31:0]  row_2_1_Sin;
    wire    [31:0]  row_2_2_Sin;
    wire    [31:0]  row_2_3_Sin;
    //row 3
    wire    [31:0]  row_3_0_Nout;
    wire    [31:0]  row_3_1_Nout;
    wire    [31:0]  row_3_2_Nout;
    wire    [31:0]  row_3_3_Nout;
    
    wire    [31:0]  row_3_0_Nin;
    wire    [31:0]  row_3_1_Nin;
    wire    [31:0]  row_3_2_Nin;
    wire    [31:0]  row_3_3_Nin;
//-----------end--------------//
//--------------interconnect--------------// 
    assign    row_0_0_Sin = row_1_0_Nout;
    assign    row_0_1_Sin = row_1_1_Nout;
    assign    row_0_2_Sin = row_1_2_Nout;
    assign    row_0_3_Sin = row_1_3_Nout;

    assign    row_1_0_Nin = row_0_0_Sout;
    assign    row_1_1_Nin = row_0_1_Sout;
    assign    row_1_2_Nin = row_0_2_Sout;
    assign    row_1_3_Nin = row_0_3_Sout;

    assign    row_1_0_Sin = row_2_0_Nout;
    assign    row_1_1_Sin = row_2_1_Nout;
    assign    row_1_2_Sin = row_2_2_Nout;
    assign    row_1_3_Sin = row_2_3_Nout;

    assign    row_2_0_Nin = row_1_0_Sout;
    assign    row_2_1_Nin = row_1_1_Sout;
    assign    row_2_2_Nin = row_1_2_Sout;
    assign    row_2_3_Nin = row_1_3_Sout;

    assign    row_2_0_Sin = row_3_0_Nout;
    assign    row_2_1_Sin = row_3_1_Nout;
    assign    row_2_2_Sin = row_3_2_Nout;
    assign    row_2_3_Sin = row_3_3_Nout;

    assign    row_3_0_Nin = row_2_0_Sout;
    assign    row_3_1_Nin = row_2_1_Sout;
    assign    row_3_2_Nin = row_2_2_Sout;
    assign    row_3_3_Nin = row_2_3_Sout;

    wire    init_row_0,init_row_1,init_row_2,init_row_3;
    wire    [4:0]init_LSU_PE;
    wire    [3:0]init_row_sel;
    wire    init_lsu_4,init_lsu_5,init_lsu_6,init_lsu_7;
    assign   {init_lsu_4,init_lsu_5,init_lsu_6,init_lsu_7,init_row_sel,init_LSU_PE} = init_PE_array;
    
    assign    {init_row_0,init_row_1,init_row_2,init_row_3} = init_row_sel ;
    wire    [`L_I_W  -1:0]  LSU_inst;
    assign  LSU_inst = PE_config [`L_I_W  -1:0];
    LSU LSU_4(
        .clk            (clk                      ),
        .rst            (rst                      ),
        .LSU_inst       (LSU_inst                 ),
        .init           (init_lsu_4               ),
        .run            (run                      ),
        .PE_in          (row_0_0_Nout             ),
        .CBG_to_LSU_bus (CBG_to_LSU_bus_4         ),
        .LSU_to_PE      (row_0_0_Nin              ),
        .R_request      (R_request_4              ),
        .W_request      (W_request_4              ), 
        .LSU_addr_bus   (LSU_addr_bus_4           ) 
    );

    LSU LSU_5(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .LSU_inst       (LSU_inst               ),
        .init           (init_lsu_5             ),
        .run            (run                    ),
        .PE_in          (row_0_1_Nout           ),
        .CBG_to_LSU_bus (CBG_to_LSU_bus_5       ),
        .LSU_to_PE      (row_0_1_Nin            ),
        .R_request      (R_request_5            ),
        .W_request      (W_request_5            ), 
        .LSU_addr_bus   (LSU_addr_bus_5         ) 
    );

    LSU LSU_6(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .LSU_inst       (LSU_inst               ),
        .init           (init_lsu_6             ),
        .run            (run                    ),
        .PE_in          (row_0_2_Nout           ),
        .CBG_to_LSU_bus (CBG_to_LSU_bus_6       ),
        .LSU_to_PE      (row_0_2_Nin            ),
        .R_request      (R_request_6            ),
        .W_request      (W_request_6            ), 
        .LSU_addr_bus   (LSU_addr_bus_6         ) 
    );
    
    LSU LSU_7(
        .clk            (clk                    ),
        .rst            (rst                    ),
        .LSU_inst       (LSU_inst               ),
        .init           (init_lsu_7             ),
        .run            (run                    ),
        .PE_in          (row_0_3_Nout           ),
        .CBG_to_LSU_bus (CBG_to_LSU_bus_7       ),
        .LSU_to_PE      (row_0_3_Nin            ),
        .R_request      (R_request_7            ),
        .W_request      (W_request_7            ), 
        .LSU_addr_bus   (LSU_addr_bus_7         ) 
    );

    PE_row_1_2  pe_row_0(
    .clk                (clk                ),
    .rst                (rst                ),
    .init_en            (init_row_0         ),
    .run                (run                ),
    .CBG_to_LSU_bus     (CBG_to_LSU_bus_0   ),
    .PE_config          (PE_config          ),
    .init_sel           (init_LSU_PE        ),
    
    .PE_0_Nin           (row_0_0_Nin        ),
    .PE_1_Nin           (row_0_1_Nin        ),
    .PE_2_Nin           (row_0_2_Nin        ),       
    .PE_3_Nin           (row_0_3_Nin        ),

    .PE_0_Sin           (row_0_0_Sin        ),
    .PE_1_Sin           (row_0_1_Sin        ),
    .PE_2_Sin           (row_0_2_Sin        ),       
    .PE_3_Sin           (row_0_3_Sin        ),
    
    .PE_0_Nout          (row_0_0_Nout       ),
    .PE_1_Nout          (row_0_1_Nout       ),
    .PE_2_Nout          (row_0_2_Nout       ),
    .PE_3_Nout          (row_0_3_Nout       ),
    
    .PE_0_Sout          (row_0_0_Sout       ),
    .PE_1_Sout          (row_0_1_Sout       ),
    .PE_2_Sout          (row_0_2_Sout       ),
    .PE_3_Sout          (row_0_3_Sout       ),

    .R_request          (R_request_0        ),
    .W_request          (W_request_0        ),
    .LSU_addr_bus       (LSU_addr_bus_0     )
    );

    PE_row_1_2  pe_row_1 (
    .clk                (clk                ),
    .rst                (rst                ),
    .init_en            (init_row_1         ),
    .run                (run                ),
    .CBG_to_LSU_bus     (CBG_to_LSU_bus_1   ),
    .PE_config          (PE_config          ),
    .init_sel           (init_LSU_PE        ),
    
    .PE_0_Nin           (row_1_0_Nin        ),
    .PE_1_Nin           (row_1_1_Nin        ),
    .PE_2_Nin           (row_1_2_Nin        ),       
    .PE_3_Nin           (row_1_3_Nin        ),

    .PE_0_Sin           (row_1_0_Sin        ),
    .PE_1_Sin           (row_1_1_Sin        ),
    .PE_2_Sin           (row_1_2_Sin        ),       
    .PE_3_Sin           (row_1_3_Sin        ),
    
    .PE_0_Nout          (row_1_0_Nout       ),
    .PE_1_Nout          (row_1_1_Nout       ),
    .PE_2_Nout          (row_1_2_Nout       ),
    .PE_3_Nout          (row_1_3_Nout       ),
    
    .PE_0_Sout          (row_1_0_Sout       ),
    .PE_1_Sout          (row_1_1_Sout       ),
    .PE_2_Sout          (row_1_2_Sout       ),
    .PE_3_Sout          (row_1_3_Sout       ),

    .R_request          (R_request_1        ),
    .W_request          (W_request_1        ),
    .LSU_addr_bus       (LSU_addr_bus_1     )
    );
    
    PE_row_1_2  pe_row_2 (
    .clk                (clk                ),
    .rst                (rst                ),
    .init_en            (init_row_2         ),
    .run                (run                ),
    .CBG_to_LSU_bus     (CBG_to_LSU_bus_2   ),
    .PE_config          (PE_config          ),
    .init_sel           (init_LSU_PE        ),
    
    .PE_0_Nin           (row_2_0_Nin        ),
    .PE_1_Nin           (row_2_1_Nin        ),
    .PE_2_Nin           (row_2_2_Nin        ),       
    .PE_3_Nin           (row_2_3_Nin        ),

    .PE_0_Sin           (row_2_0_Sin        ),
    .PE_1_Sin           (row_2_1_Sin        ),
    .PE_2_Sin           (row_2_2_Sin        ),       
    .PE_3_Sin           (row_2_3_Sin        ),
    
    .PE_0_Nout          (row_2_0_Nout       ),
    .PE_1_Nout          (row_2_1_Nout       ),
    .PE_2_Nout          (row_2_2_Nout       ),
    .PE_3_Nout          (row_2_3_Nout       ),
    
    .PE_0_Sout          (row_2_0_Sout       ),
    .PE_1_Sout          (row_2_1_Sout       ),
    .PE_2_Sout          (row_2_2_Sout       ),
    .PE_3_Sout          (row_2_3_Sout       ),

    .R_request          (R_request_2        ),
    .W_request          (W_request_2        ),
    .LSU_addr_bus       (LSU_addr_bus_2     )
    );

    PE_row_3    pe_row_3(
    .clk                (clk                ),
    .rst                (rst                ),
    .init_en            (init_row_3         ),
    .run                (run                ),
    .PE_config          (PE_config          ), 
    .CBG_to_LSU_bus     (CBG_to_LSU_bus_3   ),
    .init_sel           (init_LSU_PE        ),
    .PE_0_Nin           (row_3_0_Nin        ),
    .PE_1_Nin           (row_3_1_Nin        ),
    .PE_2_Nin           (row_3_2_Nin        ),
    .PE_3_Nin           (row_3_3_Nin        ),
        
    .PE_0_Nout          (row_3_0_Nout        ),
    .PE_1_Nout          (row_3_1_Nout        ),
    .PE_2_Nout          (row_3_2_Nout        ),

    .PE_3_Nout          (row_3_3_Nout        ),

    .R_request          (R_request_3        ),
    .W_request          (W_request_3        ), 
    .LSU_addr_bus       (LSU_addr_bus_3     )
);

endmodule