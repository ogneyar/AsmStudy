
; Светодиодная мигалка на микроконтроллере ATmega328p

.INCLUDE "m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "macro.inc" ; подключение файла с макросами

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 16000000 		; Частота МК
	.equ 	UART_BaudRate 			= 115200		; Скорость обмена по UART
	.equ 	UART_BaudDivider 		= F_CPU/8/UART_BaudRate-1 ; (F_CPU/8/x-1) при U2X0 в 1, (F_CPU/16/x-1) при U2X0 в 0
	.equ 	I2C_Frequency 			= 80000			; Частота шины I2C
	.equ 	I2C_BaudDivider 		= (F_CPU/(8*I2C_Frequency)-2)
;=================================================
	.def 	USART_Data				= R16			; регистр данных USART
	.def 	Temp					= R17			; регистр для временных данных
	.def 	Flag 					= R25 			; регистр для флага
;=================================================	
	.set 	Delay 					= 50 			; установка переменной времени задержки 
;=================================================
; Сегмент SRAM памяти
.DSEG			
;=================================================
; Сегмент EEPROM памяти
.ESEG
;=================================================
; Сегмент FLASH памяти
.CSEG
;=================================================
; Таблица прерываний
	.ORG 0x00
		RJMP	RESET

;=================================================
; Program_name: .db "USART Transmit-Reseive" 
Hello_String: 
	.db '\n',"Hello Чел!",'\n','\n'
	.db "Чтобы включить LED, пришли 1",'\n'
	.db "Чтобы погасить LED, пришли 0",'\n','\n',0
LedOn: .db "LED включен!",'\n','\n',0
LedOff: .db "LED погашен!",'\n','\n',0
;=================================================

; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	Temp, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, Temp ; установка младшего байта указателя стека 
	LDI 	Temp, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, Temp ; установка старшего байта указателя стека 

	; -- устанавливаем пин PB5 порта PORTB на вывод -- 
	LDI 	Temp, 0b00100000 ; поместим в регистр R16 число 32 (0x20) 
	OUT 	DDRB, Temp ; загрузим значение из регистра R16 в порт DDRB

	; -- инициализация USART --
	RCALL 	USART_Init 
	
	; вывод в порт приветствия
	SETstr 	Hello_String
	RCALL 	USART_Print_String

	; LDI 	Flag, 1 ; флаг

;=================================================
; Основная программа (цикл)
Start:
	RCALL 	USART_Receive
	; сравнение пришедших данных с \n и \r
	CPI 	USART_Data, 0xa ; NL (\n)
	BREQ	Start
	CPI 	USART_Data, 0xd ; CR (\r)
	BREQ	Start
	; сравнение пришедших данных с 0 и 1
	CPI 	USART_Data, '1'
	BREQ	Led_ON
	CPI 	USART_Data, '0'
	BREQ	Led_OFF
	RJMP	Continuation
Led_ON:
	SBI 	PORTB, PORTB5 ; подача на пин PB5 высокого уровня 
	SETstr 	LedOn
	RCALL 	USART_Print_String
	RJMP	Continuation
Led_OFF:
	CBI 	PORTB, PORTB5 ; подача на пин PB5 низкого уровня
	SETstr 	LedOff
	RCALL 	USART_Print_String
Continuation:	
	RJMP Start ; возврат к метке Start, повторяем все в цикле 
;=================================================


; -- функция инициализации USART -- 
USART_Init: ; r16 = ubrr & 0xff, r17 = (ubrr >> 8) & 0xff,  
	PUSH	R16
	PUSH	R17
	LDI 	R16, LOW(UART_BaudDivider) ; (UBRR & 0xff) ; 16 ;
	LDI 	R17, HIGH(UART_BaudDivider) ; ((UBRR >> 8) & 0xff) ; 0 ;
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
	POP		R17
	POP		R16
ret

; -- функция передачи данных -- 
USART_Transmit: ; data in r16
	PUSH	R17
wait_flag_UDRE0:
	; Wait for empty transmit buffer
	UIN 	R17, UCSR0A ; uin - macros из файла macro.inc
	SBRS 	R17, UDRE0 ; Skip if Bit in Register Set
	RJMP 	wait_flag_UDRE0
	POP		R17
	; Put data (r16) into buffer, sends the data
	UOUT 	UDR0, R16
ret

; -- функция приёма данных -- 
USART_Receive:
	PUSH	R17
wait_flag_RXC0:
	; Wait for data to be received
	UIN 	R17, UCSR0A
	SBRS 	R17, RXC0 ; Skip if Bit in Register Set
	RJMP	wait_flag_RXC0
	POP		R17
	; Get and return received data from buffer
	UIN 	R16, UDR0
ret

; -- функция вывода строки в порт -- 
USART_Print_String: ; use macro SETstr
	LPM		R16, Z+
	CPI		R16, 0
	BREQ	End_print
	RCALL 	USART_Transmit
	RJMP	USART_Print_String
End_print:
ret

