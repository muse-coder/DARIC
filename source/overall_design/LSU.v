`timescale 1ns / 1ps
`include "../param_define.v"

module LSU  (
    input           clk,
    input           rst,
    input   [`L_I_W-1  :0]  LSU_inst,
    input   [31        :0]  PE_0,
    input   [31        :0]  PE_1,
    input   [31        :0]  PE_2,
    input   [31        :0]  PE_3,
    input   [`C_L_bus-1:0]  CBG_to_LSU_bus,
    output  [31        :0]  LSU_to_PE,
    output  [`R_Q-1    :0]  R_request,
    output  [`W_Q-1    :0]  W_request  
    );

    wire    [31:0]  din;
    wire    [31:0]  dout;
    wire    [1:0]   pe_sel;
    wire            store_sel;
    wire    ren;
    wire    wen;
    wire    [1:0]   w_sel;
    wire    [31:0]  PE_in;
    reg     [31:0]  load_reg;
    reg     [31:0]  store_reg;
    reg     [`A_W-1:0]  AG;
    wire    read_valid;
    assign  {read_valid , din} =  CBG_to_LSU_bus;
    assign  {
        ren,      //6:6
        wen,      //5:5
        w_sel,    //4:3
        pe_sel,   //2:1
        store_sel //0:0
    }   =   LSU_inst;

    assign  PE_in = (pe_sel == 2'b00) ? PE_0:
                    (pe_sel == 2'b01) ? PE_1:
                    (pe_sel == 2'b10) ? PE_2:
                                        PE_3;  
    reg count;

//-------------------read & write request-----------------//
    assign  R_request = {
        ren,
        AG
    };

    assign  W_request = {
        w_sel,
        wen,
        AG,
        store_reg
    };
//--------------address generate------------//
    always @(posedge clk ) begin
        if(rst)
            AG <= 'b0;
        else    begin
            AG <= AG + 1'b1;
        end
    end

//-------------load data-----------------//
    always @(posedge clk ) begin
        if(rst) begin
            load_reg <= 32'hffffffff;
        end
        else if(read_valid)
            load_reg <= din;
    end

//----------------end------------------//

//--------------store data ---------------//

    always @(posedge clk ) begin
        if(rst) begin
            //待定
            store_reg <= 32'hffffffff;
        end

        else begin
            store_reg <= store_sel ? load_reg : PE_in ;
        end
    end



endmodule