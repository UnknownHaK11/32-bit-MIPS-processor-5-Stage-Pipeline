///////-----EXECUTION UNIT OF PROCESSOR---------////////
     ///////-----DATE 27/2/2007  --------////////
///////----------DESIGNER GOPI------------------///////


///--INSTRUCTION DESCRIPTION WITH OPCODES--------///

///---------R  format instructions---------///

 `define ADD   6'b100000
 `define ADDU  6'b100001
 `define AND   6'b100100
 `define OR    6'b100101
 `define SLL   6'b000000
 `define SLLV  6'b000100
 `define SRA   6'b000011
 `define SRAV  6'b000100
 `define SRL   6'b000010
 `define SRLV  6'b000100
 `define SLT   6'b101010
 `define SLTU  6'b101011
 `define SUB   6'b100010
 `define SUBU  6'b100011
 `define XOR   6'b100110
 `define NOR   6'b100111
 `define MFHI  6'b010000
 `define MFLO  6'b010010
 `define MTHI  6'b010001
 `define MTLI  6'b010011



///----------I  format instructions-------------///

 `define ADDI  6'b001000
 `define ADDIU 6'b001001
 `define ANDI  6'b001100
 `define ORI   6'b001101
 `define XORI  6'b001110
 `define SLTI  6'b001010
 `define SLTIU 6'b001010
 `define LUI   6'b001111
 `define LB    6'b100000
 `define LBU   6'b100100
 `define LH    6'b100001
 `define LHW   6'b100101
 `define LW    6'b100011
 `define LWL   6'b100010
 `define LWR   6'b100110
 `define SB    6'b101000
 `define SHW   6'b101001
 `define SW    6'b101011
 `define SWL   6'b101010
 `define SWR   6'b101110
 `define BEQ   6'b000100
 `define BNE   6'b000101

