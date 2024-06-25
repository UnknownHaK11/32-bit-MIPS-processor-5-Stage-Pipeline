//`define MaxInputSz 8192
`define Period 8 

`timescale 1ns/1ps


module T_Top_Risc;



wire [31:0] Instruction_Out;
reg Clock,Reset_;


Top_Risc  RISC
        (
         Instruction_Out, 
         Clock,                 // Processor Clock Input
         Reset_                // Processor Reset Input
        );







initial Clock = 0;



always
# 100 Clock = ~Clock;



initial
begin
 Reset_ = 1;
 #1100;
 Reset_ = 0;
 #1000;
 Reset_ = 1;
 #1000000;
end

endmodule
