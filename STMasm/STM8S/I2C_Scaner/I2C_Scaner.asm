stm8/ 
; STM8S003F black
; STM8S103F blue - разница в размере EEPROM
    #include "STM8S103F.inc"
    MOTOROLA

	WORDS			; The following addresses are 16 bits long
	segment byte at 8180-9FFF 'rom'
	

; LED_B equ 5 ; PB5 for BLUE  BOARD STM8S
LED_C equ 3 ; PC3 for BLACK BOARD STM8S

SDA equ 5 ; PB5
SCL equ 4 ; PB4


; ================================================
; начало программы
.main
    mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    ; bset    PB_DDR, #LED_B       ; PB_DDR|=(1<<LED_B)
    ; bset    PB_CR1, #LED_B       ; PB_CR1|=(1<<LED_B)
    bset    PC_DDR, #LED_C
    bset    PC_CR1, #LED_C

    ; инициализация I2C
    call    I2C_Init

    call    I2C_Scan


; ------------------------------------------------
; беЗкоечнный цикл
main_loop:   
    ; bcpl    PB_ODR, #LED_B         ; PB_ODR^=(1<<LED_B)	
    ; bcpl    PC_ODR, #LED_C
	; call    delay
    jp      main_loop
; ------------------------------------------------
; ================================================


; ================================================
; подпрограмма задержки
delay:
	; 0x30d400 = 3200000 i.e. (16 MHz)/5 cycles - 1 секуда
	; 0x186a00 = 1600000 i.e. (16 MHz)/5 cycles / 2 - 0.5 секуды
	; 0x09c400 = 640000 i.e. (16 MHz)/5 cycles / 5 - 0.2 секуды
	; 0x04e200 = 320000 i.e. (16 MHz)/5 cycles / 10 - 0.1 секуды
    ld 	    a, #$18 	; #$30 - 1000мс,   #$18 - 500мс,   #$09 - 200мс,   #$04 - 100мс
    ldw     y, #$6a00 	; #$d400 - 1000мс, #$6a00 - 500мс, #$c400 - 200мс, #$e200 - 100мс
loop:
    subw    y, #$01 	; decrement with set carry
    sbc     a, #0 		; decrement carry flag i.e. a = a - carry_flag
    jrne    loop
	
	ret
; ================================================

; ================================================
; подпрограмма инициализации I2C
I2C_Init:
    bres    PB_DDR, #SDA ; PB_DDR |= (1 << SDA)
    bset    PB_ODR, #SDA ; PB_CR1 |= (1 << SDA)
    bres    PB_DDR, #SCL ; PB_DDR |= (1 << SCL)
    bset    PB_ODR, #SCL ; PB_CR1 |= (1 << SCL)

    ; Частота тактирования периферии MHz
    mov    I2C_FREQR, #16
    ; Отключаем I2C
    bres    I2C_CR1, #0 ; PE: Peripheral enable
    ; В стандартном режиме скорость I2C max = 100 кбит/с
    ; Выбираем стандартный режим
    bres    I2C_CCRH, #7

    ;= InputClockFrequencyMHz+1
    mov     I2C_TRISER, #17

    ; ccr = Fcpu / (2 * baud)
    ; ccr = 16Mhz / (2 * 100KHz) = 80 = $50
    mov     I2C_CCRL, #$50

    ; Включаем I2C
    bset    I2C_CR1, #0 ; PE: Peripheral enable
    ; Разрешаем подтверждение в конце посылки
    bset    I2C_CR2, #2 ; ACK: Acknowledge enable

    ret
; ================================================


; ================================================
; I2C команда СТАРТ
I2C_Start:
    bset    I2C_CR2, #0 ; START: Start generation
loop_I2C_Start:
    ; Ждем установки бита SB
    btjf   I2C_SR1, #0, loop_I2C_Start ; SB = #0 -> if ( ( I2C_SR1 & (1 << SB) ) = 0 ) jmp loop_I2C_Start
    ret
; ================================================

; ================================================
; I2C команда СТОП
I2C_Stop:
    bset    I2C_CR2, #1 ; STOP: Stop generation
    ret
; ================================================

; ================================================
; ожидание I2C
I2C_Wait: ; ждём пока бит TXE не поднимится в 1
    btjf   I2C_SR1, #7, I2C_Wait ; TXE = #7 -> if ( ( I2C_SR1 & (1 << TXE) ) = 0 ) jmp I2C_Wait
    ret
; ================================================

; ================================================
; ожидание Busy
I2C_Wait_Busy: ; ждём пока бит BUSY не опустится в 0
    btjt    I2C_SR3, #1, I2C_Wait_Busy ; BUSY = #1 -> if ( ( I2C_SR3 & (1 << BUSY) ) = 1 ) jmp I2C_Wait_Busy
    ret
; ================================================

; ================================================
; подпрограмма передача байта по I2C
I2C_Write: ; данные ожидаются в регистре A
    ld      I2C_DR, A
    call    I2C_Wait
    ret
; ================================================

; ================================================
; подпрограмма передача байта по I2C
I2C_Write_Address: ; данные ожидаются в регистре A
    SLL     A ; Shift left logical
    call    I2C_Write
    ret
; ================================================

; ================================================
; подпрограмма передача байта по I2C
I2C_Scan:
    call    I2C_Wait_Busy
    call    I2C_Start

    ld      A, #$3c
    call    I2C_Write_Address

    btjt    I2C_SR1, #1, I2C_ACK ; ADDR = #1 -> if ( ( I2C_SR1 & (1 << ADDR) ) = 1 ) jmp I2C_ACK
    
    call    I2C_Stop
    jp     continue

I2C_ACK:
    call    I2C_Stop
    ; Очистка бита ADDR чтением регистра SR3
    ld      A, I2C_SR3
loop_I2C_Scan:
    bcpl    PC_ODR, #LED_C
	call    delay
    jp      loop_I2C_Scan

continue:
    ret
; ================================================

    end
