//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//												* Draw score *
//  ===================================================================================
module draw_score #(parameter WIDTH = 10,   // default width: 10 pixels
               HEIGHT = 40)(                // default height: 40 pixels  
		win_rst,
		hcount,
		vcount,
		x,
		clk,
		rst,
		pixel,
		over
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
	input [10:0] hcount;
	input [9:0]  vcount;
	input	[9:0]	 x;
	input			 win_rst;
	input 		 clk;
	input			 rst;
	output [7:0] pixel;
	output		 over;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg [7:0]	 COLOR = 8'hCF;
	reg			 over;
	reg [3:0]	 NUMBER;
	reg [7:0] 	 pixel;
	reg [9:0]  	 y = 50;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================

		always @(posedge clk) 
		begin
			if (rst == 1)
			begin
				NUMBER <= 0;
				over <= 0;
			end
			else
				if (win_rst == 1)
				begin
					NUMBER <= NUMBER + 1;
					if (NUMBER >= 9)
					begin
						over <= 1;
						NUMBER <= 0;
					end
					else
						over <= over;
				end
				else
					NUMBER <= NUMBER;

				case (NUMBER)
					0:
						//If the count is 0 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) //lower right vertical line
							)
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					1:
						//If the count is 1 draw it
						if (((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) //lower right vertical line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					2:
						//If the count is 2 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) //lower horizontal line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					3:
						//If the count is 3 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) //lower horizontal line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					4:
						//If the count is 4 draw it
						if (((hcount >= x && hcount < (x + WIDTH)) && (vcount >= y && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) //lower right vertical line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					5:
						//If the count is 5 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) //lower horizontal line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					6:
						//If the count is 6 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) //lower horizontal line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					7:
						//If the count is 7 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) //lower right vertical line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					8:
						//If the count is 8 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) //lower right vertical line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					9:
						//If the count is 9 draw it
						if (((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line
							 ((hcount >= x && hcount < (x + WIDTH)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper right vertical line
							 ((hcount >= x && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line
							 ((hcount >= (x + WIDTH + HEIGHT) && hcount < (x + 2*WIDTH + HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) //lower right vertical line
							 )
							pixel <= COLOR;
						else 
							pixel <= 8'b0;
					default:
						;
				endcase
		end
	
endmodule
