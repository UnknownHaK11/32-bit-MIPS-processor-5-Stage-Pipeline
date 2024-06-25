onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 INSTMEM
add wave -noupdate -format Logic /T_Top_Risc/RISC/INSTMEM/Clock
add wave -noupdate -format Logic /T_Top_Risc/RISC/INSTMEM/Reset_
add wave -noupdate -format Literal /T_Top_Risc/RISC/INSTMEM/PC_Out_Mem
add wave -noupdate -format Literal /T_Top_Risc/RISC/INSTMEM/IR0
add wave -noupdate -format Literal /T_Top_Risc/RISC/INSTMEM/ASMMEM
add wave -noupdate -format Literal /T_Top_Risc/RISC/INSTMEM/INDEX
add wave -noupdate -divider -height 30 IFETCH
add wave -noupdate -format Literal /T_Top_Risc/RISC/FETCHUNIT/PC_plus_4_Out
add wave -noupdate -format Literal /T_Top_Risc/RISC/FETCHUNIT/PC_Out_Mem
add wave -noupdate -format Literal /T_Top_Risc/RISC/FETCHUNIT/Branch_Addr
add wave -noupdate -format Logic /T_Top_Risc/RISC/FETCHUNIT/Clock
add wave -noupdate -format Logic /T_Top_Risc/RISC/FETCHUNIT/Reset_
add wave -noupdate -format Logic /T_Top_Risc/RISC/FETCHUNIT/Branch_ID
add wave -noupdate -format Logic /T_Top_Risc/RISC/FETCHUNIT/PC_Halt
add wave -noupdate -format Literal /T_Top_Risc/RISC/FETCHUNIT/PC
add wave -noupdate -format Literal /T_Top_Risc/RISC/FETCHUNIT/next_PC
add wave -noupdate -format Literal /T_Top_Risc/RISC/FETCHUNIT/PC_plus_4
add wave -noupdate -divider -height 30 IDECODER
add wave -noupdate -format Literal /T_Top_Risc/RISC/DECODE/Read_reg_Out1_nxt_pre2
add wave -noupdate -format Literal /T_Top_Risc/RISC/DECODE/Read_reg_Out2_nxt_pre2
add wave -noupdate -format Literal /T_Top_Risc/RISC/DECODE/IR2
add wave -noupdate -format Literal /T_Top_Risc/RISC/DECODE/IR3
add wave -noupdate -divider -height 30 IEXECUTE
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/Rs_EX
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/Rt_EX
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/Rd_EX
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/MemWrite_reg
add wave -noupdate -format Logic /T_Top_Risc/RISC/EXECUTE/MemRead_reg
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/ALU_Input1_Forward_EX_pre
add wave -noupdate -format Literal /T_Top_Risc/RISC/EXECUTE/ALU_Input2_Forward_EX_pre
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 324
configure wave -valuecolwidth 214
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
WaveRestoreZoom {0 ps} {1373 ps}
