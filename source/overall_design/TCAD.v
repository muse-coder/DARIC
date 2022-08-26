`include "../param_define.v"

module TCAD (
    input   clk,
    input   rst,
    input   [`H_C_W-1:0]    host_controller,
    input   [31:0]          external_memory
);


    wire    [`H_C_W-1:0]    pe_config;
    wire    [11:0]          scr_config;
    wire    [7:0]           cross_switch;

    wire    [`L_C_bus-1:0]  L_to_C_bus_3;
    wire    [`L_C_bus-1:0]  L_to_C_bus_2;
    wire    [`L_C_bus-1:0]  L_to_C_bus_1;
    wire    [`L_C_bus-1:0]  L_to_C_bus_0;

    wire    [`C_L_bus-1:0]  to_LSU_3; 
    wire    [`C_L_bus-1:0]  to_LSU_2;
    wire    [`C_L_bus-1:0]  to_LSU_1;
    wire    [`C_L_bus-1:0]  to_LSU_0;  

    wire    [`C_L_bus-1:0]  R_response_3; 
    wire    [`C_L_bus-1:0]  R_response_2;
    wire    [`C_L_bus-1:0]  R_response_1;
    wire    [`C_L_bus-1:0]  R_response_0;

    wire    init,run;
    scratchpad  scratchpad_lut(
	    .clk                (clk                ),
	    .rst                (rst                ),
	    .inst               (scr_config         ),
        .init               (init               ),
        .run                (run                ),
	    .external_memory    (external_memory    ),
	    .switch_in_3        (L_to_C_bus_3       ),
	    .switch_in_2        (L_to_C_bus_2       ),
	    .switch_in_1        (L_to_C_bus_1       ),
	    .switch_in_0        (L_to_C_bus_0       ),
	    .switch_out_3       (R_response_3       ),
	    .switch_out_2       (R_response_2       ),
	    .switch_out_1       (R_response_1       ),
	    .switch_out_0       (R_response_0       )
    );    



    crossbar_4x4_all cross_all(
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


        .R_response_3   (R_response_3   ), 
        .R_response_2   (R_response_2   ),
        .R_response_1   (R_response_1   ),
        .R_response_0   (R_response_0   ),

        .to_LSU_3       (to_LSU_3       ), 
        .to_LSU_2       (to_LSU_2       ),
        .to_LSU_1       (to_LSU_1       ),
        .to_LSU_0       (to_LSU_0       ),  

        .L_to_C_bus_3   (L_to_C_bus_3   ),
        .L_to_C_bus_2   (L_to_C_bus_2   ),
        .L_to_C_bus_1   (L_to_C_bus_1   ),
        .L_to_C_bus_0   (L_to_C_bus_0   )
);


    LSU lsu0(
        .clk            (clk            ),
        .rst            (rst            ),
        .LSU_inst       (LSU_inst_0     ),
        .init           (init           ),
        .run            (run            ),
        
    input   [31        :0]  PE_0,
    input   [31        :0]  PE_1,
    input   [31        :0]  PE_2,
    input   [31        :0]  PE_3,
    input   [`C_L_bus-1:0]  CBG_to_LSU_bus,
    output  [31        :0]  LSU_to_PE,
    output  [`R_Q-1    :0]  R_request,
    output  [`W_Q-1    :0]  W_request  
    );
endmodule