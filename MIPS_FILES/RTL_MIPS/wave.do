onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/Reset_
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/CONTROL/ALUSrc
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Read_reg_Out1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Read_reg_Out2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/MemOut
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR3
add wave -noupdate -divider -height 25 CHECK
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input2
add wave -noupdate -format Literal -radix decimal /T_Top_Risc/RISC/EXECUTE/result
add wave -noupdate -format Literal -radix decimal /T_Top_Risc/RISC/EXECUTE/ALU_Result
add wave -noupdate -format Literal -radix decimal /T_Top_Risc/RISC/EXECUTE/ALU_Result_Mem
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/LdSt_Forward
add wave -noupdate -divider -height 30 Dependency2
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/DepRes_Rs_Sel_EX_nxt
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rs_Sel_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rs_Sel_EX_pre
add wave -noupdate -divider -height 30 Dependency1
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/DepRes_Rs_Sel_nxt
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/DepRes_Rs_Sel
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rs_Sel_pre
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rd_ID
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rs_ID
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rt_ID
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rd
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rs
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rt
add wave -noupdate -format Logic /T_Top_Risc/RISC/DepRes_Rs_Sel_WB
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/DepRes_Rt_Sel_EX_nxt
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/DepRes_Rt_Sel_nxt
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/Clock
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input1_Forward_EX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WRBack_Data
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut3
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut4
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut6
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/RegFileWr
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/Reg3En
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WriteAddr_WB
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/ALUResult_WB
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Result
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WriteData
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/MemtoReg
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input1_Forward
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input1
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/WriteAddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2003000 ps} 0}
WaveRestoreZoom {1998096 ps} {2015325 ps}
configure wave -namecolwidth 171
configure wave -valuecolwidth 46
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
