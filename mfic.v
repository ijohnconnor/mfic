
module mfic
(
	input clk, 
    input clk_200,	
	input reset_b,
	input strobe,
	input [31:0] in_0,   
	input [31:0] in_1,
	input [31:0] in_2,
	input [31:0] in_3,
	input [31:0] in_4,
	input [31:0] in_5,
	input [31:0] in_6,
	input [31:0] in_7,
	input [31:0] in_8,
	input [31:0] in_9,
	input [31:0] in_10,
	input [31:0] in_11,
	input [31:0] in_12,
	input [31:0] in_13,
	input [31:0] in_14,
	input [31:0] in_15,
	input [31:0] th_coef,
	input [15:0] azimuth,
	output [31:0] sig_out,
	output reg [31:0] ena_out,
	output [31:0] clk_out
	//output reg [89:0] word,
	//output reg wr_word
);


////// find maximum (delay 4 cycles) ///////
	wire [31:0] in_max;   
	sort_16  #(.W(32))  sort_16_inst 
	(   .clk     ( clk     ),         
		.reset_b ( reset_b ),
		.in_0    ( in_0    ),
		.in_1    ( in_1    ),
		.in_2    ( in_2    ),
		.in_3    ( in_3    ),
		.in_4    ( in_4    ),
		.in_5    ( in_5    ),
		.in_6    ( in_6    ),
		.in_7    ( in_7    ),
		.in_8    ( in_8    ),
		.in_9    ( in_9    ),
		.in_10   ( in_10   ),
		.in_11   ( in_11   ),
		.in_12   ( in_12   ),
		.in_13   ( in_13   ),
		.in_14   ( in_14   ),
		.in_15   ( in_15   ),
		.out     ( in_max  ));
////////////////////////////////////////////


//////////// thresh calculate /////////////////////////
	reg [63:0] th_mult;	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			th_mult <= 64'd0;      
		end else begin
			th_mult <= th_coef*in_max;
		end
	wire [31:0] thresh = th_mult[62:31];
////////////////////////////////////////////////////// 

////////// delay for input signal ///////////////////////////////////////////////////
    wire [32*16-1:0] del_in = { in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7,
		                       in_8, in_9, in_10, in_11, in_12, in_13, in_14, in_15};
    wire [32*16-1:0] del_out;							   
	delay_mfic  #(.W(16*32), .D(5)) delay_inst0       
	   (.reset_b  (reset_b),
		.clk      (clk),
		.din      (del_in),     
		.dout     (del_out)); 	
    wire [31:0] in_0d, in_1d, in_2d, in_3d, in_4d, in_5d, in_6d, in_7d,
	             in_8d, in_9d, in_10d, in_11d, in_12d, in_13d, in_14d, in_15d;		
    assign { in_0d, in_1d, in_2d, in_3d, in_4d, in_5d, in_6d, in_7d,
	         in_8d, in_9d, in_10d, in_11d, in_12d, in_13d, in_14d, in_15d} = del_out;
/////////////////////////////////////////////////////////////////////////////////////



/////////////// latch signal ////////////////////////////
	reg signed [31:0] s [0:15];	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			s[0 ] <= 32'd0;
			s[1 ] <= 32'd0;
			s[2 ] <= 32'd0;
			s[3 ] <= 32'd0;
			s[4 ] <= 32'd0;
			s[5 ] <= 32'd0;
			s[6 ] <= 32'd0;
			s[7 ] <= 32'd0;
			s[8 ] <= 32'd0;
			s[9 ] <= 32'd0;
			s[10] <= 32'd0;	
			s[11] <= 32'd0;	
			s[12] <= 32'd0;	
			s[13] <= 32'd0;	
			s[14] <= 32'd0;	
			s[15] <= 32'd0;
		end else begin  
			s[0 ] <= in_0d;
			s[1 ] <= in_1d;	
			s[2 ] <= in_2d;	
			s[3 ] <= in_3d;	
			s[4 ] <= in_4d;	
			s[5 ] <= in_5d;	
			s[6 ] <= in_6d;	
			s[7 ] <= in_7d;	
			s[8 ] <= in_8d;	
			s[9 ] <= in_9d;	
			s[10] <= in_10d;	
			s[11] <= in_11d;	
			s[12] <= in_12d;	
			s[13] <= in_13d;	
			s[14] <= in_14d;	
			s[15] <= in_15d;
		end	
