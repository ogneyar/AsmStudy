
PROGRAMMER	:= usbasp

TARGET_MCU	:= 	attiny104

TARGET_FCPU := 	12000000

BAUD		:= -b 115200

FILE_NAME	:= Test
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t104.hex

all: upload
	@echo Finish All
	
compile:
	@avr-gcc -Wall -Os -nostartfiles -mmcu=$(TARGET_MCU) $(FILE_NAME).S -o $(FILE_NAME).o
	@avr-objcopy -j .text -j .data -O ihex $(FILE_NAME).o $(FILE_NAME).hex
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -U flash:w:$(HEX):a
