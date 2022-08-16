`include "../param_define.v"

module TCAD (
    input   clk,
    input   rst,
    input   [`H_C_W-1:0]    host_controller,
    input   [31:0]          external_memory
);

    wire    [`L_C_bus-1:0]      crossbar_BG3_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG2_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG1_out ;
    wire    [`L_C_bus-1:0]      crossbar_BG0_out ;
    wire    [`C_L_bus-1:0]      corssbar_BG3_in  ;
    wire    [`C_L_bus-1:0]      corssbar_BG2_in  ;
    wire    [`C_L_bus-1:0]      corssbar_BG1_in  ;
    wire    [`C_L_bus-1:0]      corssbar_BG0_in  ;

    wire    [`L_C_bus-1:0]      corssbar_LSU3_in ; 
    wire    [`L_C_bus-1:0]      corssbar_LSU2_in ;
    wire    [`L_C_bus-1:0]      corssbar_LSU1_in ;
    wire    [`L_C_bus-1:0]      corssbar_LSU0_in ;

    wire    [`C_L_bus-1:0]      corssbar_LSU3_out;
    wire    [`C_L_bus-1:0]      corssbar_LSU2_out;
    wire    [`C_L_bus-1:0]      corssbar_LSU1_out;
    wire    [`C_L_bus-1:0]      corssbar_LSU0_out;

    wire    [`H_C_W-1:0]    pe_config;
    wire    [11:0]          scr_config;
    wire    [7:0]           cross_switch;
    scratchpad  scratchpad_lut(
	    .clk                (clk                ),
	    .rst                (rst                ),
	    .inst               (scr_config         ),
	    .external_memory    (external_memory    ),
	    .switch_in_3        (crossbar_BG3_out   ),
	    .switch_in_2        (crossbar_BG2_out   ),
	    .switch_in_1        (crossbar_BG1_out   ),
	    .switch_in_0        (crossbar_BG0_out   ),
	
	    .switch_out_3       (corssbar_BG3_in    ),
	    .switch_out_2       (corssbar_BG2_in    ),
	    .switch_out_1       (corssbar_BG1_in    ),
	    .switch_out_0       (corssbar_BG0_in    )
    );    

    BG_LSU_crossbar_4x4 crossbar_4x4(
        .BG3_in             (corssbar_BG3_in    ),
        .BG2_in             (corssbar_BG2_in    ),
        .BG1_in             (corssbar_BG1_in    ),
        .BG0_in             (corssbar_BG0_in    ),
        .LSU3_in            (corssbar_LSU3_in   ), 
        .LSU2_in            (corssbar_LSU2_in   ),
        .LSU1_in            (corssbar_LSU1_in   ),
        .LSU0_in            (corssbar_LSU0_in   ),
    
        .switch             (cross_switch       ),
    
        .BG3_out            (crossbar_BG3_out   ),
        .BG2_out            (crossbar_BG2_out   ),
        .BG1_out            (crossbar_BG1_out   ),
        .BG0_out            (crossbar_BG0_out   ),
        .LSU3_out           (corssbar_LSU3_out  ), 
        .LSU2_out           (corssbar_LSU2_out  ),
        .LSU1_out           (corssbar_LSU1_out  ),
        .LSU0_out           (corssbar_LSU0_out  )
       
    );

    PEs_array PEs_array_lut(
        .clk                    (clk                    ),
        .rst                    (rst                    ),
        .pe_config              (pe_config              ),
        .CBG_to_LSU_bus_0       (corssbar_LSU3_out      ),
        .CBG_to_LSU_bus_1       (corssbar_LSU2_out      ),
        .CBG_to_LSU_bus_2       (corssbar_LSU1_out      ),
        .CBG_to_LSU_bus_3       (corssbar_LSU0_out      ),

        .LSU_to_CBG_bus_0       (corssbar_LSU3_in       ),
        .LSU_to_CBG_bus_1       (corssbar_LSU2_in       ),
        .LSU_to_CBG_bus_2       (corssbar_LSU1_in       ),
        .LSU_to_CBG_bus_3       (corssbar_LSU0_in       )
    );


endmodule