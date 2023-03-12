stm8/ TITLE “main_v25.asm”

    #include "STM8S103F.inc"
    MOTOROLA
    WORDS

    segment byte at 4831-4832 'start_address'
	dc.w   start 

    segment byte at 8004 'some_FLASH_segment'
start:
; включаем светодиод	
    bset   PB_DDR,#5       ; [72 1A 50 07]
    bset   PB_CR1,#5       ; [72 1A 50 08]
cycle:
    jra    cycle           ; [20 F6]

    end
; main_v25.asm