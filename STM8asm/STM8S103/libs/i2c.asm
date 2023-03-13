
    #ifdef _I2C_ASM_
    ; nothing
    #else
    #define _I2C_ASM_ 1

SDA equ 5 ; PB5
SCL equ 4 ; PB4

    #ifdef F_CPU
    ; nothing
    #else
    #define F_CPU 16000000 ; 16MHz
    #endif 
    
    #ifdef BAUD_I2C
    ; nothing
    #else
    #define BAUD_I2C 100000 ; 100KHz
    #endif 

    ; I2C_CCRL = F_CPU / ( 2 * BAUD_I2C ) = 16000000 / ( 2 * 100000 ) = 80 = $50
    #define CCRL        { F_CPU div { 2 mult BAUD_I2C } }

    #define FREQR       { F_CPU div 1000000 } ; Частота тактирования периферии в MHz

; ================================================
; подпрограмма инициализации I2C
I2C_Init:
    mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    ; пины SDA и SCL на выход
    bres    PB_DDR, #SDA ; PB_DDR |= (1 << SDA)
    bset    PB_ODR, #SDA ; PB_CR1 |= (1 << SDA)
    bres    PB_DDR, #SCL ; PB_DDR |= (1 << SCL)
    bset    PB_ODR, #SCL ; PB_CR1 |= (1 << SCL)

    ; Частота тактирования периферии в MHz
    mov     I2C_FREQR, #FREQR
    ; Отключаем I2C
    bres    I2C_CR1, #0 ; PE: Peripheral enable
    ; В стандартном режиме скорость I2C max = 100 кбит/с
    ; Выбираем стандартный режим
    bres    I2C_CCRH, #7

    ;= InputClockFrequencyMHz+1
    mov     I2C_TRISER, #{FREQR + 1}

    ; ccrl = Fcpu / (2 * baud)
    mov     I2C_CCRL, #CCRL

    ; Включаем I2C
    bset    I2C_CR1, #0 ; PE: Peripheral enable
    ; Разрешаем подтверждение в конце посылки
    bset    I2C_CR2, #2 ; ACK: Acknowledge enable

    ret
; ================================================


; ================================================
; I2C команда СТАРТ
I2C_Start:
    ; call    I2C_Wait_Busy
    bset    I2C_CR2, #0 ; START: Start generation
    call    I2C_Wait_START

    ret
; ================================================

; ================================================
; I2C команда СТОП
I2C_Stop:
    bset    I2C_CR2, #1 ; STOP: Stop generation
    call    I2C_Wait_STOP

    ret
; ================================================

; ================================================
; подпрограмма передача байта по I2C
I2C_Write: ; данные ожидаются в регистре A
    ld      I2C_DR, A
    call    I2C_Wait_TXE

    ret
; ================================================

; ================================================
; подпрограмма передача байта по I2C
I2C_Write_Address: ; данные ожидаются в регистре A
    push    A
    SLL     A ; Shift left logical
    call    I2C_Write
    call    I2C_Wait_ADDR
    ld      A, I2C_SR3
    pop     A

    ret
; ================================================

; ================================================
; ожидание Busy
I2C_Wait_Busy: ; ждём пока бит BUSY не опустится в 0
    btjt    I2C_SR3, #1, I2C_Wait_Busy ; BUSY = #1 -> if ( ( I2C_SR3 & (1 << BUSY) ) = 1 ) jmp I2C_Wait_Busy

    ret
; ================================================

; ================================================
; ожидание I2C
I2C_Wait_START: ; Ждем установки бита SB
    btjf   I2C_SR1, #0, I2C_Wait_START ; SB = #0 -> if ( ( I2C_SR1 & (1 << SB) ) = 0 ) jmp I2C_Wait_START

    ret
; ================================================

; ================================================
; ожидание I2C
I2C_Wait_STOP: ; ждём пока бит STOP не станет 0
    btjt   I2C_CR2, #1, I2C_Wait_STOP ;  STOP = #1 -> if ( ( I2C_CR1 & (1 <<  STOP) ) = 1 ) jmp I2C_Wait_STOP

    ret
; ================================================

; ================================================
; ожидание I2C
I2C_Wait_TXE: ; ждём пока бит TXE не поднимится в 1
    btjf   I2C_SR1, #7, I2C_Wait_TXE ; TXE = #7 -> if ( ( I2C_SR1 & (1 << TXE) ) = 0 ) jmp I2C_Wait_TXE

    ret
; ================================================

; ================================================
; ожидание I2C
I2C_Wait_ADDR: ; ждём пока бит ADDR не станет 0
    btjf   I2C_SR1, #1, I2C_Wait_ADDR ; ADDR = #1 -> if ( ( I2C_SR1 & (1 << ADDR) ) = 0 ) jmp I2C_Wait_ADDR

    ret
; ================================================


    #endif ; _I2C_ASM_
