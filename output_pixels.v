//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//										* Generates final pixel output *
//  ===================================================================================
module output_pixels #(parameter WIDTH = 10,   // default width: 10 pixels
               HEIGHT = 40)(                // default height: 40 pixels 
		clk,
		rst,
		paddle1 ,
		paddle2,
		score1,
		score2,
		over1,
		over2,
		hcount,
		vcount,
		board,
		ball,
		final 
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
	input 		 clk;
	input 		 rst;
	input			 over1;
	input			 over2;
	input	[10:0] hcount;
	input	[9:0]	 vcount;
	input [7:0]  paddle1;
	input [7:0]  paddle2;
	input [7:0]	 score1;
	input [7:0]	 score2;
	input [7:0]  board;
	input [7:0]  ball;
	output [7:0] final;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg [7:0]	 final;
	reg [7:0]	 pixels;
	reg [7:0]	 x = 180;
	reg [7:0]	 y = 245;
  
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
		always @(posedge clk)
		begin
			if ( rst == 1 )
				final <= 0;
		   else
				if (over1 == 0 && over2 == 0)
					final <= board | ball | paddle1 | paddle2 | score1 | score2;
				else
				begin
					if (over2 == 1)
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line																+-----+  |
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line												|		|  |
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line		+-----+  |
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line						|        |
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower left vertical line							|        |
							 ((hcount >= (x + 4*WIDTH + HEIGHT + HEIGHT/2) && hcount < (x + 5*WIDTH + HEIGHT + HEIGHT/2)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line								 |
							 ((hcount >= (x + 4*WIDTH + HEIGHT + HEIGHT/2) && hcount < (x + 5*WIDTH + HEIGHT + HEIGHT/2)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT)))||//lower right vertical line    |
							 ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 6*WIDTH + 3*HEIGHT)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line						  	       |
							 ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 6*WIDTH + 3*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line   |
							 ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 7*WIDTH + 4*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line    +-----
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line												    +----+
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 9*WIDTH + 4*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line				    |    |
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 9*WIDTH + 4*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line   |    |
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line   |    |
							 ((hcount >= (x + 9*WIDTH + 5*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line				    +----+
							 ((hcount >= (x + 9*WIDTH + 5*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) ||//lower right vertical line  +----+
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line													 |
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 12*WIDTH + 5*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line					 +----+
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line			 		|
							 ((hcount >= (x + 12*WIDTH + 6*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower right 				 +----+		
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) ||//lower horizontal line	 +-+--+
							 ((hcount >= (x + 14*WIDTH + 6*HEIGHT) && hcount < (x + 16*WIDTH + 7*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line													 	|
							 ((hcount >= (x + 14*WIDTH + 6*HEIGHT + HEIGHT/2) && hcount < (x + 15*WIDTH + 6*HEIGHT + HEIGHT/2)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line					|
							 ((hcount >= (x + 14*WIDTH + 6*HEIGHT + HEIGHT/2) && hcount < (x + 15*WIDTH + 6*HEIGHT + HEIGHT/2)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT)))//lower right 			|
							)
							pixels <= 8'hF0;
						else 
							pixels <= 8'b0;
					else if (over1 == 1)
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line																+-----+  +----+
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line												|		|  	  |
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line		+-----+  +----+
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle horizontal line									|        |
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower left vertical line							|        +----+
							 ((hcount >= (x + 3*WIDTH + HEIGHT) && hcount < (x + 5*WIDTH + 2*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= (x + 4*WIDTH + 2*HEIGHT) && hcount < (x + 5*WIDTH + 2*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= (x + 3*WIDTH + HEIGHT) && hcount < (x + 5*WIDTH + 2*HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle horizontal line
							 ((hcount >= (x + 3*WIDTH + HEIGHT) && hcount < (x + 4*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line		 |
							 ((hcount >= (x + 3*WIDTH + HEIGHT) && hcount < (x + 5*WIDTH + 2*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line		 |
							 ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 6*WIDTH + 3*HEIGHT)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line						  	       |
							 ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 6*WIDTH + 3*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line   |
							 ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 7*WIDTH + 4*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line    +-----
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line												    +----+
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 9*WIDTH + 4*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line				    |    |
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 9*WIDTH + 4*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line   |    |
							 ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line   |    |
							 ((hcount >= (x + 9*WIDTH + 5*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line				    +----+
							 ((hcount >= (x + 9*WIDTH + 5*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) ||//lower right vertical line  +----+
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line													 |
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 12*WIDTH + 5*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line					 +----+
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle horizontal line		 		|
							 ((hcount >= (x + 12*WIDTH + 6*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower right 				 +----+		
							 ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) ||//lower horizontal line	 +-+--+
							 ((hcount >= (x + 14*WIDTH + 6*HEIGHT) && hcount < (x + 16*WIDTH + 7*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line													 	|
							 ((hcount >= (x + 14*WIDTH + 6*HEIGHT + HEIGHT/2) && hcount < (x + 15*WIDTH + 6*HEIGHT + HEIGHT/2)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || 								//		|
							 ((hcount >= (x + 14*WIDTH + 6*HEIGHT + HEIGHT/2) && hcount < (x + 15*WIDTH + 6*HEIGHT + HEIGHT/2)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT)))		//		|
							)
							pixels <= 8'hF0;
						else 
							pixels <= 8'b0;
						
					final <= pixels;
				end
		end
										
endmodule
