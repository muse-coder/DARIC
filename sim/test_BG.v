`include "../source/param_define.v"
`timescale 1ns / 1ps

module test_BG (

);
    parameter cycle = 10;
    reg clk;
    reg rst;
    
    reg                    en_i;
    reg   [31:0]           din_i;
    reg                    pattern_i;//0：随机访存  // 1：FIFO模式
    reg   [`A_W-1:0]       addr_i;
    reg                    we_i;
    reg                    re_i;
    reg   [1:0]            fifo_sel_i;
    reg                    flush_i;
    wire  [`C_L_bus-1:0]   dout_bus;




//---------------end-----------------//
    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
    #10 rst = 1'b0;
        re_i= 'b0;
        we_i= 'b0; 
        repeat (6 )begin
        #10    write_data_fifo_1;
        end
        repeat (6) begin
        #10    read_fifo_1; 
        end
    end

    task write_data_fifo_1;
        @(posedge clk)begin
            en_i <= 'b1;
            pattern_i <='b1;
            fifo_sel_i<='d1;
            we_i <='b1;
        end
    endtask

    task read_fifo_1;
        @(posedge clk) begin
            en_i <= 'b1;
            pattern_i <='b1;
            fifo_sel_i<='d1;
            re_i <= 'b1;
        end
    
    endtask

    always @(posedge clk ) begin
        if(rst) begin
            din_i <='d1;
            addr_i<='d0;
        end

        else if(we_i) begin
            din_i <=din_i +'b1;
            addr_i<=addr_i+'b1;
        end
    end

    bankgroup bg0(
    .clk                (clk),
    .rst                (rst),
    .en_i               (en_i ),
    .din_i              (din_i),
    .pattern_i          (pattern_i),//0：随机访存  // 1：FIFO模式
    .addr_i             (addr_i),
    .we_i               (we_i),
    .re_i               (re_i),
    .fifo_sel_i         (fifo_sel_i),
    .flush_i            (flush_i   ),
    .dout_bus           (dout_bus)
    );


endmodule