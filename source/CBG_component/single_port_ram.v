`include "../param_define.v"

module single_port_ram (
	input	clk,
	input	rst,
	input	ena,
	input	wea,
	input	flush,
	input	[31:0]	din,
	input	[8:0] addr,
	output reg [31:0]	dout,
	output reg read_valid
);
	parameter  num = 32'b1<<`A_W;
	reg [31:0] ram[num-1:0];
	integer i;
	reg		write_valid;
	always @(posedge clk ) begin
		if((rst | flush)) begin
			for (i = 0;i<num ;i=i+1 ) begin
				ram[i] <= 32'b0;
			end
			dout <= 32'hffffffff;			
			read_valid <=1'b0;
			write_valid<=1'b0;
		end

		else if (ena && wea) begin
			ram[addr] <= din;
			read_valid <= 1'b0;
			write_valid<=1'b1;
		end 

		else if (ena && ~wea) begin
			dout <= ram[addr];
			read_valid <=1'b1;
			write_valid<=1'b0;
		end

		else begin
			read_valid <=1'b0;
			write_valid<=1'b0;			
		end
	end
	

endmodule