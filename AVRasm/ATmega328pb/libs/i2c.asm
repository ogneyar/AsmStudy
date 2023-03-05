
#ifndef _I2C_ASM_
#define _I2C_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

; Example
; I2C_BaudDivider = ((XTAL/I2C_Frequency)-16)/2
; I2C_Frequency = 100000 ; 100KHz
; XTAL = 8000000 ; 8MHz

; передача данных через R16
; приём данных через R17

;=================================================
; -- функция инициализации I2C0 -- (ей требуется I2C_BaudDivider в R16) 
I2C_Init: 
	push	R17	
	CLR 	R17
	STS		TWSR0, R17 ; TWSR = 0 => prescaler = 1
	STS		TWBR0, R16 ; записываем I2C_BaudDivider

	SBI		DDRC, PORTC4 ; SDA0
	SBI		DDRC, PORTC5 ; SCK0

	SBI		PORTC, PORTC4
	SBI		PORTC, PORTC5
	pop		R17
ret

; I2C команда СТАРТ
I2C_Start: 
	push	R16 ; Temp1	
	LDI 	R16, (1 << TWINT) | (1 << TWEN) | (1 << TWSTA)
	STS		TWCR0, R16 ; TWSTA - команда СТАРТ
	RCALL 	I2C_Wait	
	pop		R16 ; Temp1	
ret

; I2C команда СТОП
I2C_Stop:
	push	R16 ; Temp1
	LDI 	R16, (1 << TWINT) | (1 << TWSTO) | (1 << TWEN)
	STS		TWCR0, R16 ; TWSTO - команда СТОП
I2C_Wait_TWSTO: ; wait until transmission completet
	LDS 	R16, TWCR0
	SBRC 	R16, TWSTO ; Skip if Bit in Register Clear
	RJMP 	I2C_Wait_TWSTO
	pop		R16 ; Temp1
ret

; I2C, ожидание снятия флага TWINT
I2C_Wait: ; wait until transmission completet
	LDS 	R16, TWCR0
	SBRS 	R16, TWINT ; Skip if Bit in Register Set
	RJMP 	I2C_Wait
ret
	
; I2C передача данных 
I2C_Write: ; ожидается что в R16 записаны данные
	push	R17 ; Temp1
	STS		TWDR0, R16 ; записываем данные	
	LDI 	R17, (1 << TWINT) | (1 << TWEN) 	
	STS		TWCR0, R17 ; отправляем данные
	RCALL 	I2C_Wait ; ждём окончания отправки
	pop		R17 ; Temp1
ret

; I2C приём данных
I2C_Read: ; данные будут возвращены через R17 
	push	R16 ; Temp1
	CPI 	Flag, 1 ; Ack
	BREQ	I2C_Read_Ack
	RJMP	I2C_Read_NoAck
I2C_Read_Ack:
	LDI 	R16, (1 << TWINT) | (1 << TWEN) | (1 << TWEA) ; TWEA - Enable Ack
	RJMP	End_I2C_Read
I2C_Read_NoAck:
	LDI 	R16, (1 << TWINT) | (1 << TWEN)
End_I2C_Read:
	STS		TWCR0, R16
	RCALL 	I2C_Wait
	LDS		R17, TWDR0
	pop		R16 ; Temp1
ret


; I2C передача адреса 
I2C_Write_Address: ; ожидается что в R16 записан адрес
	push	R16
	LSL 	R16 ; << (адрес на запись)
	; ORI 	R16, 0x01 ; | (адрес на чтение)
	;ANDI	R16, 0xff ; &
	RCALL 	I2C_Write ; передача адреса записанного в R16
	RCALL 	I2C_Wait
	pop		R16
ret


;=================================================

#endif  /* _I2C_ASM_ */

