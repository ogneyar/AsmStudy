stm8/
    #include "STM8S103F.inc"
    MOTOROLA
	
	WORDS			; The following addresses are 16 bits long
	segment byte at 8080-9FFF 'rom'
	

LED_B equ 5 ; PB5 for BLUE  BOARD STM8S
LED_C equ 3 ; PC3 for BLACK BOARD STM8S


.main
    bset PB_DDR, #LED_B       ; PB_DDR|=(1<<LED_B)
    bset PB_CR1, #LED_B       ; PB_CR1|=(1<<LED_B)
    bset PC_DDR, #LED_C
    bset PC_CR1, #LED_C
main_loop:
    bcpl PB_ODR, #LED_B       ; PB_ODR^=(1<<LED_B)	
    bcpl PC_ODR, #LED_C
	call delay
    jp main_loop
	
delay:
	; 0x61a80 = 400000 i.e. (2*10^6 MHz)/5cycles - 1 секуда
	; 0x30d40 = 200000 i.e. (2*10^6 MHz)/5cycles / 2 - 0.5 секуды
	; 0x13880 = 80000 i.e. (2*10^6 MHz)/5cycles / 5 - 0.2 секуды
	; 0x09c40 = 40000 i.e. (2*10^6 MHz)/5cycles / 10 - 0.1 секуды
    ld 	a, #$03 	; #$06 - 1000мс,   #$03 - 500мс,   #$01 - 200мс,   #$00 - 100мс
    ldw y, #$0d40 	; #$1a80 - 1000мс, #$0d40 - 500мс, #$3880 - 200мс, #$9c40 - 100мс
loop:
    subw y, #$01 	; decrement with set carry
    sbc a,#0 		; decrement carry flag i.e. a = a - carry_flag
    jrne loop
	
	ret

    end
	
	
	