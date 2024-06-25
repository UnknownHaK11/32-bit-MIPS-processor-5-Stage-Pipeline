/////////----THIS IS THE DATA MEMORY OF  THE PROCESSOR-----//////
/////////----------MEM STAGE OF PROCESSOR-----------//////




module DataMem (

                 //////----INPUTS------//////
                 Byte_EX ,
                 ByteU_EX ,
                 HalfWord_EX ,
                 Word_EX ,
                 MemWrite_EX , 
                 MemRead_EX, 
                 MemtoReg_EX,
                 ALU_Result,
                 WriteAddr_EX,
                 RegWrite_EX,
                 Mem_Store,
                 Clock,
                 Reset_,


                 //////---OUTPUTS-----//////
                 WriteAddr_WB,
                 MemtoReg_ID,
                 MemOut,
                 WRBACK_Reg ,    ////Output of data Mem
                 RegWrite_Mem,
                 ALU_Result_Mem

               );


output [31:0] WRBACK_Reg,ALU_Result_Mem;
output MemtoReg_ID,RegWrite_Mem;
output [4:0] WriteAddr_WB;
output [31:0]MemOut;
//input Byte_EX,ByteU_EX,HalfWord_EX,Word_EX,StoreByte_EX,StoreWord_EX,StoreHalfWord_EX,MemWrite_EX,MemRead_EX,MemtoReg_EX;
input Byte_EX,ByteU_EX,HalfWord_EX,Word_EX,MemWrite_EX,MemRead_EX,MemtoReg_EX;
input [31:0] ALU_Result,Mem_Store;
input [4:0] WriteAddr_EX;
input RegWrite_EX;
input Clock,Reset_;
wire [31:0] QA,QB;
reg [4:0] WriteAddr_WB;
reg [31:0] MemOut,WRBACK_Reg;
reg [31:0] ALU_Result_Mem;
reg MemtoReg_ID,RegWrite_Mem;



   

//////////-------REGISTERS THAT READ DATA TO FORM THE WRITE BACK STAGE-----------////



always @(posedge Clock or negedge Reset_)

       begin
       if(Reset_ ==0)
             begin
             WRBACK_Reg     <= 32'b0;             ////WRBACK REG///
             ALU_Result_Mem <= 32'b0;         ////ALU RESULT///
             MemtoReg_ID    <= 1'b0;
             WriteAddr_WB   <= 5'b0;
             RegWrite_Mem   <= 1'b0;
             end
       else
             begin
             WRBACK_Reg     <= MemOut;
             ALU_Result_Mem <= ALU_Result;
             MemtoReg_ID    <= MemtoReg_EX ;
             WriteAddr_WB   <= WriteAddr_EX;
             RegWrite_Mem   <= RegWrite_EX;
             end
       end




////////-----CONTROLS FOR BYTE AND WORD READING FROM MEMORY---////////


always @ (Byte_EX or ByteU_EX or HalfWord_EX or Word_EX) 

begin
       case({Byte_EX,ByteU_EX,HalfWord_EX,Word_EX})

           4'b1000   :   MemOut =   {24'b0,QA[7:0]};


           4'b0100   :   MemOut =   {{24{QA[7]}},QA[7:0]}; 


           4'b0010   :   MemOut =   {16'b0,QA[15:0]};


           4'b0001   :   MemOut  =   QA;


           default   :   MemOut  =   32'b0;


       endcase
end



assign MemWen = (~MemWrite_EX);
assign MemCen = (~MemWrite_EX & MemRead_EX);



DataMem256x32  MEMINST (
                       QA,
                       Clock,
                       MemCen,
                       MemWen,
                       ALU_Result[7:0],  /////ADDRESS FOR LOAD OR STORE
                       Mem_Store,
                       QB,
                       1'b1,
                       1'b1,
                       1'b1,
                       8'b0,
                       32'b0                        
                       );

endmodule
