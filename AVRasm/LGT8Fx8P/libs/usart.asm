
	
; Example
; UART_BaudDivider = (XTAL/8/UART_BaudRate-1) ; (F_CPU/8/BAUD-1) при U2X0 в 1, (F_CPU/16/BAUD-1) при U2X0 в 0
; UART_BaudRate = 115200
; XTAL = 32000000 ; 32MHz

; инициализация через R16 и R17 (в R16 - младший байт UART_BaudDivider, в R17 - старший байт UART_BaudDivider)
; передача и приём данных через R16 

;=================================================
; -- Подпрограмма инициализации USART -- 
USART_Init: ; r16 = ubrr & 0xff, r17 = (ubrr >> 8) & 0xff,  
	push	ZL
	push	ZH
	; Set baud rate to UBRR0
	UOUT 	UBRR0L, ZL ; uout - macros из файла macro.inc
	UOUT 	UBRR0H, ZH 
	LDI 	ZL, (1 << U2X0)
	UOUT 	UCSR0A, ZL	
	; Enable receiver and transmitter	
	LDI 	ZL, (1 << RXEN0) | (1 << TXEN0)
	UOUT 	UCSR0B, ZL	
	; UPM01 - Enabled, Even Parity
	; LDI 	ZL, (1 << UCSZ01) | (1 << UCSZ00) | (1 << UPM01)  
	; UOUT 	UCSR0C, ZL
	pop		ZH
	pop		ZL
ret

; -- Подпрограмма передачи данных -- 
USART_Transmit: ; data in r16
	push	R17
wait_flag_UDRE0:
	; Wait for empty transmit buffer
	UIN 	R17, UCSR0A ; uin - macros из файла macro.inc
	SBRS 	R17, UDRE0 ; Skip if Bit in Register Set
	RJMP 	wait_flag_UDRE0
	; отправляем данные
	UOUT 	UDR0, R16
	pop		R17
ret

; -- Подпрограмма приёма данных -- 
USART_Receive: ; возвращает данные в регистр R16
	push	R17
wait_flag_RXC0:
	; Wait for data to be received
	UIN 	R17, UCSR0A
	SBRS 	R17, RXC0 ; Skip if Bit in Register Set
	RJMP	wait_flag_RXC0
	; принимаем данные
	UIN 	R16, UDR0
	pop		R17
ret

; -- Подпрограмма вывода строки в порт -- 
USART_Print_String: ; use macro SETstr
	LPM		R16, Z+
	CPI		R16, 0
	BREQ	End_USART_Print_String
	RCALL 	USART_Transmit
	RJMP	USART_Print_String
End_USART_Print_String:
ret
;=================================================

