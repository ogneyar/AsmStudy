
#ifndef _EEPROM_ASM_
#define _EEPROM_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

;=================================================
; -- Подпрограмма инициализации EEPROM -- 
EEPROM_Init:
    push    R16
	; for LGT8F328P -  1KB EEPROM emulation (uses 2KB of data in main Flash memory )
	LDI 	R16, 0x80
	mOUT 	0x56, R16 ; ECCR = 0x36 | 0x20
	LDI 	R16, 0x4C
	mOUT 	0x56, R16 ; ECCR = 0x36 | 0x20
    pop     R16
ret


; -- функция записи данных в EEPROM -- 
EEPROM_Write: ; адрес в ZL:ZH, а данные ожидаются в R16
    push    R17
 	; Дождитесь завершения предыдущей записи
	SBIC 	EECR, EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_write
	; сохраняем статус регистры
	mIN		R17, SREG
	; Установите адрес (ZL:ZH) в регистре адресов
	mOUT 	EEARH, ZH ; Out To I/O Location
	mOUT 	EEARL, ZL ; Out To I/O Location
	; Запись данных (r16) в регистр данных
	mOUT 	EEDR, r16 ; Out To I/O Location
	; запрет прерываний
	CLI
	; Напишите логическую единицу в EEMPE
	SBI 	EECR, EEMPE ; Set Bit in I/O Register
	; Запустите запись в eeprom, установив EEPE
	SBI 	EECR, EEPE ; Set Bit in I/O Register
	; возвращяем статус регистры
	mOUT	SREG, R19
    pop     R17
ret

; -- функция чтения данных из EEPROM -- 
EEPROM_Read: ; адрес в ZL:ZH, данные возвращаются в регистре R16
	; Дождитесь завершения предыдущей записи
	SBIC 	EECR,EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_read
	; Установите адрес (r18:r17) в регистре адресов
	mOUT 	EEARH, ZH ; Out To I/O Location
	mOUT 	EEARL, ZL ; Out To I/O Location
	; Запустите чтение eeprom, написав EERE
	SBI 	EECR,EERE ; Set Bit in I/O Register
	NOP
	NOP
	; Считывание данных из регистра данных
	mIN 	R16, EEDR ; In From I/O Location
ret
;=================================================

#endif  /* _EEPROM_ASM_ */
