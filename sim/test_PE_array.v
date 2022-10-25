`include "../source/param_define.v"
`timescale 1ns / 1ps

module test_PE_array (

);
    parameter cycle = 10;
    reg clk;
    reg rst;
    always  #(cycle/2)  clk = ~ clk;
    wire     [3:0]   init_row_sel;
    wire     [4:0]   init_LSU_PE;
    reg init_row_0,init_row_1,init_row_2,init_row_3;
    reg init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3;
    reg [`PE_inst-1:0]  PE_inst;
    wire [8:0    ]  init_PE_array;
    assign  init_PE_array = {init_row_sel,init_LSU_PE};
    assign  init_LSU_PE  = {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3};
    assign  init_row_sel = {init_row_0,init_row_1,init_row_2,init_row_3};

    reg [31:0]   din_N_i ;
    reg [31:0]   din_S_i ;
    reg [31:0]   din_W_i ;
    reg [31:0]   din_E_i ;

    always @(posedge clk ) begin
        if (rst) begin
            din_N_i <='d3;
            din_W_i <='d4;
            din_S_i <='d5;
            din_E_i <='d6;
        end
        else begin
            din_N_i <= din_N_i+'b1;
            din_W_i <= din_W_i+'b1;
            din_S_i <= din_S_i+'b1;
            din_E_i <= din_E_i+'b1;  
        end
    end
    reg run;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        run = 1'b0;
    #10 rst = 1'b0;    
    #10 init_pe_0_inst;
    #10 init_pe_4_inst;
    #10 init_pe_8_inst;
    #10 init_pe_12_inst;
    #10 init_pe_13_inst;
    #10 init_pe_14_inst;
    #10 init_pe_15_inst;
    #10 init_LSU_0_inst;
    #10 init_LSU_1_inst;
    #20 run = 1'b1;
    #10 run = 1'b0;
    
    end

    PEs_array pes_array (
    .clk                        (clk),
    .rst                        (rst),
    .run                        (run),
    .init_PE_array              (init_PE_array   ),
    .PE_config                  (PE_inst       ),
    .CBG_to_LSU_bus_0           ({1'b1,din_N_i}),
    .CBG_to_LSU_bus_1           ({1'b1,din_W_i}),
    .CBG_to_LSU_bus_2           ({1'b1,din_S_i}),
    .CBG_to_LSU_bus_3           ({1'b1,din_E_i}),

    .R_request_0                (),
    .R_request_1                (),
    .R_request_2                (),
    .R_request_3                (),

    .W_request_0                (), 
    .W_request_1                (), 
    .W_request_2                (), 
    .W_request_3                (), 
    
    .LSU_addr_bus_0             (), 
    .LSU_addr_bus_1             (), 
    .LSU_addr_bus_2             (), 
    .LSU_addr_bus_3             ()
    );





    task init_pe_0_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b1000};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b01000};
            PE_inst<='h966cf0;
        end
    endtask
    
    task init_pe_4_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0100};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b01000};
            PE_inst<='h964cf0;
        end
    endtask

    task init_pe_8_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0010};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b01000};
            PE_inst<='h964cf0;
        end
    endtask

    task init_pe_12_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0001};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b01000};
            PE_inst<='h965d30;
        end
    endtask
    
    task init_pe_13_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0001};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b00100};
            PE_inst<='h965d70;
        end
    endtask

    task init_pe_14_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0001};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b00010};
            PE_inst<='h965d70;
        end
    endtask

    task init_pe_15_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0001};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b00001};
            PE_inst<='h965d70;
        end
    endtask

    task init_LSU_0_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b1000};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b10000};
            PE_inst<='b11111000000;
        end
    endtask

    task init_LSU_1_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0100};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b10000};
            PE_inst<='b11111000000;
        end
    endtask

    task init_LSU_2_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0010};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b10000};
            PE_inst<='b11111000000;
        end
    endtask

    task init_LSU_3_inst;
        @(posedge clk ) begin
            {init_row_0,init_row_1,init_row_2,init_row_3}   <= {4'b0010};
            {init_LSU,init_PE_0,init_PE_1,init_PE_2,init_PE_3}  <= {5'b10000};
            PE_inst<='b11111000000;
        end
    endtask


endmodule

