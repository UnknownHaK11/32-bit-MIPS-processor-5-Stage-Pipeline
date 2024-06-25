

//`define MaxInputSz 8192
`define Period 4 

`timescale 1ns/1ns


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


initial
begin
 Reset_ = 1;
 #1000;
 Reset_ = 0;
 #1000;
 Reset_ = 1;
end

initial
begin
        Clock = 0;
        forever #(`Period/4) Clock = ~Clock;
end

endmodule
