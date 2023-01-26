@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o HCSR04.hex -d HCSR04.obj -e HCSR04.eep -m HCSR04.map HCSR04.asm
@pause