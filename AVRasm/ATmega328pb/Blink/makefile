
PROGRAMMER	:= usbasp
# PROGRAMMER	:= arduino

TARGET_MCU	:= atmega328pb

PORT		:= usb
# PORT		:= com15

BAUD		:= 57600 

FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_m328pb.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(HEX):a
	