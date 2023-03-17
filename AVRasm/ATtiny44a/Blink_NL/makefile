
PROGRAMMER	:= usbasp

TARGET_MCU	:= 	ATtiny44a

PORT		:= usb

BAUD		:= 115200

FILE_NAME	:= Blink_NL
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t44a.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo -
	@echo -------------------------
	@echo Program $(TARGET_MCU)
	@echo -------------------------
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a

fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:r:lock.hex:r 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U efuse:r:efuse.hex:r