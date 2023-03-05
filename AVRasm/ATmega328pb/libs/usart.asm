
#ifndef _USART_ASM_
#define _USART_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)
	
; Example
; UART_BaudDivider = (XTAL/8/UART_BaudRate-1)
; UART_BaudRate = 9600
; XTAL = 8000000 ; 8MHz

; инициализация через R16 и R17 (в R16 - младший байт UART_BaudDivider, в R17 - старший байт UART_BaudDivider)
; передача и приём данных через R16 

;=================================================
; -- Подпрограмма инициализации USART -- 
USART_Init: ; r16 = ubrr & 0xff, r17 = (ubrr >> 8) & 0xff,  
	push	R16
	push	R17
	push	R18
	; Set baud rate to UBRR0
	mOUT 	UBRR0L, R16 ; mOUT - macros из файла macro.inc
	mOUT 	UBRR0H, R17 
	LDI 	R16, (1 << U2X0)
	mOUT 	UCSR0A, R16	
	; Enable receiver and transmitter
	LDI 	R16, (1 << RXEN0) | (1 << TXEN0)
	mOUT 	UCSR0B, R16	
	; UPM01 - Enabled, Even Parity
	LDI 	R16, (1 << UCSZ01) | (1 << UCSZ00) ; (1 << UPM01) | 
	mOUT 	UCSR0C, R16
	pop		R18
	pop		R17
	pop		R16
ret

; -- Подпрограмма передачи данных -- 
USART_Transmit: ; data in r16
	push	R17
wait_flag_UDRE0:
	; Wait for empty transmit buffer
	mIN 	R17, UCSR0A ; mIN - macros из файла macro.inc
	SBRS 	R17, UDRE0 ; Skip if Bit in Register Set
	RJMP 	wait_flag_UDRE0
	pop		R17
	; отправляем данные
	mOUT 	UDR0, R16
ret

; -- Подпрограмма приёма данных -- 
USART_Receive: ; возвращает данные в регистр R16
	push	R17
wait_flag_RXC0:
	; Wait for data to be received
	mIN 	R17, UCSR0A
	SBRS 	R17, RXC0 ; Skip if Bit in Register Set
	RJMP	wait_flag_RXC0
	pop		R17
	; принимаем данные
	mIN 	R16, UDR0
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
