
/////This module is used to generate Control signals for Ifetch, Decode and Execute stages////
   ///////CONTROL UNIT USED TO GENERATE CONTROL SIGNALS//////
 


 `define LB    6'b100000
 `define LBU   6'b100100
 `define LW    6'b100011
 `define LHW   6'b100011
 `define SB    6'b101000
 `define SHW   6'b101001
 `define SW    6'b101011

 `define ADDI  6'b001000
 `define ADDIU 6'b001001
 `define ANDI  6'b001100
 `define ORI   6'b001101
 `define XORI  6'b001110
 `define SLTI  6'b001010
 `define SLTIU 6'b001010
 `define LUI   6'b001111

module  IControlUnit
                     ( 

                      ////INPUT 

                      Opcode, 
                      IFLUSH, 


                      ///OUTPUTS 

                      IR1,
                      Byte_reg,
                      ByteU_reg,
                      HalfWord_reg,
                      Word_reg,
                      StoreByte_reg,
                      StoreWord_reg,
                      StoreHalfWord_reg,
                      MemWrite_reg, 
                      MemRead_reg, 
                      RegDst_reg, 
                      MemtoReg_reg, 
                      RegWrite_reg, 
                      ALUSrc_reg,
                      Clock,
                      Reset_
                      ); 



parameter OPCODE = 32; 
input  Clock, Reset_;
input  IFLUSH;
input  [OPCODE-1:0] Opcode;
output RegDst_reg,MemWrite_reg,MemRead_reg,ALUSrc_reg,MemtoReg_reg;
output Byte_reg,ByteU_reg,HalfWord_reg,Word_reg,StoreByte_reg,StoreWord_reg,StoreHalfWord_reg ; 
output [OPCODE-1:0] IR1;
output RegWrite_reg;
reg  ALUSrc_reg;
reg  MemWrite_reg,MemRead_reg,MemtoReg_reg;
reg  RegDst_reg,RegWrite_reg;
reg  Byte_reg,ByteU_reg,HalfWord_reg,Word_reg,StoreByte_reg,StoreWord_reg,StoreHalfWord_reg ; 
reg  [OPCODE-1:0] IR1;
wire MemWrite_pre,MemRead_pre,MemtoReg_pre,RegDst_pre,ALUSrc_pre;
wire MemWrite,MemRead,MemtoReg,RegDst,ALUSrc;
wire LoadWord,R_format,I_format,RegWrite_reg_pre,RegWrite_reg_pre1;
reg  Byte,ByteU,HalfWord,Word,StoreByte,StoreWord,StoreHalfWord ;


/////-------------THREE INSTRUCTION FORMATS R, I ,J-------------////


////R_format = for register to register instructions ///
////////I format = Load and Store instructions /////////
////////J format = Branch instructions//////////// 


assign  R_format =  (Opcode[31:26] == 6'b000000) ? 1 : 0; 
assign  I_format =  (Opcode[31:29] == 3'b001 && Opcode[28:26] > 3'b001) ? 1 : 0; 

always @ (posedge Clock or negedge Reset_)
         if(Reset_==0)
          begin
                  Byte_reg<=1'b0;
                  ByteU_reg<=1'b0;
                  HalfWord_reg<=1'b0;
                  Word_reg<=1'b0;
                  StoreByte_reg<=1'b0;
                  StoreWord_reg<=1'b0;
                  StoreHalfWord_reg <=1'b0;
                  ALUSrc_reg   <= 1'b0;
                  MemWrite_reg <= 1'b1; 
                  MemRead_reg  <= 1'b1; 
                  MemtoReg_reg  <= 1'b0;
                  RegDst_reg <= 1'b0;
                  RegWrite_reg <= 1'b0; 
          end
          else
          begin
                  Byte_reg=Byte;
                  ByteU_reg=ByteU;
                  HalfWord_reg=HalfWord;
                  Word_reg<=Word;
                  StoreByte_reg<=StoreByte;
                  StoreWord_reg<=StoreWord;
                  StoreHalfWord_reg <=StoreHalfWord ;
                  ALUSrc_reg   <= ALUSrc;
                  MemWrite_reg <= MemWrite;
                  MemRead_reg <= MemRead;
                  MemtoReg_reg  <= MemtoReg;
                  RegDst_reg <= RegDst;
                  RegWrite_reg <= RegWrite_reg_pre; 
          end






always @ (Opcode)
begin
         case(Opcode[31:26])

              `LB   :
                      begin
                         Byte = 1; 
                         ByteU = 0;
                         HalfWord=0;
                         Word=0;
                         StoreByte = 0; 
                         StoreWord = 0; 
                         StoreHalfWord = 0; 
                      end 

              `LBU  :

                      begin
                         Byte =0 ; 
                         ByteU = 1;
                         HalfWord=0;
                         Word=0;
                         StoreByte = 0; 
                         StoreWord = 0; 
                         StoreHalfWord = 0; 
                      end 


              `LHW  :
                      begin
                         Byte = 0; 
                         ByteU = 0;
                         HalfWord=1;
                         Word=0;
                         StoreByte = 0; 
                         StoreWord = 0; 
                         StoreHalfWord = 0; 
                      end 


              `LW   :

                      begin
                         Byte = 0; 
                         ByteU = 0;
                         HalfWord=0;
                         Word=1;
                         StoreByte = 0; 
                         StoreWord = 0; 
                         StoreHalfWord = 0; 
                      end 

              `SB   :

                      begin
                         Byte =0 ; 
                         ByteU = 0;
                         HalfWord=0;
                         Word=0;
                         StoreByte = 1; 
                         StoreWord = 0; 
                         StoreHalfWord = 0; 
                      end 

              `SW   : 
                      begin
                         Byte = 0; 
                         ByteU = 0;
                         HalfWord=0;
                         Word=0;
                         StoreByte = 0; 
                         StoreWord = 1; 
                         StoreHalfWord = 0; 
                      end 


              `SHW  : 
                      begin
                         Byte = 0; 
                         ByteU = 0;
                         HalfWord=0;
                         Word=0;
                         StoreByte = 0; 
                         StoreWord = 0; 
                         StoreHalfWord = 1; 
                      end 
               
              default : 
                      begin
                         Byte = 0; 
                         ByteU = 0;
                         HalfWord=0;
                         Word=0;
                         StoreByte = 0; 
                         StoreWord = 0; 
                         StoreHalfWord = 0; 
                      end 
          endcase
