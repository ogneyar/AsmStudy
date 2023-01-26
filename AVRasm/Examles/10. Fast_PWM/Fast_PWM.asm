;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
	.include "./lib/m16def.inc"		; Программа под ATmega16A
;=================================================
; Имена регистров, а также различные константы
	.equ 	XTAL 					= 8000000 		; Частота МК
	.equ 	UART_BaudRate 			= 19200			; Скорость обмена по UART
	.equ 	UART_BaudDivider 		= XTAL/(16*UART_BaudRate)-1
	.equ 	I2C_Frequency 			= 80000			; Частота шины I2C
	.equ 	I2C_BaudDivider 		= (XTAL/(8*I2C_Frequency)-2)
	.equ	Bit0					= 0b00000001
	.equ	Bit1					= 0b00000010
	.equ	Bit2					= 0b00000100
	.equ	Bit3					= 0b00001000
	.equ	Bit4					= 0b00010000
	.equ	Bit5					= 0b00100000
	.equ	Bit6					= 0b01000000
	.equ	Bit7					= 0b10000000
	.equ	SYMBOL_MINUS 			= 0b01000000 	; Значок минуса
	.equ	SYMBOL_POINT 			= 0b10000000 	; Значок точки
	.equ	DisplayDelay			= 50			; Задержка для динамической индикации
	.def 	MulLow 					= R0			; Младший регистр результата умножения
	.def 	MulHigh 				= R1			; Старший регистр результата умножения
	.def 	Temp0 					= R15			; Регистр с нулевым значением
	.def 	Temp1 					= R16
	.def 	Temp2 					= R17
	.def 	Temp3 					= R18
	.def 	Temp4 					= R19
	.def 	Temp5 					= R20
	.def 	Temp6 					= R21
	.def 	Temp7 					= R22
	.def 	Temp8 					= R23
	.def 	Counter 				= R24			; Счетный регистр
	.def 	Flags 					= R25 			; Флаговый регистр
;=================================================
	.equ	PwmPORT					= PORTD
	.equ	PwmDDR					= DDRD
	.equ	PwmChA					= 5
	.equ	PwmChB					= 4
	.equ	BtnPORT					= PORTC
	.equ	BtnPIN					= PINC
	.equ	BtnDDR					= DDRC
	.equ	BtnChAup				= 2
	.equ	BtnChAdown				= 3
	.equ	BtnChBup				= 4
	.equ	BtnChBdown				= 5
	.equ	TimerDelay				= 100
	.equ	DeltaChA				= 10
	.equ	DeltaChB				= 5	
;=================================================
; Сегмент SRAM памяти
.DSEG
	Digits:  			.byte		4					
;=================================================
; Сегмент EEPROM памяти
.ESEG
	eDigits:  			.byte		4					
;=================================================
; Сегмент FLASH памяти
.CSEG
;=================================================
; Таблица прерываний
	.ORG 0x00
		RJMP	RESET		
	.ORG 0x0C
		RJMP 	TIMER1_COMPA	
	.ORG 0x26
		RJMP 	TIMER0_COMP
;=================================================
; Прерывание Таймера 1 по совпадению канала А
TIMER1_COMPA:
RETI
; Прерывание Таймера 0 по совпадению
TIMER0_COMP:
	OUT  	TCNT0, Temp0
	IN		Temp3, OCR1AL
	IN  	Temp1, OCR1AH
	IN		Temp4, OCR1BL
	IN  	Temp1, OCR1BH
; Проверяем кнопку Up канала А
T0_CheckChAup:
	SBIC 	BtnPIN, BtnChAup
	INC 	Temp5
	SBIS 	BtnPIN, BtnChAup
	CLR 	Temp5
	CPI 	Temp5, TimerDelay
	BRLO 	T0_CheckChAdown
	LDI		Temp1, DeltaChA
	ADD		Temp3, Temp1
	CLR 	Temp5
T0_CheckChAdown:
	SBIC 	BtnPIN, BtnChAdown
	INC 	Temp6
	SBIS 	BtnPIN, BtnChAdown
	CLR 	Temp6
	CPI 	Temp6, TimerDelay
	BRLO 	T0_CheckChBup
	LDI		Temp1, DeltaChA
	SUB		Temp3, Temp1
	CLR 	Temp6
T0_CheckChBup:
	SBIC 	BtnPIN, BtnChBup
	INC 	Temp7
	SBIS 	BtnPIN, BtnChBup
	CLR 	Temp7
	CPI 	Temp7, TimerDelay
	BRLO 	T0_CheckChBdown
	LDI		Temp1, DeltaChB
	ADD		Temp4, Temp1
	CLR 	Temp7
T0_CheckChBdown:
	SBIC 	BtnPIN, BtnChBdown
	INC 	Temp8
	SBIS 	BtnPIN, BtnChBdown
	CLR 	Temp8
	CPI 	Temp8, TimerDelay
	BRLO 	T0_Next
	LDI		Temp1, DeltaChB
	SUB		Temp4, Temp1
	CLR 	Temp8
T0_Next:
	OUT 	OCR1AH, Temp0
	OUT 	OCR1AL, Temp3
	OUT 	OCR1BH, Temp0
	OUT 	OCR1BL, Temp4
RETI
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; Инициализация стека
	LDI 	Temp1, LOW(RAMEND)
	OUT 	SPL, Temp1
	LDI 	Temp1, HIGH(RAMEND)	
	OUT 	SPH, Temp1
	; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		Temp1					; Очищаем R16
RAM_Flush:
	ST 		Z+, Temp1				
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
	; Регистры и SRAM полностью очищены (обнулены)
	; Но регистры ввода-вывода (IO) НАДО очищать
	; Глобальный запрет прерываний
	CLI
	; Настраиваем порты ввода-вывода
	LDI 	Temp1, (1<<PwmChA)|(1<<PwmChB)
	OUT 	PwmDDR, Temp1
	OUT 	PwmPORT, Temp1
	LDI		Temp1, (0<<BtnChAup)|(0<<BtnChAdown)|(0<<BtnChBup)|(0<<BtnChBdown)
	OUT 	BtnDDR, Temp1
	OUT 	BtnPORT, Temp1
	; Настраиваем таймеры
	; Настраиваем ШИМ на оба канала Таймера 1
	LDI 	Temp1, (2<<COM1A0)|(2<<COM1B0)|(0<<WGM11)|(1<<WGM10)
	OUT		TCCR1A, Temp1
	LDI 	Temp1, (0<<WGM13)|(1<<WGM12)|(1<<CS10)
	OUT		TCCR1B, Temp1
 	; Обнуляем счетчик
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0 
	; Настраиваем Таймер 0 для обработки кнопок
	LDI 	Temp1, (1<<OCIE0)
	OUT 	TIMSK, Temp1
	LDI	 	Temp1, (0<<CS02)|(1<<CS01)|(1<<CS00)
	OUT  	TCCR0, Temp1
	; Число сравнения - при делителе 64 - получим 1 мс
	LDI 	Temp1, 0x7D
	OUT  	OCR0, Temp1
	; Обнуляем счетчик
	OUT  	TCNT0, Temp0
	; Настраиваем ШИМ канала А
	OUT		OCR1AH, Temp0
	LDI		Temp1, 0x00
	OUT		OCR1AL, Temp1
	; Настраиваем ШИМ канала B
	OUT		OCR1BH, Temp0
	LDI		Temp1, 0x80
	OUT		OCR1BL, Temp1
	; Разрешаем прерывания
	SEI
;=================================================
; Основная программа (цикл)
Main:
	; Цикл выполняется сначала
	RJMP	Main
;=================================================


