
; Тестирование Timer Counter 0 на микроконтроллере ATtiny85

.INCLUDE "../libs/tn85def.inc" ; загрузка предопределений для ATtiny85
#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 10000000		; Частота МК
	.equ 	DIVIDER					= 8
	.equ 	OCR0 					= F_CPU/DIVIDER/10000 ; количество тиков в 100 мкс (1секунду/10000)

;=================================================
	.def 	Counter					= R20			; регистр для временных данных
	.def 	Counter10				= R21			; регистр для временных данных (10 раз по 100 мкс)
	.def 	Null					= R22			; нулевой регистр
	
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
	.ORG 0x000A ; OC0Aaddr - Timer/Counter Compare Match A
		RJMP 	TIM0_COMPA_ISR
		
;=================================================
; Прерывание Таймера 0 по совпадению канала А
TIM0_COMPA_ISR: ; в R20 находится счётчик миллисекунд (0-255)
	push	R16
	mIN		R16, SREG
	CLI
	mOUT 	TCNT0, Null
	CPSE	Counter, Null 	; Compare, Skip if Equal
	RJMP	TC_Label_1
	RJMP	TC_Label_3
TC_Label_1:
	CPSE	Counter10, Null 	; Compare, Skip if Equal
	RJMP	TC_Label_2
	DEC		Counter
	LDI		Counter10, 10
	RJMP	TC_Label_3
TC_Label_2:
	DEC		Counter10 ; 
TC_Label_3:
	mOUT	SREG, R16
	pop	R16
RETI 

;=================================================
; Переменные во флеш памяти
; Program_name: .db "Test Timer Counter 0 on ATtiny85",0

;=================================================
; Подключение библиотек
#include "../libs/tim0a.asm"    ; подключение файла 'задержек'
#include "../libs/delay.asm"    ; подключение файла 'задержек'

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, R16 ; установка младшего байта указателя стека 
	LDI 	R16, High(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, R16 ; установка старшего байта указателя стека 

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
	; -- инициализация TimerCounter0 --
	RCALL	TimerCounter0_Init ; таймеру требуется OCR0

	LDI		Counter10, 10 ; взводим счётчик 10 раз по 100 мкс - что бы получить 1 мс

	; глобально разрешаем прерывания
	SEI

	; -- устанавливаем пин 1 порта B на выход -- 
	SBI 	DDRB, PB1
	
	; RJMP 	ERROR


;=================================================
; Основная программа (цикл)
Main:	
	SBI		PORTB, PB1
	LDI		Counter, 250
	RCALL	Wait
	CBI		PORTB, PB1
	LDI		Counter, 250
	RCALL	Wait

	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;=================================================


Wait:
	CPSE	Counter, Null ; Compare, Skip if Equal
	RJMP	Wait
ret


;=================================================
ERROR:
	CLI
loop_ERROR:
	SBI 	PORTB, PB1 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PB1 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc

	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

