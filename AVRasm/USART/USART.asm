
; Светодиодная мигалка на микроконтроллере ATmega328p

;.NOLIST ; Отключить генерацию листинга.

.INCLUDE "m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "macro.inc" ; подключение файла с макросами

;.LIST ; включить генерацию листинга
.CSEG ; начало сегмента кода 
.ORG 0x0000 ; начальное значение для адресации 

; -- инициализация стека -- 
LDI R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
OUT SPL, R16 ; установка младшего байта указателя стека 
LDI R16, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
OUT SPH, R16 ; установка старшего байта указателя стека 

;.SET Delay = 50 ; установка переменной времени задержки 

.EQU F_CPU = 16000000
.EQU BAUD = 115200
.EQU UBRR = F_CPU/8/BAUD-1 ; (F_CPU/8/x-1) при U2X0 в 1, (F_CPU/16/x-1) при U2X0 в 0


; -- устанавливаем пин PB5 порта PORTB на вывод -- 
LDI R16, 0b00100000 ; поместим в регистр R16 число 32 (0x20) 
OUT DDRB, R16 ; загрузим значение из регистра R16 в порт DDRB 

CBI PORTB, PORTB5 ; подача на пин PB5 низкого уровня 

;LDI R20, 1 ; флаг задержки времени

LDI R16, LOW(UBRR) ; (UBRR & 0xff) ; 16 ;
LDI R17, HIGH(UBRR) ; ((UBRR >> 8) & 0xff) ; 0 ;
RCALL USART_Init 
 

LDI r16, '\n'
RCALL USART_Transmit
LDI r16, 'H'
RCALL USART_Transmit
LDI r16, 'e'
RCALL USART_Transmit
LDI r16, 'l'
RCALL USART_Transmit
LDI r16, 'l'
RCALL USART_Transmit
LDI r16, 'o'
RCALL USART_Transmit
LDI r16, ' '
RCALL USART_Transmit
LDI r16, 'B'
RCALL USART_Transmit
LDI r16, 'r'
RCALL USART_Transmit
LDI r16, 'o'
RCALL USART_Transmit
LDI r16, '!'
RCALL USART_Transmit
LDI r16, '\n'
RCALL USART_Transmit
LDI r16, '\n'
RCALL USART_Transmit

LDI R20, 1 ; флаг

; -- основной цикл программы -- 
Start: 	
	; LDI r16, Test
	; RCALL USART_Transmit
	; INC r16
	; RCALL USART_Transmit
	; LDI r16, '\n'
	; RCALL USART_Transmit
_one:
	RCALL USART_Receive
	LDI R21, 0
	CPSE R21, R20
	RJMP _two
	LDI R20, 1 ; флаг
	RJMP _one
_two:
	LDI R20, 0 ; флаг
	SBI PORTB, PORTB5 ; подача на пин PB5 высокого уровня 	
	LDI R21, '1'
	CPSE R21, R16
	CBI PORTB, PORTB5 ; подача на пин PB5 низкого уровня 

	RCALL USART_Transmit
	LDI r16, '\n'
	RCALL USART_Transmit

	LDI r16, '\n'
	RCALL USART_Transmit
	LDI r16, 'O'
	RCALL USART_Transmit
	LDI r16, 'k'
	RCALL USART_Transmit
	LDI r16, '\n'
	RCALL USART_Transmit
	LDI r16, '\n'
	RCALL USART_Transmit
	
RJMP Start ; возврат к метке Start, повторяем все в цикле 


; -- функция инициализации USART -- 
USART_Init: ; r16 = ubrr & 0xff, r17 = (ubrr >> 8) & 0xff,  
	; Set baud rate to UBRR0
	uout UBRR0L, r16 ; uout - macros из файла macro.inc
	uout UBRR0H, r17 
	ldi r16, (1 << U2X0)
	uout UCSR0A, r16	
	; Enable receiver and transmitter
	ldi r16, (1 << RXEN0) | (1 << TXEN0)
	uout UCSR0B, r16	
	; UPM01 - Enabled, Even Parity
	ldi r16, (1 << UCSZ01) | (1 << UCSZ00) ; (1 << UPM01) | 
	uout UCSR0C, r16
ret

; -- функция передачи данных -- 
USART_Transmit: ; data in r16
	; Wait for empty transmit buffer
	;uin r17, UCSR0A ; uin - macros из файла macro.inc
	;sbrs r17, UDRE0 ; Skip if Bit in Register Set
	SBIS	UCSR0A, UDRE0
	RJMP 	USART_Transmit
	; Put data (r16) into buffer, sends the data
	uout UDR0, r16
ret

; -- функция приёма данных -- 
USART_Receive:
	; Wait for data to be received
	;uin r17, UCSR0A
	;sbrs r17, RXC0 ; Skip if Bit in Register Set
	SBIS	UCSRA, RXC
	RJMP	USART_Receive
	; Get and return received data from buffer
	uin r16, UDR0
ret


; Program_name: .DB "USART Transmit-Reseive" 
Test: .DB "Test"

