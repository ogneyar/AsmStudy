;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
	.include "m16def.inc"		; Программа под ATmega16A
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
	.equ	LedDDR					= DDRA
	.equ	LedPORT					= PORTA	
	.equ	BtnPORT					= PORTD
	.equ	BtnPIN					= PIND
	.equ	BtnDDR					= DDRD
	.equ	BtnStop					= 2		
	.equ	BtnDelay				= 100	
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
	CLI
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	CPI 	Temp3, 255 ; Compare with Immediate
	BREQ 	LeftToRight ; Branch if Equal (переход к метке если равны предыдущие значения) флаг Zero в HIGH
	CPI 	Temp3, 0
	BREQ 	RightToLeft ; Branch if Equal
	RJMP 	Timer1Out
LeftToRight: 
	LSR 	Temp2 ; Logical Shift Right (Temp2 >> 1)
	CPI 	Temp2, 0b00000001              
	BREQ 	ChangeDirection		
	RJMP 	Timer1Out       
RightToLeft: 
	LSL 	Temp2 ; Logical Shift Left (Temp2 << 1)
	CPI 	Temp2, 0b10000000           
	BREQ 	ChangeDirection ; Branch if Equal
	RJMP 	Timer1Out 
ChangeDirection:
	COM 	Temp3 ; One’s Complement (Rd < $FF - Rd) Temp3 = 0xFF - Temp3
Timer1Out:  
	OUT 	LedPORT, Temp2
RETI 
; Прерывание Таймера 0 по совпадению
TIMER0_COMP: ; Temp4 - счётчик, BtnDelay - защита от дребезга контактов
	OUT  	TCNT0, Temp0
	SBIC 	BtnPIN, BtnStop ; Skip if Bit in I/O Register Cleared (если кнопка отпущена пропустить строку ниже)
	INC 	Temp4
	SBIS 	BtnPIN, BtnStop ; Skip if Bit in I/O Registerr Set (если кнопка нажата пропустить строку ниже)
	CLR		Temp4
	CPI 	Temp4, BtnDelay ; Compare with Immediate
	BRLO 	Timer0Out ; Branch if Lower (переход к метке, если был перенос (флаг переноса Carry в HIGH)) если Temp4 < BtnDelay
	CLR		Temp4
	RCALL 	ChangeInt ; Вызов функции
Timer0Out:
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
	LDI 	Temp1, 0xFF
	OUT 	LedDDR, Temp1
	CBI 	BtnDDR, BtnStop
	; Настраиваем таймеры
	; Разрешение прерывания таймера 1 по совпадению канала А и таймера 0
	LDI 	Temp1, (1<<OCIE1A)|(1<<OCIE0)
	OUT 	TIMSK, Temp1
	; Установка предделителя /256
	LDI 	Temp1, (1<<CS12)
	OUT 	TCCR1B, Temp1 
	; Установка числа сравнения 15625=0x3D09 ((8000000/256)/2=15625 - 500 мсек. при Fcpu=8мГц) 
	LDI 	XH, HIGH(0x3D09)
	OUT 	OCR1AH, XH
	LDI 	XL, LOW(0x3D09)
	OUT 	OCR1AL, XL
 	; Обнуление счетчика таймера 1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; Настраиваем Таймер 0 для обработки кнопок
	LDI	 	Temp1, (0<<CS02)|(1<<CS01)|(1<<CS00)
	OUT  	TCCR0, Temp1
	; Число сравнения (125 = 0x7D) - при делителе 64 - получим 1 мс (8000000/64=125000)/1000 = 125
	; 1КГц должно получиться при Fcpu=8мГц
	LDI 	Temp1, 0x7D
	OUT  	OCR0, Temp1
	; Обнуляем счетчик
	OUT  	TCNT0, Temp0
	; Инициализируем переменные
	LDI 	Temp2, 0x01
	CLR		Temp4
	CLR		Temp3
	; Разрешаем прерывания
	SEI
;=================================================
; Основная программа (цикл)
Main:
	; Цикл выполняется сначала
	RJMP	Main
;=================================================
; Остановка прерывания и включение всех светодиодов
ChangeInt:
	PUSH 	Temp1
	PUSH 	Temp2
	IN 		Temp1, TIMSK
	LDI		Temp2,(1<<OCIE1A)
	EOR		Temp1, Temp2 ; Exclusive OR (Исключающее ИЛИ)
	OUT		TIMSK, Temp1 ; исли в OCIE1A был 1, станет 0 и наоборот
	LDI		Temp1, 0xFF
	OUT		LedPORT, Temp1
	POP 	Temp2
	POP 	Temp1
RET
