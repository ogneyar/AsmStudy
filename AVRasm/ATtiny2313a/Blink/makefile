
PROGRAMMER	:= usbasp

PORT		:= usb

TARGET_MCU	:= 	ATtiny2313A

BAUD		:= 115200

FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t2313a.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a

fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U lock:r:lock.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
# значения фьюзов в десятичном формате
# original
#	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT)		-U hfuse:w:223:m		-U lfuse:w:98:m 		
# new
	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:w:223:m		-U lfuse:w:244:m 		

# ATtiny2313A
# lfuse = 0x62 = 98 = 0b01100010
#  0 - CKSEL0 ; 0 (unprogrammed)
#  1 - CKSEL1 ; 1 (programmed)
#  2 - CKSEL2 ; 0 (programmed)
#  3 - CKSEL3 ; 0 (programmed)
#  4 - SUT0   ; 0 (programmed)
#  5 - SUT1   ; 1 (unprogrammed)
#  6 - CKOUT  ; 1 (unprogrammed) // Oscillator options
#  7 - CKDIV8 ; 0 (unprogrammed) // Use PLL for internal clock

# hfuse = 0xdf = 223 = 0b11111011
#  0 - RSTDISBL  ; 1 (unprogrammed)
#  1 - BODLEVEL0 ; 1 (unprogrammed)
#  2 - BODLEVEL1 ; 1 (unprogrammed)
#  3 - BODLEVEL2 ; 1 (unprogrammed)
#  4 - WDTON 	 ; 1 (unprogrammed)
#  5 - SPIEN 	 ; 0 (programmed)
#  6 - EESAVE 	 ; 1 (unprogrammed)
#  7 - DWEN 	 ; 1 (unprogrammed)