/////////////////////////////////////////////////////////




//////////// find local maximum /////////////////////////////////////////////////////
    //// maximum detection
	reg [15:0] det_max;	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			det_max <= 16'd0;
		end else begin  
			det_max[0 ] <= (in_15d < in_0d ) & (in_0d  > in_1d ) & (in_0d  > thresh);
			det_max[1 ] <= (in_0d  < in_1d ) & (in_1d  > in_2d ) & (in_1d  > thresh);
			det_max[2 ] <= (in_1d  < in_2d ) & (in_2d  > in_3d ) & (in_2d  > thresh);
			det_max[3 ] <= (in_2d  < in_3d ) & (in_3d  > in_4d ) & (in_3d  > thresh);
			det_max[4 ] <= (in_3d  < in_4d ) & (in_4d  > in_5d ) & (in_4d  > thresh);
			det_max[5 ] <= (in_4d  < in_5d ) & (in_5d  > in_6d ) & (in_5d  > thresh);
			det_max[6 ] <= (in_5d  < in_6d ) & (in_6d  > in_7d ) & (in_6d  > thresh);
			det_max[7 ] <= (in_6d  < in_7d ) & (in_7d  > in_8d ) & (in_7d  > thresh);
			det_max[8 ] <= (in_7d  < in_8d ) & (in_8d  > in_9d ) & (in_8d  > thresh);
			det_max[9 ] <= (in_8d  < in_9d ) & (in_9d  > in_10d) & (in_9d  > thresh);
			det_max[10] <= (in_9d  < in_10d) & (in_10d > in_11d) & (in_10d > thresh);
			det_max[11] <= (in_10d < in_11d) & (in_11d > in_12d) & (in_11d > thresh);
			det_max[12] <= (in_11d < in_12d) & (in_12d > in_13d) & (in_12d > thresh);
			det_max[13] <= (in_12d < in_13d) & (in_13d > in_14d) & (in_13d > thresh);
			det_max[14] <= (in_13d < in_14d) & (in_14d > in_15d) & (in_14d > thresh);
			det_max[15] <= (in_14d < in_15d) & (in_15d > in_0d ) & (in_15d > thresh);	
		end		

	///////// local maximumes	
	reg [31:0] local_max [0:15];
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin  
	        local_max[0 ] <= 32'd0;
	        local_max[1 ] <= 32'd0;
	        local_max[2 ] <= 32'd0;
	        local_max[3 ] <= 32'd0;
	        local_max[4 ] <= 32'd0;
	        local_max[5 ] <= 32'd0;
	        local_max[6 ] <= 32'd0;
	        local_max[7 ] <= 32'd0;
	        local_max[8 ] <= 32'd0;
	        local_max[9 ] <= 32'd0;
	        local_max[10] <= 32'd0;
	        local_max[11] <= 32'd0;
	        local_max[12] <= 32'd0;
	        local_max[13] <= 32'd0;
	        local_max[14] <= 32'd0;
	        local_max[15] <= 32'd0;		
		end else begin  		
	        local_max[0 ] <= (det_max[0 ]) ? s[0 ] : 32'd0;
	        local_max[1 ] <= (det_max[1 ]) ? s[1 ] : 32'd0;
	        local_max[2 ] <= (det_max[2 ]) ? s[2 ] : 32'd0;
	        local_max[3 ] <= (det_max[3 ]) ? s[3 ] : 32'd0;
	        local_max[4 ] <= (det_max[4 ]) ? s[4 ] : 32'd0;
	        local_max[5 ] <= (det_max[5 ]) ? s[5 ] : 32'd0;
	        local_max[6 ] <= (det_max[6 ]) ? s[6 ] : 32'd0;
	        local_max[7 ] <= (det_max[7 ]) ? s[7 ] : 32'd0;
	        local_max[8 ] <= (det_max[8 ]) ? s[8 ] : 32'd0;
	        local_max[9 ] <= (det_max[9 ]) ? s[9 ] : 32'd0;
	        local_max[10] <= (det_max[10]) ? s[10] : 32'd0;
	        local_max[11] <= (det_max[11]) ? s[11] : 32'd0;
	        local_max[12] <= (det_max[12]) ? s[12] : 32'd0;
	        local_max[13] <= (det_max[13]) ? s[13] : 32'd0;
	        local_max[14] <= (det_max[14]) ? s[14] : 32'd0;
	        local_max[15] <= (det_max[15]) ? s[15] : 32'd0;	
		end				
