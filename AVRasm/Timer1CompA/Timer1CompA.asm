
; Тестирование Timer Counter 1 на микроконтроллере ATmega328p

; разкомментируй строку ниже если используешь LGT8F328P
#define __LGT8F__ ; for LGT8F328P

.INCLUDE "../libs/m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
#ifdef __LGT8F__
	.equ 	F_CPU 					= 32000000		; Частота МК LGT8F328P
#else
	.equ 	F_CPU 					= 16000000		; Частота МК ATmega328p
#endif
	.equ 	DIVIDER					= 64
	.equ 	OCR1A 					= F_CPU/DIVIDER/1000 ; количество тиков в 1 мс (1секунду/1000)

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
	.ORG 0x00
		RJMP	RESET
	.ORG 0x16 					; OC1Aaddr
		RJMP 	TIMER1_COMPA
		
;=================================================
; Прерывание Таймера 1 по совпадению канала А
TIMER1_COMPA: ; в R20 находится счётчик миллисекунд (0-255)
	push	R16
	push	R17
	mIN		R17, SREG
	CLI
	CLR		R16
	mOUT 	TCNT1H, R16
	mOUT 	TCNT1L, R16
	CPSE	R20, R16 	; Compare, Skip if Equal
	RJMP	TC_Label_1
	RJMP	TC_Label_2
TC_Label_1:
	DEC		R20
TC_Label_2:
	; CBI		TIFR1, OCF1A
	mOUT	SREG, R17
	pop	R17
	pop	R16
RETI 

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	Temp1, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, Temp1 ; установка младшего байта указателя стека 
	LDI 	Temp1, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, Temp1 ; установка старшего байта указателя стека 

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
	; -- инициализация TimerCounter1 --
	RCALL	TimerCounter1_Init

	; глобально разрешаем прерывания
	SEI

	; -- устанавливаем пин 5 порта B на выход -- 
	LDI		Temp1, (1 << PORTB5)
	OUT 	DDRB, Temp1
	
	; RJMP 	ERROR


;=================================================
; Основная программа (цикл)
Main:	
	SBI		PORTB, PORTB5
	LDI		R20, 10
	RCALL	Wait
	CBI		PORTB, PORTB5
	LDI		R20, 90
	RCALL	Wait
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;=================================================


Wait:
	CLR		R16
	CPSE	R20, R16
	RJMP	Wait
ret


;=================================================
TimerCounter1_Init: ; Настраиваем таймеры
	; Разрешение прерывания таймера 1 по совпадению канала А 
	LDI 	R16, (1 << OCIE1A)
	mOUT 	TIMSK1, R16
	; Установка предделителя /64   ; CS12 CS11 CS10  -   1 0 1 - 1024, 1 0 0 - 256, 0 1 1 - 64, 0 1 0 - 8, 0 0 1 - 1
	LDI 	R16, (1 << CS11) | (1 << CS10) ; (1 << CS12) | ; 
	mOUT 	TCCR1B, R16 
	; Установка числа сравнения 15625=0x3D09 ((8000000/256)/2=15625 - 500 мсек. при Fcpu=8мГц) 
	; при Fcpu=32MHz 32000000/256=125000тиков в секунду, делим на 1000 = 125 тиков в милисекунду  - 1мс
	LDI 	R16, HIGH(OCR1A)
	mOUT 	OCR1AH, R16
	LDI 	R16, LOW(OCR1A)
	mOUT 	OCR1AL, R16
 	; Обнуление счетчика таймера 1
	CLR		R16
	mOUT 	TCNT1H, R16
	mOUT 	TCNT1L, R16
ret



;=================================================
ERROR:
	; mSetStr	ErrorStr
	; RCALL	USART_Print_String ; вывод сообщения в порт
loop_ERROR:
	SBI 	PORTB, PORTB5 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PORTB5 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

