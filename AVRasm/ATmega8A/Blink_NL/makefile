
# PROGRAMMER	:= arduino
PROGRAMMER	:= usbasp

TARGET_MCU	:= atmega8a

# PORT_NANO	:= com8
PORT		:= usb

BAUD		:= 115200

FILE_NAME	:= Blink_NL
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_m8a.hex

all: upload
	@echo Finish All
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(HEX):a

compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	

fuse_get:
	avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT)  -U lock:r:lock.hex:r -U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U efuse:r:efuse.hex:r
#	avrdude.exe -p atmega8a -b 115200 -c usbasp -P usb 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U lock:r:lock.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
# значения фьюзов в десятичном формате
# original
#	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT)		-U hfuse:w:217:m		-U lfuse:w:225:m 		
# new
	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:w:217:m		-U lfuse:w:225:m 		

# atmega8a
# lfuse = 0xe1 = 225 = 0b11100001
#  7 - BODLEVEL ; 1 (programmed)
#  6 - BODEN 	; 1 (unprogrammed, BOD disabled)
#  5 - SUT1 	; 1 (unprogrammed)
#  4 - SUT0 	; 0 (programmed)
#  3 - CKSEL3   ; 0 (programmed)
#  2 - CKSEL2   ; 0 (programmed)
#  1 - CKSEL1  	; 0 (programmed)
#  0 - CKSEL0 	; 1 (unprogrammed)

# hfuse = 0xd9 = 217 = 0b11011001
#  7 - RSTDISBL ; 1 (unprogrammed, PC6 is RESET-pin)
#  6 - WDTON 	; 1 (unprogrammed, WDT enabled by WDTCR)
#  5 - SPIEN 	; 0 (programmed, SPI prog. enabled)
#  4 - CKOPT	; 1 (unprogrammed)
#  3 - EESAVE 	; 1 (unprogrammed, EEPROM not preserved)
#  2 - BOOTSZ1 	; 0 (programmed)
#  1 - BOOTSZ0 	; 0 (programmed)
#  0 - BOOTRST 	; 1 (unprogrammed)
