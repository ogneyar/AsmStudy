stm8/
; usart.asm

    #include "../libs/STM8S103F.inc"

    segment byte at 9F00-9FFF 'usart'

; ================================================
; подпрограмма передача байта по UART
.UART_transmit:
    ; mov    UART1_DR, #97
    ld    UART1_DR, A
wait_UART_transmit:
	btjf   UART1_SR, #7, wait_UART_transmit  ; skip if UART1_SR.TXE = 0 Transmit data register empty
    ret
; ================================================


; ================================================
; подпрограмма приёма байта по UART
.UART_receive:
    btjf   UART1_SR, #5, UART_receive	; skip if UART1_SR.RXNE = 0 Read data register not empty
	ld     A, UART1_DR
    ret
; ================================================

	end
