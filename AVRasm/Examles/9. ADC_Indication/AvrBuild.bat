@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o ADC_Indication.hex -d ADC_Indication.obj -e ADC_Indication.eep -m ADC_Indication.map ADC_Indication.asm
@pause