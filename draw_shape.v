//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//												* Draw paddles *
//  ===================================================================================
module draw_shape #(parameter WIDTH = 16,   // default width: 16 pixels
               HEIGHT = 128)(               // default height: 128 pixels  
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
	reg [7:0]	 COLOR = 8'hBB;
	reg [7:0] 	 pixel;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================

		always @(posedge clk) 
		begin
			if ((hcount >= x && hcount < (x+WIDTH)) && (vcount >= y && vcount < (y+HEIGHT)))
				pixel <= COLOR;
			else 
				pixel <= 8'b0;
		end
	
endmodule

