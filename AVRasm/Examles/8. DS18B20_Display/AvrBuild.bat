@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o DS18B20_Display.hex -d DS18B20_Display.obj -e DS18B20_Display.eep -m DS18B20_Display.map DS18B20_Display.asm
@pause