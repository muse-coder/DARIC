`timescale 1ns / 1ps
`include "../param_define.v"

module LSU #(
    parameter alpha = 60,
    parameter beta  = 1,
    parameter num =50
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
    (* DONT_TOUCH = "1" *)    input   [`C_L_bus-1:0]  CBG_to_LSU_bus,
    output  [31        :0]  LSU_to_PE,
    output  [`R_Q-1    :0]  R_request,
    output  [`W_Q-1    :0]  W_request,  
    output  [`A_bus    -1:0]  LSU_addr_bus
    );
    wire    [`L_I_W-1   :0] inst;
    wire    [31:0]  din;
    wire    [1:0]   pe_sel;
    wire            store_sel;
    wire    ren;
    wire    wen;
    wire    [1:0]   w_sel;
    wire    [1:0]   r_sel;
    wire    [1:0]   addr_sel;
    wire    [31:0]  PE_in;
    reg     [31:0]  load_reg;
    reg     [31:0]  store_reg;
    reg     [`A_W-1:0]  R_AG;
    reg     [`A_W-1:0]  W_AG;
    wire    read_valid;
//------------configuration buffer-------------//
    reg     [`L_I_W-1:0]    config_buffer [`buffer_depth-1:0]  ;
    reg     [31:0]  init_count;
    reg     [31:0]  run_count;
    integer i = 0;
    reg     [`L_I_W-1:0]    inst_r;
//-------------初始化-------------------//
    always @(posedge clk ) begin
        if(rst) begin
            init_count  <=  'b0;
            run_count   <=  'b0;
            // for (i = 0; i <4 ; i = i + 1) begin
            //     config_buffer[i] <='b0;
            // end
            inst_r  <= 'b0;
        end
        else if(init) begin
            config_buffer[init_count] <= LSU_inst;
            init_count <= init_count +1'b1;
        end
        else if(run) begin
            run_count <= run_count +1'b1;
            inst_r    <= config_buffer[run_count];
        end
    end
// //------------------运行时---------------//
//     always @(posedge clk ) begin
//         if(rst) begin
//             run_count   <=  'b0;
//         end
//         else if(run) begin
//             run_count <= run_count +1'b1;
//             inst_r    <= config_buffer[run_count];
//         end
//     end
// //-----------------end-----------------//
    assign  {read_valid , din} =  CBG_to_LSU_bus;

    assign  {
        ren,      //12:11
        wen,      //10:9
        r_sel,    //8:7
        w_sel,    //6:5
        addr_sel, //4:3
        pe_sel,   //2:1
        store_sel //0:0
    } = inst_r;

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

    wire    [`A_W-1:0]  ADDR;
    assign  LSU_addr_bus ={
        addr_sel,
        ADDR
    };
//--------------address generate------------//
    reg     [`A_W-1:0]  ACC_i;
    reg     [`A_W-1:0]  ACC_j;
    reg     [31:0]  count_j;
    always @(posedge clk ) begin
        if(rst) begin
            count_j <= 'b0;
            ACC_j <= 'b0;
            ACC_i <= 'b0;
        end
        else if (ren | wen) begin
            
            if(count_j < num) begin
                ACC_j  <= ACC_j + beta;    
                count_j <= count_j + 1'b1;
            end
            else    begin
                count_j <= 'b0;
                ACC_i   <= ACC_i + alpha;
                ACC_j   <= 'b0;
            end
        end
    end

    assign  ADDR = ACC_i + ACC_j ;

//-------------load data-----------------//
    always @(posedge clk ) begin
        if(rst) begin
            load_reg <= 32'hffffffff;
        end
        else 
            load_reg <= din;
    end

    assign LSU_to_PE = load_reg ;
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