stm8/ 
; STM8S003F black
; STM8S103F blue - разница в размере EEPROM
    #include "../libs/STM8S103F.inc"
    MOTOROLA

	WORDS			; The following addresses are 16 bits long
	segment byte at 8180-9FFF 'rom'
	

LED_B equ 5 ; PB5 for BLUE  BOARD STM8S
LED_C equ 3 ; PC3 for BLACK BOARD STM8S


    #define F_CPU       16000000    ; 16MHz
    #define BAUD        9600        ; BaudRate USART1 9,6KHz
    #define BAUD_I2C    100000      ; BaudRate I2C 100KHz


; ================================================
; начало программы
.main
    ; устанавливаем частоту МК 16MHz
    mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)

    ; инициализация UART1
    call    UART_init
    
    ; инициализация I2C
    call    I2C_Init

    ; сканируем адрес I2C устройства
    call    I2C_Scan

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
    #include "../libs/usart.asm"
    #include "../libs/delay.asm"
    #include "../libs/i2c.asm"


; ================================================
; подпрограмма передача байта по I2C
I2C_Scan:
    ld      A, #$00
loop_I2C_Scan:
    call    I2C_Wait_Busy
    call    I2C_Start

    ; call    I2C_Write_Address
    push    A
    SLL     A ; Shift left logical
    ld      I2C_DR, A ; call    I2C_Write
    pop     A    

    btjt    I2C_SR1, #1, I2C_ACK ; ADDR = #1 -> if ( ( I2C_SR1 & (1 << ADDR) ) = 1 ) jmp I2C_ACK
    
    call    I2C_Stop

    inc     A
    CP      A, #$80 ; $7f - maximum
    JRNE    loop_I2C_Scan

    jp      I2C_NO_ACK

I2C_ACK:
    call    I2C_Stop
    
    dec     A
    ld      XL, A ; save address

    ; Очистка бита ADDR чтением регистра SR3
    ld      A, I2C_SR3

    ld      A, #'\n'
    call    UART_transmit
    ld      A, #'F'
    call    UART_transmit
    ld      A, #'o'
    call    UART_transmit
    ld      A, #'u'
    call    UART_transmit
    ld      A, #'n'
    call    UART_transmit
    ld      A, #'d'
    call    UART_transmit
    ld      A, #':'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit

    ld      A, #'0'
    call    UART_transmit
    ld      A, #'b'
    call    UART_transmit
        
    ld      A, #0
    ld      XH, A
send_address:
    ld      A, XH
    cp      A, #8
    JREQ    end_send_address

    ld      A, XL
    RLC     A ; Rotate Left Logical through Carry
    JRC     send_1
    jp      send_0
    
send_0:
    ld      XL, A
    ld      A, XH
    inc     A
    ld      XH, A
    ld      A, #'0'
    call    UART_transmit
    jp      send_address
    
send_1:
    ld      XL, A
    ld      A, XH
    inc     A
    ld      XH, A
    ld      A, #'1'
    call    UART_transmit
    jp      send_address

end_send_address:
    ld      A, #'\n'
    call    UART_transmit

    jp      end_I2C_Scan

I2C_NO_ACK:
    call    I2C_Stop
    
    ld      A, #'\n'
    call    UART_transmit

    ld      A, #'N'
    call    UART_transmit
    ld      A, #'o'
    call    UART_transmit
    ld      A, #' '
    call    UART_transmit
    ld      A, #'A'
    call    UART_transmit
    ld      A, #'c'
    call    UART_transmit
    ld      A, #'k'
    call    UART_transmit
    ld      A, #'\n'
    call    UART_transmit

    jp      end_I2C_Scan

end_I2C_Scan:
    ret
; ================================================

    end
