//----------------------- IFETCH UNIT----------------------//
//--------- DATE 23/2/2007, DESIGNER --S.GOPI KRISHNA----------// 
//-THIS MODULE INCREMENTS PC BYE 4 WHILE READING EVERY SUCCESSIVE INSTRUCTION-//
//--HOWEVER ON A BRANCH IT CALCULATES THE EFFECTIVE ADDRESS AND ADDS TO PC--//

/*
                     |---------------------------------------------------------|
                     |                                           |\            | 
                     |                            |------------->| \           | 
                     |                            |              |  \          | 
                     |                            |              |   \         | 
                     |                            |              \    \        | 
                     |                            |               \    \  PC+4 | 
                     |                            |                |ADD |------| 
                     |                            |               /    /       
                     |                            |              /    /         
                     |                            |    4         |   /          
                     |                            |     -------->|  /           
                     |                            |              | /            
                     |                            |              |/ 
                     |     |\                     | 
                     |     | \                    |
                     |     |  \                   |  |---------|
                     ----->|   \                  |  |         |
                           |    \       |-----|   |  |         |   
                           |     |      |     |   |  |  INSTR  | 
                           | MUX |----->| PC  |----->|         |--------> 
                           |     |      |     |      |  MEMOR  | 
         EFFECTIVE BRANCH  |    /       |-----|      |         | 
                     ----->|   /                     |         | 
                           |  /                      |---------|  
                           | /|     
                           |/ |     
          AND GATE            | 
             ---              | 
     ------>|   )             | 
    ZERO    |    )            | 
            |     )-----------|         
            |     )  
            |    )         
     ------>|   )         
  BRANCH     ---
*/



module    IFETCH
                 ( 

                  ///Outputs

                  PC_plus_4_Out, 
                  PC_Out_Mem,

                  //Inputs 
                  PC_Halt, 
                  Branch_Addr,   //EFFECTIVE BRANCH ADDRESS 
                  Branch_ID, 
                  Clock,
                  Reset_

                 )  ; 

parameter INSTRWIDTH = 32; 
parameter PCWIDTH =8; 

output [PCWIDTH-1 : 0 ] PC_plus_4_Out;
output [PCWIDTH-1 : 0 ] PC_Out_Mem;



input  [PCWIDTH-1 : 0 ] Branch_Addr;
input Clock,Reset_;
input Branch_ID,PC_Halt;

reg [PCWIDTH+1 : 0 ] PC;
wire Sel;
wire [PCWIDTH-1 : 0 ] next_PC;
wire [PCWIDTH+1 : 0 ] PC_plus_4;
wire [PCWIDTH-1 : 0 ] PC_plus_4_Out;
wire [PCWIDTH-1 : 0 ] PC_Out_Mem;
wire [PCWIDTH-1 : 0 ] PC_Out_Mem_pre;

 


////////--------MUX TO SELECT BETWEEN BRANCH ADDRESS AND PC INCREMENTED VALUE-----------////////////

IMux2x1   #(PCWIDTH)  Branch1(.OutputData(next_PC), .DataIn1( Branch_Addr), .DataIn2(PC_plus_4[PCWIDTH+1:2]), .SelectIn(Branch_ID)); 




assign PC_plus_4_Out = PC_plus_4[PCWIDTH-1:0]; 
assign PC_plus_4[PCWIDTH+1:2] = PC[PCWIDTH+1:2]  + 1;
assign PC_plus_4[PCWIDTH-7:0] = 2'b00;




////////////------INDEXING FOR INSTRUCTION MEMORY------------////////////

assign PC_Out_Mem = (PC_Halt) ? Branch_Addr : PC[PCWIDTH+1:2]; 



always@ ( posedge Clock)
begin
          if( Reset_ == 0)
                    PC = 10'b0; 
          else
          begin 
                    PC[PCWIDTH+1 :2] = next_PC; 
                    PC[PCWIDTH-7: 0] = 2'b0; 
          end 
end
endmodule
