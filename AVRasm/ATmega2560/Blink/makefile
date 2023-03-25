
PROGRAMMER	:= wiring
# PROGRAMMER	:= usbasp

TARGET_MCU	:= ATmega2560

PORT		:= com6
# PORT		:= usb

BAUD		:= 115200

FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_m2560.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(HEX):a -D
		
fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U lock:r:lock.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
# значения фьюзов в десятичном формате
# original
#	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT)		-U hfuse:w:153:m		-U lfuse:w:98:m 		
# new
	@avrdude.exe -p $(TARGET_MCU) -b $(BAUD) -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:w:216:m		-U lfuse:w:255:m 		

# ATmega2560
# lfuse = 0x62 = 98 = 0b01100010
#  0 - CKSEL0 ; 0 (programmed)
#  1 - CKSEL1 ; 1 (unprogrammed)
#  2 - CKSEL2 ; 0 (programmed)
#  3 - CKSEL3 ; 0 (programmed)
#  4 - SUT0   ; 0 (programmed)
#  5 - SUT1   ; 1 (unprogrammed)
#  6 - CKOUT  ; 1 (unprogrammed) // Oscillator options
#  7 - CKDIV8 ; 0 (programmed) // Use PLL for internal clock

# hfuse = 0x99 = 153 = 0b10011001
#  0 - BOOTRST	 ; 1 (unprogrammed)
#  1 - BOOTSZ0	 ; 0 (programmed)
#  2 - BOOTSZ1	 ; 0 (programmed)
#  3 - EESAVE	 ; 1 (unprogrammed)
#  4 - WDTON 	 ; 1 (unprogrammed)
#  5 - SPIEN 	 ; 0 (programmed)
#  6 - JTAGEN 	 ; 0 (programmed)
#  7 - OCDEN 	 ; 1 (unprogrammed)

