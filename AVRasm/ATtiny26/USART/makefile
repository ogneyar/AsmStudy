
PROGRAMMER	:= usbasp

TARGET_MCU	:= 	ATtiny26

BAUD		:= 115200

FILE_NAME	:= USART
ASM			:= $(FILE_NAME).asm
HEX			:= $(FILE_NAME)_t26.hex

all: upload
	@echo Finish All
	
compile:
	@avrasm2.exe -fI $(ASM) -o $(HEX)
	
upload: compile
	@echo Program $(TARGET_MCU)
	@avrdude -p $(TARGET_MCU) -c $(PROGRAMMER) -b $(BAUD) -U flash:w:$(HEX):a

fuse_get:
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:r:hfuse.hex:r 	-U lfuse:r:lfuse.hex:r 	-U lock:r:lock.hex:r 	-U efuse:r:efuse.hex:r

fuse_set:
# значения фьюзов в десятичном формате
# original
#	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT)		-U hfuse:w:247:m		-U lfuse:w:225:m 		
# new
	@avrdude.exe -p $(TARGET_MCU) -B 125kHz -c $(PROGRAMMER) -P $(PORT) 	-U hfuse:w:247:m		-U lfuse:w:97:m 		

# ATtiny26
# lfuse = 0xe1 = 225 = 0b11100001
#  0 - CKSEL0 ; 1 (unprogrammed)
#  1 - CKSEL1 ; 0 (programmed)
#  2 - CKSEL2 ; 0 (programmed)
#  3 - CKSEL3 ; 0 (programmed)
#  4 - SUT0   ; 0 (programmed)
#  5 - SUT1   ; 1 (unprogrammed)
#  6 - CKOPT  ; 1 (unprogrammed) // Oscillator options
#  7 - PLLCK  ; 1 (unprogrammed) // Use PLL for internal clock

# hfuse = 0xf7 = 247 = 0b11110111
#  0 - BODEN
#  1 - BODLEVEL
#  2 - EESAVE
#  3 - SPIEN ; 0 (programmed, SPI prog.enabled)
#  4 - RSTDISBL
#  5 - -----
#  6 - -----
#  7 - -----

# lock = 0x03 = 3 = 0b00000011
