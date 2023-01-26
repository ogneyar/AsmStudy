@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o Shift_Register.hex -d Shift_Register.obj -e Shift_Register.eep -m Shift_Register.map Shift_Register.asm
@pause