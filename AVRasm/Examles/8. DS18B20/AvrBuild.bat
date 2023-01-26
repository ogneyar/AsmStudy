@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o DS18B20.hex -d DS18B20.obj -e DS18B20.eep -m DS18B20.map DS18B20.asm
@pause