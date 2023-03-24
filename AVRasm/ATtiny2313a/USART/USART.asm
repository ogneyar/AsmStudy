
; Тестирование USART на микроконтроллере ATtiny2313A

.INCLUDE "../libs/tn2313Adef.inc" ; загрузка предопределений для ATtiny2313A 
#include "../libs/macro.inc" ; подключение файла с макросами

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 8000000		; Частота МК
	.equ 	DIVIDER					= 8				; 8 при U2X0 = 1, 16 при U2X0 = 0
	.equ 	BAUD 					= 9600			; Скорость обмена по UART
	.equ 	UART_BaudDivider		= F_CPU/DIVIDER/BAUD-1

;=================================================
	.def 	USART_Data				= R16			; регистр данных USART
	.def 	Temp					= R17			; регистр для временных данных
	.def 	Flag 					= R25 			; регистр для флага

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
; Переменные во флеш памяти
; Program_name: .db "Test USART Transmit-Reseive on ATtiny2313A",0
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

;=================================================
	; -- инициализация стека -- 
	LDI 	Temp, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	mOUT 	SPL, Temp ; установка младшего байта указателя стека 
	; LDI 	Temp, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	; mOUT 	SPH, Temp ; установка старшего байта указателя стека 

;==============================================================
; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		R16					; Очищаем R16
RAM_Flush:
	ST 		Z+, R16				
	; CPI		ZH, HIGH(RAMEND+1)	
	; BRNE	RAM_Flush			
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
	; -- устанавливаем пин 0 порта B на выход -- 
	SBI		DDRB, PB0

	; -- инициализация USART --	
	mSetZ	UART_BaudDivider
	RCALL 	USART_Init 
	
	; вывод в порт приветствия
	mSetStr	Hello_String
	RCALL 	USART_Print_String

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
	SBI 	PORTB, PB0 ; подача на пин PB0 высокого уровня 
	mSetStr LedOn
	RCALL 	USART_Print_String
	RJMP	Continuation
Led_OFF:
	CBI 	PORTB, PB0 ; подача на пин PB0 низкого уровня
	mSetStr LedOff
	RCALL 	USART_Print_String
Continuation:	
	RJMP Start ; возврат к метке Start, повторяем все в цикле 
;=================================================

