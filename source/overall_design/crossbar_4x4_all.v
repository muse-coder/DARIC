`include "../param_define.v"
module crossbar_4x4_all (
    input    [`R_Q    -1:0]  LSU_R_req_3,
    input    [`R_Q    -1:0]  LSU_R_req_2,
    input    [`R_Q    -1:0]  LSU_R_req_1,
    input    [`R_Q    -1:0]  LSU_R_req_0,

    input    [`A_bus    -1:0]  LSU_addr_bus_3,
    input    [`A_bus    -1:0]  LSU_addr_bus_2,
    input    [`A_bus    -1:0]  LSU_addr_bus_1,
    input    [`A_bus    -1:0]  LSU_addr_bus_0,

    input    [`W_Q    -1:0]  LSU_W_req_3,
    input    [`W_Q    -1:0]  LSU_W_req_2,
    input    [`W_Q    -1:0]  LSU_W_req_1,
    input    [`W_Q    -1:0]  LSU_W_req_0,


    input    [`C_L_bus-1:0]  R_response_3, 
    input    [`C_L_bus-1:0]  R_response_2,
    input    [`C_L_bus-1:0]  R_response_1,
    input    [`C_L_bus-1:0]  R_response_0,

    output   [`C_L_bus-1:0]  to_LSU_3, 
    output   [`C_L_bus-1:0]  to_LSU_2,
    output   [`C_L_bus-1:0]  to_LSU_1,
    output   [`C_L_bus-1:0]  to_LSU_0,  

    output  [`L_C_bus-1:0]  L_to_C_bus_3,
    output  [`L_C_bus-1:0]  L_to_C_bus_2,
    output  [`L_C_bus-1:0]  L_to_C_bus_1,
    output  [`L_C_bus-1:0]  L_to_C_bus_0

);
    wire   [`W_d-1:0]  W_BG_3;
    wire   [`W_d-1:0]  W_BG_2;
    wire   [`W_d-1:0]  W_BG_1;
    wire   [`W_d-1:0]  W_BG_0;
    wire   to_CBG_3;
    wire   to_CBG_2;
    wire   to_CBG_1;
    wire   to_CBG_0;
    wire   [`A_W      -1:0]  BG_addr_in_3;
    wire   [`A_W      -1:0]  BG_addr_in_2;
    wire   [`A_W      -1:0]  BG_addr_in_1;
    wire   [`A_W      -1:0]  BG_addr_in_0;


    crossbar_4x4_write_data c_w(
        .LSU_W_req_3        (LSU_W_req_3  ),
        .LSU_W_req_2        (LSU_W_req_2  ),
        .LSU_W_req_1        (LSU_W_req_1  ),
        .LSU_W_req_0        (LSU_W_req_0  ),
        .W_BG_3             (W_BG_3       ),
        .W_BG_2             (W_BG_2       ),
        .W_BG_1             (W_BG_1       ),
        .W_BG_0             (W_BG_0       )
    );

    crossbar_4x4_read_data c_r(
        .LSU_R_req_3        (LSU_R_req_3    ),
        .LSU_R_req_2        (LSU_R_req_2    ),
        .LSU_R_req_1        (LSU_R_req_1    ),
        .LSU_R_req_0        (LSU_R_req_0    ),

        .to_CBG_3           (to_CBG_3       ),
        .to_CBG_2           (to_CBG_2       ),
        .to_CBG_1           (to_CBG_1       ),
        .to_CBG_0           (to_CBG_0       ),

        .R_response_3       (R_response_3   ),   
        .R_response_2       (R_response_2   ),  
        .R_response_1       (R_response_1   ),  
        .R_response_0       (R_response_0   ),  

        .to_LSU_3           (to_LSU_3       ), 
        .to_LSU_2           (to_LSU_2       ),
        .to_LSU_1           (to_LSU_1       ),
        .to_LSU_0           (to_LSU_0       ) 
    );

    crossbar_4x4_addr   c_a(
        .LSU_addr_bus_3     (LSU_addr_bus_3 ),
        .LSU_addr_bus_2     (LSU_addr_bus_2 ),
        .LSU_addr_bus_1     (LSU_addr_bus_1 ),
        .LSU_addr_bus_0     (LSU_addr_bus_0 ),

        .BG_addr_in_3       (BG_addr_in_3   ),
        .BG_addr_in_2       (BG_addr_in_2   ),
        .BG_addr_in_1       (BG_addr_in_1   ),
        .BG_addr_in_0       (BG_addr_in_0   )
    );

    assign  L_to_C_bus_3 = { W_BG_3 , to_CBG_3 , BG_addr_in_3 } ;  
    assign  L_to_C_bus_2 = { W_BG_2 , to_CBG_2 , BG_addr_in_2 } ;
    assign  L_to_C_bus_1 = { W_BG_1 , to_CBG_1 , BG_addr_in_1 } ;
    assign  L_to_C_bus_0 = { W_BG_0 , to_CBG_0 , BG_addr_in_0 } ;

endmodule