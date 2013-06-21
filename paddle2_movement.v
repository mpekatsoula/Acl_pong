//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//						* Calculate paddle2 movement based on the accelerometer2 *
//  ===================================================================================
module paddle2_movement #(parameter X = 778,  // default X & Y
											   Y = 200 )(
		frame, 
		clk,
		ACL_IN,
		rst,
		win_rst,
		paddle_x,
		paddle_y
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
	input 		  frame; 
	input 		  clk;
	input [9:0]   ACL_IN;
	input 		  rst;
	input 		  win_rst;
	output [10:0] paddle_x;
	output [9:0]  paddle_y;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg [9:0] 		  paddle_y;
	reg [1:0] 		  v_y;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
		assign paddle_x = X;

		always @ ( posedge clk)
		begin
			if ( rst == 1 || win_rst == 1 ) 
			begin
				paddle_y <= Y;
				v_y <= 1; // velocity on y axis
			end
			else 
			begin
				if ( frame == 1 ) 
				begin
					if ( (ACL_IN[8:0] >= 0 && ACL_IN[8:0] <= 175) && paddle_y > 2)
						paddle_y <= paddle_y - v_y;
								
					if ( (ACL_IN[8:0] > 175 && ACL_IN[8:0] <= 250) && paddle_y > 3)
						paddle_y <= paddle_y - v_y - v_y;
									 
					if ( (ACL_IN[8:0] > 250 && ACL_IN[8:0] <= 375) && paddle_y < 469)
						paddle_y <= paddle_y + v_y + v_y;
									 
					if ( (ACL_IN[8:0] > 375 && ACL_IN[8:0] <= 550) && paddle_y < 470)
						paddle_y <= paddle_y + v_y;
				end
			end
		end
								  
endmodule