`include "../param_define.v"
module Delay (
    input   [`H_C_W-1:0]    host_controller_i,
	input	[`EX_in_bus-1 :0]	ex_bus_i,
    output  [`H_C_W-1:0]    host_controller,
	output	[`EX_in_bus-1 :0]	ex_bus
);
    
    assign  host_controller = host_controller_i;
    assign  ex_bus = ex_bus_i;

endmodule