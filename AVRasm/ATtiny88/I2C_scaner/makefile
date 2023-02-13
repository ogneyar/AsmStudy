
PROGRAMMER	:= usbasp

TARGET_MCU	:= 	ATtiny88

BAUD		:= 115200

FILE_NAME	:= I2C_scaner
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t88.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a
