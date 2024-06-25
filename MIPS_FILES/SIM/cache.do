onerror {resume}
quietly WaveActivateNextPane {} 0
quietly virtual signal -install /T_Top_Risc/RISC/ICACHE { /T_Top_Risc/RISC/ICACHE/ICache_VA[11:4]} ICache_va_add
quietly virtual signal -install /T_Top_Risc/RISC/ICACHE { /T_Top_Risc/RISC/ICACHE/ICache_PA[31:14]} ICache_PA_TAG
add wave -noupdate -divider -height 100 DIVIDE
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/Reset_
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/ASMMEM
add wave -noupdate -divider -height 100 DIVIDE
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/Clock
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR3
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_Word
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_Word_pre
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_Line
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_Line_pre
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Mainbiu_input
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Mainbiu_input_nxt
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/IFLUSH
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/HitorMiss_pre
add wave -noupdate -format Literal /T_Top_Risc/RISC/ICACHE/ICache_VA_reg
add wave -noupdate -format Logic /T_Top_Risc/RISC/DECODE/Branch_Inst
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/HitorMiss
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/Branch_ID
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/PC_Halt
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/IR0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/Branch_result
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/Branch_Addr
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/PC_plus_4
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/PC_plus_4_Out
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/PC
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_block0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_VA
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Tag_Add
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/Clock
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Reset_
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/Reset_
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Reset_sync
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/INSTMEM/PC_Out_Mem
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/PC_Out_Mem
add wave -noupdate -divider -height 100 {New Divider}
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/IR0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_block0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block1_WrEn
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_PA
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/CEN
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/WEN
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/A
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/D
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/Q
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/CLK
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/FETCHUNIT/Clock
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_VA
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Mainbiu_input_nxt
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/HitorMiss
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_va_add
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_VA
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_block0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_block1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_block2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_block3
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/D
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/EMA
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/CLK
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut1
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/DECODE/RegOut2
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block2_WrEn
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block3_WrEn
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block4_WrEn
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block1_WrEn_Reg
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block2_WrEn_Reg
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block3_WrEn_Reg
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Block4_WrEn_Reg
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/current_state
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/next_state
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_PA
add wave -noupdate -divider -height 25 {New Divider}
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/ICache_PA_TAG
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/Tag_Mux_Out
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/Q
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/CEN
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/WEN
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/A
add wave -noupdate -format Literal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/Q
add wave -noupdate -format Logic /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/CLK
add wave -noupdate -format Logic /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/CEN
add wave -noupdate -format Literal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/WEN
add wave -noupdate -format Literal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/A
add wave -noupdate -format Literal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/D
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 6} {0 ps} 0} {{Cursor 7} {5144271 ps} 0} {{Cursor 8} {6970000 ps} 0} {{Cursor 5} {5142000 ps} 0}
WaveRestoreZoom {5133387 ps} {5161651 ps}
configure wave -namecolwidth 373
configure wave -valuecolwidth 38
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
