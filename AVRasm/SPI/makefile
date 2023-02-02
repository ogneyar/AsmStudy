
PROGRAMMER	:= arduino

TARGET_MCU	:= atmega328p

PORT_NANO	:= com8
PORT_LGT	:= com12

BAUD_NANO	:= 115200
BAUD_LGT	:= 57600 

FILE_NAME	:= SPI
ASM			:= $(FILE_NAME).asm
HEX_NANO	:= $(FILE_NAME)_atmega328p.hex
HEX_LGT		:= $(FILE_NAME)_lgt8f328p.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX_NANO)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -P $(PORT_NANO) -b $(BAUD_NANO) -U flash:w:$(HEX_NANO):a
	
lgt8f:
	@avrasm2.exe -fI $(ASM) -o $(HEX_LGT)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -P $(PORT_LGT)  -b $(BAUD_LGT) -U flash:w:$(HEX_LGT):a

nano: all
	@echo Finish nano

