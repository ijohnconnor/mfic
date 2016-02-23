
`timescale 1ns / 10ps


module mfic_tb
 #(parameter   WIDTH = 32,
			   LENGTH_IN = 1200000,
               LENGTH_OUT = 40000,
			   DELAY_module = 0 )                         // delay of module (must be bigger than real delay))
			   
   (output [WIDTH-1:0] sig_rom_out_0,
    output sig_rom_out_1,
	output [13:0] sig_rom_out_2,
    output [13:0] sig_rom_out_3
	);


// == Generate clock and reset ===
reg clk_10;
reg clk_200;
reg reset_b;
	

always
  #100 clk_10 = ~clk_10;
 
always
  #5 clk_200 = ~clk_200;

  
initial
begin
  clk_10 = 1;
  clk_200 = 1;
  reset_b = 0;
  #200 reset_b = 1; 
end 
// ===============================	


//////// Читаем входные воздействия из файлов /////////////////////
	reg [WIDTH-1:0] rom_in_0  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_1  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_2  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_3  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_4  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_5  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_6  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_7  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_8  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_9  [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_10 [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_11 [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_12 [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_13 [0:LENGTH_IN-1];
	reg [WIDTH-1:0] rom_in_14 [0:LENGTH_IN-1]; 
	reg [WIDTH-1:0] rom_in_15 [0:LENGTH_IN-1];

	
	initial begin 
	$readmemb("in_0.dat", rom_in_0 );
    $readmemb("in_1.dat", rom_in_1 );  
    $readmemb("in_2.dat", rom_in_2 );  
    $readmemb("in_3.dat", rom_in_3 );  
    $readmemb("in_4.dat", rom_in_4 );  
    $readmemb("in_5.dat", rom_in_5 );  
    $readmemb("in_6.dat", rom_in_6 );  
    $readmemb("in_7.dat", rom_in_7 );  
    $readmemb("in_8.dat", rom_in_8 );  
    $readmemb("in_9.dat", rom_in_9 );  
    $readmemb("in_10.dat", rom_in_10);  
    $readmemb("in_11.dat", rom_in_11);  
    $readmemb("in_12.dat", rom_in_12);  
    $readmemb("in_13.dat", rom_in_13); 
    $readmemb("in_14.dat", rom_in_14);  
    $readmemb("in_15.dat", rom_in_15); 	
	end
	
	reg [0:0] rom_in_16 [0:LENGTH_IN-1]; 
	initial begin 
	$readmemb("strobe.dat", rom_in_16);  
	end

	
	reg [31:0] cnt;
	always @(posedge clk_10, negedge reset_b) 
	    if (~reset_b) 
		  	cnt <= 32'd0;
	    else
		  	cnt <= cnt + 32'd1;

	reg [31:0] in_0 ;
	reg [31:0] in_1 ;
	reg [31:0] in_2 ;
	reg [31:0] in_3 ;
	reg [31:0] in_4 ;
	reg [31:0] in_5 ;
	reg [31:0] in_6 ;
	reg [31:0] in_7 ;
	reg [31:0] in_8 ;
	reg [31:0] in_9 ;
	reg [31:0] in_10;
	reg [31:0] in_11;
	reg [31:0] in_12;
	reg [31:0] in_13;
	reg [31:0] in_14;
	reg [31:0] in_15;	
	reg strobe;
	
	always @ (posedge clk_10, negedge reset_b)
    if (~reset_b) begin
	   in_0   <= 32'd0;
	   in_1   <= 32'd0;
	   in_2   <= 32'd0;
	   in_3   <= 32'd0;
	   in_4   <= 32'd0;
	   in_5   <= 32'd0;
	   in_6   <= 32'd0;
	   in_7   <= 32'd0;
	   in_8   <= 32'd0;
	   in_9   <= 32'd0;
	   in_10  <= 32'd0;
	   in_11  <= 32'd0;	
	   in_12  <= 32'd0;
	   in_13  <= 32'd0;
	   in_14  <= 32'd0;
	   in_15  <= 32'd0;   
	   strobe <= 1'b0;
	end else begin
	   in_0   <= rom_in_0 [cnt];
	   in_1   <= rom_in_1 [cnt];
	   in_2   <= rom_in_2 [cnt];
	   in_3   <= rom_in_3 [cnt];
	   in_4   <= rom_in_4 [cnt];
	   in_5   <= rom_in_5 [cnt];
	   in_6   <= rom_in_6 [cnt];
	   in_7   <= rom_in_7 [cnt];
	   in_8   <= rom_in_8 [cnt];
	   in_9   <= rom_in_9 [cnt];
	   in_10  <= rom_in_10[cnt];
	   in_11  <= rom_in_11[cnt];
	   in_12  <= rom_in_12[cnt];
	   in_13  <= rom_in_13[cnt];   
	   in_14  <= rom_in_14[cnt];
	   in_15  <= rom_in_15[cnt];	   
	   strobe <= rom_in_16[cnt];	   
	end
//////////////////////////////////////////////////////////////

     
///////////// Module /////////////////////////////////////
	wire [99:0] word;
	wire wr_word;
    wire [31:0] sig_out;
	wire ena_out;
	wire clk_out;
	
	mfic  mfic_inst
	(
		.clk      (clk_10), 
		.clk_200  (clk_200),
		.reset_b  (reset_b),
		.strobe   (strobe),
		.in_0     (in_0 ), 
		.in_1     (in_1 ),
		.in_2     (in_2 ),
		.in_3     (in_3 ),
		.in_4     (in_4 ),
		.in_5     (in_5 ),
		.in_6     (in_6 ),
		.in_7     (in_7 ),
		.in_8     (in_8 ),
		.in_9     (in_9 ),
		.in_10    (in_10),
		.in_11    (in_11),
		.in_12    (in_12),
		.in_13    (in_13),
		.in_14    (in_14),
		.in_15    (in_15),
		.th_coef  (32'd1717986918 ),
		.azimuth  (16'd100 ),
		.sig_out  (sig_out),
		.ena_out  (ena_out),
		.clk_out  (clk_out)
		//.word     (word),
		//.wr_word  (wr_word)
	);
//////////////////////////////////////////////////////////
	
	
	
// ========= Write output files ====================================================
// --------- counter for addr output roms --------------------------------------------
reg [31:0] ind;
reg [31:0] cnt_rom = {(32){1'b0}};

always @(posedge clk_10, negedge reset_b) begin : counter_out
   if (!reset_b) 
      begin
      cnt_rom <= {(32){1'b0}};
      ind <= {(32){1'b0}}; 
	  end
   else if (cnt_rom <= DELAY_module)
      begin
      cnt_rom <= cnt_rom + 1;
      ind <= {(32){1'b0}}; 
	  end
   else
      begin
      cnt_rom <= cnt_rom + 1;	   
      ind <= cnt_rom-DELAY_module;
	  end
end
	


 	write_signal  #(.WIDTH (32), .LENGTH_OUT (LENGTH_OUT), .FILE_NAME  ("sig_out.dat"))    write_signal_inst2
	    (.clk         (clk_10),  
	  	 .reset_b     (reset_b),	
	 	 .ind         (ind), 
	 	 .input_sig   (sig_out),
		 .sig_rom_out (sig_rom_out_2));

	write_signal  #(.WIDTH (1), .LENGTH_OUT (LENGTH_OUT), .FILE_NAME  ("ena_out.dat"))    write_signal_inst3
	    (.clk         (clk_10),  
	  	 .reset_b     (reset_b),	
	 	 .ind         (ind), 
	 	 .input_sig   (ena_out),
		 .sig_rom_out (sig_rom_out_3)); 
	

endmodule




















