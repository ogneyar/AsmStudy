
PROGRAMMER	:= usbasp

TARGET_MCU	:= 	ATtiny84a

PORT		:= usb

# -B 125kHz

BAUD		:= 115200

FILE_NAME	:= Blink_NL
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t84.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a
#	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -B 125kHz -P $(PORT) -U flash:w:$(HEX):a

fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:r:lock.hex:r 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U efuse:r:efuse.hex:r