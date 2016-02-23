
`timescale 1ns / 10ps

module delay_mfic
   #(parameter W = 16,         // разрядность входного и выходного сигнала
     parameter D = 10)         // задержка
   (input reset_b,
    input clk,
	input [W-1:0] din,     // входной сигнал
    output [W-1:0] dout);   // выходной сигнал


	reg [W-1:0] rg [0:D-1]; 
	always @ (posedge clk, negedge reset_b) begin : delay_line
	integer i;
		if(~reset_b) begin
			for(i=0; i<D; i=i+1)
				rg[i] <= {(W){1'b0}};
		end else begin
		    rg[0] <= din;
			for(i=0; i<(D-1); i=i+1)
				rg[i+1] <= rg[i];
		end
	end

	assign dout = rg[D-1];
	
endmodule








