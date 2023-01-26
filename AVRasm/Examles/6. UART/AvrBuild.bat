@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o UART.hex -d UART.obj -e UART.eep -m UART.map UART.asm
@pause