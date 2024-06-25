`define DataSz 32
module	WriteReg(

				//output	

				RegOut,

				//inputs

                Enable,                    
				RegWrEn,
				WriteData,
				Clk,
				Reset_

			    );

output	[`DataSz-1:0] 	RegOut;

input	Enable;
input	RegWrEn;
input	[`DataSz-1:0]   WriteData;
input	Clk, Reset_;

reg	[`DataSz-1:0] 	RegOut;




always @(posedge Clk  or negedge Reset_)
  begin
        	if ( Reset_ == 1'b0)
	        	RegOut <= 32'b1;
        	else
           	if (Enable & RegWrEn)
                 	RegOut <= WriteData;
  end
endmodule
