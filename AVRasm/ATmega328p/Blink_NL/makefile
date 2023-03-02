
PROGRAMMER	:= arduino
# PROGRAMMER	:= usbasp

TARGET_MCU	:= atmega328p

PORT_NANO	:= com8
# PORT_NANO	:= usb
PORT_LGT	:= com12
PORT_328PB	:= usb

BAUD_NANO	:= 115200
BAUD_LGT	:= 57600 

FILE_NAME	:= Blink_NL
ASM			:= $(FILE_NAME).asm
HEX_NANO	:= $(FILE_NAME)_nano.hex
HEX_LGT		:= $(FILE_NAME)_lgt8f328p.hex
HEX_PB		:= $(FILE_NAME)_m328pb.hex

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
	
	
pb:
	@avrasm2.exe -fI $(ASM) -o $(HEX_PB)
	@avrdude -p $(TARGET_MCU)b -B 125kHz -c usbasp -U flash:w:$(HEX_PB):a


fuse_get:
	avrdude.exe -p m328p -c usbasp -P usb  -U lock:r:lock.hex:r -U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
	avrdude.exe -p m328p -c usbasp -P usb  -U lock:w:207:m 		-U hfuse:w:218:m		-U lfuse:w:255:m 		-U efuse:w:253:m
