stm8/
    #include "STM8S103F.inc"
    #include "macros.inc"
	
	;extern delay ; from file utils.asm

LED equ 5

    segment 'rom'

.main
	; Bit Set	
    bset PB_DDR, #LED	; PB_DDR|=(1<<LED)
    bset PB_CR1, #LED	; PB_CR1|=(1<<LED)
mloop:
	; Bit Complement
    bcpl PB_ODR, #LED	; PB_ODR^=(1<<LED)
	;call delay
	delay_ms 1000
    jp mloop

    end
