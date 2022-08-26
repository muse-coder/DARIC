`timescale 1ns / 1ps
`include "../param_define.v"

module LSU #(
    parameter alpha = 1,
    parameter beta  = 1
) (       
    input                   clk,
    input                   rst,
    input   [`L_I_W-1  :0]  LSU_inst,
    input                   init,
    input                   run,
    input   [31        :0]  PE_0,
    input   [31        :0]  PE_1,
    input   [31        :0]  PE_2,
    input   [31        :0]  PE_3,
    input   [`C_L_bus-1:0]  CBG_to_LSU_bus,
    output  [31        :0]  LSU_to_PE,
    output  [`R_Q-1    :0]  R_request,
    output  [`W_Q-1    :0]  W_request,  
    output  [`A_W-1    :0]  AG
    );
    wire    [`L_I_W-1   :0] inst;
    wire    [31:0]  din;
    wire    [1:0]   pe_sel;
    wire            store_sel;
    wire    ren;
    wire    wen;
    wire    [1:0]   w_sel;
    wire    [1:0]   r_sel;
    wire    [31:0]  PE_in;
    reg     [31:0]  load_reg;
    reg     [31:0]  store_reg;
    reg     [`A_W-1:0]  R_AG;
    reg     [`A_W-1:0]  W_AG;
    wire    read_valid;
//------------configuration buffer-------------//
    reg     [`L_I_W-1:0]    config_buffer [31:0]  ;
    reg     [31:0]  init_count;
    reg     [31:0]  run_count;
    integer i = 0;
//-------------初始化-------------------//
    always @(posedge clk ) begin
        if(rst) begin
            init_count  <=  'b0;
            for (i = 0; i <32 ; i = i + 1) begin
                config_buffer[i] <='b0;
            end
        end
        else if(init) begin
            config_buffer[init_count] <= LSU_inst;
            init_count <= init_count +1'b1;
        end
    end
//------------------运行时---------------//
    always @(posedge clk ) begin
        if(rst) begin
            run_count   <=  'b0;
        end
        else if(run) begin
            run_count <= run_count +1'b1;
        end
    end
//-----------------end-----------------//
    assign  {read_valid , din} =  CBG_to_LSU_bus;

    assign  {
        ren,      //6:6
        wen,      //5:5
        w_sel,    //4:3
        pe_sel,   //2:1
        store_sel //0:0
    }   =   config_buffer[run_count];

    assign  PE_in = (pe_sel == 2'b00) ? PE_0:
                    (pe_sel == 2'b01) ? PE_1:
                    (pe_sel == 2'b10) ? PE_2:
                                        PE_3;  


//-------------------read & write request-----------------//
    assign  R_request = {
        r_sel,
        ren
    };

    assign  W_request = {
        w_sel,
        wen,
        store_reg
    };
//--------------address generate------------//
    always @(posedge clk ) begin
        if(rst) begin
            R_AG <= 'b0;
            W_AG <= 'b0;
        end
            
        if(ren)   begin
            R_AG <= R_AG + 1'b1;
        end

        if(wen)    begin
            W_AG <= W_AG + 1'b1;
        end
    end


//-------------load data-----------------//
    always @(posedge clk ) begin
        if(rst) begin
            load_reg <= 32'hffffffff;
        end
        else 
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