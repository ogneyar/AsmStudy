
PROGRAMMER	:= usbasp

TARGET_MCU	:= atmega328pb

PORT		:= usb

BAUD		:= 57600 

FILE_NAME	:= optiboot_m328pb
# FILE_NAME	:= optiboot_atmega328pb_8mhz
HEX			:= $(FILE_NAME).hex


all: pb
	@echo Finish All	
	
pb:
	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -U flash:w:$(HEX):a

fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:r:lock.hex:r 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
# значения фьюзов в десятичном формате
# original
#	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:w:255:m 		-U hfuse:w:217:m		-U lfuse:w:98:m 		-U efuse:w:247:m
# new
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U lock:w:255:m 		-U hfuse:w:217:m		-U lfuse:w:226:m 		-U efuse:w:247:m
