/////////////////////////////////////////////////////////////////////////////////////
// Description: The spi_master controls the state of the entire interface. Using 
//					 several signals to interact with the other modules. The spi_master
//					 selects the data to be transmitted and stores all data received
//					 from the PmodACL.  The data is then made available to the rest of
//					 the design on the xAxis, yAxis, and zAxis outputs.
//
//
//  Inputs:
//		CLK				100MHz onboard system clock
//		RST				Main Reset Controller
//		START				Signal to initialize a data transfer
//		SDI				Serial Data In
//
//  Outputs:
//		SDO				Serial Data Out
//		SCLK				Serial Clock
//		SS					Slave Select
//		yAxis				y-axis data received from PmodACL

////////////////////////////////////////////////////////////////////////////////////

//  ===================================================================================
//  								  Define Module, Inputs and Outputs
//  ===================================================================================
module SPIcomponent(
		CLK,
		RST,
		START,
		SDI,
		SDO,
		SCLK,
		SS,
		yAxis
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
   input			 CLK;
   input        RST;
   input        START;
   input        SDI;
   output       SDO;
   output       SCLK;
   output       SS;
   output [9:0] yAxis;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	wire [9:0] 	 yAxis;

   wire [15:0]  TxBuffer;
   wire [7:0]   RxBuffer;
   wire         doneConfigure;
   wire         done;
   wire         transmit;
   
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
   
		//-------------------------------------------------------------------------
		//	Controls SPI Interface, Stores Received Data, and Controls Data to Send
		//-------------------------------------------------------------------------
		SPImaster C0(
					.rst(RST),
					.start(START),
					.clk(CLK),
					.transmit(transmit),
					.txdata(TxBuffer),
					.rxdata(RxBuffer),
					.done(done),
					.y_axis_data(yAxis)
		);
		
		//-------------------------------------------------------------------------
		//		 Produces Timing Signal, Reads ACL Data, and Writes Data to ACL
		//-------------------------------------------------------------------------
		SPIinterface C1(
					.sdi(SDI),
					.sdo(SDO),
					.rst(RST),
					.clk(CLK),
					.sclk(SCLK),
					.txbuffer(TxBuffer),
					.rxbuffer(RxBuffer),
					.done_out(done),
					.transmit(transmit)
		);
		
		//-------------------------------------------------------------------------
		//		 			 	Enables/Disables PmodACL Communication
		//-------------------------------------------------------------------------
		slaveSelect C2(
					.clk(CLK),
					.ss(SS),
					.done(done),
					.transmit(transmit),
					.rst(RST)
		);
   
endmodule
