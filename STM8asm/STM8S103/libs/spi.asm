
    #ifdef _SPI_ASM_
    ; nothing
    #else
    #define _SPI_ASM_ 1

SS      equ 3 ; PA3

DC      equ 3 ; PC3
RES     equ 4 ; PC4
SCK     equ 5 ; PC5
MOSI    equ 6 ; PC6
MISO    equ 7 ; PC7

    #ifdef F_CPU
    ; nothing
    #else
    #define F_CPU 16000000 ; 16MHz
    #endif 

; ================================================
; подпрограмма инициализации SPI
SPI_Init:
    mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)

    bset    CLK_PCKENR1, #1 ; Enable SPI1 (CLK_PCKENR1_SPI1 = 1)

    ; пины SCK, MOSI и SS на выход
    bset    PC_DDR, #SCK ; PC_DDR |= (1 << SCK)
    bset    PC_DDR, #MOSI    
    bset    PC_DDR, #RES    
    bset    PC_DDR, #DC    
    bset    PA_DDR, #SS ; PORT A
    ; пин MISO на вход
    bres    PC_DDR, #MISO ; PC_DDR &= ~(1 << MISO)

    ; push pull
    bset    PC_CR1, #SCK ; PC_CR1 |= (1 << SCK)
    bset    PC_CR1, #MOSI
    bset    PC_CR1, #MISO  
    bset    PC_CR1, #RES      
    bset    PC_CR1, #DC    
    bset    PA_CR1, #SS ; PORT A
    
    ; pull up
    bset    PC_ODR, #RES ; PC_ODR |= (1 << RES)
    bset    PC_ODR, #DC    
    bset    PA_ODR, #SS ; PORT A
    
    ; Master selection
    bset    SPI_CR1, #2 ; SPI_CR1_MSTR
    ; Enable SPI
    bset    SPI_CR1, #6 ; SPI_CR1_SPE
    ; Частота тактирования SPI (0b000 - F_CPU / 2, 0b001 - F_CPU / 4, 0b010 - F_CPU / 8, 0b011 - F_CPU / 16)
    ; F_CPU / 2 = 8 MHz
    bres    SPI_CR1, #3 ;  BR0
    bres    SPI_CR1, #4 ;  BR1
    bres    SPI_CR1, #5 ;  BR2
    
    ; Internal slave select
    bset    SPI_CR2, #0 ; SPI_CR2_SSI
    ; Software slave management
    bset    SPI_CR2, #1 ; SPI_CR2_SSM

    ret
; ================================================


; ================================================
; подпрограмма передачи данных SPI
SPI_Transmit: ; данные в регистре A
    ld      SPI_DR, A
    call    SPI_Wait_RXNE
       
    ld      A, SPI_DR

    ret
; ================================================


; ================================================
; ожидание RXNE
SPI_Wait_RXNE: ; ждём пока бит RXNE не поднимится в 1
    btjf    SPI_SR, #0, SPI_Wait_RXNE ; RXNE = #0 -> if ( ( I2C_SR3 & (1 << RXNE) ) = 0 ) jmp SPI_Wait_RXNE

    ret
; ================================================


; ================================================
; SS = 0
SPI_Slave_Select: 
    bres    PA_ODR, #SS         ; PA_ODR &= ~(1 << SS)	

    ret
; ================================================


; ================================================
; SS = 1
SPI_Slave_Unselect: 
    bset    PA_ODR, #SS         ; PA_ODR |= (1 << SS)	

    ret
; ================================================


; ================================================
; begin Command
SPI_Begin_Command: 
    bres    PC_ODR, #DC         ; PC_ODR &= ~(1 << DC)	

    ret
; ================================================


; ================================================
; begin Data
SPI_Begin_Data: 
    bset    PC_ODR, #DC         ; PC_ODR |= (1 << DC)

    ret
; ================================================


; ================================================
; reset On
SPI_Reset_On: 
    bres    PC_ODR, #RES         ; PC_ODR |= (1 << RES)

    ret
; ================================================


; ================================================
; reset Off
SPI_Reset_Off: 
    bset    PC_ODR, #RES         ; PC_ODR |= (1 << RES)

    ret
; ================================================

    #endif ; _SPI_ASM_
