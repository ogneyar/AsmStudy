
; Светодиодная мигалка на микроконтроллере ATtiny2313A

.INCLUDE "../libs/tn2313Adef.inc" ; загрузка предопределений для ATtiny2313A 
#include "../libs/macro.inc" ; подключение файла с макросами

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 8000000		; Частота МК

;=================================================
; Имена регистров, а также различные константы
	.equ 	Address 				= 0 			; адрес ячейки памяти в EEPROM
	.equ 	Key 					= 127 			; устанавливаемое значение ячейки памяти в EEPROM
	.def 	Temp 					= R19 			; регистр для флага
	.def 	Flag 					= R20 			; регистр для флага

;=================================================	
	; .set 	Delay 					= 50 			; установка переменной времени задержки 

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
; Program_name: .db "EEPROM Read-Write on ATtiATtiny2313Any26",0

;=================================================
; Подключение библиотек
#include "../libs/eeprom.asm"
#include "../libs/delay.asm"

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI 	R16, Low(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
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
	; -- устанавливаем пин 0 порта B на выход -- 
	SBI		DDRB, PB0

	; чтение данных из EEPROM в регистр R17
	LDI  	R16, Address ; Address in R16
	RCALL 	EEPROM_Read ; вызов функции

	LDI 	Flag, 0 ; флаг задержки времени

	LDI 	Temp, Key ; записываем ключ в регистр для сравнения
	CPSE 	R17, Temp ; сравниваем данные полученые из EEPROM с заданным ключём (Compare, Skip if Equal) пропустим следующую строку если значеия равны
	RJMP 	Write ; прыжок до метки Write

	LDI 	Flag, 1 ; флаг задержки времени
	RJMP 	Start ; прыжок до метки Start

Write: ; запись данных в EEPROM
	LDI 	R16, Address ; Address in R16
	LDI 	R17, Key ; EEDR = Key
	RCALL 	EEPROM_write


;=================================================
; Основная программа (цикл)
Start: 	
	LDI		R16, 1
loop_Start:
	SBI 	PORTB, PB0 ; подача на пин PB0 высокого уровня 
	RCALL 	Delay_100ms
	CBI 	PORTB, PB0 ; подача на пин PB0 низкого уровня 
	CPSE	Flag, R16 ; R16 = 1
	RCALL 	Delay_500ms
	RCALL 	Delay_100ms

	RJMP 	loop_Start ; возврат к метке Start, повторяем все в цикле 
;=================================================

