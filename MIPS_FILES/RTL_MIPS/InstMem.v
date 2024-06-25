`define  infile "D:/Projects/MIPS_FILES/CODE_10JULY/Asm8.o"


module  InstMem


               ( 
                /////OUTPUTS   
                IR0, 



                ////INPUTS 
                IFLUSH,  
                PC_Out_Mem,
                Clock,
                Reset_
               ) ;




input Clock,Reset_;
input [7:0]  PC_Out_Mem;
input IFLUSH;

output [31:0] IR0;


reg [31:0] IR0;
reg [31:0] ASMMEM [0:255];
reg [7:0] INDEX;




initial
begin
   $readmemh ( `infile, ASMMEM); 
end


always @ ( PC_Out_Mem )
begin
       INDEX =  PC_Out_Mem  ;
end



always @ (posedge Clock or negedge Reset_)
begin
 if(Reset_ == 0)
        IR0 <= 32'b0;  
 else
 if(IFLUSH) 
        IR0 <= 32'b0;
 else
        IR0 <= ASMMEM[INDEX]; 
end
endmodule
