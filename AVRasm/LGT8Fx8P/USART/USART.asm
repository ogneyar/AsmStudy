
; Светодиодная мигалка на микроконтроллере LGT8F328P 

.INCLUDE "../libs/lgt328Pdef.inc" ; загрузка предопределений для LGT8F328P 
#include "../libs/macro.inc" ; подключение файла с макросами

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 32000000 		; Частота МК
	.equ 	UART_BaudRate 			= 115200		; Скорость обмена по UART
	.equ 	UART_BaudDivider 		= (F_CPU/(8*UART_BaudRate)-1) ; (F_CPU/8/BAUD-1) при U2X0 в 1, (F_CPU/16/BAUD-1) при U2X0 в 0
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
; Подключение библиотек
#include "../libs/usart.asm"    ; подключение библиотеки USART (ей требуется UART_BaudDivider)

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	Temp, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, Temp ; установка младшего байта указателя стека 
	LDI 	Temp, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, Temp ; установка старшего байта указателя стека 
;==============================================================
; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		R16					; Очищаем R16
RAM_Flush:
	ST 		Z+, R16				
	CPI		ZH, HIGH(RAMEND+1)	
	BRNE	RAM_Flush			
	CPI		ZL, LOW(RAMEND+1)	
	BRNE	RAM_Flush
	LDI		ZL, (0x1F-2)			; Адрес регистра R29
	CLR		ZH
Reg_Flush:
	ST		Z, ZH
	DEC		ZL
	BRNE	Reg_Flush
	CLR		ZL
	CLR		ZH
;==============================================================
	; -- устанавливаем пин PB5 порта PORTB на вывод -- 
	;LDI 	Temp, 0b00100000 ; поместим в регистр R16 число 32 (0x20) 
	;OUT 	DDRB, Temp ; загрузим значение из регистра R16 в порт DDRB

	; -- инициализация USART --	
	LDI 	ZL, LOW(UART_BaudDivider)
	LDI 	ZH, HIGH(UART_BaudDivider)
	RCALL 	USART_Init 

	LDI 	R16, 0xd0
	RCALL	USART_Transmit

	LDI 	R16, 0x9f
	RCALL	USART_Transmit
	
	LDI 	R16, 0x20
	RCALL	USART_Transmit

	LDI 	R16, 0xd0
	RCALL	USART_Transmit

	LDI 	R16, 0x9f
	RCALL	USART_Transmit
	
	LDI 	R16, 0x20
	RCALL	USART_Transmit

	LDI 	R16, 0xd0
	RCALL	USART_Transmit

	LDI 	R16, 0x9f
	RCALL	USART_Transmit
	
	; вывод в порт приветствия
	; SETstr 	Hello_String
	; RCALL 	USART_Print_String

;=================================================
; Основная программа (цикл)
Start:
; 	RCALL 	USART_Receive
; 	; сравнение пришедших данных с \n и \r
; 	CPI 	USART_Data, 0xa ; NL (\n)
; 	BREQ	Start
; 	CPI 	USART_Data, 0xd ; CR (\r)
; 	BREQ	Start
; 	; сравнение пришедших данных с 0 и 1
; 	CPI 	USART_Data, '1'
; 	BREQ	Led_ON
; 	CPI 	USART_Data, '0'
; 	BREQ	Led_OFF
; 	RJMP	Continuation
; Led_ON:
; 	SBI 	PORTB, PORTB5 ; подача на пин PB5 высокого уровня 
; 	SETstr 	LedOn
; 	RCALL 	USART_Print_String
; 	RJMP	Continuation
; Led_OFF:
; 	CBI 	PORTB, PORTB5 ; подача на пин PB5 низкого уровня
; 	SETstr 	LedOff
; 	RCALL 	USART_Print_String
; Continuation:	
	RJMP Start ; возврат к метке Start, повторяем все в цикле 
;=================================================