////////////////////////////////////////////////////////////////////////////////////// 









/////////////////// estimation frequency doppler /////////////////////////////////////////////////////
	/////// rounding input signal //////////
	
	/////// dopler coeff ////////////////////////////////////////////////////////////
	wire signed [23:0] ch [0:17]; // df= 76.2939453125; x=[0:16  -1]; y=round(df*x*2^10); y=y';
    assign ch[0 ] = 0;
	assign ch[1 ] = 78125;
	assign ch[2 ] = 156250;
	assign ch[3 ] = 234375;
	assign ch[4 ] = 312500;
	assign ch[5 ] = 390625;
	assign ch[6 ] = 468750;
	assign ch[7 ] = 546875;
	assign ch[8 ] = 625000;
	assign ch[9 ] = 703125;
	assign ch[10] = 781250;
	assign ch[11] = 859375;
	assign ch[12] = 937500;
	assign ch[13] = 1015625;
    assign ch[14] = 1093750;
	assign ch[15] = 1171875;
	assign ch[16] = 1250000;
	assign ch[17] = 0-78125;

	////// numerator ////////////////////////////////////////////////////////////////
	reg signed [57:0] num0 [0:15];
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
	        num0[0 ] <= 58'd0;
	        num0[1 ] <= 58'd0;
	        num0[2 ] <= 58'd0;
	        num0[3 ] <= 58'd0;
	        num0[4 ] <= 58'd0;
	        num0[5 ] <= 58'd0;
	        num0[6 ] <= 58'd0;
	        num0[7 ] <= 58'd0;
	        num0[8 ] <= 58'd0;
	        num0[9 ] <= 58'd0;
	        num0[10] <= 58'd0;
	        num0[11] <= 58'd0;
	        num0[12] <= 58'd0;
	        num0[13] <= 58'd0;
	        num0[14] <= 58'd0;
	        num0[15] <= 58'd0;	
		end else begin  		
	        num0[0 ] <= (det_max[0 ])  ?  s[15]*ch[17] + s[0 ]*ch[0  ] + s[1 ]*ch[1  ]  :  58'd0;
	        num0[1 ] <= (det_max[1 ])  ?  s[0 ]*ch[0 ] + s[1 ]*ch[1  ] + s[2 ]*ch[2  ]  :  58'd0;
	        num0[2 ] <= (det_max[2 ])  ?  s[1 ]*ch[1 ] + s[2 ]*ch[2  ] + s[3 ]*ch[3  ]  :  58'd0;
	        num0[3 ] <= (det_max[3 ])  ?  s[2 ]*ch[2 ] + s[3 ]*ch[3  ] + s[4 ]*ch[4  ]  :  58'd0;
	        num0[4 ] <= (det_max[4 ])  ?  s[3 ]*ch[3 ] + s[4 ]*ch[4  ] + s[5 ]*ch[5  ]  :  58'd0;
	        num0[5 ] <= (det_max[5 ])  ?  s[4 ]*ch[4 ] + s[5 ]*ch[5  ] + s[6 ]*ch[6  ]  :  58'd0;
	        num0[6 ] <= (det_max[6 ])  ?  s[5 ]*ch[5 ] + s[6 ]*ch[6  ] + s[7 ]*ch[7  ]  :  58'd0;
	        num0[7 ] <= (det_max[7 ])  ?  s[6 ]*ch[6 ] + s[7 ]*ch[7  ] + s[8 ]*ch[8  ]  :  58'd0;
	        num0[8 ] <= (det_max[8 ])  ?  s[7 ]*ch[7 ] + s[8 ]*ch[8  ] + s[9 ]*ch[9  ]  :  58'd0;
	        num0[9 ] <= (det_max[9 ])  ?  s[8 ]*ch[8 ] + s[9 ]*ch[9  ] + s[10]*ch[10 ]  :  58'd0;
	        num0[10] <= (det_max[10])  ?  s[9 ]*ch[9 ] + s[10]*ch[10 ] + s[11]*ch[11 ]  :  58'd0;
	        num0[11] <= (det_max[11])  ?  s[10]*ch[10] + s[11]*ch[11 ] + s[12]*ch[12 ]  :  58'd0;
	        num0[12] <= (det_max[12])  ?  s[11]*ch[11] + s[12]*ch[12 ] + s[13]*ch[13 ]  :  58'd0;
	        num0[13] <= (det_max[13])  ?  s[12]*ch[12] + s[13]*ch[13 ] + s[14]*ch[14 ]  :  58'd0;
	        num0[14] <= (det_max[14])  ?  s[13]*ch[13] + s[14]*ch[14 ] + s[15]*ch[15 ]  :  58'd0;
	        num0[15] <= (det_max[15])  ?  s[14]*ch[14] + s[15]*ch[15 ] + s[0 ]*ch[16 ]  :  58'd0;		
		end		
	
    /////// denominator //////////////////////////////////////////////////////////////
	reg signed [33:0] denum0 [0:15];
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
	        denum0[0 ] <= {24'd1, 10'd0};
	        denum0[1 ] <= {24'd1, 10'd0};
	        denum0[2 ] <= {24'd1, 10'd0};
	        denum0[3 ] <= {24'd1, 10'd0};
	        denum0[4 ] <= {24'd1, 10'd0};
	        denum0[5 ] <= {24'd1, 10'd0};
	        denum0[6 ] <= {24'd1, 10'd0};
	        denum0[7 ] <= {24'd1, 10'd0};
	        denum0[8 ] <= {24'd1, 10'd0};
	        denum0[9 ] <= {24'd1, 10'd0};
	        denum0[10] <= {24'd1, 10'd0};
	        denum0[11] <= {24'd1, 10'd0};
	        denum0[12] <= {24'd1, 10'd0};
	        denum0[13] <= {24'd1, 10'd0};
	        denum0[14] <= {24'd1, 10'd0};
	        denum0[15] <= {24'd1, 10'd0};			
		end else begin  		
	        denum0[0 ] <= (det_max[0 ])  ?  s[15] + s[0 ] + s[1 ]  :  {24'd1, 10'd0};
	        denum0[1 ] <= (det_max[1 ])  ?  s[0 ] + s[1 ] + s[2 ]  :  {24'd1, 10'd0};
	        denum0[2 ] <= (det_max[2 ])  ?  s[1 ] + s[2 ] + s[3 ]  :  {24'd1, 10'd0};
	        denum0[3 ] <= (det_max[3 ])  ?  s[2 ] + s[3 ] + s[4 ]  :  {24'd1, 10'd0};
	        denum0[4 ] <= (det_max[4 ])  ?  s[3 ] + s[4 ] + s[5 ]  :  {24'd1, 10'd0};
	        denum0[5 ] <= (det_max[5 ])  ?  s[4 ] + s[5 ] + s[6 ]  :  {24'd1, 10'd0};
	        denum0[6 ] <= (det_max[6 ])  ?  s[5 ] + s[6 ] + s[7 ]  :  {24'd1, 10'd0};
	        denum0[7 ] <= (det_max[7 ])  ?  s[6 ] + s[7 ] + s[8 ]  :  {24'd1, 10'd0};
	        denum0[8 ] <= (det_max[8 ])  ?  s[7 ] + s[8 ] + s[9 ]  :  {24'd1, 10'd0};
	        denum0[9 ] <= (det_max[9 ])  ?  s[8 ] + s[9 ] + s[10]  :  {24'd1, 10'd0};
	        denum0[10] <= (det_max[10])  ?  s[9 ] + s[10] + s[11]  :  {24'd1, 10'd0};
	        denum0[11] <= (det_max[11])  ?  s[10] + s[11] + s[12]  :  {24'd1, 10'd0};
	        denum0[12] <= (det_max[12])  ?  s[11] + s[12] + s[13]  :  {24'd1, 10'd0};
	        denum0[13] <= (det_max[13])  ?  s[12] + s[13] + s[14]  :  {24'd1, 10'd0};
	        denum0[14] <= (det_max[14])  ?  s[13] + s[14] + s[15]  :  {24'd1, 10'd0};
	        denum0[15] <= (det_max[15])  ?  s[14] + s[15] + s[0 ]  :  {24'd1, 10'd0};	
		end		
		
		
	reg [23:0] denum [0:15]; 
	reg [47:0] num [0:15]; 
	always @ (posedge clk, negedge reset_b) begin : delay_line
	integer i;
		if(~reset_b) begin
			for(i=0; i<16; i=i+1) begin
				denum[i] <= 24'd1;
				num[i] <= 48'd0;
			end
		end else begin
			for(i=0; i<16; i=i+1) begin
				denum[i] <= denum0[i][33:10] + ~|denum0[i][33:10];
				num[i] <= num0[i][57:10];
			end
		end
	end	
		
		
		
		
		
	wire signed [47:0] div [0:15];	
	divider_mfic  divider_mfic_inst_0(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[0]),
		.numer    (num  [0]),
		.quotient (div  [0]),
		.remain   ());

	divider_mfic  divider_mfic_inst_1(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[1]),
		.numer    (num  [1]),
		.quotient (div  [1]),
		.remain   ());
		
	divider_mfic  divider_mfic_inst_2(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[2]),
		.numer    (num  [2]),
		.quotient (div  [2]),
		.remain   ());		
		
	divider_mfic  divider_mfic_inst_3(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[3]),
		.numer    (num  [3]),
		.quotient (div  [3]),
		.remain   ());		

	divider_mfic  divider_mfic_inst_4(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[4]),
		.numer    (num  [4]),
		.quotient (div  [4]),
		.remain   ());

	divider_mfic  divider_mfic_inst_5(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[5]),
		.numer    (num  [5]),
		.quotient (div  [5]),
		.remain   ());

	divider_mfic  divider_mfic_inst_6(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[6]),
		.numer    (num  [6]),
		.quotient (div  [6]),
		.remain   ());

	divider_mfic  divider_mfic_inst_7(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[7]),
		.numer    (num  [7]),
		.quotient (div  [7]),
		.remain   ());

	divider_mfic  divider_mfic_inst_8(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[8]),
		.numer    (num  [8]),
		.quotient (div  [8]),
		.remain   ());

	divider_mfic  divider_mfic_inst_9(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[9]),
		.numer    (num  [9]),
		.quotient (div  [9]),
		.remain   ());

	divider_mfic  divider_mfic_inst_10(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[10]),
		.numer    (num  [10]),
		.quotient (div  [10]),
		.remain   ());	

	divider_mfic  divider_mfic_inst_11(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[11]),
		.numer    (num  [11]),
		.quotient (div  [11]),
		.remain   ());

	divider_mfic  divider_mfic_inst_12(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[12]),
		.numer    (num  [12]),
		.quotient (div  [12]),
		.remain   ());

	divider_mfic  divider_mfic_inst_13(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[13]),
		.numer    (num  [13]),
		.quotient (div  [13]),
		.remain   ());

	divider_mfic  divider_mfic_inst_14(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[14]),
		.numer    (num  [14]),
		.quotient (div  [14]),
		.remain   ());

	divider_mfic  divider_mfic_inst_15(
		.aclr     (~reset_b),
		.clock    (clk     ),
		.denom    (denum[15]),
		.numer    (num  [15]),
		.quotient (div  [15]),
		.remain   ());	

    
	wire signed [23:0] dopler [0:15];

    localparam DSH = 10;  // ch was mult by 1024
    assign dopler[0 ] = div[0 ][23+DSH:0+DSH];
	assign dopler[1 ] = div[1 ][23+DSH:0+DSH];
	assign dopler[2 ] = div[2 ][23+DSH:0+DSH];
	assign dopler[3 ] = div[3 ][23+DSH:0+DSH];
	assign dopler[4 ] = div[4 ][23+DSH:0+DSH];
	assign dopler[5 ] = div[5 ][23+DSH:0+DSH];
	assign dopler[6 ] = div[6 ][23+DSH:0+DSH];
	assign dopler[7 ] = div[7 ][23+DSH:0+DSH];
	assign dopler[8 ] = div[8 ][23+DSH:0+DSH];
	assign dopler[9 ] = div[9 ][23+DSH:0+DSH];
	assign dopler[10] = div[10][23+DSH:0+DSH];
	assign dopler[11] = div[11][23+DSH:0+DSH];
	assign dopler[12] = div[12][23+DSH:0+DSH];
	assign dopler[13] = div[13][23+DSH:0+DSH];
	assign dopler[14] = div[14][23+DSH:0+DSH];
	assign dopler[15] = div[15][23+DSH:0+DSH];		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////// delay for input signal //////////////////////////////////////////////////////////////////////////////////////
    wire [32*16-1:0] del_in1 = { local_max[0],  local_max[1],  local_max[2],  local_max[3],  local_max[4], local_max[5], 
	                            local_max[6],  local_max[7],  local_max[8],  local_max[9],  local_max[10], 
							    local_max[11], local_max[12], local_max[13], local_max[14], local_max[15]};
    wire [32*16-1:0] del_out1;							   
	delay_mfic  #(.W(16*32), .D(24)) delay_inst1       
	   (.reset_b  (reset_b),
		.clk      (clk),
		.din      (del_in1),     
		.dout     (del_out1)); 	
		
    wire [31:0] loc_max_0,  loc_max_1,  loc_max_2,  loc_max_3,  loc_max_4, 
	             loc_max_5,  loc_max_6,  loc_max_7,  loc_max_8,  loc_max_9, 
				 loc_max_10, loc_max_11, loc_max_12, loc_max_13, loc_max_14, loc_max_15;
    assign { loc_max_0,  loc_max_1,  loc_max_2,  loc_max_3,  loc_max_4, 
	         loc_max_5,  loc_max_6,  loc_max_7,  loc_max_8,  loc_max_9, 
			 loc_max_10, loc_max_11, loc_max_12, loc_max_13, loc_max_14, loc_max_15} = del_out1;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//////////// index range  ////////////////////////////////
	reg strobe_reg;	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			strobe_reg <= 1'b0;      
		end else begin
			strobe_reg <= strobe;
		end
	wire strobe_pos = (~strobe_reg) & strobe;
	
	wire start_cnt_range;
	delay_mfic  #(.W(1), .D(25)) delay_inst2       
	   (.reset_b  (reset_b),
		.clk      (clk),
		.din      (strobe_pos),     
		.dout     (start_cnt_range)); 	
	
	
	reg [19:0] cnt_range;	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			cnt_range <= 20'd0;      
		end else begin
		    if (start_cnt_range) 
				cnt_range <= 20'd0;	
			else
				cnt_range <= cnt_range + 20'd1;
		end
	//assign [19:0] index_range = cnt_range;
