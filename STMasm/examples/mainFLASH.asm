stm8/ TITLE “mainFLASH.asm”

    #include "STM8S103F3P.inc"
    MOTOROLA
    WORDS
	
    segment byte at 0100 'some_RAM_segment'
start:
    bset    PB_DDR,#5   ; [72 1A 50 07]
    bset    PB_CR1,#5   ; [72 1A 50 08]
cycle:
    jra     cycle       ; [20 FE]
;    jra     *           ; [20 FE] 

    end
; mainFLASH.asm