end



always@ (posedge Clock or negedge Reset_)
begin
              if(Reset_==0)
                       IR1  <= 32'b0;
              else
                       IR1  <= Opcode;
end



     ///IN CASE OF LOAD OR STORE IN IMMEDIATE MODE WITH ADDRESS VALUE///
///GENERATE A SELECT FOR SELECTING THE IMMEDIATE FIELD OR Rt ADDRESS REGVALUE///
////---FLUSHING THE CONTROL SIGNALS DURING BRANCH----////

assign  ALUSrc_pre   =  Byte | ByteU | HalfWord | Word | StoreByte | StoreWord | StoreHalfWord ;
assign  ALUSrc       =  (IFLUSH) ?  1'b0 : ALUSrc_pre;



assign  RegDst_pre   =  R_format;
assign  RegDst       =  (IFLUSH) ?  1'b0 : RegDst_pre;


assign  MemtoReg_pre =  Byte | ByteU | HalfWord | Word ;  //Load reg controls
assign  MemtoReg     =  (IFLUSH) ?  1'b0 : MemtoReg_pre;


assign  MemWrite_pre =  StoreByte | StoreWord | StoreHalfWord ;
assign  MemWrite     =  (IFLUSH) ?  1'b0 : MemWrite_pre;


assign  MemRead_pre  =  Byte | ByteU | HalfWord | Word ;
assign  MemRead      =  (IFLUSH) ?  1'b0 : MemRead_pre;


assign  RegWrite_reg_pre1 =  R_format | (Byte | ByteU | HalfWord | Word) | I_format;
assign  RegWrite_reg_pre  =  (IFLUSH) ?  1'b0 : RegWrite_reg_pre1;

endmodule
