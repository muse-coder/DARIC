`include "../param_define.v"

module bankgroup (
    input                    clk,
    input                    rst,
    input                    en_i,
    input   [31:0]           din_i,
    input                    pattern_i,//0：随机访存  // 1：FIFO模式
    input   [`A_W-1:0]       addr_i,
    input                    we_i,
    input                    re_i,
    input   [1:0]            fifo_sel_i,
    input                    flush_i,
    output  [`C_L_bus-1:0]   dout_bus
);
    wire    ram_sel;
    wire    [`A_W-2:0]    random_addr;
    
    parameter    fifo_0_start = 32'b0;
    parameter    fifo_1_start = 32'b0 + `F_D >> 1;
    parameter    fifo_2_start = 32'b0 + `F_D  ;
    parameter    random_start = 32'b0 + `F_D  + (`F_D >> 1)  ;


//-----------输入数据 控制信号 和地址暂存一拍  缓解关键路径延迟------------//
    reg   [31       :0]     din;
    reg   [`A_W-1   :0]     addr;
    reg   [1        :0]     fifo_sel;
    reg   en;
//---------------解决巨大扇出问题--------------//
    (* max_fanout = "5" *)   reg   pattern_0;
    (* max_fanout = "5" *)   reg   pattern_1;
    (* max_fanout = "5" *)   reg   pattern_2;//0：随机访存  // 1：FIFO模式
    (* max_fanout = "10" *)  reg   pattern_3_w;//0：随机访存  // 1：FIFO模式
    (* max_fanout = "10" *)  reg   pattern_3_r;//0：随机访存  // 1：FIFO模式
    (* max_fanout = "10" *)  reg   pattern_3_addr_0;//0：随机访存  // 1：FIFO模式
    (* max_fanout = "10" *)  reg   pattern_3_addr_1;//0：随机访存  // 1：FIFO模式
    (* max_fanout = "10" *)  reg   pattern_3_en;//0：随机访存  // 1：FIFO模式
    
    reg   we;
    reg   re;
    reg   flush;
       
    always @(posedge clk ) begin
        if(rst)
            {en , pattern_0, pattern_1, pattern_2, pattern_3_w, pattern_3_r, pattern_3_addr_0 ,pattern_3_addr_1 , pattern_3_en, we , re , flush , din , addr , fifo_sel } <='b0;
        else
            {en   , pattern_0,  pattern_1, pattern_2, we ,   re ,   flush , din , addr , fifo_sel} <=     
            {en_i , pattern_i , pattern_i ,pattern_i , we_i , re_i , flush_i , din_i , addr_i , fifo_sel_i };
            { pattern_3_w, pattern_3_r, pattern_3_addr_0, pattern_3_addr_1 , pattern_3_en } <= 
                {pattern_i,pattern_i,   pattern_i, pattern_i ,   pattern_i};
    
    end
//------------------end---------------------------//
    assign  {
        random_addr,//9:1
        ram_sel     //0:0
    }   = addr ;
// ---------模式选择---------------//
    wire    fifo_0_en;
    wire    fifo_1_en;
    wire    fifo_2_en;
    // wire    random_en;
    assign  {fifo_0_en, fifo_1_en, fifo_2_en} = (({3'b100} >> fifo_sel) & {pattern_0 , pattern_1 ,pattern_2});

//-----------fifo 0 号--------------//

    wire    [`A_W-2:0]  fifo_0_addr_0;
    wire    [`A_W-2:0]  fifo_0_addr_1;

    wire    fifo_0_en_0;
    wire    fifo_0_en_1;
    wire    fifo_0_we_0;
    wire    fifo_0_we_1;
    fifo  fifo_0(
	    .clk        (clk        ),
	    .rst        (rst        ),
        .en         (fifo_0_en  ),
	    .RE         (re         ),
	    .WE         (we         ),
        .flush      (flush      ),
//----------single port ram_0 signal----------//
 	    .ENABLE_0   (fifo_0_en_0   ),
	    .WE_0       (fifo_0_we_0   ),
	    .A_0        (fifo_0_addr_0 ),
//----------single port ram_1 signal----------//
 	    .ENABLE_1   (fifo_0_en_1   ),
	    .WE_1       (fifo_0_we_1   ),
	    .A_1        (fifo_0_addr_1)
    );
//-------------end-------------//


//-----------fifo 1 号--------------//

    wire    [`A_W-2:0]  fifo_1_addr_0;
    wire    [`A_W-2:0]  fifo_1_addr_1;

    wire    fifo_1_en_0;
    wire    fifo_1_en_1;
    wire    fifo_1_we_0;
    wire    fifo_1_we_1;
    fifo  fifo_1(
	    .clk        (clk        ),
	    .rst        (rst        ),
        .en         (fifo_1_en  ),
	    .RE         (re         ),
	    .WE         (we         ),
        .flush      (flush      ),
//----------single port ram_0 signal----------//
 	    .ENABLE_0   (fifo_1_en_0   ),
	    .WE_0       (fifo_1_we_0   ),
	    .A_0        (fifo_1_addr_0),
//----------single port ram_1 signal----------//
 	    .ENABLE_1   (fifo_1_en_1   ),
	    .WE_1       (fifo_1_we_1   ),
	    .A_1        (fifo_1_addr_1)
    );
//-------------end-------------//

//-----------fifo 2 号--------------//

    wire    [`A_W-2:0]  fifo_2_addr_0;
    wire    [`A_W-2:0]  fifo_2_addr_1;

    wire    fifo_2_en_0;
    wire    fifo_2_en_1;
    wire    fifo_2_we_0;
    wire    fifo_2_we_1;
    fifo  fifo_2(
	    .clk        (clk        ),
	    .rst        (rst        ),
        .en         (fifo_2_en  ),
	    .RE         (re         ),
	    .WE         (we         ),
        .flush      (flush      ),
//----------single port ram_0 signal----------//
 	    .ENABLE_0   (fifo_2_en_0   ),
	    .WE_0       (fifo_2_we_0   ),
	    .A_0        (fifo_2_addr_0),
//----------single port ram_1 signal----------//
 	    .ENABLE_1   (fifo_2_en_1   ),
	    .WE_1       (fifo_2_we_1   ),
	    .A_1        (fifo_2_addr_1)
    );
//-------------end-------------//
    wire    FIFO_EN_0;
    wire    FIFO_EN_1;

    wire    FIFO_WE_0;
    wire    FIFO_WE_1;
    
    wire    [`A_W-2:0]    FIFO_ADDR_0;
    wire    [`A_W-2:0]    FIFO_ADDR_1;
    
    assign  FIFO_EN_0 = (fifo_sel == 2'b00) ? fifo_0_en_0 :
                        (fifo_sel == 2'b01) ? fifo_1_en_0 :
                        (fifo_sel == 2'b10) ? fifo_2_en_0 :
                                                1'b0; 

    assign  FIFO_EN_1 = (fifo_sel == 2'b00) ? fifo_0_en_1 :
                        (fifo_sel == 2'b01) ? fifo_1_en_1 :
                        (fifo_sel == 2'b10) ? fifo_2_en_1 :
                                                1'b0;

    assign  FIFO_WE_0 = (fifo_sel == 2'b00) ? fifo_0_we_0 :
                        (fifo_sel == 2'b01) ? fifo_1_we_0 :
                        (fifo_sel == 2'b10) ? fifo_2_we_0 :
                                                1'b0;

    assign  FIFO_WE_1 = (fifo_sel == 2'b00) ? fifo_0_we_1 :
                        (fifo_sel == 2'b01) ? fifo_1_we_1 :
                        (fifo_sel == 2'b10) ? fifo_2_we_1 :
                                                1'b0;

    assign  FIFO_ADDR_0 =   (fifo_sel == 2'b00) ? fifo_0_addr_0 + fifo_0_start  :
                            (fifo_sel == 2'b01) ? fifo_1_addr_0 + fifo_1_start  :
                            (fifo_sel == 2'b10) ? fifo_2_addr_0 + fifo_2_start  :
                                                    32'b0;

    assign  FIFO_ADDR_1 =   (fifo_sel == 2'b00) ? fifo_0_addr_1 + fifo_0_start  :
                            (fifo_sel == 2'b01) ? fifo_1_addr_1 + fifo_1_start  :
                            (fifo_sel == 2'b10) ? fifo_2_addr_1 + fifo_2_start  :
                                                    32'b0;

    wire    [`A_W-2:0]    ram_0_addr;
    wire    ram_0_en;
    wire    ram_0_we;
    wire    [`A_W-2:0]    ram_1_addr;
    wire    ram_1_en;
    wire    ram_1_we;

//------------ram_0----------------//
    assign  ram_0_en =  pattern_3_en  ?  FIFO_EN_0 :
                        ~ram_sel ?  1'b1 & en:
                                    1'b0;

    assign  ram_0_we    = pattern_3_w ? FIFO_WE_0 :
                                    we       ;

    assign  ram_0_addr = pattern_3_addr_0 ?  FIFO_ADDR_0 :
                                    random_addr + random_start ;

//------------ram_1----------------//
    assign  ram_1_en =  pattern_3_en ?  FIFO_EN_1 :
                        ram_sel  ?  1'b1 & en:
                                    1'b0;
                           
    assign  ram_1_we    = pattern_3_w ? FIFO_WE_1 :
                                    we       ;

    assign  ram_1_addr = pattern_3_addr_1 ?  FIFO_ADDR_1 :
                                    random_addr + random_start;
//-------------end-----------------//
    
    wire    [31:0] data0,data1;
    wire    read_valid_0;
    wire    read_valid_1;
    
    single_port_ram RAM_0(
        .clk        (clk            ),
        .rst        (rst            ),
        .ena        (ram_0_en       ),
        .wea        (ram_0_we       ),
        .flush      (flush          ),
       	.din        (din            ),
    	.addr       (ram_0_addr     ),
        .read_valid (read_valid_0   ),
    	.dout       (data0)
    );
    
    single_port_ram RAM_1(
        .clk        (clk            ),
        .rst        (rst            ),
        .ena        (ram_1_en       ),
        .wea        (ram_1_we       ),
        .flush      (flush          ),
       	.din        (din            ),
    	.addr       (ram_1_addr     ),
        .read_valid (read_valid_1   ),
    	.dout       (data1)
    );
    
    assign  dout_bus =  read_valid_0 ? {read_valid_0,data0} :
                        read_valid_1 ? {read_valid_1,data1} :
                                                  'hffffffff; 
    
endmodule