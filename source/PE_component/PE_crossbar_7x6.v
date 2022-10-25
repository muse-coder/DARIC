`include "../param_define.v"

module PE_crossbar_7x6 (
    input   [`PE_7x6-1:0]  switch_7x6,
    input   [31:0]  din_0,
    input   [31:0]  din_1,
    input   [31:0]  dout_R0,
    input   [31:0]  dout_R1,
    input   [31:0]  dout_R2,
    input   [31:0]  dout_R3,
    input   [31:0]  din_res,
    output  reg [31:0]  operand_A,  
    output  reg [31:0]  operand_B,
    output  reg [31:0]  dout_N,
    output  reg [31:0]  dout_S,
    output  reg [31:0]  dout_W,
    output  reg [31:0]  dout_E
);
    wire    [2:0]   dout_N_sel    ;
    wire    [2:0]   dout_S_sel    ;
    wire    [2:0]   dout_W_sel    ;
    wire    [2:0]   dout_E_sel    ;
    wire    [2:0]   op_A_sel      ;
    wire    [2:0]   op_B_sel      ;
    
    assign  {
        op_A_sel,       //17:15
        op_B_sel,       //14:12
        dout_N_sel,     //11:9
        dout_S_sel,     //8:6
        dout_W_sel,     //5:3
        dout_E_sel      //2:0
    } = switch_7x6;
    
    
    always @(*) begin
        case (dout_N_sel)
            3'd0:   dout_N = dout_R0 ;
            3'd1:   dout_N = dout_R1 ; 
            3'd2:   dout_N = dout_R2 ; 
            3'd3:   dout_N = dout_R3 ; 
            3'd4:   dout_N = din_0   ; 
            3'd5:   dout_N = din_1   ; 
            3'd6:   dout_N = din_res ;
            default:dout_N = 'b0     ;
        endcase
    end

    always @(*) begin
        case (dout_S_sel)
            3'd0:   dout_S = dout_R0 ;
            3'd1:   dout_S = dout_R1 ; 
            3'd2:   dout_S = dout_R2 ; 
            3'd3:   dout_S = dout_R3 ; 
            3'd4:   dout_S = din_0   ; 
            3'd5:   dout_S = din_1   ; 
            3'd6:   dout_S = din_res ;
            default:dout_S = 'b0     ;
        endcase
    end

    always @(*) begin
        case (dout_W_sel)
            3'd0:   dout_W = dout_R0 ;
            3'd1:   dout_W = dout_R1 ; 
            3'd2:   dout_W = dout_R2 ; 
            3'd3:   dout_W = dout_R3 ; 
            3'd4:   dout_W = din_0   ; 
            3'd5:   dout_W = din_1   ; 
            3'd6:   dout_W = din_res ;
            default:dout_W = 'b0     ;
        endcase
    end

    always @(*) begin
        case (dout_E_sel)
            3'd0:   dout_E = dout_R0 ;
            3'd1:   dout_E = dout_R1 ; 
            3'd2:   dout_E = dout_R2 ; 
            3'd3:   dout_E = dout_R3 ; 
            3'd4:   dout_E = din_0   ; 
            3'd5:   dout_E = din_1   ; 
            3'd6:   dout_E = din_res ;
            default:dout_E = 'b0     ;
        endcase
    end

    always @(*) begin
        case (op_A_sel)
            3'd0:   operand_A = dout_R0 ;
            3'd1:   operand_A = dout_R1 ; 
            3'd2:   operand_A = dout_R2 ; 
            3'd3:   operand_A = dout_R3 ; 
            3'd4:   operand_A = din_0   ; 
            3'd5:   operand_A = din_1   ; 
            3'd6:   operand_A = din_res ;
            default:operand_A = 'b0     ;
        endcase
    end

    always @(*) begin
        case (op_B_sel)
            3'd0:   operand_B = dout_R0 ;
            3'd1:   operand_B = dout_R1 ; 
            3'd2:   operand_B = dout_R2 ; 
            3'd3:   operand_B = dout_R3 ; 
            3'd4:   operand_B = din_0  ; 
            3'd5:   operand_B = din_1  ; 
            3'd6:   operand_B = din_res;
            default:operand_B = 'b0     ;
        endcase
    end

endmodule