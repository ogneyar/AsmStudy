
; Тестирование EEPROM памяти на микроконтроллере ATmega328p

; разкомментируй строку ниже если используешь LGT8F328P
#define __LGT8F__ ; for LGT8F328P

.INCLUDE "../libs/m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "../libs/macro.inc" ; подключение файла с макросами

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
Program_name: .db "Test EEPROM Read-Write on ATmega328p/LGT8F328P",0

;=================================================
; Подключение библиотек
#include "../libs/eeprom.asm"
#include "../libs/delay.asm"

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI R16, Low(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT SPL, R16 ; установка младшего байта указателя стека 
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
	; -- устанавливаем пин PB5 порта B на выход -- 
	SBI		DDRB, PORTB5

	; Инициализация EEPROM
	RCALL	EEPROM_Init

	; чтение данных из EEPROM, в регистр r16
	LDI 	ZL, Address ; EEARL = Address
	LDI 	ZH, 0 ; EEARH = 0
	RCALL 	EEPROM_Read ; вызов функции

	LDI 	Flag, 0 ; флаг задержки времени

	LDI 	Temp, Key ; записываем ключ в регистр для сравнения
	CPSE 	R16, Temp ; сравниваем данные полученые из EEPROM с заданным ключём (Compare, Skip if Equal) пропустим следующую строку если значеия равны
	RJMP 	Write ; прыжок до метки Write
	LDI 	Flag, 1 ; флаг задержки времени
	RJMP 	Start ; прыжок до метки Start

Write: ; запись данных в EEPROM
	LDI 	ZH, 0 ; EEARH = 0
	LDI 	ZL, Address ; EEARL = Address
	LDI 	R16, Key ; EEDR = Key
	RCALL 	EEPROM_write


;=================================================
; Основная программа (цикл)
Start: 	
	SBI 	PORTB, PORTB5 ; подача на пин PB5 высокого уровня 
	RCALL 	Delay_100ms
	CBI 	PORTB, PORTB5 ; подача на пин PB5 низкого уровня 
	LDI		R16, 1
	CPSE	Flag, R16
	RCALL 	Delay_500ms
	RCALL 	Delay_100ms
	RJMP 	Start ; возврат к метке Start, повторяем все в цикле 
;=================================================


