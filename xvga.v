/////////////////////////////////////////////////////////////////////////////////////
// Description: The xvga module creates the signals for the refresh rate of the
//					 display, the horizontal interval and the signal for the three 
//					 colors red, green, blue. The signals of the three colors are 
//					 consisted of a three bit vector for red and green and a two bit 
//					 vector for blue. The shapes and the movement of the ball and the 
//					 paddles are also calculated.
//
//
//  Inputs:
//		clk				100MHz onboard system clock
//		rst				Main Reset Controller
//		frz				Signal to freeze the displaying frame
//		ACL1				Data from the accelerometer 1
//		ACL2				Data from the accelerometer 2
//
//  Outputs:
//		vsync				Signal for the reafresh rate of the display
//		hsync				Signal for the horizontal interval
//		VGA_R				Signal for color red
//		VGA_G				Signal for color green
//		VGA_B				Signal for color blue
//
////////////////////////////////////////////////////////////////////////////////////

//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//  ===================================================================================
module xvga( 
		clk, 
		rst,
		frz,
		ACL1, 
		ACL2,
		vsync,
		hsync,
		VGA_R,
		VGA_G,
		VGA_B
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================			
	input 		 clk; 
	input 		 rst;
	input 		 frz;
	input [9:0]  ACL1; 
	input [9:0]	 ACL2;
	output		 vsync;
	output		 hsync;
	output [2:0] VGA_R;
	output [2:0] VGA_G;
	output [1:0] VGA_B;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================	
	reg			 vs;
	reg			 hs;
   reg [10:0]	 hcount;
   reg [9:0]	 vcount;
	reg [9:0]	 counter;
   reg 			 hblank;
	reg			 vblank;
   reg			 frame;
	reg [7:0]	 x_one = 170;
	reg [9:0]	 x_two = 570;

   wire [10:0]	 ball_x;
	wire [10:0]  paddle1_x;
	wire [10:0]	 paddle2_x;
	wire [9:0] 	 ball_y;
	wire [9:0]   paddle1_y;
	wire [9:0]	 paddle2_y;
	wire [7:0] 	 pixel;
	wire [7:0] 	 board_pixel;
	wire [7:0] 	 paddle1_pixel;
	wire [7:0] 	 paddle2_pixel;
	wire [7:0]	 score1_pixel;
	wire [7:0]	 score2_pixel;
	wire [7:0] 	 ball_pixel;
	wire [7:0] 	 final_pixels;
   wire 			 win_rst1;
	wire 			 win_rst2;
	wire			 over1;
	wire			 over2;
	wire 			 hsyncon;
	wire			 hsyncoff;
	wire			 hreset;
	wire			 hblankon;
	wire			 next_hblank;
	wire			 next_vblank;
	wire 			 vclk;
	
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
		// horizontal: 1039 pixels total
		// display 800 pixels per line
		assign hblankon = (hcount == 799);    
		assign hsyncon = (hcount == 855);
		assign hsyncoff = (hcount == 975);
		assign hreset = (hcount == 1039);

		// vertical: 665 lines total
		// display 600 lines
		wire vsyncon,vsyncoff,vreset,vblankon;
		assign vblankon = hreset & (vcount == 599);    
		assign vsyncon = hreset & (vcount == 636);
		assign vsyncoff = hreset & (vcount == 642);
		assign vreset = hreset & (vcount == 665);

		// Get 50Mhz clock for the vga calculations
		ClkDiv_50MHz vgaclk(
			 .CLK(clk),
			 .RST(rst),
			 .CLKOUT(vclk)
		);
  
		// sync and blanking
		assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
		assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
  	
		always @(posedge clk) 
		begin
			if (rst == 1)  
			begin
				hcount <= 0;
				vcount <= 0;
				vs <= 1;
				hs <= 1;
				vblank <= 0;
				hblank <= 0;
				counter <= 0;
				frame <= 0;
			end
			else 
			begin
				if ( vclk == 1 ) 
				begin
					hcount <= hreset ? 0 : hcount + 1;
					hblank <= next_hblank;
					hs <= hsyncon ? 0 : hsyncoff ? 1 : hs;  // active low
					vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
					vblank <= next_vblank;
					vs <= vsyncon ? 0 : vsyncoff ? 1 : vs;  // active low
      
					if ( vs == 0 )
						counter <= counter + 1;
						
					if ( counter ==  600 &&  frz == 0) 
					begin
						counter <= 0;
						frame <= 1;
					end
					else
						frame <= 0;
				end
			end
		end

		//-------------------------------------------------------------------------
		//		 							Draw the score
		//-------------------------------------------------------------------------
		draw_score score1(
			 .win_rst(win_rst1),
			 .hcount(hcount),
			 .vcount(vcount),
			 .x(x_one),
			 .clk(vclk),
			 .rst(rst),
			 .pixel(score1_pixel),
			 .over(over1)
		);

		draw_score score2(
			 .win_rst(win_rst2),
			 .hcount(hcount),
			 .vcount(vcount),
			 .x(x_two),
			 .clk(vclk),
			 .rst(rst),
			 .pixel(score2_pixel),
			 .over(over2)
		);

		//-------------------------------------------------------------------------
		//		 							Draw the paddles
		//-------------------------------------------------------------------------   
		draw_shape paddle1(
			 .x(paddle1_x),
			 .y(paddle1_y), 
			 .hcount(hcount),
			 .vcount(vcount),
			 .clk(vclk),
			 .pixel(paddle1_pixel)
		);
		
		draw_shape paddle2(
			 .x(paddle2_x),
			 .y(paddle2_y),
			 .hcount(hcount),
			 .vcount(vcount),
			 .clk(vclk),
			 .pixel(paddle2_pixel)
		);
		
		//-------------------------------------------------------------------------
		//		 								Draw the ball
		//------------------------------------------------------------------------- 	
		draw_ball ball(
			 .x(ball_x),
			 .y(ball_y),
			 .hcount(hcount),
			 .vcount(vcount),
			 .clk(vclk),
			 .pixel(ball_pixel)
		);
		
		//-------------------------------------------------------------------------
		//		 							Draw the pong table
		//------------------------------------------------------------------------- 
		board board1(
			 .hcount(hcount),
			 .vcount(vcount),
			 .clk(vclk),
			 .pixel(board_pixel)
		);

		//-------------------------------------------------------------------------
		//		 							Calculate movement
		//-------------------------------------------------------------------------
		ball_movement ball_move(
			 .frame(frame),
			 .clk(vclk),
			 .rst(rst),
			 .paddle1(paddle1_y),
			 .paddle2(paddle2_y),
			 .ball_x(ball_x),
			 .ball_y(ball_y),
			 .win_rst1(win_rst1),
			 .win_rst2(win_rst2)
		);
		
		paddle1_movement paddle1_move(
			 .frame(frame), 
			 .clk(vclk), 
			 .ACL_IN(ACL1),
			 .rst(rst),
			 .win_rst(win_rst1),
			 .paddle_x(paddle1_x),
			 .paddle_y(paddle1_y)
		);
		
		paddle2_movement paddle2_move(
			 .frame(frame),
			 .clk(vclk),
			 .ACL_IN(ACL2),
			 .rst(rst),
			 .win_rst(win_rst2),
			 .paddle_x(paddle2_x),
			 .paddle_y(paddle2_y)
		);

		//-------------------------------------------------------------------------
		//		 							Generate final output
		//-------------------------------------------------------------------------
		output_pixels final_out(
			 .clk(vclk),
			 .rst(rst),
			 .paddle1(paddle1_pixel),
			 .paddle2(paddle2_pixel),
			 .score1(score1_pixel),
			 .score2(score2_pixel),
			 .over1(over1),
			 .over2(over2),
			 .hcount(hcount),
			 .vcount(vcount),
			 .board(board_pixel),
			 .ball(ball_pixel),
			 .final(final_pixels)
		);

 
		assign pixel = final_pixels;
		assign VGA_R = pixel[7:5];
		assign VGA_G = pixel[4:2];
		assign VGA_B = pixel[1:0];
		assign vsync = ~vs;
		assign hsync = ~hs;

endmodule
