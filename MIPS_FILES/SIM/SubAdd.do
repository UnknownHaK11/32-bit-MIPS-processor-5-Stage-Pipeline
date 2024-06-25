onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/Clock
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/Reset_
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/PC_Out_Mem
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/INDEX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/ASMMEM
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut3
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut4
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut5
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/result
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/IR0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR3
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input2_Forward_EX_pre
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input1_Forward_EX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/result
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Result
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DATAMEM/QA
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DATAMEM/MemOut
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/Mem_Store_EX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DATAMEM/Mem_Store
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DATAMEM/ALU_Result_Mem
add wave -noupdate -format Logic /T_Top_Risc/RISC/DATAMEM/Byte_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/DATAMEM/ByteU_EX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WRBack_Data
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/ALUSrc
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/DepRes_Rt_LdSt_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/DepRes_Rs_LdSt_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rs_Sel_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rt_Sel_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rs_Sel
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/DepRes_Rt_Sel
add wave -noupdate -format Logic /T_Top_Risc/RISC/DATAMEM/HalfWord_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/DATAMEM/Word_EX
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/j
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WriteData
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WRBack_Data
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/Input2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input2
add wave -noupdate -divider -height 50 {New Divider}
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rt_ID
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rs_ID
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Rd_ID
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Read_reg_Out1_pre
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Read_reg_Out2_pre
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Read_reg_Out1_nxt
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Read_reg_Out2_nxt
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/ALU_Input2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/WriteAddr_EX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WriteAddr_WB
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/DECODE/Reg4En
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/DECODE/Reg6En
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/DECODE/Reg9En
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/DECODE/MemtoReg
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/WRBack_Data
add wave -noupdate -format Logic /T_Top_Risc/RISC/DATAMEM/RegWrite_Mem
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/DECODE/Reg3En
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut3
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut4
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/EXECUTE/RegDst_EX
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut5
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut6
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut9
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {2010952 ps} 0} {{Cursor 5} {2013000 ps} 0}
configure wave -namecolwidth 327
configure wave -valuecolwidth 138
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
update
WaveRestoreZoom {1989439 ps} {2017691 ps}
