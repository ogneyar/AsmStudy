stm8/
    MOTOROLA	
	WORDS		; following addresses are 16-bit length

	segment word at 8080-BFFF 'rom' ; 16Kb

; LED = PE5 

.main
    MOV     $50c6, #0 ; CLK_CKDIVR = $50c6 -> делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    BSET    $5016, #5 ; PE_DDR = $5016 ; PE_DDR|=(1<<PE5)
    BSET    $5017, #5 ; PE_CR1 = $5017 ; PE_CR1|=(1<<PE5)
    BSET    $5007, #5 ; PB_DDR = $5007 ; PB_DDR|=(1<<PB5)
    BSET    $5008, #5 ; PB_CR1 = $5008 ; PB_CR1|=(1<<PB5)
main_loop:
    bcpl    $5014, #5 ; PE_ODR = $5014 ; PE_ODR^=(1<<PE5)	
    bcpl    $5005, #5 ; PB_ODR = $5005 ; PB_ODR^=(1<<PB5)	
	call    delay

    jp      main_loop
	
delay:
	; 0x30d400 = 3200000 i.e. (16 MHz)/5 cycles - 1 секуда
	; 0x186a00 = 1600000 i.e. (16 MHz)/5 cycles / 2 - 0.5 секуды
	; 0x09c400 = 640000 i.e. (16 MHz)/5 cycles / 5 - 0.2 секуды
	; 0x04e200 = 320000 i.e. (16 MHz)/5 cycles / 10 - 0.1 секуды
    ld 	    a, #$30 	; #$30 - 1000мс,   #$18 - 500мс,   #$09 - 200мс,   #$04 - 100мс
    ldw     y, #$d400 	; #$d400 - 1000мс, #$6a00 - 500мс, #$c400 - 200мс, #$e200 - 100мс
loop:
    subw    y, #$01 	; decrement with set carry
    sbc     a, #0 		; decrement carry flag i.e. a = a - carry_flag
    jrne    loop
	
	ret

    end
    	