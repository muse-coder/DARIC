`include "../source/param_define.v"
`timescale 1ns / 1ps

module test_BG (

);
    parameter cycle = 10;
    reg clk;
    reg rst;
    reg flush_3;        //  23:23
    reg flush_2;        //  22:22
    reg flush_1;        //  21:21
    reg flush_0;        //  20:20
	reg [1:0] BG2_fifo_sel;   //  17:16
    reg [1:0] BG3_fifo_sel;   //  19:18
	reg [1:0] BG1_fifo_sel;   //  15:14
    reg [1:0] BG0_fifo_sel;   //  13:12
	reg	BG3_en;         //	11:11
	reg	BG2_en;         // 	10:10
	reg	BG1_en;         //  9:9
	reg	BG0_en;         //  8:8

	reg	BG3_sel;//	7:7
	reg	BG2_sel;// 	6:6
	reg	BG1_sel;//  5:5
	reg	BG0_sel;//  4:4
		
	reg	BG3_mode;// 3:3
	reg	BG2_mode;//	2:2
	reg	BG1_mode;//	1:1
	reg	BG0_mode;//	0:0


//---------------end-----------------//
    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
    #10 rst = 1'b0;
        flush_3 <= 'b0;        //  23:23
        flush_2 <= 'b0;        //  22:22
        flush_1 <= 'b0;        //  21:21
        flush_0 <= 'b0;        //  20:20
        BG3_fifo_sel <= 'd2;   //  19:18
		BG2_fifo_sel <= 'd2;   //  17:16
		BG1_fifo_sel <= 'd2;   //  15:14
        BG0_fifo_sel <= 'd2;   //  13:12
		BG3_en  ='b1;         //	11:11
		BG2_en  ='b1;         // 	10:10
		BG1_en  ='b1;         //  9:9
		BG0_en  ='b1;         //  8:8

		BG3_sel ='b0;//	7:7选择数据来源 外部
		BG2_sel ='b0;// 	6:6
		BG1_sel ='b0;//  5:5
		BG0_sel ='b0;//  4:4
		
		BG3_mode='b1;// 3:3 选择模式 FIFO
		BG2_mode='b1;//	2:2
		BG1_mode='b1;//	1:1
		BG0_mode='b1;//	0:0
    end

    

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