//----MULTIPLY AND DIVIDE---//

 `define MULT  6'b011000
 `define MULTU 6'b011001
 `define DIV   6'b011010
 `define DIVU  6'b011011
 
 //-----halt-----///
 `define HALT  6'b000001


//////----J TYPE INSTRUCTIONS------////

 `define BLEZ    6'b000110
 `define BGZ     6'b000111
 `define BLZ     6'b000101
 `define BGEZ    6'b000110
 `define BLTZAL  6'b000100
 `define BGEZAL  6'b000101
 `define J       6'b000110
 `define JAL     6'b000011
 
 //--SPECIAL--//
 `define JR      6'b001000
 `define JALR    6'b001001


module  IExecute
                 ( 

                 ///INPUTS 
     
                 DepRes_Rt_Sel_EX,
                 DepRes_Rs_Sel_EX,
                 DepRes_Rt_Sel,
                 DepRes_Rs_Sel,
                 DepRes_Rt_LdSt_EX,
                 DepRes_Rs_LdSt_EX,
                 DepRes_Rt_LdSt_WB_EX,
                 DepRes_Rs_LdSt_WB_EX,
                 ALU_Result_Mem,  //S1_Contents
                 ALU_Input1,      //S1_Contents
                 Read_data_2,     //S2_Contents
                 Sign_Extend,
                 MemOut,
                 opcode,          //MSB 6 Bits of Inst for comparison
                 Rs_EX,           //Address rt of contents2
                 Rt_EX,           //Address rt of contents2
                 Rd_EX,           //Address rd of destination register                 
                 Immediate,       //Immediate field  Imm
                 Shift,           //Shift value
                 Function_opcode, //LSB SIX BITS OR ALU FUNCTION
                 Byte_reg,
                 ByteU_reg,
                 HalfWord_reg,
                 Word_reg,
                 StoreByte_reg,
                 StoreWord_reg,
                 StoreHalfWord_reg,
                 MemWrite_reg, 
                 MemRead_reg, 
                 MemtoReg_reg,
                 RegWrite_reg,
                 RegDst_EX,
                 ALUSrc, 
                 Clock, 
                 Reset_,
                 

                 ///OUTPUTS 
                 Byte_EX ,
                 ByteU_EX ,
                 HalfWord_EX ,
                 Word_EX ,
                 MemWrite_EX , 
                 MemRead_EX, 
                 MemtoReg_EX,
                 RegWrite_EX,
                 result,//OUTPUT THAT GOES TO DATA MEMORY AS ADDRESS TO READ WRITE OR IS OUTPUT OF ALU OPERATION 
                 ALU_Result,//OUTPUT THAT GOES TO DATA MEMORY AS ADDRESS TO READ WRITE OR IS OUTPUT OF ALU OPERATION 
                 WriteAddr_EX,
                 Mem_Store_EX 
                 ); 
                 
                 
input DepRes_Rt_LdSt_WB_EX,DepRes_Rs_LdSt_WB_EX;
input [4:0] Rs_EX,Rt_EX,Rd_EX,Shift;       //Write Back Address
input [5:0]  opcode;
input Clock,Reset_;
input RegWrite_reg;
input Byte_reg,ByteU_reg,HalfWord_reg,Word_reg,StoreByte_reg,StoreWord_reg,StoreHalfWord_reg,MemWrite_reg,MemRead_reg,MemtoReg_reg;
input [31:0] ALU_Input1,Read_data_2,Sign_Extend;
input [5:0]  Function_opcode;
input        RegDst_EX;
input        ALUSrc;
input [15:0] Immediate;
input DepRes_Rt_Sel,DepRes_Rs_Sel;
input DepRes_Rt_Sel_EX,DepRes_Rs_Sel_EX;
input  [31:0] ALU_Result_Mem;     //S1_Contents
input  [31:0] MemOut;     //S1_Contents
input  DepRes_Rt_LdSt_EX;
input  DepRes_Rs_LdSt_EX;
output RegWrite_EX;
output [4:0] WriteAddr_EX;
output [31:0] Mem_Store_EX;
output [31:0] ALU_Result;
output [31:0] result;
output Byte_EX,ByteU_EX ,HalfWord_EX,Word_EX,MemWrite_EX,MemRead_EX,MemtoReg_EX;  

reg RegWrite_EX;
reg         Byte_EX,ByteU_EX,HalfWord_EX,Word_EX,MemWrite_EX,MemRead_EX,MemtoReg_EX;
reg [4:0]   WriteAddr_EX;
reg [31:0]  ALU_Result;
wire [2:0]  ALU_Cntrl ;
wire [31:0] ALU_Input2;
wire [31:0] Immediate_nxt, Immediate_0ext;
wire [4:0]  WriteAddr;
reg [31:0]  result,result1,result_pre,Target_address;
reg [63:0]  mult_result,mult_temp_result;
reg [31:0]  Input1,Input2,Mem_Store;
reg [31:0]  Mem_Store_EX;
wire [31:0] Mem_Store_EX_pre;
wire [31:0]  ALU_Input1_Forward,ALU_Input2_Forward;
wire [31:0]  ALU_Input1_Forward_EX,ALU_Input1_Forward_EX_pre,ALU_Input1_Forward_EX_pre1,ALU_Input2_Forward_EX_pre,ALU_Input2_Forward_EX;
reg [1:0]   signs;
reg [31:0] ALU_Result_WB;
reg   MemtoReg_WB;
reg div_temp_result; 
reg  DepRes_Rt_LdSt_EX_pre;
reg  DepRes_Rs_LdSt_EX_pre;
reg  DepRes_Rt_LdSt_WB_EX_pre;
reg  DepRes_Rs_LdSt_WB_EX_pre;
reg  [31:0]MemOut_WB;
integer j;




//////////////---------Dependency resolving by DataForwading--------/////////////
//////////////--------------Operand One & Two Forwarding------------/////////////
//////////////----------------ID/EX  FORWARDING--------------------/////////////
//////////////----------------ID/MEM  FORWARDING--------------------/////////////
//////////////----------------ID/WB  FORWARDING--------------------/////////////

IMux2x1   #(32) DepResMux1(.OutputData(ALU_Input1_Forward), .DataIn1(ALU_Result), .DataIn2(ALU_Input1),  .SelectIn(DepRes_Rs_Sel));
IMux2x1   #(32) DepResMux2(.OutputData(ALU_Input2_Forward), .DataIn1(ALU_Result), .DataIn2(Read_data_2), .SelectIn(DepRes_Rt_Sel));
IMux2x1   #(32) DepResMux3(.OutputData(ALU_Input1_Forward_EX_pre), .DataIn1(ALU_Result_Mem), .DataIn2(ALU_Input1_Forward), .SelectIn(DepRes_Rs_Sel_EX));
IMux2x1   #(32) DepResMux4(.OutputData(ALU_Input2_Forward_EX_pre), .DataIn1(ALU_Result_Mem), .DataIn2(ALU_Input2_Forward), .SelectIn(DepRes_Rt_Sel_EX));

IMux2x1   #(32) DepResMux5_LdSt(.OutputData(Mem_Store_EX_pre), .DataIn1(MemOut),  .DataIn2(Mem_Store), .SelectIn(LdSt_Rt_Forward));
IMux2x1   #
(32) DepResMux6_LdSt(.OutputData(ALU_Input1_Forward_EX_pre1), .DataIn1(MemOut),  .DataIn2(ALU_Input1_Forward_EX_pre), .SelectIn(LdSt_Rs_Forward));

IMux2x1   #(32) DepResMux7_LdSt(.OutputData(ALU_Input2_Forward_EX), .DataIn1(MemOut_WB),  .DataIn2(ALU_Input2_Forward_EX_pre), .SelectIn(LdSt_Rt_Forward_WB));
IMux2x1   #(32) DepResMux8_LdSt(.OutputData(ALU_Input1_Forward_EX), .DataIn1(MemOut_WB),  .DataIn2(ALU_Input1_Forward_EX_pre1), .SelectIn(LdSt_Rs_Forward_WB));


//////------------This Mux is used for selection during a LoadWord or StoreWord------------------////


IMux2x1   #(32) Branch1(.OutputData(ALU_Input2), .DataIn1(Sign_Extend), .DataIn2(ALU_Input2_Forward_EX), .SelectIn(ALUSrc));

IMux2x1   #(5)  Write_Sel_reg(.OutputData(WriteAddr), .DataIn1(Rd_EX), .DataIn2(Rt_EX), .SelectIn(RegDst_EX));



assign Immediate_nxt = {{16{ Immediate[15]}},Immediate[15:0]};
assign Immediate_0ext = {16'b0,Immediate[15:0]};

assign LdSt_Rt_Forward = DepRes_Rt_LdSt_EX_pre & MemtoReg_EX;
assign LdSt_Rs_Forward = DepRes_Rs_LdSt_EX_pre & MemtoReg_EX;

assign LdSt_Rt_Forward_WB = DepRes_Rt_LdSt_WB_EX_pre & MemtoReg_WB;
assign LdSt_Rs_Forward_WB = DepRes_Rs_LdSt_WB_EX_pre & MemtoReg_WB;



always @ (posedge Clock or negedge Reset_)
   if(Reset_==0)
               begin
               ALU_Result     <= 32'b0; 
               ALU_Result_WB  <= 32'b0; 
               WriteAddr_EX   <= 5'b0;
               DepRes_Rt_LdSt_EX_pre <= 1'b0;
               DepRes_Rs_LdSt_EX_pre <= 1'b0;
               DepRes_Rt_LdSt_WB_EX_pre <= 1'b0;
               DepRes_Rs_LdSt_WB_EX_pre <= 1'b0;
               end
   else
               begin
               ALU_Result            <= result;
               ALU_Result_WB         <= ALU_Result_Mem;
               WriteAddr_EX          <= WriteAddr;
               DepRes_Rt_LdSt_EX_pre <= DepRes_Rt_LdSt_EX;
               DepRes_Rs_LdSt_EX_pre <= DepRes_Rs_LdSt_EX;
               DepRes_Rt_LdSt_WB_EX_pre <= DepRes_Rt_LdSt_WB_EX;
               DepRes_Rs_LdSt_WB_EX_pre <= DepRes_Rs_LdSt_WB_EX;
               end


always @(posedge Clock or negedge Reset_)
    if(Reset_==0)
                 begin
                 MemtoReg_WB <= 1'b0;
                 MemOut_WB   <= 32'b0;
                 end
    else
                 begin
                 MemtoReg_WB <= MemtoReg_EX;
                 MemOut_WB   <= MemOut;
                 end
                 
                 
always @ (posedge Clock or negedge Reset_)
    if(Reset_==0)
             begin
                 Byte_EX          <= 1'b0;
                 ByteU_EX         <= 1'b0;
                 HalfWord_EX      <= 1'b0;
                 Word_EX          <= 1'b0;
                 Mem_Store_EX     <= 32'b0;
                 MemWrite_EX      <= 1'b0; 
                 MemRead_EX       <= 1'b0; 
                 RegWrite_EX      <= 1'b0;
                 MemtoReg_EX      <= 1'b0;
             end
    else
             begin
                 Byte_EX          <= Byte_reg ;
                 ByteU_EX         <= ByteU_reg ;
                 HalfWord_EX      <= HalfWord_reg ;
                 Word_EX          <= Word_reg ;
                 Mem_Store_EX     <= Mem_Store_EX_pre ;
                 MemWrite_EX      <= MemWrite_reg ; 
                 MemRead_EX       <= MemRead_reg ; 
                 RegWrite_EX      <= RegWrite_reg;
                 MemtoReg_EX      <= MemtoReg_reg;
             end



///////////----------ALU OPERATIONS--------///////////

always @ (opcode or Function_opcode or result or Shift or signs or result1 or ALU_Input1_Forward_EX or ALU_Input2 or Input1 or Input2 or Immediate or Immediate_nxt or mult_temp_result or div_temp_result)
begin

        case(opcode)
        
        6'b000000 :   /* ---- R format instruction---------*/
        
             case(Function_opcode)

                  //-----SHIFT LEFT LOGICAL--------//
                  //-This instruction shifts the operand 2 by the SHIFT field in the instruction--//

                            `SLL :
                             begin 
                             result = ALU_Input2 << Shift;
                             end 




                  //----SHIFT LEFT LOGICAL VARIABLE--//
                  //-This instruction Shifts the operand 2 by value specified in operand 1-//


                            `SLLV:
                             begin 
                             result = ALU_Input2 << ALU_Input1_Forward_EX;
                             end 




                  //----SHIFT RIGHT LOGICAL----//
                  //-This instruction Shifts the operand 2 by value specified in Shift field of instruction--// 


                            `SRL :
                             begin 
                             result = ALU_Input2 >> Shift;
                             end 





                  //----SHIFT RIGHT LOGICAL VARIABLE--//
                  //--This instruction Shifts operand 2 Logical right by value specified in Operand 1--//


                            `SRLV:
                             begin 
                             result = ALU_Input2 >> ALU_Input1_Forward_EX;
                             end 




                  //---SHIFT RIGHT ARITHMETIC----///
                  //--This instruction shifts the operand2 arithmetic by value specified in Shift field of instruction--//


                            `SRA : 
                                   begin
                                   result = ALU_Input2;
                                   for(j=0;j<Shift;j=j+1)
                                      begin
                                       result = result >> 1;
                                       result = {ALU_Input2[31],result[30:0]};
                                      end
                                   end



                  //---SHIFT RIGHT ARITHMETIC VARIABLE--//
                  //--This instruction shifts operand 2 arithmetic by the value sprecified in operand 1--//


                            `SRAV : 
                                   begin
                                   result = ALU_Input2;
                                   for(j=0;j<ALU_Input1_Forward_EX;j=j+1)
                                      begin
                                       result = result >> 1;
                                       result = {ALU_Input2[31],result[30:0]};
                                      end
                                   end




                 //---ADD INSTRUCTION adds operands by comparing the signs of the two operands---//


                            `ADD :
                                    begin
                                    signs = {ALU_Input1_Forward_EX[31],ALU_Input2[31]};
                                    case(signs)
                                      
                                      0  :  result  = ALU_Input1_Forward_EX + ALU_Input2;
                                      1  : 
                                            begin 
                                            Input2 = -ALU_Input2;  
                                            result =  ALU_Input1_Forward_EX - Input2;
                                            end
                                      2  :  
                                            begin
                                            Input1 = -ALU_Input1_Forward_EX;
                                            result =  ALU_Input2 - Input1;
                                            end
                                            
                                      3  :  
                                            begin
                                            Input2 = -ALU_Input2;
                                            Input1 = -ALU_Input1_Forward_EX;
                                            result_pre = Input1 + Input2;
                                            result = -result_pre;
                                            end
                                     endcase
                                     end





                //----ADDU INSTRUCTION ADDS BOTH OPERANDS IN UNSIGNED MANNER WITHOUT CONSIDERING THE SIGN--// 


                             `ADDU : 
                                      begin
                                      result = ALU_Input1_Forward_EX  +  ALU_Input2;
                                      end




                ///-----SUB AND SUBU BOTH USE SIGN BITS TO CALCULATE THE OPERATION----//


                             `SUB,`SUBU :  
                                       begin 
                                       signs = {ALU_Input1_Forward_EX[31],ALU_Input2[31]};
                                       case(signs)
                                      
                                         0  :  result  = ALU_Input1_Forward_EX - ALU_Input2;
                                         1  : 
                                               begin 
                                               Input2 = -ALU_Input2;  
                                               result =  ALU_Input1_Forward_EX + Input2;
                                               end
                                         2  :  
                                               begin
                                               Input1 = -ALU_Input1_Forward_EX;
                                               result =  ALU_Input2 + Input1;
                                               end
                                            
                                         3  :  
                                               begin
                                               Input2 = -ALU_Input2;
                                               result = Input2 - ALU_Input1_Forward_EX;
                                               end
                                       endcase
                                    	end





                 ///-----SET RESULT EQUAL TO ONE IF OPERAND ONE IS LESS THAN OPERAND2--///


                             `SLTU : 
                                    begin
                                    if(ALU_Input1_Forward_EX < ALU_Input2)
                                    result = 1;
                                    else
                                    result = 0;
                                    end






                 ///-------SET RESULT EQUAL TO ONE BY COMPARING OPERAND ONE WITH IMMEDIATE FIELD ----///


                             `SLTIU:
                                    begin
                                    Input1 = Immediate_nxt; 
                                    if(ALU_Input1_Forward_EX < Input1)
                                    result = 1;
                                    else
                                    result = 0;
                                    end




                 ////-------SET RESULT BY COMPARING BOTH THE SIGNS OF THE OPERANDS----//


                             `SLT :
                                  begin
                                  signs = {ALU_Input1_Forward_EX[31],ALU_Input2[31]};
                                  case(signs)
                                 
                                    0  :  if(ALU_Input1_Forward_EX < ALU_Input2)
                                          result = 1;
                                          else
                                          result = 0;
                                    1  : 
                                          begin
                                          result = 0;
                                          end
                                    2  :  
                                          begin
                                          result = 1;
                                          end
                                       
                                    3  :  
                                          begin
                                          if(ALU_Input1_Forward_EX < ALU_Input2)
                                          result = 0;
                                          else
                                          result = 1;                               
                                          end
                                  endcase
                                  end




                             `SLTI:
                                  begin
                                  Input2 = Immediate_nxt; 
                                  signs = {ALU_Input1_Forward_EX[31],Input2[31]};
                                  case(signs)
                                    0  :  if(ALU_Input1_Forward_EX < Input2)
                                          result = 1;
                                          else
                                          result = 0;
                                    1  : 
                                          result = 0;
                                    2  :  
                                          result = 1;
                                    3  :  
                                          begin
                                          if(ALU_Input1_Forward_EX < Input2)
                                          result = 0;
                                          else
                                          result = 1;                               
                                          end
                                  endcase
                                  end



                               `AND :
                                      begin
                                      result = ALU_Input1_Forward_EX & ALU_Input2;
                                      end

                               `OR  :
                                      begin
                                      result = ALU_Input1_Forward_EX | ALU_Input2;
                                      end

                               `XOR :
                                      begin
                                      result = ALU_Input1_Forward_EX ^ ALU_Input2;
                                      end

                               `NOR : 
                                     begin
                                     result1 = ALU_Input1_Forward_EX | ALU_Input2;
                                     result = !result1;
                                     end

                               `MULTU :
                                     begin
                                     mult_result = ALU_Input1_Forward_EX * ALU_Input2 ; 
                                     end

                               `MULT :
                                     begin
                                     signs = {ALU_Input1_Forward_EX[31],ALU_Input2[31]};
                                     case(signs)
                                     0  :  mult_result = ALU_Input1_Forward_EX * ALU_Input2;
                                           
                                     1  :
                                           begin
                                           Input2 = -ALU_Input2;  
                                           mult_temp_result = ALU_Input1_Forward_EX * Input2;
                                           mult_result = - mult_temp_result;
                                           end
                                     2  :  
                                           begin
                                           Input1 = -ALU_Input1_Forward_EX;  
                                           mult_temp_result = ALU_Input2 * Input1;
                                           mult_result = - mult_temp_result;
                                           end
                     
                                     3  :  
                                           begin
                                           Input1 = -ALU_Input1_Forward_EX;
                                           Input2 = -ALU_Input2;  
                                           mult_temp_result = -Input1 * -Input2;
                                           mult_result = - mult_temp_result;       
                                           end
                                        endcase
                                        end 
                                        
                               `DIVU : 
                                        begin
                                        result = ALU_Input1_Forward_EX /ALU_Input2;
                                        end 
                                  
                               `DIV: 
                                        begin
                                        signs = {ALU_Input1_Forward_EX[31],ALU_Input2[31]};
                                        case(signs)
                                     
                                     0  :  result = ALU_Input1_Forward_EX / ALU_Input2;
                                           
                                     1  :
                                           begin
                                           Input2 = -ALU_Input2;  
                                           div_temp_result = ALU_Input1_Forward_EX / Input2;
                                           result = - div_temp_result;
                                           end
                                     2  :  
                                           begin
                                           Input1 = -ALU_Input1_Forward_EX;  
                                           div_temp_result = Input1 / ALU_Input2;
                                           result = - mult_temp_result;
                                           end
                     
                                     3  :  
                                           begin
                                           Input1 = -ALU_Input1_Forward_EX;
                                           Input2 = -ALU_Input2;  
                                           div_temp_result = -Input1 / -Input2;
                                           result = - div_temp_result;       
                                        end
                                        endcase
                                     end
                                     endcase
                                           
                                                      /////-------R -FORMAT COMPLETES HERE----///
                                           /////----NEXT INST WITHOUT FUNCTION FIELD or IMMEDIATE INSTRUCTIONS----////
                                           
                               `ADDI :
                                        begin
                                           result1 = Immediate_nxt;
                                           signs = {ALU_Input1_Forward_EX[31],result1[31]};
                                           case(signs)
                                           
                                           0  : result = ALU_Input1_Forward_EX + result1;
                                           
                                           1 :  begin
                                                Input1 = -result1;
                                                result = ALU_Input1_Forward_EX + Input1;
                                                end
                                           2 :  begin
                                                
                                                Input1 = -ALU_Input1_Forward_EX;
                                                result = result1 - ALU_Input1_Forward_EX;
                                                end
                                           3:   begin
                                               Input1 = -result1;
                                                Input2 = -ALU_Input1_Forward_EX;
                                                result_pre =  Input1 + Input2;
                                                result = -result_pre;
                                                end
                                           endcase
                                       end
                                `ADDIU :
                                           begin
                                           result1 = Immediate_nxt; 
                                           result = ALU_Input1_Forward_EX + result1;
                                           end
                                `ANDI  :
                                           begin
                                           result1 = Immediate_0ext;
                                           result = ALU_Input1_Forward_EX & result1;
                                           end
                                `ORI  :
                                           begin
                                           result1 = Immediate_nxt;
                                           result = ALU_Input1_Forward_EX | result1;
                                           end
                                `XORI :
                                           begin
                                           result1 = Immediate_nxt; 
                                           result = ALU_Input1_Forward_EX ^ result1;
                                           end
                                `LUI  :
                                           begin
                                           result1 = {Immediate[15:0],16'b0}; //result1 = {{16{Immediate[15]}},16'b0};
                                           result = result1; 
                                           end 
                                     
                                `LB,`LBU,`LHW,`LW,`SB,`SW,`SHW:
                                           ////--THIS EFFECTIVE ADDRESS GOES TO THE DATA MEMORY FOR READING OR WRITING THE BYTES --////
                                           //////-------EFFECTIVE ADDRESS IS THE CALCULATED RESULT---------////// 
                                           begin 
                                           result = ALU_Input1_Forward_EX + ALU_Input2;	
                                           end
                                            
                                 default :                                 
                                           begin
                                           result = 32'b0;
                                           end
                                endcase
                                end   





//////////------CONTROLS FOR WRITING INTO MEMORY---------///////

always @ (StoreByte_reg or StoreWord_reg or StoreHalfWord_reg or ALU_Input2 ) 

begin
       case({StoreByte_reg,StoreHalfWord_reg,StoreWord_reg})

           3'b100   :   Mem_Store = {24'b0,Read_data_2[7:0]};


           3'b010   :   Mem_Store = {16'b0,Read_data_2[15:0]}; 


           3'b001   :   Mem_Store = Read_data_2;


           default   :  Mem_Store = 32'b0;

       endcase
end
endmodule
