
; Светодиодная мигалка на микроконтроллере ATmega328p

;.INCLUDEPATH "E:\Libraries\AVR-master\asm\include" ; путь для подгрузки INC файлов 
.INCLUDE "m328Pdef.inc" ; загрузка предопределений для ATmega328p 
;.INCLUDE "E:\Libraries\AVR-master\asm\include\m328Pdef.inc" ; загрузка предопределений для ATmega328p 

.LIST ; включить генерацию листинга 
.CSEG ; начало сегмента кода 
.ORG 0x0000 ; начальное значение для адресации 

; -- инициализация стека -- 
LDI R16, Low(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
OUT SPL, R16 ; установка младшего байта указателя стека 
LDI R16, High(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
OUT SPH, R16 ; установка старшего байта указателя стека 

.equ Address = 0 ; адрес ячейки памяти в EEPROM
.equ Key = 127 ; устанавливаемое значение ячейки памяти в EEPROM
.equ Delay = 50 ; установка константы времени задержки 
.equ DelayFast = 10 ; быстрое мигание светодиода

; -- устанавливаем пин PB5 порта PORTB (PD) на вывод -- 
LDI R16, 0b00100000 ; поместим в регистр R16 число 32 (0x20) 
OUT DDRB, R16 ; загрузим значение из регистра R16 в порт DDRB 

; чтение данных из EEPROM, в регистр r16
LDI R18, 0 ; EEARH = 0
LDI R17, Address ; EEARL = Address
RCALL EEPROM_read ; вызов функции

LDI R20, 0 ; флаг задержки времени

LDI R19, Key ; записываем ключ в регистр для сравнения
CPSE R16, R19 ; сравниваем данные полученые из EEPROM с заданным ключём (Compare, Skip if Equal) пропустим следующую строку если значеия равны
RJMP Write ; прыжок до метки Write
LDI R20, 1 ; флаг задержки времени
RJMP Start ; прыжок до метки Start

; запись данных в EEPROM
Write:
	LDI R18, 0 ; EEARH = 0
	LDI R17, Address ; EEARL = Address
	LDI R16, Key ; EEDR = Key
	RCALL EEPROM_write

; -- основной цикл программы -- 
Start: 	
	SBI PORTB, PORTB5 ; подача на пин PB5 высокого уровня 
	RCALL Wait ; вызываем подпрограмму задержки по времени 
	CBI PORTB, PORTB5 ; подача на пин PB5 низкого уровня 
	RCALL Wait 
	RJMP Start ; возврат к метке Start, повторяем все в цикле 

; -- подпрограмма задержки по времени -- 
Wait: 
	LDI R17, 250 ; загрузка константы для задержки в регистр R20 (Load Immediate)
WLoop0: 
	LDI R18, Delay ; загружаем число 50 (0x32) в регистр R18 
	LDI R21, 0
	CPSE R21, R20 ; сравнение данных (Compare, Skip if Equal) пропустим следующую строку если значеия равны
	LDI R18, DelayFast ; иначе загружаем число 10 (0x0a) в регистр R18 
WLoop1: 
	LDI R19, 0xC8 ; загружаем число 200 (0xC8, $C8) в регистр R19 
WLoop2: 
	DEC R19 ; уменьшаем значение в регистре R19 на 1 
	BRNE WLoop2 ; возврат к WLoop2 если значение в R19 не равно 0 
	DEC R18 ; уменьшаем значение в регистре R18 на 1 
	BRNE WLoop1 ; возврат к WLoop1 если значение в R18 не равно 0 
	DEC R17 ; уменьшаем значение в регистре R17 на 1 
	BRNE WLoop0 ; возврат к WLoop0 если значение в R17 не равно 0 
ret ; возврат из подпрограммы Wait 

; -- функция записи данных в EEPROM -- 
EEPROM_write: ; адрес в r17-r18, а данные в r16
 	; Дождитесь завершения предыдущей записи
	sbic EECR,EEPE ; Skip if Bit in I/O Register Cleared
	rjmp EEPROM_write
	; Установите адрес (r18:r17) в регистре адресов
	out EEARH, r18 ; Out To I/O Location
	out EEARL, r17 ; Out To I/O Location
	; Запись данных (r16) в регистр данных
	out EEDR,r16 ; Out To I/O Location
	; Напишите логическую единицу в EEMPE
	sbi EECR,EEMPE ; Set Bit in I/O Register
	; Запустите запись в eeprom, установив EEPE
	sbi EECR,EEPE ; Set Bit in I/O Register
ret

; -- функция чтения данных из EEPROM -- 
EEPROM_read: ; адрес в r17-r18
	; Дождитесь завершения предыдущей записи
	sbic EECR,EEPE ; Skip if Bit in I/O Register Cleared
	rjmp EEPROM_read
	; Установите адрес (r18:r17) в регистре адресов
	out EEARH, r18 ; Out To I/O Location
	out EEARL, r17 ; Out To I/O Location
	; Запустите чтение eeprom, написав EERE
	sbi EECR,EERE ; Set Bit in I/O Register
	; Считывание данных из регистра данных
	in r16,EEDR ; In From I/O Location
ret


; Program_name: .DB "EEPROM Read-Write" 

