`timescale 1ns / 1ps
`include "../param_define.v"
module LSU(
    input           clk,
    input           rst,
    input   [`L_I_W-1:0]  LSU_inst,
    input   [31:0]  PE_0,
    input   [31:0]  PE_1,
    input   [31:0]  PE_2,
    input   [31:0]  PE_3,
    input   [`C_L_bus-1:0]  CBG_to_LSU_bus,
    output  [31:0]  LSU_to_PE,
    output  [`L_C_bus-1:0]  LSU_to_CBG_bus
    );
//-----------握手信号-------------//            
    wire    din_valid;
    wire    din_ready;
    wire    dout_valid;
    wire    dout_ready;
    wire    write_request;
    reg     write_valid;    
// ------------end--------------//
    wire    [31:0]  din;
    wire    [31:0]  dout;
    wire    [`A_W-1:0]    AG;
    wire    [1:0]   pe_sel;
    wire            store_sel;
    wire    [31:0]  PE_in;
    reg     [31:0]  load_reg;
    reg     [31:0]  store_reg;

    assign  {
        write_request,
        pe_sel,
        store_sel

    }   =   LSU_inst;

    assign  PE_in = (pe_sel == 2'b00) ? PE_0:
                    (pe_sel == 2'b01) ? PE_1:
                    (pe_sel == 2'b10) ? PE_2:
                                        PE_3;  

//-------------load data-----------------//
    always @(posedge clk ) begin
        if(rst) begin
            //待定
        end

        else 
            load_reg <= din;
    end

//----------------end------------------//

//--------------store data ---------------//

    always @(posedge clk ) begin
        if(rst) begin
            //待定
        end

        else begin
            store_reg <= store_sel ? load_reg : PE_in ;
        end
    end
//------------------end-------------------//
    always @(posedge clk ) begin
        if(rst) begin
            write_valid <= 1'b0;
        end

        else if(write_request) begin
            write_valid <= 1'b1;
        end

        else    
            write_valid <= 1'b0;
    end


endmodule