//////////////////////////////////////////////////////////////////////////////////
// University of Thessaly
// 
// Authors:  Spyrou Michalis
//           Delakoura Aggeliki
//
// Year:     2013
//
//////////////////////////////////////////////////////////////////////////////////

//===================================================================================
//  							  Define Module, Inputs and Outputs
//===================================================================================
module top_logic(  
		clk,
		rst,
		FRZ,
		SDI1,
		SDI2,
		vsync,
		hsync,
		VGA_R,
		VGA_G,
		VGA_B,
		SS1,
		SDO1,
		SCLK1,
		SS2,
		SDO2,
		SCLK2
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================	
	input			 clk;
   input 		 rst;
	input 		 FRZ;
	input 		 SDI1;
	input 		 SDI2;
	output 		 vsync;
	output 		 hsync;
	output [2:0] VGA_R;
	output [2:0] VGA_G;
	output [1:0] VGA_B;
	output 		 SS1;
	output 		 SDO1;
	output 		 SCLK1;
	output 		 SS2;
	output 		 SDO2;
	output 		 SCLK2;		

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	wire			clk_acl;
	wire [9:0] 	yAxis1;
	wire [9:0] 	yAxis2;

//  ===================================================================================
// 							  				Implementation
//  ===================================================================================


		//-------------------------------------------------------------------------
		//	 								Generate the vga output
		//-------------------------------------------------------------------------
		xvga VGA( 
			 .clk(clk),
			 .rst(rst),
			 .frz(FRZ),
			 .vsync(vsync),
			 .hsync(hsync),
			 .ACL1(yAxis1),
			 .ACL2(yAxis2),
			 .VGA_R(VGA_R),
			 .VGA_G(VGA_G),
			 .VGA_B(VGA_B)
		);	

		//-------------------------------------------------------------------------
		//	 					Generate 5hz clock for the accelerometers
		//-------------------------------------------------------------------------
		ClkDiv_5Hz acl_clk(
			 .CLK(clk),
			 .RST(rst),
			 .CLKOUT(clk_acl)
		);

		//-------------------------------------------------------------------------
		//	 								Control Accelerometer 1
		//-------------------------------------------------------------------------
		SPIcomponent SPI1(
			 .CLK(clk),
			 .RST(rst),
			 .START(clk_acl),
			 .SDI(SDI1),
			 .SDO(SDO1),
			 .SCLK(SCLK1),
			 .SS(SS1),
			 .yAxis(yAxis1)
		);

		//-------------------------------------------------------------------------
		//	 								Control Accelerometer 2
		//-------------------------------------------------------------------------
		SPIcomponent SPI2(
			 .CLK(clk),
			 .RST(rst),
			 .START(clk_acl),
			 .SDI(SDI2),
			 .SDO(SDO2),
			 .SCLK(SCLK2),
			 .SS(SS2),
			 .yAxis(yAxis2)
		);
		
endmodule
