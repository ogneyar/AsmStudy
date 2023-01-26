@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o Clock.hex -d Clock.obj -e Clock.eep -m Clock.map Clock.asm
@pause