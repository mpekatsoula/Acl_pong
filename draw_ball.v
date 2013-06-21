//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//													* Draw ball *
//  ===================================================================================
module draw_ball #(parameter WIDTH = 32,  // default width: 32 pixels
                   HEIGHT = 32)(          // default height: 32 pixels
		x,
		hcount, 
		y,
		vcount,
		clk,
		pixel
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
	input [10:0] x;
	input [10:0] hcount;
	input [9:0]  y;
	input [9:0]  vcount;
	input 		 clk;
	output [7:0] pixel;
	
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg 			 COLOR = 8'hFF;
	reg [7:0] 	 pixel;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================

		always @(posedge clk) 
		begin
			if ((hcount >= x && hcount < (x+WIDTH)) && (vcount >= y && vcount < (y+HEIGHT)))
				pixel <= 8'hFF;
			else
				pixel <= 8'b0;
		end
				
endmodule
