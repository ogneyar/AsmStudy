@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o RGB_Lamp.hex -d RGB_Lamp.obj -e RGB_Lamp.eep -m RGB_Lamp.map RGB_Lamp.asm
@pause