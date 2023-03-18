
#ifndef _EEPROM_ASM_
#define _EEPROM_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

;=================================================
; -- функция записи данных в EEPROM -- 
EEPROM_Write: ; адрес в R16, а данные ожидаются в R17
    push    R18
loop_EEPROM_Write:
 	; Дождитесь завершения предыдущей записи
	SBIC 	EECR, EEWE ; Skip if Bit in I/O Register Cleared
	RJMP 	loop_EEPROM_Write
	; сохраняем статус регистры
	mIN		R18, SREG
	; Установите адрес (ZL:ZH) в регистре адресов
	mOUT 	EEAR, R16 ; Out To I/O Location
	; Запись данных (r16) в регистр данных
	mOUT 	EEDR, r17 ; Out To I/O Location
	; запрет прерываний
	CLI
	; Напишите логическую единицу в EEMWE: EEPROM Master Write Enabl
	SBI 	EECR, EEMWE ; Set Bit in I/O Register
	; Запустите запись в eeprom, установив EEWE: EEPROM Write Enable
	SBI 	EECR, EEWE ; Set Bit in I/O Register
	; возвращяем статус регистры
	mOUT	SREG, R18
    pop     R18
ret

; -- функция чтения данных из EEPROM -- 
EEPROM_Read: ; адрес в R16, данные возвращаются в регистре R17
	; Дождитесь завершения предыдущей записи
	SBIC 	EECR,EEWE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_read
	; Установите адрес (ZL:ZH) в регистре адресов
	mOUT 	EEAR, R16 ; Out To I/O Location
	; Запустите чтение eeprom, написав EERE: EEPROM Read Enable
	SBI 	EECR,EERE ; Set Bit in I/O Register
	NOP
	NOP
	; Считывание данных из регистра данных
	mIN 	R17, EEDR ; In From I/O Location
ret
;=================================================

#endif  /* _EEPROM_ASM_ */
