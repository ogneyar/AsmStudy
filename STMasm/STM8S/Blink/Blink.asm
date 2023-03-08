stm8/
    #include "STM8S103F.inc"
    MOTOROLA
	
	WORDS			; The following addresses are 16 bits long
	segment byte at 8080-9FFF 'rom'
	

LED_B equ 5 ; PB5 for BLUE  BOARD STM8S
LED_C equ 3 ; PC3 for BLACK BOARD STM8S


.main
    MOV     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    BSET    PB_DDR, #LED_B      ; PB_DDR|=(1<<LED_B)
    BSET    PB_CR1, #LED_B      ; PB_CR1|=(1<<LED_B)
    BSET    PC_DDR, #LED_C
    BSET    PC_CR1, #LED_C
main_loop:
    bcpl PB_ODR, #LED_B         ; PB_ODR^=(1<<LED_B)	
    bcpl PC_ODR, #LED_C
	call delay
    jp main_loop
	
delay:
	; 0x30d400 = 3200000 i.e. (16 MHz)/5 cycles - 1 секуда
	; 0x186a00 = 1600000 i.e. (16 MHz)/5 cycles / 2 - 0.5 секуды
	; 0x09c400 = 640000 i.e. (16 MHz)/5 cycles / 5 - 0.2 секуды
	; 0x04e200 = 320000 i.e. (16 MHz)/5 cycles / 10 - 0.1 секуды
    ld 	    a, #$18 	; #$30 - 1000мс,   #$18 - 500мс,   #$09 - 200мс,   #$04 - 100мс
    ldw     y, #$6a00 	; #$d400 - 1000мс, #$6a00 - 500мс, #$c400 - 200мс, #$e200 - 100мс
loop:
    subw y, #$01 	; decrement with set carry
    sbc a,#0 		; decrement carry flag i.e. a = a - carry_flag
    jrne loop
	
	ret

    end
	
	
	