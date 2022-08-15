module PE_crossbar_9x6 (
    input   [31:0]  din_N,
    input   [31:0]  din_S,
    input   [31:0]  din_W,
    input   [31:0]  din_E,
    input   [31:0]  din_R0,
    input   [31:0]  din_R1,
    input   [31:0]  din_R2,
    input   [31:0]  din_R3,
    input   [31:0]  fu_res,
    input   [23:0]  switch,
    output  reg [31:0]  operand_A,  
    output  reg [31:0]  operand_B,
    output  reg [31:0]  dout_N,
    output  reg [31:0]  dout_S,
    output  reg [31:0]  dout_W,
    output  reg [31:0]  dout_E
);
    wire    [3:0]   dout_N_sel;
    wire    [3:0]   dout_S_sel;
    wire    [3:0]   dout_W_sel;
    wire    [3:0]   dout_E_sel;
    wire    [3:0]   op_A_sel;
    wire    [3:0]   op_B_sel;
    wire    [3:0]   res_sel;
    
    assign  {
        op_A_sel, //23:20
        op_B_sel, //19:16
        dout_N_sel,//15:12
        dout_S_sel,//11:8
        dout_W_sel,//7:4
        dout_E_sel //3:0
    } = switch;
    
    
    always @(*) begin
        case (dout_N_sel)
            4'd0:   dout_N = din_N  ;
            4'd1:   dout_N = din_S  ; 
            4'd2:   dout_N = din_W  ; 
            4'd3:   dout_N = din_E  ; 
            4'd4:   dout_N = din_R0 ; 
            4'd5:   dout_N = din_R1 ; 
            4'd6:   dout_N = din_R2 ;
            4'd7:   dout_N = din_R3 ;
            4'd8:   dout_N = fu_res ;
        default:    dout_N = 32'hffffffff;
        endcase
    end

    always @(*) begin
        case (dout_S_sel)
            4'd0:   dout_S = din_N  ;
            4'd1:   dout_S = din_S  ; 
            4'd2:   dout_S = din_W  ; 
            4'd3:   dout_S = din_E  ; 
            4'd4:   dout_S = din_R0 ; 
            4'd5:   dout_S = din_R1 ; 
            4'd6:   dout_S = din_R2 ;
            4'd7:   dout_S = din_R3 ;
            4'd8:   dout_S = fu_res ;
        default:    dout_S = 32'hffffffff;
        endcase
    end

    always @(*) begin
        case (dout_W_sel)
            4'd0:   dout_W = din_N  ;
            4'd1:   dout_W = din_S  ; 
            4'd2:   dout_W = din_W  ; 
            4'd3:   dout_W = din_E  ; 
            4'd4:   dout_W = din_R0 ; 
            4'd5:   dout_W = din_R1 ; 
            4'd6:   dout_W = din_R2 ;
            4'd7:   dout_W = din_R3 ;
            4'd8:   dout_W = fu_res ;
        default:    dout_W = 32'hffffffff;
        endcase
    end

    always @(*) begin
        case (dout_E_sel)
            4'd0:   dout_E = din_N  ;
            4'd1:   dout_E = din_S  ; 
            4'd2:   dout_E = din_W  ; 
            4'd3:   dout_E = din_E  ; 
            4'd4:   dout_E = din_R0 ; 
            4'd5:   dout_E = din_R1 ; 
            4'd6:   dout_E = din_R2 ;
            4'd7:   dout_E = din_R3 ;
            4'd8:   dout_E = fu_res ;
        default:    dout_E = 32'hffffffff;
        endcase
    end

    always @(*) begin
        case (op_A_sel)
            4'd0:   operand_A = din_N  ;
            4'd1:   operand_A = din_S  ; 
            4'd2:   operand_A = din_W  ; 
            4'd3:   operand_A = din_E  ; 
            4'd4:   operand_A = din_R0 ; 
            4'd5:   operand_A = din_R1 ; 
            4'd6:   operand_A = din_R2 ;
            4'd7:   operand_A = din_R3 ;
            4'd8:   operand_A = fu_res ;
        default:    operand_A = 32'hffffffff;
        endcase
    end

    always @(*) begin
        case (op_B_sel)
            4'd0:   operand_B = din_N  ;
            4'd1:   operand_B = din_S  ; 
            4'd2:   operand_B = din_W  ; 
            4'd3:   operand_B = din_E  ; 
            4'd4:   operand_B = din_R0 ; 
            4'd5:   operand_B = din_R1 ; 
            4'd6:   operand_B = din_R2 ;
            4'd7:   operand_B = din_R3 ;
            4'd8:   operand_B = fu_res ;
        default:    operand_B = 32'hffffffff;
        endcase
    end

endmodule