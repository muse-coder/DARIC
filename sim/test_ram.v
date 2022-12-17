`timescale 1ns / 1ps

module test_ram (

);
    parameter DATA_WIDTH = 32 ;
    parameter ADDR_WIDTH = 7 ;
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;
    parameter cycle = 10;
    
    reg clk0; // clock
    reg csb0; // active low chip select
    reg web0; // active low write control
    wire     [ADDR_WIDTH-1:0]  addr0;
    reg     [DATA_WIDTH-1:0]  din0;
    wire    [DATA_WIDTH-1:0] dout0;

    reg rst;
    reg     [ADDR_WIDTH-1:0]  read_addr;
    reg     [ADDR_WIDTH-1:0]  write_addr;
    
    always  #(cycle/2)  clk0 = ~ clk0;
    initial begin
        clk0 = 'b1;
        csb0 = 'b1;
        web0 = 'b0;
        rst  = 'b1;
        read_addr ='b0;
        write_addr ='b0;
        #20 rst ='b0;
        repeat(20) begin
            #10 write_data;
        end
        repeat(20) begin
            #10 read_data;
        end

        repeat(20) begin
            #10 write_data;
        end
    end
    assign addr0= ~web0 ? write_addr : read_addr;
    wire read_valid;
    sram_1rw0r0w_32_128_freepdk45 sram (
        .clk0           (clk0),
        .csb0           (csb0),
        .web0           (web0),
        .addr0          (addr0),
        .din0           (din0),
        .dout0          (dout0),
        .read_valid     (read_valid)
    );


    always @(posedge clk0 ) begin
        if(rst) din0<='d5;
        if(~web0 & ~csb0)
            write_addr <=write_addr+1'b1;
        if(web0 & ~csb0)
            read_addr <=read_addr+1'b1;

    end
    
    task write_data;
        @(posedge clk0) begin
            csb0 <= 'b0;
            web0 <= 'b0;
            din0 <= din0+'b1;
        end
    endtask

    task read_data;
        @(posedge clk0) begin
            csb0 <= 'b0;
            web0 <= 'b1;
        end
    endtask

endmodule

