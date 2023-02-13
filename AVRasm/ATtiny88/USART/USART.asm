
; Тестирование USART на микроконтроллере ATtiny88

.INCLUDE "../libs/tn88def.inc" ; загрузка предопределений для ATtiny88 
#include "../libs/macro.inc" ; подключение файла с макросами

; #define TxD      PD1
; #define PORT_TxD PORTD
; #define DDR_TxD  DDRD

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 16000000		; Частота МК
	.equ 	DIVIDER					= 8				; делитель
	.equ 	BAUD 					= 9600			; Скорость обмена по UART
	.equ 	UBRR 					= F_CPU/DIVIDER/BAUD-1

;=================================================
	.def 	Data					= R16			; регистр данных USART
	.def 	Temp					= R20			; регистр для временных данных
	.def 	Count 					= R21 			; регистр для флага
	.def 	Start 					= R22 			; регистр для флага
	.def 	Null 					= R23 			; регистр для флага
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
	.ORG 0x0000
		RJMP	RESET
		
;=================================================
; Переменные во флеш памяти
; Program_name: .db "Test USART Transmit-Reseive on ATtiny88",0
Hello_String: .db '\n',"Hello Bro!",'\n',"Are you fine?",'\n','\n',0

;=================================================
; Подключение библиотек
#include "../libs/usart.asm"    ; подключение библиотеки USART (ей требуется UBRR)
#include "../libs/delay.asm"

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI 	R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, R16 ; установка младшего байта указателя стека 
	LDI R16, High(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT SPH, R16 ; установка старшего байта указателя стека 

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
	; -- устанавливаем пин 0 порта D на выход -- 
	SBI 	DDRD, PD0 ;	

	; инициализация USART
	RCALL 	USART_Init
	
;=================================================
; Основная программа (цикл)
Main:	
	mSetStr Hello_String
	RCALL 	USART_Print_String

	SBI 	PORTD, PD0
	RCALL 	Delay_500ms
	CBI 	PORTD, PD0
	RCALL 	Delay_500ms

	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================

