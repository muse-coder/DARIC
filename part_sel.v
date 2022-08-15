`include "param_define.v"
module part_sel    (
	input	clk,
	input	rst,
	input	WE_N,
	input	RE_N,
	input	[`WIDTH-1:0] R_ADR,
	input	[`WIDTH-1:0] W_ADR,
//----------single port ram_0 signal----------//
 	output 	ENABLE_0,
	output	WE_0,
	output	[`WIDTH-2:0] A_0,
//----------single port ram_1 signal----------//
 	output 	ENABLE_1,
	output	WE_1,
	output	[`WIDTH-2:0] A_1

);
	wire	R_bit, W_bit;
	wire	[`WIDTH-2:0] R_A;
	wire	[`WIDTH-2:0] W_A;
	
//--- write signal  register --------//
	reg		W_bit_D;
	reg		[`WIDTH-2:0] W_A_D;
	reg		[31:0] DI_D; 	
	reg		flag;
//----------------------------------//
	assign  {R_A,R_bit} = R_ADR;
	assign  {W_A,W_bit} = W_ADR;

//----------  read & write conflct check--------//
	assign	CONFLICT = (RE_N & WE_N )&&(R_bit ^~ W_bit ) ? 1'b1 : 1'b0;
// if conflict ,use reg to  keep write signal for 1 clk 




//------read or write select RAM_0 or RAM_1---------//
	assign  ENABLE_0 = (RE_N & ~R_bit) | (WE_N & ~W_bit) ;
	assign  ENABLE_1 = (RE_N &  R_bit) | (WE_N &  W_bit) ;
	
	assign	WE_0 = (~ (RE_N & ~R_bit) ) & ( WE_N & ~W_bit) ;
	assign	WE_1 = (~ (RE_N &  R_bit) ) & ( WE_N &  W_bit) ;
	

	assign	A_0  = (RE_N & ~R_bit)   ? R_A   :
				   (WE_N & ~W_bit) 	 ? W_A   :
				   					   R_A   ;

	assign	A_1  = (RE_N & R_bit)   ? R_A   :
				   (WE_N & W_bit)   ? W_A   :
				   					  R_A   ;

//------------------------------------//



endmodule