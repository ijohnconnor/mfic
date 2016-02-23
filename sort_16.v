
module sort_16
   #(parameter W = 32)   
(
	input clk,             
	input reset_b,
	input [W-1:0] in_0,   
	input [W-1:0] in_1,
	input [W-1:0] in_2,
	input [W-1:0] in_3,
	input [W-1:0] in_4,
	input [W-1:0] in_5,
	input [W-1:0] in_6,
	input [W-1:0] in_7,
	input [W-1:0] in_8,
	input [W-1:0] in_9,
	input [W-1:0] in_10,
	input [W-1:0] in_11,
	input [W-1:0] in_12,
	input [W-1:0] in_13,
	input [W-1:0] in_14,
	input [W-1:0] in_15,
	output [W-1:0] out
);


//////////// stage 0 //////////////////////////////////////////	
	reg [W-1:0] sig_00;
	reg [W-1:0] sig_01;
	reg [W-1:0] sig_02;
	reg [W-1:0] sig_03;
	reg [W-1:0] sig_04;
	reg [W-1:0] sig_05;
	reg [W-1:0] sig_06;
	reg [W-1:0] sig_07;	                        
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			sig_00 <= {(W){1'b0}};
			sig_01 <= {(W){1'b0}};
			sig_02 <= {(W){1'b0}};
			sig_03 <= {(W){1'b0}};
			sig_04 <= {(W){1'b0}};
			sig_05 <= {(W){1'b0}};
			sig_06 <= {(W){1'b0}};
			sig_07 <= {(W){1'b0}};	            
		end else begin
			sig_00 <= (in_0  >=in_1 ) ? in_0  : in_1;
			sig_01 <= (in_2  >=in_3 ) ? in_2  : in_3;
			sig_02 <= (in_4  >=in_5 ) ? in_4  : in_5;
			sig_03 <= (in_6  >=in_7 ) ? in_6  : in_7;
			sig_04 <= (in_8  >=in_9 ) ? in_8  : in_9;
			sig_05 <= (in_10 >=in_11) ? in_10 : in_11;
			sig_06 <= (in_12 >=in_13) ? in_12 : in_13;
			sig_07 <= (in_14 >=in_15) ? in_14 : in_15;	
		end
///////////////////////////////////////////////////////////////		
	
//////////// stage 1 //////////////////////////////////////////	
	reg [W-1:0] sig_10;
	reg [W-1:0] sig_11;
	reg [W-1:0] sig_12;
	reg [W-1:0] sig_13;                        
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			sig_10 <= {(W){1'b0}};
			sig_11 <= {(W){1'b0}};
			sig_12 <= {(W){1'b0}};
			sig_13 <= {(W){1'b0}};            
		end else begin
			sig_10 <= (sig_00 >= sig_01 ) ? sig_00  : sig_01;
			sig_11 <= (sig_02 >= sig_03 ) ? sig_02  : sig_03;
			sig_12 <= (sig_04 >= sig_05 ) ? sig_04  : sig_05;
			sig_13 <= (sig_06 >= sig_07 ) ? sig_06  : sig_07;
		end
///////////////////////////////////////////////////////////////	
	
//////////// stage 2 //////////////////////////////////////////	
	reg [W-1:0] sig_20;
	reg [W-1:0] sig_21;                       
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			sig_20 <= {(W){1'b0}};
			sig_21 <= {(W){1'b0}};       
		end else begin
			sig_20 <= (sig_10 >= sig_11 ) ? sig_10  : sig_11;
			sig_21 <= (sig_12 >= sig_13 ) ? sig_12  : sig_13;
		end
///////////////////////////////////////////////////////////////		
	
//////////// stage 3 //////////////////////////////////////////	
	reg [W-1:0] sig_30;	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			sig_30 <= {(W){1'b0}};      
		end else begin
			sig_30 <= (sig_20 >= sig_21 ) ? sig_20  : sig_21;
		end
///////////////////////////////////////////////////////////////			
	
	assign out = sig_30;
	
endmodule


























