onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/Q
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/CEN
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/WEN
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/A
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/VALIDBIT_TAGMEM1/D
add wave -noupdate -divider -height 30 {New Divider}
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/CLK
add wave -noupdate -format Logic -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/CEN
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/WEN
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/A
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/Q
add wave -noupdate -format Literal -radix hexadecimal /T_Top_Risc/RISC/ICACHE/INSTRUCTION_MEM1/D
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5090000 ps} 0}
configure wave -namecolwidth 306
configure wave -valuecolwidth 99
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
WaveRestoreZoom {5068992 ps} {5167952 ps}
