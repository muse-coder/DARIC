`include "../param_define.v"
module Delay (
    input   run_i     ,
    input   [`H_C_W-1:0]    host_controller_i,
	input	[`EX_bus-1 :0]	ex_bus_i,
    output  run     ,
    output  [`H_C_W-1:0]    host_controller,
	output	[`EX_bus-1 :0]	ex_bus
);
    assign  run   = run_i  ? 1'b1 : 1'b0;
    
    assign  host_controller = host_controller_i;
    assign  ex_bus = ex_bus_i;

endmodule