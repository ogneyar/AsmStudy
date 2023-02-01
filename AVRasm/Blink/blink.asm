
; Светодиодная мигалка на микроконтроллере ATmega328p

;.INCLUDEPATH "E:\Libraries\AVR-master\asm\include" ; путь для подгрузки INC файлов 
.INCLUDE "..\libs\m328Pdef.inc" ; загрузка предопределений для ATmega328p 
;.INCLUDE "E:\Libraries\AVR-master\asm\include\m328Pdef.inc" ; загрузка предопределений для ATmega328p 

.LIST ; включить генерацию листинга 
.CSEG ; начало сегмента кода 
.ORG 0x0000 ; начальное значение для адресации 

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
.equ Delay = 250 ; установка константы времени задержки 

; -- устанавливаем пин PB5 порта PORTB на выход -- 
LDI R16, 0b00100000 ; поместим в регистр R16 число 32 (0x20) 
OUT DDRB, R16 ; загрузим значение из регистра R16 в порт DDRB 

; -- основной цикл программы -- 
Start: 	
	SBI PORTB, PORTB5 ; подача на пин PB5 высокого уровня 
	RCALL Wait ; вызываем функцию задержки по времени 
	CBI PORTB, PORTB5 ; подача на пин PB5 низкого уровня 
	RCALL Wait ; вызываем функцию задержки по времени 	
RJMP Start ; возврат к метке Start, повторяем все в цикле 

; -- подпрограмма задержки по времени -- 
Wait: 
	LDI R17, Delay ; загрузка константы для задержки в регистр R17 
	WLoop0: LDI R18, 50 ; загружаем число 50 (0x32) в регистр R18 
	WLoop1: LDI R19, 0xC8 ; загружаем число 200 (0xC8, $C8) в регистр R19 
	WLoop2: DEC R19 ; уменьшаем значение в регистре R19 на 1 
	BRNE WLoop2 ; возврат к WLoop2 если значение в R19 не равно 0 
	DEC R18 ; уменьшаем значение в регистре R18 на 1 
	BRNE WLoop1 ; возврат к WLoop1 если значение в R18 не равно 0 
	DEC R17 ; уменьшаем значение в регистре R17 на 1 
	BRNE WLoop0 ; возврат к WLoop0 если значение в R17 не равно 0 
RET ; возврат из подпрограммы Wait 

; Program_name: .DB "LEDs blink" 
