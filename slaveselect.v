/////////////////////////////////////////////////////////////////////////////////////
// Description: A simple module involving the switching of the slave select line
//					 during transmission and idle states. 
//
//  Inputs:
//		rst 					User input Reset
//		transmit 			signal from SPImaster causing ss line to go low
//								( enable )
//		done 					signal from SPIinterface causing ss line to go 
//								high ( disable )
//
//  Outputs:
//		ss 					ss output to ACL
////////////////////////////////////////////////////////////////////////////////////

module slaveSelect(
		rst,
		clk,
		transmit,
		done,
		ss
);

   input   rst;
   input   clk;
   input   transmit;
   input   done;
   output  ss;
   reg     ss = 1'b1;
      
   
		//-----------------------------------------------
		//			  Generates Slave Select Signal
		//-----------------------------------------------
		always @(posedge clk)
		begin: ssprocess
			
			begin
				//reset state, ss goes high ( disabled )
				if (rst == 1'b1)
					ss <= 1'b1;
				//if transmitting, then ss goes low ( enabled )
				else if (transmit == 1'b1)
					ss <= 1'b0;
				//if done, then ss goes high ( disabled )
				else if (done == 1'b1)
					ss <= 1'b1;
			end
		end
   
endmodule


