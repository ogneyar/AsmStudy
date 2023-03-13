stm8/ 
; STM8S003F black
; STM8S103F blue - разница в размере EEPROM
    #include "../libs/STM8S103F.inc"
    ; #include "../libs/defines.inc"  ; подключение файла 'определений'
    MOTOROLA

	WORDS			; The following addresses are 16 bits long
	segment byte at 8180-9FFF 'rom'
	

LED_B equ 5 ; PB5 for BLUE  BOARD STM8S
LED_C equ 3 ; PC3 for BLACK BOARD STM8S


    #define F_CPU       16000000    ; 16MHz 
    ; #define BAUD_SPI    1000000      ; BaudRate SPI 1 MHz

    ; #define SSD1306_128x32 1 ; по умочанию SSD1306_128x64


; ================================================
; начало программы
.main
    ; устанавливаем частоту МК 16MHz
    mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    
    ; инициализация SSD1306
    call    SSD1306_Init

    ; тестирование дисплея
    call    SSD1306_Test

    ; инициализация LED
    bset    PB_DDR, #LED_B       ; PB_DDR|=(1<<LED_B)
    bset    PB_CR1, #LED_B       ; PB_CR1|=(1<<LED_B)
    bset    PC_DDR, #LED_C
    bset    PC_CR1, #LED_C

; ------------------------------------------------
; беЗкоечнный цикл
main_loop:   
    bcpl    PB_ODR, #LED_B         ; PB_ODR^=(1<<LED_B)	
    bcpl    PC_ODR, #LED_C
	call    delay
    jp      main_loop
; ------------------------------------------------
; ================================================


; ================================================
    ; подключение библиотек
    #include "../libs/delay.asm"  ; подключение файла 'задержек'
    ; #include "../libs/spi.asm"
    #include "../libs/ssd1306_spi.asm"


    end
