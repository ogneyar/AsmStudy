;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
	.include "./lib/m16def.inc"		; Программа под ATmega16A
;=================================================
; Имена регистров, а также различные константы
	.equ 	XTAL 					= 8000000 		; Частота МК
	.equ 	UART_BaudRate 			= 19200			; Скорость обмена по UART
	.equ 	UART_BaudDivider 		= XTAL/(16*UART_BaudRate)-1
	.equ 	I2C_Frequency 			= 100000		; Частота шины I2C
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
	.equ	DisplayDelay			= 2				; Задержка для динамической индикации
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
	.def 	Temp9 					= R24
	.def 	Temp10 					= R25

;=================================================
	.equ	SegPORT 				= PORTC			
	.equ	SegDDR  				= DDRC			
	.equ	DigPORT 				= PORTB			
	.equ	DigDDR  				= DDRB			
	.equ	Digit1  				= 0				
	.equ	Digit2  				= 1				
	.equ	Digit3  				= 2				
	.equ	Digit4  				= 3	
	.equ	BtnPORT					= PORTD
	.equ	BtnPIN					= PIND
	.equ	BtnDDR					= DDRD
	.equ	BtnUp					= 2
	.equ	BtnDown					= 3
	.equ	PwmDDR					= DDRD
	.equ	PwmPORT					= PORTD
	.equ	PwmChA					= 5
	.equ	PwmChB					= 4
	.equ	BtnDelay				= 100
	.equ	Delta					= 5
	.equ	PwmMin					= 55
	.equ	PwmMiddle				= 165
	.equ	PwmMax					= 285
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
	PUSH	Temp1
	PUSH	Temp2
; Проверяем кнопку Up
T0_CheckUp:
	SBIC 	BtnPIN, BtnUp
	INC 	Temp7
	SBIS 	BtnPIN, BtnUp
	CLR 	Temp7
	CPI 	Temp7, BtnDelay
	BRLO 	T0_CheckDown
	SER		Temp6
	LDI		Temp1, Delta
	ADD		Temp10, Temp1
	ADC		Temp9, Temp0
	LDI		Temp1, HIGH(PwmMax)
	LDI		Temp2, LOW(PwmMax)
	CP		Temp10, Temp2
	CPC		Temp9, Temp1
	BRLO	T0_CheckUp2
	LDI		Temp9, HIGH(PwmMax)
	LDI		Temp10, LOW(PwmMax)
T0_CheckUp2:
	CLR 	Temp7
T0_CheckDown:
	SBIC 	BtnPIN, BtnDown
	INC 	Temp8
	SBIS 	BtnPIN, BtnDown
	CLR 	Temp8
	CPI 	Temp8, BtnDelay
	BRLO 	T0_Next
	SER		Temp6
	LDI		Temp1, Delta
	SUB		Temp10, Temp1
	SBC		Temp9, Temp0
	LDI		Temp1, HIGH(PwmMin)
	LDI		Temp2, LOW(PwmMin)
	CP		Temp10, Temp2
	CPC		Temp9, Temp1
	BRSH	T0_CheckDown2

	LDI		Temp9, HIGH(PwmMin)
	LDI		Temp10, LOW(PwmMin)
T0_CheckDown2:
	CLR 	Temp8
T0_Next:
	OUT 	OCR1AH, Temp9
	OUT 	OCR1AL, Temp10
	POP		Temp2
	POP		Temp1
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
	CBI 	BtnDDR, BtnUp
	CBI 	BtnDDR, BtnDown
	SBI		PwmDDR, PwmChA
	SBI		PwmDDR, PwmChB
	; Сегменты индикатора
	LDI 	Temp1, 0xFF
	OUT 	SegDDR, Temp1
	; Разряды индикатора
	LDI 	Temp1, (1<<Digit1)|(1<<Digit2)|(1<<Digit3)|(1<<Digit4)
	OUT 	DigDDR, Temp1
	; Настраиваем таймеры
	; Таймер 1 включаем канал А ШИМ, режим работы FastPWM (14 в списке)
	; TOP - ICR1
	LDI		Temp1, (1<<COM1A1)|(0<<COM1B1)|(1<<WGM11)|(0<<WGM10)
	OUT 	TCCR1A, Temp1
	; Предделитель - 64 
	LDI 	Temp1, (1<<WGM13)|(1<<WGM12)|(0<<CS12)|(1<<CS11)|(1<<CS10);
	OUT 	TCCR1B, Temp1 
	LDI 	XH, HIGH(2499)
	OUT 	ICR1H, XH
	LDI 	XL, LOW(2499)
	OUT 	ICR1L, XL
	; Частота ШИМ считается как Fpwm = Fcpu / (N*(1+TOP)) = 8000000 / (64*(1+2499)) = 50 Гц
	; Устанавливаем начальный коэффициент заполнения - 50%
	LDI 	Temp9, HIGH(PwmMiddle)
	OUT 	OCR1AH, Temp9
	LDI 	Temp10, LOW(PwmMiddle)
	OUT 	OCR1AL, Temp10
	SER		Temp6
 	; Обнуление счетчика таймера 1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; Настраиваем Таймер 0 для обработки кнопок
	LDI	 	Temp1, (0<<CS02)|(1<<CS01)|(1<<CS00)
	OUT  	TCCR0, Temp1
	; Число сравнения - при делителе 64 - получим 1 мс
	LDI 	Temp1, 0x7D
	OUT  	OCR0, Temp1
	; Обнуляем счетчик
	OUT  	TCNT0, Temp0
	; Разрешение прерываний таймера 0
	LDI 	Temp1, (1<<OCIE0)
	OUT 	TIMSK, Temp1
	; Разрешаем прерывания
	SEI
;=================================================
; Основная программа (цикл)
Main:
	CPI		Temp6, 0xFF
	BRNE	M1
	CLI
	CLR		Temp6
	MOV		Temp1, Temp9
	MOV		Temp2, Temp10	
	; Определяем цифры числа
	RCALL	DIGITS16
	; Полученные цифры пишем в память
	STS		Digits+3, Temp0
	STS		Digits+2, Temp3
	STS		Digits+1, Temp4
	STS		Digits, Temp5
	SEI
M1:
	; Вызываем процедуру индикации
	RCALL	Display
	; Цикл выполняется сначала
	RJMP	Main
;=================================================
	.include "./lib/Delay.asm"
	.include "./lib/Math.asm"
;=================================================
; Процедура декодирования цифры в код числа для 7-сегментного индикатора
Decoder:
	LDI 	ZL, LOW(LedMatrix*2)   
	LDI 	ZH, HIGH(LedMatrix*2)  
	ADD 	ZL, Temp1                        
    ADC 	ZH, Temp0				
    LPM 	Temp1, Z                     
RET
LedMatrix:
			; hgfedcba   hgfedcba
	.db 	0b00111111, 0b00000110	;0,1
	.db 	0b01011011, 0b01001111	;2,3
	.db 	0b01100110, 0b01101101	;4,5
	.db 	0b01111101, 0b00000111	;6,7
	.db 	0b01111111, 0b01101111	;8,9
;=================================================
; Процедура динамической индикации
Display:
	LDI 	Temp1, Bit0
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+3
	RCALL	Decoder
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+2
    RCALL 	Decoder 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+1
    RCALL 	Decoder            
	OUT 	SegPORT, Temp1     
 	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits
    RCALL 	Decoder   
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms
RET
