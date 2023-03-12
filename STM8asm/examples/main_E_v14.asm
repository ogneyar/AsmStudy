stm8/ TITLE “main_E_v14.asm”

    #include "STM8S103F.inc"
    MOTOROLA
    WORDS

    segment byte at 4000 'some_EEPROM_segment'
start:
; включаем светодиод	
    bset   PB_DDR,#5       ; [72 1A 50 07]
    bset   PB_CR1,#5       ; [72 1A 50 08]
cycle:
    jra    cycle           ; [20 F6]

    segment byte at 9FFE-9FFF 'start_address'
; после копирования кода из EEPROM в RAM
; загрузчик передаст управление по адресу $0000
	dc.w   $0000
	
    end
; main_E_v14.asm