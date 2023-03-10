stm8/ 
; STM8S003F black
; STM8S103F blue - разница в размере EEPROM
    #include "../libs/STM8S103F.inc"

    MOTOROLA

	WORDS			; The following addresses are 16 bits long

	segment byte at 8180-9FFF 'rom'


LED_B equ 5 ; PB5 for BLUE  BOARD STM8S
LED_C equ 3 ; PC3 for BLACK BOARD STM8S

    #define F_CPU       16000000
    #define BAUD        9600

; ================================================
; начало программы
.main
    mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    bset    PB_DDR, #LED_B       ; PB_DDR|=(1<<LED_B)
    bset    PB_CR1, #LED_B       ; PB_CR1|=(1<<LED_B)
    bset    PC_DDR, #LED_C
    bset    PC_CR1, #LED_C

    ; инициализация UART1
    call    UART_init
    
    ld      A, #'\n'
    call    UART_transmit

    ld      A, #'H'
    call    UART_transmit
    ld      A, #'e'
    call    UART_transmit
    ld      A, #'l'
    call    UART_transmit
    ld      A, #'l'
    call    UART_transmit
    ld      A, #'o'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'W'
    call    UART_transmit
    ld      A, #'o'
    call    UART_transmit
    ld      A, #'r'
    call    UART_transmit
    ld      A, #'l'
    call    UART_transmit
    ld      A, #'d'
    call    UART_transmit
    ld      A, #'!'
    call    UART_transmit

    ld      A, #'\n'
    call    UART_transmit


; ------------------------------------------------
; беЗкоечнный цикл
main_loop:   
    ; ожидаем байт по UART
    call    UART_receive
    
    CP      A, #'0' ; сравниваем принятый байт с 0
    JREQ    send_0
    
    CP      A, #'1' ; сравниваем принятый байт с 1
    JREQ    send_1
       
    CP      A, #'\n' ; сравниваем принятый байт с 1
    JREQ    nothing
       
    CP      A, #'\r' ; сравниваем принятый байт с 1
    JREQ    nothing

    jp      send_nothing

send_0:
    call    LED_OFF
    jp      continue
    
send_1:
    call    LED_ON
    jp      continue

send_nothing:
    call    LED_Nothing
    jp      continue

nothing:
    jp      continue

continue:
    jp      main_loop
; ------------------------------------------------
; ================================================


; ================================================
    ; подключение библиотек
    #include "../libs/usart.asm"


; ================================================
; подпрограмма включения светодиодов
LED_ON:
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'-'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'L'
    call    UART_transmit
    ld      A, #'e'
    call    UART_transmit
    ld      A, #'d'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'O'
    call    UART_transmit
    ld      A, #'n'
    call    UART_transmit
    ld      A, #'\n'
    call    UART_transmit
    ; включаем светодиоды
    bres    PB_ODR, #LED_B       ; PB_ODR^=(1<<LED_B)	
    bres    PC_ODR, #LED_C    
    ret
; ================================================


; ================================================
; подпрограмма выключения светодиодов
LED_OFF:
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'-'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'L'
    call    UART_transmit
    ld      A, #'e'
    call    UART_transmit
    ld      A, #'d'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'O'
    call    UART_transmit
    ld      A, #'f'
    call    UART_transmit
    ld      A, #'f'
    call    UART_transmit
    ld      A, #'\n'
    call    UART_transmit
    ; выключаем светодиоды
    bset    PB_ODR, #LED_B       ; PB_ODR^=(1<<LED_B)	
    bset    PC_ODR, #LED_C
    ret
; ================================================


; ================================================
; подпрограмма вывода информации
LED_Nothing:
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'-'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'N'
    call    UART_transmit
    ld      A, #'o'
    call    UART_transmit
    ld      A, #'t'
    call    UART_transmit
    ld      A, #'h'
    call    UART_transmit
    ld      A, #'i'
    call    UART_transmit
    ld      A, #'n'
    call    UART_transmit
    ld      A, #'g'
    call    UART_transmit
    ld      A, #'\n'
    call    UART_transmit
    ret
; ================================================


    end
