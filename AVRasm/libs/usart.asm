
	
; Example
; UART_BaudDivider = (XTAL/8/UART_BaudRate-1)
; UART_BaudRate = 9600
; XTAL = 16000000 ; 16MHz

; инициализация через R16 и R17 (в R16 - младший байт UART_BaudDivider, в R17 - старший байт UART_BaudDivider)
; передача и приём данных через R16 

;=================================================
; -- Подпрограмма инициализации USART -- 
USART_Init: ; r16 = ubrr & 0xff, r17 = (ubrr >> 8) & 0xff,  
	push	R16
	push	R17
	; Set baud rate to UBRR0
	UOUT 	UBRR0L, R16 ; uout - macros из файла macro.inc
	UOUT 	UBRR0H, R17 
	LDI 	R16, (1 << U2X0)
	UOUT 	UCSR0A, R16	
	; Enable receiver and transmitter
	LDI 	R16, (1 << RXEN0) | (1 << TXEN0)
	UOUT 	UCSR0B, R16	
	; UPM01 - Enabled, Even Parity
	LDI 	R16, (1 << UCSZ01) | (1 << UCSZ00) ; (1 << UPM01) | 
	UOUT 	UCSR0C, R16
	pop		R17
	pop		R16
ret

; -- Подпрограмма передачи данных -- 
USART_Transmit: ; data in r16
	push	R17
wait_flag_UDRE0:
	; Wait for empty transmit buffer
	UIN 	R17, UCSR0A ; uin - macros из файла macro.inc
	SBRS 	R17, UDRE0 ; Skip if Bit in Register Set
	RJMP 	wait_flag_UDRE0
	pop		R17
	; отправляем данные
	UOUT 	UDR0, R16
ret

; -- Подпрограмма приёма данных -- 
USART_Receive: ; возвращает данные в регистр R16
	push	R17
wait_flag_RXC0:
	; Wait for data to be received
	UIN 	R17, UCSR0A
	SBRS 	R17, RXC0 ; Skip if Bit in Register Set
	RJMP	wait_flag_RXC0
	pop		R17
	; принимаем данные
	UIN 	R16, UDR0
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

