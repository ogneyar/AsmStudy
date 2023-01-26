@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o Fast_PWM.hex -d Fast_PWM.obj -e Fast_PWM.eep -m Fast_PWM.map Fast_PWM.asm
@pause
