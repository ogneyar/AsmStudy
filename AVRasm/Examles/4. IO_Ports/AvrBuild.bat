@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o IO_Ports.hex -d IO_Ports.obj -e IO_Ports.eep -m IO_Ports.map IO_Ports.asm
@pause