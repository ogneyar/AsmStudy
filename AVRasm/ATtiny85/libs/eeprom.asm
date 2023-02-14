
#ifndef _EEPROM_ASM_
#define _EEPROM_ASM_

; #include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

;=================================================
; -- функция записи данных в EEPROM -- 
EEPROM_Write: ; адрес в ZL:ZH, а данные ожидаются в R16
    push    R18 ; save SREG
    push    R19 ; temp
loop_EEPROM_Write:
 	; Дождитесь завершения предыдущей записи
	SBIC 	EECR, EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	loop_EEPROM_Write
	; сохраняем статус регистры
	IN		R18, SREG
	; запрет прерываний
	CLI
	; Set Programming mode
	LDI R19, (0 << EEPM1) | (0 << EEPM0)
	OUT EECR, R19
	; Установите адрес (ZL:ZH) в регистре адресов
	OUT 	EEARH, ZH ; Out To I/O Location
	OUT 	EEARL, ZL ; Out To I/O Location
	; Запись данных (R16) в регистр данных
	OUT 	EEDR, R16 ; Out To I/O Location
	; Напишите логическую единицу в EEMPE (EEPROM Master Program Enable)
	SBI 	EECR, EEMPE ; Set Bit in I/O Register
	; Запустите запись в eeprom, установив EEPE
	SBI 	EECR, EEPE ; Set Bit in I/O Register
	; возвращяем статус регистры
	OUT	SREG, R18
    pop     R19
    pop     R18
ret

; -- функция чтения данных из EEPROM -- 
EEPROM_Read: ; адрес в ZL:ZH, данные возвращаются в регистре R16
	; Дождитесь завершения предыдущей записи
	SBIC 	EECR,EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_Read
	; Установите адрес (ZL:ZH) в регистре адресов
	OUT 	EEARH, ZH ; Out To I/O Location
	OUT 	EEARL, ZL ; Out To I/O Location
	; Запустите чтение eeprom, установив флаг EERE
	SBI 	EECR,EERE ; Set Bit in I/O Register
	NOP
	NOP
	; Считывание данных из регистра данных
	IN 		R16, EEDR ; In From I/O Location
ret
;=================================================

#endif  /* _EEPROM_ASM_ */
