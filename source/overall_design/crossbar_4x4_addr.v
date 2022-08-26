`include "../param_define.v"

module crossbar_4x4_addr (
    input    [`A_bus    -1:0]  LSU_addr_bus_3,
    input    [`A_bus    -1:0]  LSU_addr_bus_2,
    input    [`A_bus    -1:0]  LSU_addr_bus_1,
    input    [`A_bus    -1:0]  LSU_addr_bus_0,

    output   [`A_W      -1:0]  BG_addr_in_3,
    output   [`A_W      -1:0]  BG_addr_in_2,
    output   [`A_W      -1:0]  BG_addr_in_1,
    output   [`A_W      -1:0]  BG_addr_in_0
);

    wire [1:0]   addr_sel_3;
    wire [1:0]   addr_sel_2;
    wire [1:0]   addr_sel_1;
    wire [1:0]   addr_sel_0;
    wire [`A_W-1:0]   addr_0,addr_1,addr_2,addr_3;
    
    assign {
        addr_sel_0,
        addr_0
    } = LSU_addr_bus_0;

    assign {
        addr_sel_1,
        addr_1
    } = LSU_addr_bus_1;

    assign {
        addr_sel_2,
        addr_2
    } = LSU_addr_bus_2;

    assign {
        addr_sel_3,
        addr_3
    } = LSU_addr_bus_3;

//-------------------write crossbar select---------------------//
    assign  BG_addr_in_0   =  (addr_sel_0 == 2'b00) ? addr_0 :
                              (addr_sel_1 == 2'b00) ? addr_1 :
                              (addr_sel_2 == 2'b00) ? addr_2 :
                              (addr_sel_3 == 2'b00) ? addr_3 :
                                                        'b0;

    assign  BG_addr_in_1   =  (addr_sel_0 == 2'b01) ? addr_0 :
                              (addr_sel_1 == 2'b01) ? addr_1 :
                              (addr_sel_2 == 2'b01) ? addr_2 :
                              (addr_sel_3 == 2'b01) ? addr_3 :
                                                        'b0;

    assign  BG_addr_in_2   =  (addr_sel_0 == 2'b10) ? addr_0 :
                              (addr_sel_1 == 2'b10) ? addr_1 :
                              (addr_sel_2 == 2'b10) ? addr_2 :
                              (addr_sel_3 == 2'b10) ? addr_3 :
                                                        'b0;

    assign  BG_addr_in_3   =  (addr_sel_0 == 2'b11) ? addr_0 :
                              (addr_sel_1 == 2'b11) ? addr_1 :
                              (addr_sel_2 == 2'b11) ? addr_2 :
                              (addr_sel_3 == 2'b11) ? addr_3 :
                                                        'b0;

endmodule