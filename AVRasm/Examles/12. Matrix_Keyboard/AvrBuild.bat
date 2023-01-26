@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o Matrix_Keyboard.hex -d Matrix_Keyboard.obj -e Matrix_Keyboard.eep -m Matrix_Keyboard.map Matrix_Keyboard.asm
@pause