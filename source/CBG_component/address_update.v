`include "../param_define.v"

module address_update (
	input   clk,
	input   rst,
	input	en,
	input	we,
	input	re,
	input	flush,

	output	we_n,
	output	re_n,
	output  reg [`A_W -1:0] rd_addr,
	output  reg [`A_W -1:0] wr_addr
	);

	reg  [`A_W -1:0] count;
	wire	almost_full;
	wire  	empty;
	wire	full ;

	assign	empty =  (count == 32'b0) ;
	assign	full  =  (count == `F_D) ;
	assign	almost_full = ((count + 1'b1) == `F_D) ;
	assign	re_n  = en & (re & ~empty  | almost_full );
	assign	we_n  = en & ((we & ~full) | (we & re & full ));
    

	always @(posedge clk ) begin
		if((rst | flush)) begin
			rd_addr <= 32'b0;
			wr_addr <= 32'b0;
		end
		else begin
            if(re_n)  rd_addr <= (rd_addr == `F_D - 1'b1) ? 32'b0 : rd_addr + 1'b1;   
            if(we_n)  wr_addr <= (wr_addr == `F_D - 1'b1) ? 32'b0 : wr_addr + 1'b1;
        end
	end


	always @(posedge clk ) begin
		if((rst | flush)) begin
			count	<= 32'b0;
		end

		else if(re_n & ~we_n) begin
			count   <= count - 1'b1;
		end

		else if(we_n & ~re_n ) begin
			count   <= count + 1'b1;
		end

		else 
			count	<= count;
	end 

endmodule