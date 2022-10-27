
`include "../param_define.v"

module bankgroup (
    input                    clk,
    input                    rst,
    input                    en_i,
    input   [31:0]           din_i,
    input   [`A_W-1:0]       addr_i,
    input                    we_i,
    input                    re_i,
    output  [`C_L_bus-1:0]   dout_bus
);


//-----------输入数据 控制信号 和地址暂存一拍  缓解关键路径延迟------------//
    reg   [31       :0]     din;
    reg   [`A_W-1   :0]     addr;
    reg   en;
    reg   we;
    always @(posedge clk ) begin
        if(rst)
            {en , we ,  din , addr } <='b0;
        else
            begin
                addr <= addr_i;
                din  <= din_i;
                en <= (we_i | re_i ) & en_i;
                we <= we_i & ~re_i;
            end
    end
    
    wire    [31:0]  data;
    
    sram_1rw0r0w_32_256_freepdk45 sram (
        .clk0           (clk),
        .csb0           (~en),
        .web0           (~we),
        .addr0          (addr),
        .din0           (din),
        .dout0          (data)
    );
        
    assign  dout_bus =  {1'b1,data} ;                        
endmodule