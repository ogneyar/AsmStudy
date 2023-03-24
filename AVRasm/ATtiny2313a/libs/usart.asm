
#ifndef _USART_ASM_
#define _USART_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)
	
; Example
; UART_BaudDivider = (XTAL/8/UART_BaudRate-1)
; UART_BaudRate = 9600
; XTAL = 8000000 ; 8MHz

; инициализация через ZL:ZH
; передача и приём данных через R16 

;=================================================
; -- Подпрограмма инициализации USART -- 
USART_Init: ; UBRR in ZL:ZH
	push	R16
	push	R17
	; Set baud rate
	out 	UBRRH, ZH
	out 	UBRRL, ZL
	; U2X: Double the USART Transmission Speed
	ldi 	R16, (1<<U2X)
	out 	UCSRA, R16
	; Enable receiver and transmitter
	ldi 	R16, (1<<RXEN) | (1<<TXEN)
	out 	UCSRB, R16
	; Set frame format: 8data, 2stop bit
	ldi 	R16, (1<<USBS) | (3<<UCSZ0)
	out 	UCSRC, R16
	pop		R17
	pop		R16
ret

; -- Подпрограмма передачи данных -- 
USART_Transmit: ; data in r16
	push	R17
wait_flag_UDRE:
	; Wait for empty transmit buffer
	sbis 	UCSRA, UDRE
	rjmp 	wait_flag_UDRE
	; отправляем данные
	mOUT 	UDR, R16
	pop		R17
ret

; -- Подпрограмма приёма данных -- 
USART_Receive: ; возвращает данные в регистр R16
	push	R17
wait_flag_RXC:
	; Wait for data to be received
	sbis 	UCSRA, RXC
	rjmp 	wait_flag_RXC
	; принимаем данные
	mIN 	R16, UDR
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
