stm8/ TITLE “main_F_v14.asm”

    #include "STM8S103F.inc"
    MOTOROLA
    WORDS

    segment byte at 8004 'some_FLASH_segment'
start:
; включаем светодиод	
    bset   PB_DDR,#5       ; [72 1A 50 07]
    bset   PB_CR1,#5       ; [72 1A 50 08]
cycle:
    jra    cycle           ; [20 F6]

    segment byte at 9FFE-9FFF 'start_address'
	dc.w   start
	
    end
; main_F_v14.asm