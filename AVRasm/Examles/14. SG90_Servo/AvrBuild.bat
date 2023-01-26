@echo off
avrasm2.exe -S labels.tmp -fI -W+ie -C V2E -o SG90_Servo.hex -d SG90_Servo.obj -e SG90_Servo.eep -m SG90_Servo.map SG90_Servo.asm
@pause