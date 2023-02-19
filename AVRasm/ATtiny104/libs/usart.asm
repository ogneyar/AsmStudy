
#ifndef _USART_ASM_
#define _USART_ASM_

#pragma AVRPART CORE NEW_INSTRUCTIONS lpm rd,z+

; Инициализация USART
USART_Init: ; в ZH:ZL ожидается UBRR
	push	R16
    ; Set baud rate to UBRR0
    out     UBRRH, ZH
    out     UBRRL, ZL
    ; Enable receiver and transmitter
    ldi     r16, (1 << RXEN) | (1 << TXEN)
    out     UCSRB, r16
    ; U2X0: Double the USART Transmission Speed
    ldi     r16, (1 << U2X)
    out     UCSRA, r16
	pop		R16
ret

; -- Подпрограмма передачи данных
USART_Transmit: ; в R16 ожидаются данныеR16
	push	R17
loop_USART_Transmit:
    ; Wait for empty transmit buffer
    in      r17, UCSRA
    sbrs    r17, UDRE
    rjmp    loop_USART_Transmit
    ; Put data (r16) into buffer, sends the data
    out     UDR, r16
	pop	    R17
ret

; -- Подпрограмма приёма данных -- 
USART_Receive: ; возвращает данные в регистр R16
	push	R17
wait_flag_RXC:
	; Wait for data to be received
	in 	    R17, UCSRA
	SBRS 	R17, RXC ; Skip if Bit in Register Set
	RJMP	wait_flag_RXC
	; принимаем данные
	in 	    R16, UDR
	pop		R17
ret

; -- Подпрограмма вывода строки в порт -- 
USART_Print_String: ; use macro mSetStr
	LPM		R16, Z+
	CPI		R16, 0
	BREQ	End_USART_Print_String
	RCALL 	USART_Transmit
	RJMP	USART_Print_String
End_USART_Print_String:
ret
;=================================================

#endif  /* _USART_ASM_ */
