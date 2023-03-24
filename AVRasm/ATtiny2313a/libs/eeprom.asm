
#ifndef _EEPROM_ASM_
#define _EEPROM_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

;=================================================
; -- функция записи данных в EEPROM -- 
EEPROM_Write: ; адрес в R16, а данные ожидаются в R17
    push    R18 ; sreg save
    push    R19 ; temp data
loop_EEPROM_Write:
 	; Дождитесь завершения предыдущей записи
	SBIC 	EECR, EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	loop_EEPROM_Write
	; Set Programming mode
	ldi 	R19, (0 << EEPM1) | (0 << EEPM0)
	out 	EECR, R19
	; сохраняем статус регистры
	mIN		R18, SREG
	; Установите адрес (R16) в регистре адресов
	out 	EEAR, R16
	; Запись данных (R17) в регистр данных
	out 	EEDR, R17 ; Out To I/O Location
	; запрет прерываний
	CLI
	; Напишите логическую единицу в EEMPE
	SBI 	EECR, EEMPE
	; Запустите запись в eeprom, установив EEPE
	SBI 	EECR, EEPE ; Set Bit in I/O Register
	; возвращяем статус регистры
	out		SREG, R18
    pop     R19
    pop     R18
ret

; -- функция чтения данных из EEPROM -- 
EEPROM_Read: ; адрес в R16, данные возвращаются в регистре R17
	; Дождитесь завершения предыдущей записи
	SBIC 	EECR,EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_read
	; Установите адрес (R16) в регистре адресов
	out 	EEAR, R16
	; Запустите чтение eeprom, написав EERE: EEPROM Read Enable
	SBI 	EECR, EERE ; Set Bit in I/O Register
	NOP
	; Считывание данных из регистра данных
	in 	R17, EEDR ; In From I/O Location
ret
;=================================================

#endif  /* _EEPROM_ASM_ */
