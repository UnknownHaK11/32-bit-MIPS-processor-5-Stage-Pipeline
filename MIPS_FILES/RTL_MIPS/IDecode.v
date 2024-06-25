                //////---------INSTRUCTION DECODING----------///
                //////-----------DATE 23/2/2007--------------///
                //////---------DESIGNER S.GOPIKRISHNA -------///


/////----BRANCH INSTRUCTIONS EXECUTED HERE TO IMPROVE FLUSHING BY ONE CLOCK CYCLE---////////



//////----I Format INSTRUCTIONS----////
 `define BEQ     6'b000100
 `define BNE     6'b000101
 `define BLZ     6'b000101
 `define BGZ     6'b000111
 `define BLEZ    6'b000110
 `define BGEZ    6'b000110
 `define BLTZAL  6'b000100
 `define BGEZAL  6'b000101


//////----J TYPE INSTRUCTIONS------////

 `define J       6'b000110
 `define JAL     6'b000011










/////----This module also contains the RegFile for writing and reading--- //////

module IDecode
                 ( 
                  ////INPUTS

                  IR0,               //instruction from IFETCH STAGE
                  IR1, 
                  ALUResult,
                  WRBack_Data, 
                  MemtoReg, 
                  RegFileWr,       //Input from Mem/WB stage 
                  Clock,
                  Reset_,
                  PC_plus_4,
                  WriteAddr_WB,       //Write Back Address

                  ////OUTPUTS 
                  DepRes_Rt_Sel_EX,
                  DepRes_Rs_Sel_EX,
                  DepRes_Rt_Sel,
                  DepRes_Rs_Sel,
                  DepRes_Rt_LdSt_EX,
                  DepRes_Rs_LdSt_EX,
                  DepRes_Rt_LdSt_WB_EX,
                  DepRes_Rs_LdSt_WB_EX,
                  PC_Halt, 
                  Branch_Addr, 
                  Branch_ID, 
                  Rs_ID,           //Address rs
                  Rt_ID,           //Address rt
                  Rd_ID,           //Address rd
                  Immediate_ID,    //Immediate field  Imm
                  Shift_ID,        //Shift value
                  Sign_Ext_Out_Reg,
                  Read_reg_Out1,   //S1_Contents
                  Read_reg_Out2    //S2_Contents
                  ); 





input [31:0] IR0;
input [31:0] IR1;
input [31:0] ALUResult,WRBack_Data;
input MemtoReg,Clock,Reset_;
input RegFileWr;
input [7:0] PC_plus_4;
input [4:0] WriteAddr_WB;

output PC_Halt;
output DepRes_Rt_LdSt_EX;
output DepRes_Rs_LdSt_EX;
output [31:0] Read_reg_Out1;
output [31:0] Read_reg_Out2;
output [15:0] Immediate_ID;
output [31:0] Sign_Ext_Out_Reg;
output [4:0] Rs_ID,Rt_ID,Rd_ID;
output [4:0] Shift_ID;
output DepRes_Rt_Sel_EX ;
output DepRes_Rs_Sel_EX ;
output DepRes_Rt_Sel ;
output DepRes_Rs_Sel ;
output DepRes_Rt_LdSt_WB_EX;
output DepRes_Rs_LdSt_WB_EX;
output [7:0] Branch_Addr;
output Branch_ID;

wire [4:0] Rs,Rt,Rd;
wire [4:0] Shift;
wire [15:0] Sign_Ext_reg;
wire [31:0] Sign_Ext_Out;
wire [31:0] WriteData;
wire [15:0] Immediate;
reg Branch;

