`include "../source/param_define.v"
`timescale 1ns / 1ps
//task 1  
//       C0 C1 stage
//        din_N ->din_0 
//        din_W ->din_1
//        din_S ->din_2
//        din_E ->din_3

//      regfile stage
//        res ->dout_R0
//        dout_R0 ->dout_R1
//        dout_R1 ->dout_R2
//        dout_R2 ->dout_R3

//      crossbar stage
//      din_0 -> op_A        
//      din_1 -> op_B        
//      din_0   -> dout_N        
//      din_1   -> dout_W        
//      dout_R2 -> dout_S
//      dout_R3 -> dout_E
// 
//

module test_PE_0 (

);
    parameter cycle = 10;
    reg clk;
    reg rst;
    
    wire   [31:0]               PE_0_dout_N  ;
    wire   [31:0]               PE_0_dout_S  ;
    wire   [31:0]               PE_0_dout_W  ;
    wire   [31:0]               PE_0_dout_E  ;
    reg  init,run;

    reg [27:0]   PE_inst ;
    reg [31:0]   din_N_i ;
    reg [31:0]   din_S_i ;
    reg [31:0]   din_W_i ;
    reg [31:0]   din_E_i ;
//---------------end-----------------//
    always  #(cycle/2)  clk = ~ clk;
    integer i;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
    #10 rst = 1'b0;    
        init ='b1;
        PE_inst='h965b70;
    #20 init ='b0;
        run ='b1;
    #10 run ='b0;
    end

    reg   init_i;
    reg   [27:0] PE_inst_i;
    reg   run_i;

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


    always @(posedge clk ) begin
        init_i  <= init;
        run_i  <= run;
        PE_inst_i =PE_inst;  
    end

    PE_D  pe_0(
        .clk            (clk            ),
        .rst            (rst            ),
        .PE_inst        (PE_inst_i      ),
        .init           (init_i           ),
        .run            (run_i            ),
        .din_N          (din_N_i          ),//上
        .din_W          (din_W_i          ),//下
        .din_S          (din_S_i          ),//左 
        .din_E          (din_E_i          ),
        .dout_N         (PE_0_dout_N    ),
        .dout_S         (PE_0_dout_S    ),
        .dout_W         (PE_0_dout_W    ),
        .dout_E         (PE_0_dout_E    )
    );

endmodule