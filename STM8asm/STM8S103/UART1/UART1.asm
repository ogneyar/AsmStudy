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
    ; пины PB5 и PC3 на выход
    bset    PB_DDR, #LED_B       ; PB_DDR|=(1<<LED_B)
    bset    PB_CR1, #LED_B       ; PB_CR1|=(1<<LED_B)
    bset    PC_DDR, #LED_C
    bset    PC_CR1, #LED_C
    
    ; выключаем светодиоды
    bset    PB_ODR, #LED_B       ; PB_ODR |= (1<<LED_B)	
    bset    PC_ODR, #LED_C

    ; инициализация UART1 
    call    UART_init
    
    ; вывод строки
    ldw     x, #msg_hello
    call    UART_print_str
    
    ; вывод символа
    ; ld      A, #'\n'
    ; call    UART_transmit

    ; вывод числа
    ; ldw     x,  #42
    ; call    UART_print_num


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
    call    UART_transmit
    call    LED_OFF
    jp      continue
    
send_1:
    call    UART_transmit
    call    LED_ON
    jp      continue

send_nothing:
    call    UART_transmit
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
; текстовые строки
msg_hello:
    DC.B $0a ; '\n'
    STRING "Здравствуй дорогой!"
    DC.B $0a
    DC.B $0a
    STRING "Жми 1 для включения LED"
    DC.B $0a
    STRING "Жми 0 для выключения LED"
    DC.B $0a
    DC.B $0a
    DC.B $00
; ================================================
msg_led_on:
    STRING " - LED включен!"
    DC.B '\n'
    DC.B $00
; ================================================
msg_led_off:
    STRING " - LED вЫключен!"
    DC.B '\n'
    DC.B $00
; ================================================
msg_nothing:
    STRING " - нет знакомой команды..."
    DC.B '\n'
    DC.B $00
; ================================================



; ================================================
; подпрограмма включения светодиодов
LED_ON:
    ; вывод строки
    ldw     x, #msg_led_on
    call    UART_print_str
    ; включаем светодиоды
    bres    PB_ODR, #LED_B       ; PB_ODR  &= ~(1<<LED_B)	
    bres    PC_ODR, #LED_C  

    ret
; ================================================


; ================================================
; подпрограмма выключения светодиодов
LED_OFF:
    ; вывод строки
    ldw     x, #msg_led_off
    call    UART_print_str
    ; выключаем светодиоды
    bset    PB_ODR, #LED_B       ; PB_ODR |= (1<<LED_B)	
    bset    PC_ODR, #LED_C

    ret
; ================================================


; ================================================
; подпрограмма вывода информации
LED_Nothing:
    ; вывод строки
    ldw     x, #msg_nothing
    call    UART_print_str

    ret
; ================================================


    end
