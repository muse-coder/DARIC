`include "../param_define.v"
module crossbar_8x8_all (
    input    [`R_Q    -1:0]  LSU_R_req_7,
    input    [`R_Q    -1:0]  LSU_R_req_6,
    input    [`R_Q    -1:0]  LSU_R_req_5,
    input    [`R_Q    -1:0]  LSU_R_req_4,
    input    [`R_Q    -1:0]  LSU_R_req_3,
    input    [`R_Q    -1:0]  LSU_R_req_2,
    input    [`R_Q    -1:0]  LSU_R_req_1,
    input    [`R_Q    -1:0]  LSU_R_req_0,


    input    [`A_bus    -1:0]  LSU_addr_bus_7,
    input    [`A_bus    -1:0]  LSU_addr_bus_6,
    input    [`A_bus    -1:0]  LSU_addr_bus_5,
    input    [`A_bus    -1:0]  LSU_addr_bus_4,
    input    [`A_bus    -1:0]  LSU_addr_bus_3,
    input    [`A_bus    -1:0]  LSU_addr_bus_2,
    input    [`A_bus    -1:0]  LSU_addr_bus_1,
    input    [`A_bus    -1:0]  LSU_addr_bus_0,

    input    [`W_Q    -1:0]  LSU_W_req_7,
    input    [`W_Q    -1:0]  LSU_W_req_6,
    input    [`W_Q    -1:0]  LSU_W_req_5,
    input    [`W_Q    -1:0]  LSU_W_req_4,
    input    [`W_Q    -1:0]  LSU_W_req_3,
    input    [`W_Q    -1:0]  LSU_W_req_2,
    input    [`W_Q    -1:0]  LSU_W_req_1,
    input    [`W_Q    -1:0]  LSU_W_req_0,


    input    [`C_L_bus-1:0]  R_response_7, 
    input    [`C_L_bus-1:0]  R_response_6,
    input    [`C_L_bus-1:0]  R_response_5,
    input    [`C_L_bus-1:0]  R_response_4,
    input    [`C_L_bus-1:0]  R_response_3, 
    input    [`C_L_bus-1:0]  R_response_2,
    input    [`C_L_bus-1:0]  R_response_1,
    input    [`C_L_bus-1:0]  R_response_0,

    output   [`C_L_bus-1:0]  to_LSU_7, 
    output   [`C_L_bus-1:0]  to_LSU_6,
    output   [`C_L_bus-1:0]  to_LSU_5,
    output   [`C_L_bus-1:0]  to_LSU_4,  
    output   [`C_L_bus-1:0]  to_LSU_3, 
    output   [`C_L_bus-1:0]  to_LSU_2,
    output   [`C_L_bus-1:0]  to_LSU_1,
    output   [`C_L_bus-1:0]  to_LSU_0,  

    output  [`L_C_bus-1:0]  L_to_C_bus_7,
    output  [`L_C_bus-1:0]  L_to_C_bus_6,
    output  [`L_C_bus-1:0]  L_to_C_bus_5,
    output  [`L_C_bus-1:0]  L_to_C_bus_4,
    output  [`L_C_bus-1:0]  L_to_C_bus_3,
    output  [`L_C_bus-1:0]  L_to_C_bus_2,
    output  [`L_C_bus-1:0]  L_to_C_bus_1,
    output  [`L_C_bus-1:0]  L_to_C_bus_0

);
    wire   [`W_d-1:0]  W_BG_7;
    wire   [`W_d-1:0]  W_BG_6;
    wire   [`W_d-1:0]  W_BG_5;
    wire   [`W_d-1:0]  W_BG_4;
    wire   [`W_d-1:0]  W_BG_3;
    wire   [`W_d-1:0]  W_BG_2;
    wire   [`W_d-1:0]  W_BG_1;
    wire   [`W_d-1:0]  W_BG_0;

    wire   to_CBG_7;
    wire   to_CBG_6;
    wire   to_CBG_5;
    wire   to_CBG_4;
    wire   to_CBG_3;
    wire   to_CBG_2;
    wire   to_CBG_1;
    wire   to_CBG_0;
    
    wire   [`A_W -1:0]  BG_addr_in_7;
    wire   [`A_W -1:0]  BG_addr_in_6;
    wire   [`A_W -1:0]  BG_addr_in_5;
    wire   [`A_W -1:0]  BG_addr_in_4;
    wire   [`A_W -1:0]  BG_addr_in_3;
    wire   [`A_W -1:0]  BG_addr_in_2;
    wire   [`A_W -1:0]  BG_addr_in_1;
    wire   [`A_W -1:0]  BG_addr_in_0;


    crossbar_8x8_write_data c_w(
        .LSU_W_req_7        (LSU_W_req_7),   
        .LSU_W_req_6        (LSU_W_req_6),   
        .LSU_W_req_5        (LSU_W_req_5),   
        .LSU_W_req_4        (LSU_W_req_4),   
        .LSU_W_req_3        (LSU_W_req_3),   
        .LSU_W_req_2        (LSU_W_req_2),   
        .LSU_W_req_1        (LSU_W_req_1),   
        .LSU_W_req_0        (LSU_W_req_0),   
        .W_BG_7             (W_BG_7),
        .W_BG_6             (W_BG_6),
        .W_BG_5             (W_BG_5),
        .W_BG_4             (W_BG_4),
        .W_BG_3             (W_BG_3),
        .W_BG_2             (W_BG_2),
        .W_BG_1             (W_BG_1),
        .W_BG_0             (W_BG_0)
    );

    crossbar_8x8_read_data c_r(
        .LSU_R_req_7            (LSU_R_req_7),
        .LSU_R_req_6            (LSU_R_req_6),
        .LSU_R_req_5            (LSU_R_req_5),
        .LSU_R_req_4            (LSU_R_req_4),
        .LSU_R_req_3            (LSU_R_req_3),
        .LSU_R_req_2            (LSU_R_req_2),
        .LSU_R_req_1            (LSU_R_req_1),
        .LSU_R_req_0            (LSU_R_req_0),

        .to_CBG_7               (to_CBG_7   ),
        .to_CBG_6               (to_CBG_6   ),
        .to_CBG_5               (to_CBG_5   ),
        .to_CBG_4               (to_CBG_4   ),
        .to_CBG_3               (to_CBG_3   ),
        .to_CBG_2               (to_CBG_2   ),
        .to_CBG_1               (to_CBG_1   ),
        .to_CBG_0               (to_CBG_0   ),

        .R_response_7           (R_response_7), 
        .R_response_6           (R_response_6),
        .R_response_5           (R_response_5),
        .R_response_4           (R_response_4),
        .R_response_3           (R_response_3), 
        .R_response_2           (R_response_2),
        .R_response_1           (R_response_1),
        .R_response_0           (R_response_0),

        .to_LSU_7               (to_LSU_7   ), 
        .to_LSU_6               (to_LSU_6   ),
        .to_LSU_5               (to_LSU_5   ),
        .to_LSU_4               (to_LSU_4   ),
        .to_LSU_3               (to_LSU_3   ), 
        .to_LSU_2               (to_LSU_2   ),
        .to_LSU_1               (to_LSU_1   ),
        .to_LSU_0               (to_LSU_0   )
    );

    crossbar_8x8_addr   c_a(
        .LSU_addr_bus_7     (LSU_addr_bus_7),
        .LSU_addr_bus_6     (LSU_addr_bus_6),
        .LSU_addr_bus_5     (LSU_addr_bus_5),
        .LSU_addr_bus_4     (LSU_addr_bus_4),
        .LSU_addr_bus_3     (LSU_addr_bus_3),
        .LSU_addr_bus_2     (LSU_addr_bus_2),
        .LSU_addr_bus_1     (LSU_addr_bus_1),
        .LSU_addr_bus_0     (LSU_addr_bus_0),

        .BG_addr_in_7       (BG_addr_in_7   ),
        .BG_addr_in_6       (BG_addr_in_6   ),
        .BG_addr_in_5       (BG_addr_in_5   ),
        .BG_addr_in_4       (BG_addr_in_4   ),
        .BG_addr_in_3       (BG_addr_in_3   ),
        .BG_addr_in_2       (BG_addr_in_2   ),
        .BG_addr_in_1       (BG_addr_in_1   ),
        .BG_addr_in_0       (BG_addr_in_0   )
    );

    assign  L_to_C_bus_7 = { W_BG_7 , to_CBG_7 , BG_addr_in_7 } ;  
    assign  L_to_C_bus_6 = { W_BG_6 , to_CBG_6 , BG_addr_in_6 } ;
    assign  L_to_C_bus_5 = { W_BG_5 , to_CBG_5 , BG_addr_in_5 } ;
    assign  L_to_C_bus_4 = { W_BG_4 , to_CBG_4 , BG_addr_in_4 } ;
    assign  L_to_C_bus_3 = { W_BG_3 , to_CBG_3 , BG_addr_in_3 } ;  
    assign  L_to_C_bus_2 = { W_BG_2 , to_CBG_2 , BG_addr_in_2 } ;
    assign  L_to_C_bus_1 = { W_BG_1 , to_CBG_1 , BG_addr_in_1 } ;
    assign  L_to_C_bus_0 = { W_BG_0 , to_CBG_0 , BG_addr_in_0 } ;

endmodule