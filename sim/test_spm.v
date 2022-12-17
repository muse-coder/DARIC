`include "../source/param_define.v"
`timescale 1ns / 1ps

module test_spm (

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

    wire [`SPM_INST-1:0]     inst_r;
//---------------end-----------------//

    assign  inst_r= {
        flush_3,        //  23:23
        flush_2,        //  22:22
        flush_1,        //  21:21
        flush_0,        //  20:20
        BG3_fifo_sel,   //  19:18
		BG2_fifo_sel,   //  17:16
		BG1_fifo_sel,   //  15:14
        BG0_fifo_sel,   //  13:12
		BG3_en,         //	11:11
		BG2_en,         // 	10:10
		BG1_en,         //  9:9
		BG0_en,         //  8:8

		BG3_sel,//	7:7
		BG2_sel,// 	6:6
		BG1_sel,//  5:5
		BG0_sel,//  4:4
		
		BG3_mode,// 3:3
		BG2_mode,//	2:2
		BG1_mode,//	1:1
		BG0_mode//	0:0
	};
    reg init,run;
    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        init =1'b0;
        run =1'b0;
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
    #10 init<=1;
    #10 run<=1;
        init<=0;
    #10 run<=0;
        repeat(10) begin
        #10    write_bg;    
        end
    
        repeat(10) begin
        #10    read_bg;    
        end
    
    end

    



    wire    [`EX_in_bus-1  :0]	ex_in_bus;
	reg ex_wen_3;		//167:167
	reg ex_wen_2;		//166:166
	reg ex_wen_1;		//165:165
	reg ex_wen_0;		//164:164
	reg ex_ren_3;		//163:163
	reg ex_ren_2;		//162:162
	reg ex_ren_1;		//161:161
	reg ex_ren_0;		//160:160
	reg [7:0] ex_addr_3;	    //159:152
	reg [7:0] ex_addr_2;	    //151:144
	reg [7:0] ex_addr_1;	    //143:136
	reg [7:0] ex_addr_0;	    //135:128
	reg [31:0] ex_data_3;		//127:96
	reg [31:0] ex_data_2;		//95:64
	reg [31:0] ex_data_1;		//63:32
	reg [31:0] ex_data_0;
    assign ex_in_bus = 
		{ex_wen_3,		//167:167
		ex_wen_2,		//166:166
		ex_wen_1,		//165:165
		ex_wen_0,		//164:164
		ex_ren_3,		//163:163
		ex_ren_2,		//162:162
		ex_ren_1,		//161:161
		ex_ren_0,		//160:160
		ex_addr_3,	    //159:152
		ex_addr_2,	    //151:144
		ex_addr_1,	    //143:136
		ex_addr_0,	    //135:128
		ex_data_3,		//127:96
		ex_data_2,		//95:64
		ex_data_1,		//63:32
		ex_data_0
    };	



    task write_bg;
        @(posedge clk) begin
	        ex_wen_3 <= 'b1;
            ex_wen_2 <= 'b1;
            ex_wen_1 <= 'b1;
            ex_wen_0 <= 'b1;
            ex_ren_3 <= 'b0;
            ex_ren_2 <= 'b0;
            ex_ren_1 <= 'b0;
            ex_ren_0 <= 'b0;            
        end
    endtask

    task read_bg;
        @(posedge clk) begin
	        ex_ren_3 <= 'b1;
            ex_ren_2 <= 'b1;
            ex_ren_1 <= 'b1;
            ex_ren_0 <= 'b1;            
        end
    endtask

    always @(posedge clk ) begin
        if(rst) begin
            ex_data_3 <='d1;
            ex_data_2 <='d11;
            ex_data_1 <='d111;
            ex_data_0 <='d1111;
	        ex_wen_3 = 'b0;
            ex_wen_2 = 'b0;
            ex_wen_1 = 'b0;
            ex_wen_0 = 'b0;
            ex_ren_3 = 'b0;
            ex_ren_2 = 'b0;
            ex_ren_1 = 'b0;
            ex_ren_0 = 'b0;    
        end
        else begin
	        ex_data_3 <= ex_wen_3 ? ex_data_3+'b1 :ex_data_3 ;
            ex_data_2 <= ex_wen_2 ? ex_data_2+'b1 :ex_data_2 ;
            ex_data_1 <= ex_wen_1 ? ex_data_1+'b1 :ex_data_1 ;
            ex_data_0 <= ex_wen_0 ? ex_data_0+'b1 :ex_data_0 ;
	        
            ex_addr_3 <= ex_wen_3 ? ex_data_3+'b1 :ex_data_3 ;
            ex_addr_2 <= ex_wen_2 ? ex_addr_2+'b1 :ex_data_2 ;
            ex_addr_1 <= ex_wen_1 ? ex_addr_1+'b1 :ex_data_1 ;
            ex_addr_0 <= ex_wen_0 ? ex_addr_0+'b1 :ex_data_0 ;
        end
    end


    scratchpad scr (
	    .clk    (clk),
	    .rst    (rst),
	    .inst   (inst_r),
        .init   (init),
        .run    (run),
	    .ex_in_bus      (ex_in_bus),
	    .switch_in_3    (),
	    .switch_in_2    (),
	    .switch_in_1    (),
	    .switch_in_0    (),
	
	    .switch_out_3   (),
	    .switch_out_2   (),
	    .switch_out_1   (),
	    .switch_out_0   (),
        .ex_out_bus     ()
        );



endmodule