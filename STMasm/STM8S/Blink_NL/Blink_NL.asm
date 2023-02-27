stm8/
    MOTOROLA	
	WORDS		; following addresses are 16-bit length

	segment byte at 8080-9FFF 'rom'	

; PB5 for BLUE  BOARD STM8S
; PC3 for BLACK BOARD STM8S

.main
    bset    $5007, #5; PB_DDR = $5007 ; PB_DDR|=(1<<PB5)
    bset    $5008, #5; PB_CR1 = $5008 ; PB_CR1|=(1<<PB5)
    bset    $500c, #3; PC_DDR = $500c ; PC_DDR|=(1<<PC3)
    bset    $500d, #3; PC_CR1 = $500d ; PC_CR1|=(1<<PC3)
main_loop:
    bcpl    $5005, #5; PB_ODR = $5005 ; PB_ODR^=(1<<PB5)	
    bcpl    $500a, #3; PC_ODR = $500a ; PC_ODR^=(1<<PC3)
	call    delay

    jp      main_loop
	
delay:
	; 0x61a80 = 400000 i.e. (2*10^6 MHz)/5cycles - 1 секуда
	; 0x30d40 = 200000 i.e. (2*10^6 MHz)/5cycles / 2 - 0.5 секуды
	; 0x13880 = 80000 i.e. (2*10^6 MHz)/5cycles / 5 - 0.2 секуды
	; 0x09c40 = 40000 i.e. (2*10^6 MHz)/5cycles / 10 - 0.1 секуды
    ld 	    a, #$03 	; #$06 - 1000мс,   #$03 - 500мс,   #$01 - 200мс,   #$00 - 100мс
    ldw     y, #$0d40 	; #$1a80 - 1000мс, #$0d40 - 500мс, #$3880 - 200мс, #$9c40 - 100мс
loop:
    subw    y, #$01 	; decrement with set carry
    sbc     a, #0 		; decrement carry flag i.e. a = a - carry_flag
    jrne    loop
	
	ret

    end
    	