
#ifndef _EEPROM_ASM_
#define _EEPROM_ASM_

; #include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

;=================================================
; -- функция записи данных в EEPROM -- 
EEPROM_Write: ; адрес в R17, а данные ожидаются в R16
    push    R18 ; save SREG
    push    R19 ; temp
 	; Дождитесь завершения предыдущей записи
	SBIC 	EECR, EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_write
	; сохраняем статус регистры
	IN		R18, SREG

	; Set Programming mode
	LDI R19, (0 << EEPM1) | (0 << EEPM0)
	OUT EECR, R19

	; Установите адрес R17 в регистре адресов
	OUT 	EEARL, R17 ; Out To I/O Location
	; Запись данных (R16) в регистр данных
	OUT 	EEDR, R16 ; Out To I/O Location
	; запрет прерываний
	CLI
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
EEPROM_Read: ; адрес в R17, данные возвращаются в регистре R16
	; Дождитесь завершения предыдущей записи
	SBIC 	EECR,EEPE ; Skip if Bit in I/O Register Cleared
	RJMP 	EEPROM_read
	; Установите адрес R17 в регистре адресов
	OUT 	EEARL, R17 ; Out To I/O Location
	; Запустите чтение eeprom, написав EERE
	SBI 	EECR,EERE ; Set Bit in I/O Register
	NOP
	NOP
	; Считывание данных из регистра данных
	IN 	R16, EEDR ; In From I/O Location
ret
;=================================================

#endif  /* _EEPROM_ASM_ */
