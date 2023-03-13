@echo off
CLS

:: ������ 䠩�� �०��� ����⮪ ᡮન �஥��
del /Q compile\*.* 
del /Q compile\temp\*.* 

:: ���������
bin\arm-none-eabi-as.exe -o compile\temp\sys.o main.asm
:: �᫨ �� �������樨 �뫨 �訡�� � ��室���� 䠩�� ��� - ��室�� !
SET st=compile\temp\sys.o
IF NOT exist %st% (
echo �訡�� �� �������樨 !
exit
)
:: �믮��塞 �������� 
bin\arm-none-eabi-ld.exe -T stm32f40_map.ld -o compile\temp\sys.elf compile\temp\sys.o
:: �᫨ �� �������� �뫨 �訡�� � ��室���� 䠩�� ��� - ��室�� !
SET st=compile\temp\sys.elf
IF NOT exist %st% (
echo �訡�� �� �������� ᥪ権 !
exit
)
:: �뤥�塞 �� .elf 䠩�� - 䠩�� ��訢�� .bin � .hex 
bin\arm-none-eabi-objcopy.exe -O binary compile\temp\sys.elf compile\output.bin
bin\arm-none-eabi-objcopy.exe -O ihex   compile\temp\sys.elf compile\output.hex

:: ���ଠ�� � ᥪ���
bin\arm-none-eabi-size.exe compile\temp\sys.o -A -d
bin\arm-none-eabi-objdump compile\temp\sys.o -h > compile\temp\sections.lst

:: �⤥�쭮 ���ଠ�� � ������ ᥪ樨 � 䠩� (�뢮� � 䠩��)
bin\arm-none-eabi-objdump.exe  -j .text -d -t -w compile\temp\sys.o > compile\temp\main_text.lst

:: ���� ��⮪ � ���祭�� ��६�����, �뢮� � 䠩�
bin\arm-none-eabi-nm.exe -A -p compile\temp\sys.elf > compile\temp\labels.lst

echo ����� ��訢�� ��室���� � ����� \compile\
