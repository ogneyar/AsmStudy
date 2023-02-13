
; Тестирование Timer Counter 0 на микроконтроллере ATtiny13A

.INCLUDE "../libs/tn13Adef.inc" ; загрузка предопределений для ATtiny13A 
; #include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 9600000		; Частота МК
	.equ 	DIVIDER					= 64
	.equ 	OCR0 					= F_CPU/DIVIDER/1000 ; количество тиков в 1 мс (1секунду/1000)

;=================================================
	.def 	Temp1					= R20			; регистр для временных данных
	
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
	.ORG 0x0006 ; OC0Aaddr - Timer/Counter Compare Match A
		RJMP 	TIM0_COMPA
		
;=================================================
; Прерывание Таймера 0 по совпадению канала А
TIM0_COMPA: ; в R20 находится счётчик миллисекунд (0-255)
	push	R16
	push	R17
	IN		R17, SREG
	CLI
	CLR		R16
	OUT 	TCNT0, R16
	CPSE	R20, R16 	; Compare, Skip if Equal
	RJMP	TC_Label_1
	RJMP	TC_Label_2
TC_Label_1:
	DEC		R20
TC_Label_2:
	OUT	SREG, R17
	pop	R17
	pop	R16
RETI 

;=================================================
; Переменные во флеш памяти
Program_name: .db "Test Timer Counter 0 on ATtiny13A",0

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
	; LDI 	R16, High(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	; OUT 	SPH, R16 ; установка старшего байта указателя стека 

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
	; -- инициализация TimerCounter0 --
	LDI 	R17, OCR0
	RCALL	TimerCounter0_Init

	; глобально разрешаем прерывания
	SEI

	; -- устанавливаем пин 1 порта B на выход -- 
	SBI 	DDRB, PB1
	
	; RJMP 	ERROR


;=================================================
; Основная программа (цикл)
Main:	
	SBI		PORTB, PB1
	LDI		R20, 50
	RCALL	Wait
	CBI		PORTB, PB1
	LDI		R20, 250
	RCALL	Wait
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;=================================================


Wait:
	CLR		R16
	CPSE	R20, R16
	RJMP	Wait
ret


;=================================================
ERROR:
	SBI 	PORTB, PB1 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PB1 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	ERROR ; беЗконечный цикл
;=================================================

