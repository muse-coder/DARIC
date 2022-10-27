`include "../param_define.v"

module Daric (
    input   clk,
    input   rst,
    input   [`H_C_W-1       :0]    host_controller,
	input	[`EX_in_bus-1   :0]    ex_in_bus,
    output  [`EX_out_bus-1  :0]    ex_out_bus
);

//-----------加载指令---------------//    
    wire    init_SPM;
    wire    [`PE_inst   -1:0]   PE_config;
    wire    [`SPM_INST  -1:0]   scr_config;
    wire    [12:0]   init_PE_array;
    wire    [`Top_inst   -1:0]  instruction;
    assign  {
            run,          // 62:62    1bit
            init_SPM    , // 61:61    1bit
            init_PE_array, // 60:48     13bit
            instruction    // 47:0   48bit
        } = host_controller;
    assign  scr_config  = instruction   [`SPM_INST  -1:0];
    
    assign  PE_config   = instruction   [`PE_inst   -1:0];
//-----------------end-------------------//

    wire    [`L_C_bus   -1:0]   L_to_C_bus_7;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_6;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_5;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_4;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_3;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_2;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_1;
    wire    [`L_C_bus   -1:0]   L_to_C_bus_0;

    wire    [`C_L_bus   -1:0]   to_LSU_7; 
    wire    [`C_L_bus   -1:0]   to_LSU_6;
    wire    [`C_L_bus   -1:0]   to_LSU_5;
    wire    [`C_L_bus   -1:0]   to_LSU_4;  
    wire    [`C_L_bus   -1:0]   to_LSU_3; 
    wire    [`C_L_bus   -1:0]   to_LSU_2;
    wire    [`C_L_bus   -1:0]   to_LSU_1;
    wire    [`C_L_bus   -1:0]   to_LSU_0;  

    wire    [`C_L_bus   -1:0]   R_response_7; 
    wire    [`C_L_bus   -1:0]   R_response_6;
    wire    [`C_L_bus   -1:0]   R_response_5;
    wire    [`C_L_bus   -1:0]   R_response_4;
    wire    [`C_L_bus   -1:0]   R_response_3; 
    wire    [`C_L_bus   -1:0]   R_response_2;
    wire    [`C_L_bus   -1:0]   R_response_1;
    wire    [`C_L_bus   -1:0]   R_response_0;

    wire  [`R_Q   -1          :0]  R_request_7;
    wire  [`R_Q   -1          :0]  R_request_6;
    wire  [`R_Q   -1          :0]  R_request_5;
    wire  [`R_Q   -1          :0]  R_request_4;
    wire  [`R_Q   -1          :0]  R_request_3;
    wire  [`R_Q   -1          :0]  R_request_2;
    wire  [`R_Q   -1          :0]  R_request_1;
    wire  [`R_Q   -1          :0]  R_request_0;
    
    wire  [`W_Q   -1          :0]  W_request_7; 
    wire  [`W_Q   -1          :0]  W_request_6; 
    wire  [`W_Q   -1          :0]  W_request_5; 
    wire  [`W_Q   -1          :0]  W_request_4; 
    wire  [`W_Q   -1          :0]  W_request_3; 
    wire  [`W_Q   -1          :0]  W_request_2; 
    wire  [`W_Q   -1          :0]  W_request_1; 
    wire  [`W_Q   -1          :0]  W_request_0; 
    
    wire  [`A_bus -1          :0]  LSU_addr_bus_7; 
    wire  [`A_bus -1          :0]  LSU_addr_bus_6; 
    wire  [`A_bus -1          :0]  LSU_addr_bus_5; 
    wire  [`A_bus -1          :0]  LSU_addr_bus_4;
    wire  [`A_bus -1          :0]  LSU_addr_bus_3; 
    wire  [`A_bus -1          :0]  LSU_addr_bus_2; 
    wire  [`A_bus -1          :0]  LSU_addr_bus_1; 
    wire  [`A_bus -1          :0]  LSU_addr_bus_0;

    scratchpad  scratchpad_lut(
	    .clk                (clk                ),
	    .rst                (rst                ),
	    .inst               (scr_config         ),
        .init               (init_SPM           ),
        .run                (run                ),
	    .ex_in_bus          (ex_in_bus          ),
	    .switch_in_7        (L_to_C_bus_7       ),
	    .switch_in_6        (L_to_C_bus_6       ),
	    .switch_in_5        (L_to_C_bus_5       ),
	    .switch_in_4        (L_to_C_bus_4       ),
	    .switch_in_3        (L_to_C_bus_3       ),
	    .switch_in_2        (L_to_C_bus_2       ),
	    .switch_in_1        (L_to_C_bus_1       ),
	    .switch_in_0        (L_to_C_bus_0       ),
	    
        .switch_out_7       (R_response_7       ),
	    .switch_out_6       (R_response_6       ),
	    .switch_out_5       (R_response_5       ),
	    .switch_out_4       (R_response_4       ),
        .switch_out_3       (R_response_3       ),
	    .switch_out_2       (R_response_2       ),
	    .switch_out_1       (R_response_1       ),
	    .switch_out_0       (R_response_0       ),
        
        .ex_out_bus         (ex_out_bus         )
    );    



    crossbar_8x8_all cross_all(
        .LSU_R_req_7        (R_request_7        ),
        .LSU_R_req_6        (R_request_6        ),
        .LSU_R_req_5        (R_request_5        ),
        .LSU_R_req_4        (R_request_4        ),
        .LSU_R_req_3        (R_request_3        ),
        .LSU_R_req_2        (R_request_2        ),
        .LSU_R_req_1        (R_request_1        ),
        .LSU_R_req_0        (R_request_0        ),

        .LSU_addr_bus_7     (LSU_addr_bus_7     ),
        .LSU_addr_bus_6     (LSU_addr_bus_6     ),
        .LSU_addr_bus_5     (LSU_addr_bus_5     ),
        .LSU_addr_bus_4     (LSU_addr_bus_4     ),
        .LSU_addr_bus_3     (LSU_addr_bus_3     ),
        .LSU_addr_bus_2     (LSU_addr_bus_2     ),
        .LSU_addr_bus_1     (LSU_addr_bus_1     ),
        .LSU_addr_bus_0     (LSU_addr_bus_0     ),

        .LSU_W_req_7        (W_request_7        ),
        .LSU_W_req_6        (W_request_6        ),
        .LSU_W_req_5        (W_request_5        ),
        .LSU_W_req_4        (W_request_4        ),
        .LSU_W_req_3        (W_request_3        ),
        .LSU_W_req_2        (W_request_2        ),
        .LSU_W_req_1        (W_request_1        ),
        .LSU_W_req_0        (W_request_0        ),

        .R_response_7       (R_response_7   ), 
        .R_response_6       (R_response_6   ),
        .R_response_5       (R_response_5   ),
        .R_response_4       (R_response_4   ),
        .R_response_3       (R_response_3   ), 
        .R_response_2       (R_response_2   ),
        .R_response_1       (R_response_1   ),
        .R_response_0       (R_response_0   ),

        .to_LSU_7           (to_LSU_7       ), 
        .to_LSU_6           (to_LSU_6       ),
        .to_LSU_5           (to_LSU_5       ),
        .to_LSU_4           (to_LSU_4       ),  
        .to_LSU_3           (to_LSU_3       ), 
        .to_LSU_2           (to_LSU_2       ),
        .to_LSU_1           (to_LSU_1       ),
        .to_LSU_0           (to_LSU_0       ),  

        .L_to_C_bus_7       (L_to_C_bus_7   ),
        .L_to_C_bus_6       (L_to_C_bus_6   ),
        .L_to_C_bus_5       (L_to_C_bus_5   ),
        .L_to_C_bus_4       (L_to_C_bus_4   ),
        .L_to_C_bus_3       (L_to_C_bus_3   ),
        .L_to_C_bus_2       (L_to_C_bus_2   ),
        .L_to_C_bus_1       (L_to_C_bus_1   ),
        .L_to_C_bus_0       (L_to_C_bus_0   )
);


    PEs_array pes_array (
        .clk                (clk                ),
        .rst                (rst                ),
        .run                (run                ),
        .init_PE_array      (init_PE_array      ),
        .PE_config          (PE_config          ),
        
        .CBG_to_LSU_bus_7   (to_LSU_7           ),
        .CBG_to_LSU_bus_6   (to_LSU_6           ),
        .CBG_to_LSU_bus_5   (to_LSU_5           ),
        .CBG_to_LSU_bus_4   (to_LSU_4           ),
        .CBG_to_LSU_bus_3   (to_LSU_3           ),
        .CBG_to_LSU_bus_2   (to_LSU_2           ),
        .CBG_to_LSU_bus_1   (to_LSU_1           ),
        .CBG_to_LSU_bus_0   (to_LSU_0           ),

        .R_request_7        (R_request_7        ),
        .R_request_6        (R_request_6        ),
        .R_request_5        (R_request_5        ),
        .R_request_4        (R_request_4        ),
        .R_request_3        (R_request_3        ),
        .R_request_2        (R_request_2        ),
        .R_request_1        (R_request_1        ),
        .R_request_0        (R_request_0        ),

        .W_request_7        (W_request_7        ), 
        .W_request_6        (W_request_6        ), 
        .W_request_5        (W_request_5        ), 
        .W_request_4        (W_request_4        ), 
        .W_request_3        (W_request_3        ), 
        .W_request_2        (W_request_2        ), 
        .W_request_1        (W_request_1        ), 
        .W_request_0        (W_request_0        ), 
    
        .LSU_addr_bus_7     (LSU_addr_bus_7     ), 
        .LSU_addr_bus_6     (LSU_addr_bus_6     ), 
        .LSU_addr_bus_5     (LSU_addr_bus_5     ), 
        .LSU_addr_bus_4     (LSU_addr_bus_4     ),
        .LSU_addr_bus_3     (LSU_addr_bus_3     ), 
        .LSU_addr_bus_2     (LSU_addr_bus_2     ), 
        .LSU_addr_bus_1     (LSU_addr_bus_1     ), 
        .LSU_addr_bus_0     (LSU_addr_bus_0     )
    );

endmodule