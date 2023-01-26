@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o Dynamic_Indication.hex -d Dynamic_Indication.obj -e Dynamic_Indication.eep -m Dynamic_Indication.map Dynamic_Indication.asm
@pause