stm8/
    #include "STM8S003F.inc"
    MOTOROLA
	
	WORDS			; The following addresses are 16 bits long
	segment byte at 8080-9FFF 'rom'
	

LED equ 5


.main
    bset PB_DDR, #LED       ; PB_DDR|=(1<<LED)
    bset PB_CR1, #LED       ; PB_CR1|=(1<<LED)
mloop:
    bcpl PB_ODR, #LED       ; PB_ODR^=(1<<LED)	
	call delay
    jp mloop
	
delay:
	; 0x61a80 = 400000 i.e. (2*10^6 MHz)/5cycles - 1 секуда
	; 0x30d40 = 200000 i.e. (2*10^6 MHz)/5cycles / 2 - 0.5 секуды
	; 0x13880 = 80000 i.e. (2*10^6 MHz)/5cycles / 5 - 0.2 секуды
	; 0x09c40 = 40000 i.e. (2*10^6 MHz)/5cycles / 10 - 0.1 секуды
    ld 	a, #$06 	; #$06 - 1000мс,   #$03 - 500мс,   #$01 - 200мс,   #$00 - 100мс
    ldw y, #$1a80 	; #$1a80 - 1000мс, #$0d40 - 500мс, #$3880 - 200мс, #$9c40 - 100мс
loop:
    subw y, #$01 	; decrement with set carry
    sbc a,#0 		; decrement carry flag i.e. a = a - carry_flag
    jrne loop
	
	ret

    end
	
	
	