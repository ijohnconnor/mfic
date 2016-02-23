

`timescale 1ns / 1ps

module write_signal
	#(parameter WIDTH = 32,
                LENGTH_OUT = 1900,
			    FILE_NAME = "output_sig_2.dat")
   (input clk,  
    input reset_b,	
    input [31:0] ind, 
    input [WIDTH-1:0] input_sig, 	
    output reg [WIDTH-1:0] sig_rom_out);
    
	
	
reg [WIDTH-1:0] rom [0:LENGTH_OUT-1];
	
always @(posedge clk, negedge reset_b) begin : ROM_write
   rom[ind] = input_sig; 
   sig_rom_out <= rom[ind];
   if (ind==LENGTH_OUT-1)
      $writememh(FILE_NAME, rom, 0, LENGTH_OUT-1); 
end	

	
	
endmodule