reg DepRes_Rt_Sel_EX ;
reg DepRes_Rt_Sel_EX_pre ;
reg DepRes_Rs_Sel_EX ;
reg DepRes_Rs_Sel_EX_pre ;
reg DepRes_Rt_Sel  ;
reg DepRes_Rt_Sel_pre  ;
reg DepRes_Rs_Sel ;
reg DepRes_Rs_Sel_pre ;
reg [31:0] Sign_Ext_Out_Reg;
reg [15:0] Immediate_ID;
reg [4:0] Shift_ID;
reg [4:0]  Rs_ID, Rt_ID,Rd_ID;
reg [31:0] Read_reg_Out1;
wire [31:0] Read_reg_Out1_nxt;
reg [31:0] Read_reg_Out1_pre;
reg [31:0] Read_reg_Out2;
wire [31:0] Read_reg_Out2_nxt;
reg [31:0] Read_reg_Out2_pre;
reg DepRes_Rt_LdSt_EX;
reg DepRes_Rt_LdSt_WB_EX;
reg DepRes_Rs_LdSt_WB_EX;
reg DepRes_Rt_LdSt_WB_ID;
reg DepRes_Rs_LdSt_WB_ID;
reg [31:0]Target_address;
reg DepRes_Rs_LdSt_EX;
reg [31:0] ALUResult_WB;
reg [31:0] IR2,IR3,IR4;
reg DepRes_Rt_Sel_RegFile;
reg Branch_ID;
wire PC_Halt;
reg [31:0]Branch_result;
wire DepRes_Rt_LdSt_WB_ID_RegFile;
reg DepRes_Rs_Sel_RegFile;
wire [7:0]Branch_Addr;
wire DepRes_Rs_LdSt_WB_ID_RegFile;
wire    [31:0]  RegOut0,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8,RegOut9,
                RegOut10,RegOut11,RegOut12,RegOut13,RegOut14,RegOut15,RegOut16,RegOut17,RegOut18,RegOut19,
                RegOut20,RegOut21,RegOut22,RegOut23,RegOut24,RegOut25,RegOut26,RegOut27,RegOut28,RegOut29,
                RegOut30,RegOut31;




`define Zero 1'b0
`define One  1'b1



