
PROGRAMMER	:= usbasp

TARGET_MCU	:= 	ATtiny13

BAUD		:= 115200

FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_ATtiny13.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a
