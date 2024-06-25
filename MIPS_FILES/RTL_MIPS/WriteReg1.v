`define DataSz 32
module	WriteReg1	(

				//output	

				RegOut,

				//inputs

				Enable0, Enable1, Enable2, Enable3,

				RegWrEn,

				WriteData0,

				Clk,

				ResetBar
			);

output	[`DataSz-1:0] 	RegOut;

input	Enable0, Enable1, Enable2, Enable3;
input	RegWrEn;
input	[`DataSz-1:0]   WriteData0;
input	Clk, ResetBar;

reg	[`DataSz-1:0] 	RegOut;

always @(posedge Clk )
  begin
	if ( ResetBar == 1'b0 )
		RegOut <= 32'b0;
	else
	   begin
		if (Enable0 & RegWrEn)
                    	RegOut[7:0] <= WriteData0[7:0];
                else
                        RegOut[7:0] <= RegOut[7:0];

                if (Enable1 & RegWrEn)
                        RegOut[15:8] <= WriteData0[15:8];
                else
                        RegOut[15:8] <= RegOut[15:8];

                if (Enable2 & RegWrEn)
                        RegOut[23:16] <= WriteData0[23:16];
                else
                        RegOut[23:16] <= RegOut[23:16];

                if (Enable3 & RegWrEn)
                        RegOut[31:24] <= WriteData0[31:24];
                else
                        RegOut[31:24] <= RegOut[31:24];
	    end
  end

endmodule
