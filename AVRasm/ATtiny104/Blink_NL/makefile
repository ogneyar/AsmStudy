
PROGRAMMER	:= usbasp

# TARGET_MCU	:= 	ATtiny104
TARGET_MCU	:= 	t104

BAUD		:= 115200

FILE_NAME	:= Blink_NL
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t104.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a
