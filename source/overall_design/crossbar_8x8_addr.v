`include "../param_define.v"

module crossbar_8x8_addr (
    input    [`A_bus    -1:0]  LSU_addr_bus_7,
    input    [`A_bus    -1:0]  LSU_addr_bus_6,
    input    [`A_bus    -1:0]  LSU_addr_bus_5,
    input    [`A_bus    -1:0]  LSU_addr_bus_4,
    input    [`A_bus    -1:0]  LSU_addr_bus_3,
    input    [`A_bus    -1:0]  LSU_addr_bus_2,
    input    [`A_bus    -1:0]  LSU_addr_bus_1,
    input    [`A_bus    -1:0]  LSU_addr_bus_0,

    output   [`A_W      -1:0]  BG_addr_in_7,
    output   [`A_W      -1:0]  BG_addr_in_6,
    output   [`A_W      -1:0]  BG_addr_in_5,
    output   [`A_W      -1:0]  BG_addr_in_4,
    output   [`A_W      -1:0]  BG_addr_in_3,
    output   [`A_W      -1:0]  BG_addr_in_2,
    output   [`A_W      -1:0]  BG_addr_in_1,
    output   [`A_W      -1:0]  BG_addr_in_0
);

    wire [2:0]   addr_sel_7;
    wire [2:0]   addr_sel_6;
    wire [2:0]   addr_sel_5;
    wire [2:0]   addr_sel_4;
    wire [2:0]   addr_sel_3;
    wire [2:0]   addr_sel_2;
    wire [2:0]   addr_sel_1;
    wire [2:0]   addr_sel_0;


    wire [`A_W-1:0]   addr_0,addr_1,addr_2,addr_3,addr_4,addr_5,addr_6,addr_7;
    
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
    assign {
        addr_sel_4,
        addr_4
    } = LSU_addr_bus_4;

    assign {
        addr_sel_5,
        addr_5
    } = LSU_addr_bus_5;

    assign {
        addr_sel_6,
        addr_6
    } = LSU_addr_bus_6;

    assign {
        addr_sel_7,
        addr_7
    } = LSU_addr_bus_7;

//-------------------write crossbar select---------------------//
    assign  BG_addr_in_0   =  (addr_sel_7 == 3'b000) ? addr_7 :
                              (addr_sel_6 == 3'b000) ? addr_6 :
                              (addr_sel_5 == 3'b000) ? addr_5 :
                              (addr_sel_4 == 3'b000) ? addr_4 :
                              (addr_sel_3 == 3'b000) ? addr_3 :
                              (addr_sel_2 == 3'b000) ? addr_2 :
                              (addr_sel_1 == 3'b000) ? addr_1 :
                              (addr_sel_0 == 3'b000) ? addr_0 :
                                                        'b0;

    assign  BG_addr_in_1   =  (addr_sel_7 == 3'b001) ? addr_7 :
                              (addr_sel_6 == 3'b001) ? addr_6 :
                              (addr_sel_5 == 3'b001) ? addr_5 :
                              (addr_sel_4 == 3'b001) ? addr_4 :
                              (addr_sel_3 == 3'b001) ? addr_3 :
                              (addr_sel_2 == 3'b001) ? addr_2 :
                              (addr_sel_1 == 3'b001) ? addr_1 :
                              (addr_sel_0 == 3'b001) ? addr_0 :
                                                        'b0;

    assign  BG_addr_in_2   =  (addr_sel_7 == 3'b010) ? addr_7 :
                              (addr_sel_6 == 3'b010) ? addr_6 :
                              (addr_sel_5 == 3'b010) ? addr_5 :
                              (addr_sel_4 == 3'b010) ? addr_4 :
                              (addr_sel_3 == 3'b010) ? addr_3 :
                              (addr_sel_2 == 3'b010) ? addr_2 :
                              (addr_sel_1 == 3'b010) ? addr_1 :
                              (addr_sel_0 == 3'b010) ? addr_0 :
                                                        'b0;

    assign  BG_addr_in_3   =  (addr_sel_7 == 3'b011) ? addr_7 :
                              (addr_sel_6 == 3'b011) ? addr_6 :
                              (addr_sel_5 == 3'b011) ? addr_5 :
                              (addr_sel_4 == 3'b011) ? addr_4 :
                              (addr_sel_3 == 3'b011) ? addr_3 :
                              (addr_sel_2 == 3'b011) ? addr_2 :
                              (addr_sel_1 == 3'b011) ? addr_1 :
                              (addr_sel_0 == 3'b011) ? addr_0 :
                                                        'b0;


    assign  BG_addr_in_4   =  (addr_sel_7 == 3'b100) ? addr_7 :
                              (addr_sel_6 == 3'b100) ? addr_6 :
                              (addr_sel_5 == 3'b100) ? addr_5 :
                              (addr_sel_4 == 3'b100) ? addr_4 :
                              (addr_sel_3 == 3'b100) ? addr_3 :
                              (addr_sel_2 == 3'b100) ? addr_2 :
                              (addr_sel_1 == 3'b100) ? addr_1 :
                              (addr_sel_0 == 3'b100) ? addr_0 :
                                                        'b0;

    assign  BG_addr_in_5   =  (addr_sel_7 == 3'b101) ? addr_7 :
                              (addr_sel_6 == 3'b101) ? addr_6 :
                              (addr_sel_5 == 3'b101) ? addr_5 :
                              (addr_sel_4 == 3'b101) ? addr_4 :
                              (addr_sel_3 == 3'b101) ? addr_3 :
                              (addr_sel_2 == 3'b101) ? addr_2 :
                              (addr_sel_1 == 3'b101) ? addr_1 :
                              (addr_sel_0 == 3'b101) ? addr_0 :
                                                        'b0;

    assign  BG_addr_in_6   =  (addr_sel_7 == 3'b110) ? addr_7 :
                              (addr_sel_6 == 3'b110) ? addr_6 :
                              (addr_sel_5 == 3'b110) ? addr_5 :
                              (addr_sel_4 == 3'b110) ? addr_4 :
                              (addr_sel_3 == 3'b110) ? addr_3 :
                              (addr_sel_2 == 3'b110) ? addr_2 :
                              (addr_sel_1 == 3'b110) ? addr_1 :
                              (addr_sel_0 == 3'b110) ? addr_0 :
                                                        'b0;

    assign  BG_addr_in_7   =  (addr_sel_7 == 3'b111) ? addr_7 :
                              (addr_sel_6 == 3'b111) ? addr_6 :
                              (addr_sel_5 == 3'b111) ? addr_5 :
                              (addr_sel_4 == 3'b111) ? addr_4 :
                              (addr_sel_3 == 3'b111) ? addr_3 :
                              (addr_sel_2 == 3'b111) ? addr_2 :
                              (addr_sel_1 == 3'b111) ? addr_1 :
                              (addr_sel_0 == 3'b111) ? addr_0 :
                                                        'b0;



endmodule