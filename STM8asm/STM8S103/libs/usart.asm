
    #ifdef _USART_ASM_
    ; nothing
    #else
    #define _USART_ASM_ 1

    ; #define F_CPU       16000000
    ; #define BAUD        9600

    ; UART_DIV = F_CPU / BAUD = 16000000 / 9600 = 1667 = $0683
    #define UBRR        { F_CPU div BAUD }
    #define UBRR2       { { UBRR and $0f } or { { UBRR shr 8 } and $f0 } } ; #$03 
    #define UBRR1       { { UBRR shr 4 } and $ff } ; #$68
    ;
    ;       7     6     5     4     3     2     1     0
    ;     ----- ----- ----- ----- ----- ----- ----- -----
    ;    |  15 |  14 |  13 |  12 |  3  |  2  |  1  |  0  |  UART2_BRR2
    ;     ----- ----- ----- ----- ----- ----- ----- -----
    ;    |  11 |  10 |  9  |  8  |  7  |  6  |  5  |  4  |  UART2_BRR1
    ;     ----- ----- ----- ----- ----- ----- ----- -----


; ================================================
; инициализация UART1
UART_init:
    ; mov     CLK_CKDIVR, #0      ; делитель 1 - 16MHz (по умолчанию делитель 8 - 2MHz)
    bset    CLK_PCKENR1, #3 ; включить тактирование UART1 (PCKEN13 = #3)

    mov     UART1_BRR2, #UBRR2
    mov     UART1_BRR1, #UBRR1

    mov     UART1_CR2, #%00001100    ; [35 0C 52 35]    UART1_CR2.TEN <- 1  UART1_CR2.REN <- 1  разрешаем передачу/прием

    ret
; ================================================


; ================================================
; подпрограмма передача байта по UART
UART_transmit:
    ; mov    UART1_DR, #97
    ld      UART1_DR, A
wait_UART_transmit:
	btjf    UART1_SR, #7, wait_UART_transmit  ; skip if UART1_SR.TXE = 0 Transmit data register empty
    ret
; ================================================


; ================================================
; подпрограмма приёма байта по UART
UART_receive:
    btjf   UART1_SR, #5, UART_receive	; skip if UART1_SR.RXNE = 0 Read data register not empty
	ld     A, UART1_DR
    ret
; ================================================


; ================================================
; подпрограмма передачи числа по UART
UART_print_num: ; input parameter: X
    push    a
    ldw     y, sp
    push    #0
loop_UART_print_num:
    ld      a, #10
    div     x, a
    add     a, #$30
    push    a
    tnzw    x
    jrne    loop_UART_print_num
    ldw     x, sp
    incw    x
    call    UART_print_str
    ldw     sp, y
    pop     a

    ret
; ================================================


; ================================================
; подпрограмма передачи строки по UART
UART_print_str: ;  input parameter:  X 
    push    a
repeat_UART_print_str:
    ld      a,(x)
    jreq    exit_UART_print_str
wait_UART_print_str:
    btjf    UART1_SR, #7, wait_UART_print_str     ;wait if UART_DR is full yet (TXE == 0)
    ld      UART1_DR, a
    incw    x
    jra     repeat_UART_print_str
exit_UART_print_str:
    pop     a

    ret
; ================================================

    

    #endif ; _USART_ASM_