assign PC_Halt = ((Branch_result == 32'b0)&&(Branch_ID == 1)) ? 1 : 0;

/////---------EFFECTIVE BRANCH ADDRESS ADDER FOR FEEDING IT BACK TO IFETCH STAGE-----------///////


assign Branch_Addr =  PC_plus_4[7:0] + Branch_result[7:0]; 



////////-----EXECUTE BRANCH WITHIN DECODE STAGE TO SAVE ONE CLOCK CYCLE------////

always @ (Read_reg_Out2_nxt or Read_reg_Out1_nxt or IR0 or Target_address)
begin
                    case(IR0[31:26]) 
                    
//                                `JR :
//                                           ///----Branch target address to value specified in Rs---//
//                                               begin
//                                               Branch_result = Read_reg_Out1_nxt;
//                                               Branch_ID = 1'b1;
//                                               end

                                `BEQ :
                                            begin
                                            if(Read_reg_Out1_nxt == Read_reg_Out2_nxt)
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                            else
                                               begin
                                               Branch_result = 0;
                                               Branch_ID = 1'b0;
                                               end
                                            end
                                `BNE :
                                            begin
                                            if(Read_reg_Out1_nxt != Read_reg_Out2_nxt)
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                            else
                                               begin
                                               Branch_result = 0;
                                               Branch_ID = 1'b0;
                                               end
                                            end
                                `BGZ :
                                            begin
                                            if(Read_reg_Out1_nxt > Read_reg_Out2_nxt)
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                            else
                                               begin
                                               Branch_result = 0;
                                               Branch_ID = 1'b0;
                                               end
                                            end
                                `BLZ :
                                            begin
                                            if(Read_reg_Out1_nxt < Read_reg_Out2_nxt)
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                            else
                                               begin
                                               Branch_result = 0;
                                               Branch_ID = 1'b0;
                                               end
                                            end
                                `BGEZ :
                                            begin
                                            if(Read_reg_Out1_nxt >= Read_reg_Out2_nxt)
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                            else
                                               begin
                                               Branch_result = 0;
                                               Branch_ID = 1'b0;
                                               end
                                            end

                                `BLEZ :

                                            begin
                                            if(Read_reg_Out1_nxt <= Read_reg_Out2_nxt)
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                            else
                                               begin
                                               Branch_result = 0;
                                               Branch_ID = 1'b0;
                                               end
                                            end

                                 `J:
                                            //-----JAL STORES THE RETURN ADDRESS IN REG 31--//
                                            ///Target address with direct jump address
                                               begin
                                               Branch_result = {Target_address[29:0],2'b0};
                                               Branch_ID = 1'b1;
                                               end
                                 default :
                                               begin
                                               Branch_result = 32'b0;
                                               Branch_ID = 1'b0;
                                               end
                     endcase
                     end






always @ (IR0 or Sign_Ext_Out)
begin
         case(IR0[31:26])

            `BEQ,`BNE,`BGZ,`BLZ,`BGEZ,`BLEZ :
                            begin
                            Target_address =   Sign_Ext_Out;
                            end

            `J:
                            begin
                            Target_address  =  {{6{Sign_Ext_Out[25]}},Sign_Ext_Out[25:0]};
                            end
            default :
                            begin
                            Target_address =  32'b0;
                            end
         endcase
end



////////////----------GENERATE SELECT SIGNALS FOR FORWARDING MUXES FOR ID/EX STAGES---------////////////

always @ (IR1 or IR0 ) 
         if(IR1[15:11] == IR0[20:16]) ///IF IR0 SOURCE ADDRESS IS EQUAL TO Rd  
             DepRes_Rt_Sel_pre =1 ;
         else
             DepRes_Rt_Sel_pre =0 ;
always @ (IR1 or IR0  ) 
         if((IR1[15:11])&&(IR1[15:11] == IR0[25:21])) //IR1[15:11] == IR0[25:21]
             DepRes_Rs_Sel_pre =1 ;
         else if(!(IR1[15:11])&&(IR1[20:16] == IR0[25:21]))
             DepRes_Rs_Sel_pre =1 ;
         else
             DepRes_Rs_Sel_pre =0 ;

////////////----------GENERATE SELECT SIGNALS FOR FORWARDING MUXES IN ID/MEM STAGES--------/////////////
always @ (IR2 or IR0 ) 
         if(IR2[15:11] == IR0[20:16]) ///IF Rt_ID SOURCE ADDRESS IS EQUAL TO IR0  
             DepRes_Rt_Sel_EX_pre =1 ;
         else
             DepRes_Rt_Sel_EX_pre =0 ;
always @ (IR2 or IR0 ) 
         if((IR2[15:11])&&(IR2[15:11] == IR0[25:21])) //IR2[15:11] == IR0[25:21]
             DepRes_Rs_Sel_EX_pre =1 ;
         else if(!(IR2[15:11])&&(IR2[20:16] == IR0[25:21]))
             DepRes_Rs_Sel_EX_pre =1 ;
         else
             DepRes_Rs_Sel_EX_pre =0 ;


//////////----------------FORWARDING WITHIN REGISTER FILE---------------//////////
always @ (IR3 or IR0)
         if(IR3[15:11] == IR0[20:16])  
             DepRes_Rt_Sel_RegFile = 1;
         else
             DepRes_Rt_Sel_RegFile = 0;
always @ (IR3 or IR0)
         if((IR3[15:11])&&(IR3[15:11] == IR0[25:21])) //IR3[15:11] == IR0[25:21]
             DepRes_Rs_Sel_RegFile = 1;
         else if(!(IR3[15:11])&&(IR3[20:16] == IR0[25:21]))
             DepRes_Rs_Sel_RegFile =1 ;
         else
             DepRes_Rs_Sel_RegFile = 0;



/////-----GENERATE SELECT SIGNAL FOR FORWARDING MUXES IN MEM/WB STAGES IF STORE IS EXEC AFTER LOAD---/////////
always @ (IR1 or IR0 ) 
         if(IR1[20:16] == IR0[20:16]) 
            DepRes_Rt_LdSt_EX =  1;
         else
            DepRes_Rt_LdSt_EX =  0;

always @ (IR1 or IR0 )
         if(IR1[20:16] == IR0[25:21])
            DepRes_Rs_LdSt_EX =  1;
         else
            DepRes_Rs_LdSt_EX =  0;

/////------LOAD DEPENDENCY WITH INSTRUCTION IN EX STAGE------/////
always @ (IR2 or IR0)
         if(IR2[20:16] == IR0[20:16]) 
            DepRes_Rt_LdSt_WB_EX =  1;
         else
            DepRes_Rt_LdSt_WB_EX =  0;

always @ (IR3 or IR0 )
         if(IR3[20:16] == IR0[25:21])
            DepRes_Rs_LdSt_WB_EX =  1;
         else
            DepRes_Rs_LdSt_WB_EX =  0;   
            

/////------LOAD DEPENDENCY WITH INSTRUCTION IN ID STAGE------/////
always @ (IR3 or IR0)
         if(IR3[20:16] == IR0[20:16])
            DepRes_Rt_LdSt_WB_ID =  1;
         else
            DepRes_Rt_LdSt_WB_ID =  0;

always @ (IR3 or IR0 )
         if(IR3[20:16] == IR0[25:21])
            DepRes_Rs_LdSt_WB_ID =  1;
         else
            DepRes_Rs_LdSt_WB_ID =  0;

               

//////---------FORWARDING WITHIN REGISTER FILE------//////
assign DepRes_Rs_LdSt_WB_ID_RegFile  = ((DepRes_Rs_LdSt_WB_ID & MemtoReg)|DepRes_Rs_Sel_RegFile);
assign DepRes_Rt_LdSt_WB_ID_RegFile  = ((DepRes_Rt_LdSt_WB_ID & MemtoReg)|DepRes_Rt_Sel_RegFile);


IMux2x1   #(32) Forward_Mux1_RegFile(.OutputData(Read_reg_Out2_nxt), .DataIn1(WriteData), .DataIn2(Read_reg_Out2_pre), .SelectIn(DepRes_Rt_LdSt_WB_ID_RegFile));
IMux2x1   #(32) Forward_Mux2_RegFile(.OutputData(Read_reg_Out1_nxt), .DataIn1(WriteData), .DataIn2(Read_reg_Out1_pre), .SelectIn(DepRes_Rs_LdSt_WB_ID_RegFile));


IMux2x1   #(32) Write_Sel_reg1(.OutputData(WriteData), .DataIn1(WRBack_Data), .DataIn2(ALUResult), .SelectIn(MemtoReg));


always @ (posedge Clock or negedge Reset_)
            begin
                if(Reset_ == `Zero)
                    begin
                    Read_reg_Out2    <= 1'b0;
                    Read_reg_Out1    <= 1'b0;
                    end
                else
                    begin
                    Read_reg_Out2    <= Read_reg_Out2_nxt;
                    Read_reg_Out1    <= Read_reg_Out1_nxt;
                    end
             end

always @ (posedge Clock or negedge Reset_)
            begin
                if(Reset_ == `Zero)
                    begin
                    DepRes_Rt_Sel    <= 1'b0;
                    DepRes_Rs_Sel    <= 1'b0;
                    DepRes_Rt_Sel_EX <= 1'b0;
                    DepRes_Rs_Sel_EX <= 1'b0;
                    end
                else
                    begin
                    DepRes_Rt_Sel    <= DepRes_Rt_Sel_pre;
                    DepRes_Rs_Sel    <= DepRes_Rs_Sel_pre;
                    DepRes_Rt_Sel_EX <= DepRes_Rt_Sel_EX_pre;
                    DepRes_Rs_Sel_EX <= DepRes_Rs_Sel_EX_pre;
                    end
             end

always @ (posedge Clock or negedge Reset_)
           begin 
                if(Reset_ == `Zero) 
                    begin 
                    Sign_Ext_Out_Reg <= 32'b0 ;
                    Immediate_ID     <= 16'b0;
                    Rs_ID            <= 5'b0;
                    Rt_ID            <= 5'b0;
                    Rd_ID            <= 5'b0;
                    Shift_ID         <= 5'b0;
                    IR2              <= 32'b0;
                    IR3              <= IR2;
                    IR4              <= IR3;
                    ALUResult_WB     <= 32'b0;
                    end 

                else
                    begin 
                    Sign_Ext_Out_Reg <= Sign_Ext_Out ;
                    Immediate_ID     <= Immediate;
                    Rs_ID            <= Rs;
                    Rt_ID            <= Rt;  
                    Rd_ID            <= Rd;  
                    Shift_ID         <= Shift;
                    IR2              <= IR1;
                    IR3              <= IR2;
                    IR4              <= IR3;
                    ALUResult_WB     <= ALUResult;
                    end 
           end


           


/////////////////////////////////////////////////////////////////////
///////--RdAddr and WrAddr for reading and Writing registers----/////
/////////////////////////////////////////////////////////////////////


assign  Rs =  IR0[25:21];
assign  Rt =  IR0[20:16];
assign  Rd =  IR0[15:11];
assign  Shift     = IR0[10:6];
assign  Immediate = IR0[15:0] ;



assign  Sign_Ext_reg = {16{IR0[15]}};
assign  Sign_Ext_Out = {Sign_Ext_reg,IR0[15:0]};








always @ (Rs or 
          RegOut0 or RegOut1 or RegOut2 or RegOut3 or RegOut4 or RegOut5 or RegOut6 or RegOut7 or RegOut8 or RegOut9 or 
          RegOut10 or RegOut11 or RegOut12 or RegOut13 or RegOut14 or RegOut15 or RegOut16 or RegOut17 or RegOut18 or RegOut19 or 
          RegOut20 or RegOut21 or RegOut22 or RegOut23 or RegOut24 or RegOut25 or RegOut26 or RegOut27 or RegOut28 or RegOut29 or 
          RegOut30 or RegOut31)
   begin

    case(Rs)          

	5'b00000	:	Read_reg_Out1_pre = RegOut0;
	5'b00001	:	Read_reg_Out1_pre = RegOut1;
	5'b00010	:	Read_reg_Out1_pre = RegOut2; 
	5'b00011	:	Read_reg_Out1_pre = RegOut3; 
	5'b00100	:	Read_reg_Out1_pre = RegOut4; 
	5'b00101	:	Read_reg_Out1_pre = RegOut5; 
	5'b00110	:	Read_reg_Out1_pre = RegOut6; 
	5'b00111	:	Read_reg_Out1_pre = RegOut7; 
	5'b01000	:	Read_reg_Out1_pre = RegOut8; 
	5'b01001	:	Read_reg_Out1_pre = RegOut9; 
	5'b01010	:	Read_reg_Out1_pre = RegOut10; 
	5'b01011	:	Read_reg_Out1_pre = RegOut11; 
	5'b01100	:	Read_reg_Out1_pre = RegOut12; 
	5'b01101	:	Read_reg_Out1_pre = RegOut13; 
	5'b01110	:	Read_reg_Out1_pre = RegOut14; 
	5'b01111	:	Read_reg_Out1_pre = RegOut15; 
	5'b10000	:	Read_reg_Out1_pre = RegOut16; 
	5'b10001	:	Read_reg_Out1_pre = RegOut17; 
	5'b10010	:	Read_reg_Out1_pre = RegOut18; 
	5'b10011	:	Read_reg_Out1_pre = RegOut19; 
	5'b10100	:	Read_reg_Out1_pre = RegOut20; 
	5'b10101	:	Read_reg_Out1_pre = RegOut21; 
	5'b10110	:	Read_reg_Out1_pre = RegOut22; 
	5'b10111	:	Read_reg_Out1_pre = RegOut23; 
	5'b11000	:	Read_reg_Out1_pre = RegOut24; 
	5'b11001	:	Read_reg_Out1_pre = RegOut25; 
	5'b11010	:	Read_reg_Out1_pre = RegOut26; 
	5'b11011	:	Read_reg_Out1_pre = RegOut27; 
	5'b11100	:	Read_reg_Out1_pre = RegOut28; 
	5'b11101	:	Read_reg_Out1_pre = RegOut29; 
	5'b11110	:	Read_reg_Out1_pre = RegOut30; 
	5'b11111	:	Read_reg_Out1_pre = RegOut31; 

    endcase
   end




always @ (Rt  or 
          RegOut0 or RegOut1 or RegOut2 or RegOut3 or RegOut4 or RegOut5 or RegOut6 or RegOut7 or RegOut8 or RegOut9 or 
          RegOut10 or RegOut11 or RegOut12 or RegOut13 or RegOut14 or RegOut15 or RegOut16 or RegOut17 or RegOut18 or RegOut19 or 
          RegOut20 or RegOut21 or RegOut22 or RegOut23 or RegOut24 or RegOut25 or RegOut26 or RegOut27 or RegOut28 or RegOut29 or 
          RegOut30 or RegOut31)

   begin

    case(Rt)

	5'b00000	:	Read_reg_Out2_pre = RegOut0;
	5'b00001	:	Read_reg_Out2_pre = RegOut1;
	5'b00010	:	Read_reg_Out2_pre = RegOut2; 
	5'b00011	:	Read_reg_Out2_pre = RegOut3; 
	5'b00100	:	Read_reg_Out2_pre = RegOut4; 
	5'b00101	:	Read_reg_Out2_pre = RegOut5; 
	5'b00110	:	Read_reg_Out2_pre = RegOut6; 
	5'b00111	:	Read_reg_Out2_pre = RegOut7; 
	5'b01000	:	Read_reg_Out2_pre = RegOut8; 
	5'b01001	:	Read_reg_Out2_pre = RegOut9; 
	5'b01010	:	Read_reg_Out2_pre = RegOut10; 
	5'b01011	:	Read_reg_Out2_pre = RegOut11; 
	5'b01100	:	Read_reg_Out2_pre = RegOut12; 
	5'b01101	:	Read_reg_Out2_pre = RegOut13; 
	5'b01110	:	Read_reg_Out2_pre = RegOut14; 
	5'b01111	:	Read_reg_Out2_pre = RegOut15; 
	5'b10000	:	Read_reg_Out2_pre = RegOut16; 
	5'b10001	:	Read_reg_Out2_pre = RegOut17; 
	5'b10010	:	Read_reg_Out2_pre = RegOut18; 
	5'b10011	:	Read_reg_Out2_pre = RegOut19; 
	5'b10100	:	Read_reg_Out2_pre = RegOut20; 
	5'b10101	:	Read_reg_Out2_pre = RegOut21; 
	5'b10110	:	Read_reg_Out2_pre = RegOut22; 
	5'b10111	:	Read_reg_Out2_pre = RegOut23; 
	5'b11000	:	Read_reg_Out2_pre = RegOut24; 
	5'b11001	:	Read_reg_Out2_pre = RegOut25; 
	5'b11010	:	Read_reg_Out2_pre = RegOut26; 
	5'b11011	:	Read_reg_Out2_pre = RegOut27; 
	5'b11100	:	Read_reg_Out2_pre = RegOut28; 
	5'b11101	:	Read_reg_Out2_pre = RegOut29; 
	5'b11110	:	Read_reg_Out2_pre = RegOut30; 
	5'b11111	:	Read_reg_Out2_pre = RegOut31; 

    endcase
   end





/////////////////////////////////////////
///*	Enable Signal for regfile..  *///	
/////////////////////////////////////////



reg	Reg0En, Reg1En, Reg2En,  Reg3En, Reg4En,
        Reg5En, Reg6En, Reg7En,  Reg8En, Reg9En,
        Reg10En, Reg11En, Reg12En, Reg13En, Reg14En,
        Reg15En, Reg16En, Reg17En, Reg18En, Reg19En,    
        Reg20En, Reg21En, Reg22En, Reg23En, Reg24En,    
        Reg25En, Reg26En, Reg27En, Reg28En, Reg29En,    
        Reg30En, Reg31En;    






always @ (WriteAddr_WB)
  begin
	Reg0En = `Zero; Reg1En =`Zero; Reg2En = `Zero; Reg3En = `Zero; Reg4En = `Zero;
	Reg5En = `Zero; Reg6En =`Zero; Reg7En = `Zero; Reg8En = `Zero; Reg9En = `Zero;
	Reg10En = `Zero; Reg11En =`Zero; Reg12En = `Zero; Reg13En = `Zero; Reg14En = `Zero;
	Reg15En = `Zero; Reg16En =`Zero; Reg17En = `Zero; Reg18En = `Zero; Reg19En = `Zero;
	Reg20En = `Zero; Reg21En =`Zero; Reg22En = `Zero; Reg23En = `Zero; Reg24En = `Zero;
	Reg25En = `Zero; Reg26En =`Zero; Reg27En = `Zero; Reg28En = `Zero; Reg29En = `Zero;
	Reg30En = `Zero; Reg31En =`Zero;  

   case	(WriteAddr_WB)
	5'b00000	:	Reg0En = `One;
	5'b00001	:	Reg1En = `One;
	5'b00010	:	Reg2En = `One; 
	5'b00011	:	Reg3En = `One; 
	5'b00100	:	Reg4En = `One; 
	5'b00101	:	Reg5En = `One; 
	5'b00110	:	Reg6En = `One; 
	5'b00111	:	Reg7En = `One; 
	5'b01000	:	Reg8En = `One; 
	5'b01001	:	Reg9En = `One; 
	5'b01010	:	Reg10En = `One; 
	5'b01011	:	Reg11En = `One; 
	5'b01100	:	Reg12En = `One; 
	5'b01101	:	Reg13En = `One; 
	5'b01110	:	Reg14En = `One; 
	5'b01111	:	Reg15En = `One; 
	5'b10000	:	Reg16En = `One; 
	5'b10001	:	Reg17En = `One; 
	5'b10010	:	Reg18En = `One; 
	5'b10011	:	Reg19En = `One; 
	5'b10100	:	Reg20En = `One; 
	5'b10101	:	Reg21En = `One; 
	5'b10110	:	Reg22En = `One; 
	5'b10111	:	Reg23En = `One; 
	5'b11000	:	Reg24En = `One; 
	5'b11001	:	Reg25En = `One; 
	5'b11010	:	Reg26En = `One; 
	5'b11011	:	Reg27En = `One; 
	5'b11100	:	Reg28En = `One; 
	5'b11101	:	Reg29En = `One; 
	5'b11110	:	Reg30En = `One; 
	5'b11111	:	Reg31En = `One; 
  endcase
 end






//////////--------- REGFILE WITH ENABLES FOR WRITING INTO CONTROL REGISTERS----////////////




WriteReg    IWriteReg0( .RegOut(RegOut0), .Enable(Reg0En), .RegWrEn(RegFileWr), .WriteData(32'b0), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg1( .RegOut(RegOut1), .Enable(Reg1En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg2( .RegOut(RegOut2), .Enable(Reg2En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg3( .RegOut(RegOut3), .Enable(Reg3En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg4( .RegOut(RegOut4), .Enable(Reg4En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg5( .RegOut(RegOut5), .Enable(Reg5En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg6( .RegOut(RegOut6), .Enable(Reg6En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg7( .RegOut(RegOut7), .Enable(Reg7En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg8( .RegOut(RegOut8), .Enable(Reg8En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg9( .RegOut(RegOut9), .Enable(Reg9En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg10( .RegOut(RegOut10), .Enable(Reg10En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg11( .RegOut(RegOut11), .Enable(Reg11En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg12( .RegOut(RegOut12), .Enable(Reg12En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg13( .RegOut(RegOut13), .Enable(Reg13En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg14( .RegOut(RegOut14), .Enable(Reg14En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg15( .RegOut(RegOut15), .Enable(Reg15En), .RegWrEn(RegFileWr) ,.WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg16( .RegOut(RegOut16), .Enable(Reg16En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg17( .RegOut(RegOut17), .Enable(Reg17En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg18( .RegOut(RegOut18), .Enable(Reg18En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg19( .RegOut(RegOut19), .Enable(Reg19En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg20( .RegOut(RegOut20), .Enable(Reg20En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg21( .RegOut(RegOut21), .Enable(Reg21En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg22( .RegOut(RegOut22), .Enable(Reg22En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg23( .RegOut(RegOut23), .Enable(Reg23En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg24( .RegOut(RegOut24), .Enable(Reg24En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg25( .RegOut(RegOut25), .Enable(Reg25En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg26( .RegOut(RegOut26), .Enable(Reg26En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg27( .RegOut(RegOut27), .Enable(Reg27En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg28( .RegOut(RegOut28), .Enable(Reg28En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg29( .RegOut(RegOut29), .Enable(Reg29En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg30( .RegOut(RegOut30), .Enable(Reg30En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
WriteReg    IWriteReg31( .RegOut(RegOut31), .Enable(Reg31En), .RegWrEn(RegFileWr), .WriteData(WriteData), .Clk(Clock), .Reset_(Reset_));
 
endmodule
