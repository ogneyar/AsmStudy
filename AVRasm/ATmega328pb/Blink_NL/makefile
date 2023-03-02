
PROGRAMMER	:= usbasp

TARGET_MCU	:= atmega328pb

PORT		:= usb

FILE_NAME	:= Blink_NL
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_m328pb.hex

all: pb
	@echo Finish All	
	
pb:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -U flash:w:$(HEX):a

fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:r:lock.hex:r 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
# значения фьюзов в десятичном формате
# original
#	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:w:255:m 		-U hfuse:w:217:m		-U lfuse:w:98:m 		-U efuse:w:247:m
# new
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:w:255:m 		-U hfuse:w:217:m		-U lfuse:w:226:m 		-U efuse:w:247:m
