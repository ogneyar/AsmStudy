
PROGRAMMER	:= arduino

TARGET_MCU	:= atmega328p

PORT		:= com8
# PORT		:= com12

# BAUD		:= 19200
# для LGT8F
# BAUD		:= 57600 
# для NANO
BAUD		:= 115200

FILE_NAME	:= SPI
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME).hex

all: upload
	@echo Finish
	
compile:
	@avrasm2.exe -fI $(ASM)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(HEX):a
	