////////////////////////////////////////////////////////// 


//////////// range ///////////////////////////////////////
	reg [12:0] cnt_r;	
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			cnt_r <= 13'd0;      
		end else begin
		    if (start_cnt_range) 
				cnt_r <= 13'd0;	
			else
				cnt_r <= cnt_r + 13'd1;
		end
	//assign [12:0] range = cnt_r;
//////////////////////////////////////////////////////////


////////////// write data to fifo ////////////////////////
	wire [15:0] pos_max;	
	delay_mfic  #(.W(16), .D(25)) delay_inst3       
	   (.reset_b  (reset_b),
		.clk      (clk),
		.din      (det_max),     
		.dout     (pos_max)); 	
//////////////////////////////////////////////////////////
		
		
//////////// speed counter /////////////////////////////
	reg strobe_reg1;	
	always @(posedge clk_200, negedge reset_b)
		if (~reset_b) begin
			strobe_reg1 <= 1'b0;      
		end else begin
			strobe_reg1 <= strobe;
		end
	wire start_cnt = (~strobe_reg1) & strobe;
	
	reg [7:0] cnt20;	
	always @(posedge clk_200, negedge reset_b)
		if (~reset_b) begin
			cnt20 <= 1'b0;      
		end else begin
		    if ((start_cnt)|(cnt20==8'd19))
			    cnt20 <= 8'd0;
			else
			    cnt20 <= cnt20 + 8'd1;			
		end	
////////////////////////////////////////////////////// 



/////////////////////////////// form word for fifo ////////////////////////////////////////////////////////////////////////////////////////////
	reg [31:0] amp   [0:15];
	reg [23:0] dop   [0:15];
	reg [12:0] ran   [0:15];	
	reg [19:0] i_ran [0:15];
	reg        en    [0:15];	
		
    always @(posedge clk_200, negedge reset_b)
	    if (~reset_b) begin
            {amp[0 ], dop[0 ], ran[0 ], i_ran[0 ], en[0 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[1 ], dop[1 ], ran[1 ], i_ran[1 ], en[1 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[2 ], dop[2 ], ran[2 ], i_ran[2 ], en[2 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[3 ], dop[3 ], ran[3 ], i_ran[3 ], en[3 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[4 ], dop[4 ], ran[4 ], i_ran[4 ], en[4 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[5 ], dop[5 ], ran[5 ], i_ran[5 ], en[5 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[6 ], dop[6 ], ran[6 ], i_ran[6 ], en[6 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[7 ], dop[7 ], ran[7 ], i_ran[7 ], en[7 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[8 ], dop[8 ], ran[8 ], i_ran[8 ], en[8 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[9 ], dop[9 ], ran[9 ], i_ran[9 ], en[9 ]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[10], dop[10], ran[10], i_ran[10], en[10]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[11], dop[11], ran[11], i_ran[11], en[11]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[12], dop[12], ran[12], i_ran[12], en[12]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[13], dop[13], ran[13], i_ran[13], en[13]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[14], dop[14], ran[14], i_ran[14], en[14]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			{amp[15], dop[15], ran[15], i_ran[15], en[15]} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};	
	    end else begin
			{amp[0 ], dop[0 ], ran[0 ], i_ran[0 ], en[0 ]} <= {loc_max_0 [31:0], dopler[0 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[0 ]};
			{amp[1 ], dop[1 ], ran[1 ], i_ran[1 ], en[1 ]} <= {loc_max_1 [31:0], dopler[1 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[1 ]};
			{amp[2 ], dop[2 ], ran[2 ], i_ran[2 ], en[2 ]} <= {loc_max_2 [31:0], dopler[2 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[2 ]};
			{amp[3 ], dop[3 ], ran[3 ], i_ran[3 ], en[3 ]} <= {loc_max_3 [31:0], dopler[3 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[3 ]};
			{amp[4 ], dop[4 ], ran[4 ], i_ran[4 ], en[4 ]} <= {loc_max_4 [31:0], dopler[4 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[4 ]};
			{amp[5 ], dop[5 ], ran[5 ], i_ran[5 ], en[5 ]} <= {loc_max_5 [31:0], dopler[5 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[5 ]};
			{amp[6 ], dop[6 ], ran[6 ], i_ran[6 ], en[6 ]} <= {loc_max_6 [31:0], dopler[6 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[6 ]};
			{amp[7 ], dop[7 ], ran[7 ], i_ran[7 ], en[7 ]} <= {loc_max_7 [31:0], dopler[7 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[7 ]};
			{amp[8 ], dop[8 ], ran[8 ], i_ran[8 ], en[8 ]} <= {loc_max_8 [31:0], dopler[8 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[8 ]};
			{amp[9 ], dop[9 ], ran[9 ], i_ran[9 ], en[9 ]} <= {loc_max_9 [31:0], dopler[9 ][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[9 ]};
			{amp[10], dop[10], ran[10], i_ran[10], en[10]} <= {loc_max_10[31:0], dopler[10][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[10]};
			{amp[11], dop[11], ran[11], i_ran[11], en[11]} <= {loc_max_11[31:0], dopler[11][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[11]};
			{amp[12], dop[12], ran[12], i_ran[12], en[12]} <= {loc_max_12[31:0], dopler[12][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[12]};
			{amp[13], dop[13], ran[13], i_ran[13], en[13]} <= {loc_max_13[31:0], dopler[13][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[13]};
			{amp[14], dop[14], ran[14], i_ran[14], en[14]} <= {loc_max_14[31:0], dopler[14][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[14]};
			{amp[15], dop[15], ran[15], i_ran[15], en[15]} <= {loc_max_15[31:0], dopler[15][23:0], cnt_r[12:0], cnt_range[19:0], pos_max[15]};		
		end
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	


/////////////////////////////// form word for fifo //////////////////////////////////////////////////////////////////////
/////////////////////////////// form word for fifo ////////////////////////////////////////////////////////////////////////////////////////////
	reg [31:0] amplitude;
	reg [23:0] doppler;
	reg [12:0] range;	
	reg [19:0] index_range;
	reg        ena;	
    always @(posedge clk_200, negedge reset_b)
	    if (~reset_b) begin
		    {amplitude, doppler, range, index_range, ena} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
	    end else begin
			case (cnt20)
				8'd0   :  {amplitude, doppler, range, index_range, ena} <= {amp[0 ], dop[0 ], ran[0 ], i_ran[0 ], en[0 ]};
				8'd1   :  {amplitude, doppler, range, index_range, ena} <= {amp[1 ], dop[1 ], ran[1 ], i_ran[1 ], en[1 ]};
				8'd2   :  {amplitude, doppler, range, index_range, ena} <= {amp[2 ], dop[2 ], ran[2 ], i_ran[2 ], en[2 ]};
				8'd3   :  {amplitude, doppler, range, index_range, ena} <= {amp[3 ], dop[3 ], ran[3 ], i_ran[3 ], en[3 ]};
				8'd4   :  {amplitude, doppler, range, index_range, ena} <= {amp[4 ], dop[4 ], ran[4 ], i_ran[4 ], en[4 ]};
				8'd5   :  {amplitude, doppler, range, index_range, ena} <= {amp[5 ], dop[5 ], ran[5 ], i_ran[5 ], en[5 ]};
				8'd6   :  {amplitude, doppler, range, index_range, ena} <= {amp[6 ], dop[6 ], ran[6 ], i_ran[6 ], en[6 ]};
				8'd7   :  {amplitude, doppler, range, index_range, ena} <= {amp[7 ], dop[7 ], ran[7 ], i_ran[7 ], en[7 ]};
				8'd8   :  {amplitude, doppler, range, index_range, ena} <= {amp[8 ], dop[8 ], ran[8 ], i_ran[8 ], en[8 ]};
				8'd9   :  {amplitude, doppler, range, index_range, ena} <= {amp[9 ], dop[9 ], ran[9 ], i_ran[9 ], en[9 ]};
				8'd10  :  {amplitude, doppler, range, index_range, ena} <= {amp[10], dop[10], ran[10], i_ran[10], en[10]};
				8'd11  :  {amplitude, doppler, range, index_range, ena} <= {amp[11], dop[11], ran[11], i_ran[11], en[11]};
				8'd12  :  {amplitude, doppler, range, index_range, ena} <= {amp[12], dop[12], ran[12], i_ran[12], en[12]};				
				8'd13  :  {amplitude, doppler, range, index_range, ena} <= {amp[13], dop[13], ran[13], i_ran[13], en[13]};
				8'd14  :  {amplitude, doppler, range, index_range, ena} <= {amp[14], dop[14], ran[14], i_ran[14], en[14]};
				8'd15  :  {amplitude, doppler, range, index_range, ena} <= {amp[15], dop[15], ran[15], i_ran[15], en[15]};		
			default    :  {amplitude, doppler, range, index_range, ena} <= {32'd0, 24'd0, 13'd0, 20'd0, 1'b0};
			endcase
		end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	




////////////////// FIFO-буфер /////////////////////////////////
	wire fifo_wrclk          = clk_200; 
	wire fifo_wrreq          = ena; 
	wire [31:0] fifo_data_wr = amplitude;
	wire        fifo_rdclk = clk;  
    //reg         fifo_rd;
	wire         fifo_rd;
    wire [31:0] fifo_data_rd;
    wire        fifo_empty;
    wire        fifo_full;
    wire [10:0] fifo_usedw;   
	
	fifo_mfic  fifo_mfic_inst (
        .aclr     (~reset_b    ),
        .wrclk    (fifo_wrclk  ),
        .wrreq    (fifo_wrreq  ),
        .data     (fifo_data_wr),
		.rdclk    (fifo_rdclk  ),
        .rdreq    (fifo_rd     ),
        .q        (fifo_data_rd),
        .rdempty  (fifo_empty  ),
        .rdfull   (fifo_full   ),	
        .rdusedw  (fifo_usedw  )		
	);	
	
		
	assign fifo_rd = ~fifo_empty;	
		
	assign sig_out = fifo_data_rd;
	assign clk_out = clk;
	
	//reg ena_out;
	always @(posedge clk, negedge reset_b)
		if (~reset_b) begin
			ena_out <= 1'b0;      
		end else begin
			ena_out <= fifo_rd;
		end
//////////////////////////////////////////////////////////////






endmodule


























