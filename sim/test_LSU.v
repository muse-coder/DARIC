`include "../source/param_define.v"
`timescale 1ns / 1ps

module test_PE_array (

);
    parameter cycle = 10;
    reg clk;
    reg rst;
    always  #(cycle/2)  clk = ~ clk;
    
    reg ren;     
    reg wen;     
    reg [1:0]   r_sel;   
    reg [1:0]   w_sel;   
    reg [1:0]   addr_sel;
    reg [1:0]   store_sel;
    wire [`L_I_W-1  :0]  LSU_inst;
    assign LSU_inst =  {
        ren,      //10:10
        wen,      //9:9
        r_sel,    //8:7
        w_sel,    //6:5
        addr_sel, //4:3
        store_sel //0:0
    } ;

    initial begin
        clk = 1'b1;
        rst = 1'b1;
    #10 rst = 1'b0;    
    end


    task init_LSU_0_inst;
        @(posedge clk ) begin
        ren       <=  'b0;      //10:10
        wen       <=  'b0;      //9:9
        r_sel     <=  'b0;    //8:7
        w_sel     <=  'b0;    //6:5
        addr_sel  <=  'b0; //4:3
        store_sel <= 'b0 ;
        end
    endtask


endmodule

