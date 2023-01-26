
.include "m16def.inc"		; Use AtMega16A
;=================================================
; Имена регистров, а также различные константы
	.equ XTAL 				= 8000000 	; Частота МК
	.equ UART_BaudRate 		= 19200		; Скорость при связи по UART
	.equ UART_BaudDivider		= XTAL / (16 * UART_BaudRate) - 1
	.equ I2C_Frequency 		= 80000		; Частота шины I2C
	.equ I2C_BaudDivider 		= (XTAL / (8 * I2C_Frequency) - 2)
	.equ Bit0				= 0b00000001
	.equ Bit1				= 0b00000010
	.equ Bit2				= 0b00000100
	.equ Bit3				= 0b00001000
	.equ Bit4				= 0b00010000
	.equ Bit5				= 0b00100000
	.equ Bit6				= 0b01000000
	.equ Bit7				= 0b10000000
	.def MulLow 			= R0	; Младший регистр результата умножения
	.def MulHigh 			= R1	; Старший регистр результата умножения
	.def Temp0 			= R15	; Регистр с нулевым значением
	.def Temp1 			= R16
	.def Temp2 			= R17
	.def Temp3 			= R18
	.def Temp4 			= R19
	.def Temp5 			= R20
	.def Temp6 			= R21
	.def Temp7 			= R22
	.def Temp8 			= R23
	.def Counter 			= R24	; Регистр счетчик
	.def Flags 			= R25 	; Флаговый регистр

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
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; Инициализация стека
	LDI 	Temp1, LOW(RAMEND)
	OUT 	SPL, Temp1
	LDI 	Temp1, HIGH(RAMEND)	
	OUT 	SPH, Temp1
	; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ
	LDI		ZH, HIGH(SRAM_START)
	CLR		Temp1				; Очищаем R16
RAM_Flush:
	ST 		Z+, Temp1				
	CPI		ZH, HIGH(RAMEND + 1)	
	BRNE	RAM_Flush			
	CPI		ZL, LOW(RAMEND + 1)	
	BRNE	RAM_Flush
	LDI		ZL, (0x1F - 2)			; Адрес регистра R29
	CLR		ZH
Reg_Flush:
	ST		Z, ZH
	DEC		ZL
	BRNE	Reg_Flush
	CLR		ZL
	CLR		ZH
	; Регистры и SRAM полностью очищены
	; Но регистры ввода-вывода НЕОБХОДИМО очищать
	; Глобальный запрет прерываний
	CLI
