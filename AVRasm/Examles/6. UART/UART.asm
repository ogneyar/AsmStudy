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
	.equ	SegPORT 				= PORTC			
	.equ	SegDDR  				= DDRC			
	.equ	DigPORT 				= PORTB			
	.equ	DigDDR  				= DDRB			
	.equ	Digit1  				= 0				
	.equ	Digit2  				= 1				
	.equ	Digit3  				= 2				
	.equ	Digit4  				= 3	
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
	.ORG 0x16
		RJMP 	USART_RXC			
;=================================================
; Прерывание Таймера 1 по совпадению канала А
TIMER1_COMPA:
RETI
; Прерывание по приему байта по UART
USART_RXC:
	PUSH	Temp1
	PUSH	Temp2
	IN		Temp1,SREG
	PUSH	Temp1
	IN		Temp1, UDR
	; Определяем цифры числа
	RCALL	DIGITS8
	; Полученные цифры пишем в память
	STS		Digits+3, Temp3 ; Store Direct to Data Space
	STS		Digits+2, Temp2 ; Store Direct to Data Space
	STS		Digits+1, Temp1 ; Store Direct to Data Space
	STS		Digits, Temp0 ; Store Direct to Data Space
	POP		Temp1
	OUT		SREG, Temp1
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
	; Сегменты индикатора
	LDI 	Temp1, 0xFF
	OUT 	SegDDR, Temp1
	; Разряды индикатора
	LDI 	Temp1, (1<<Digit1)|(1<<Digit2)|(1<<Digit3)|(1<<Digit4)
	OUT 	DigDDR, Temp1
	; Настройка UART
	RCALL	UART_Init
	; Разрешаем прерывания
	SEI
;=================================================
; Основная программа (цикл)
Main:
	; Вызываем процедуру индикации
	RCALL	Display
	; Цикл выполняется сначала
	RJMP	Main
;=================================================
	.include "./lib/Math.asm"
	.include "./lib/Delay.asm"
;=================================================
; Процедура декодирования цифры в код числа для 7-сегментного индикатора
Decoder:
	LDI 	ZL, LOW(LedMatrix*2) ; Load Immediate
	LDI 	ZH, HIGH(LedMatrix*2)  
	ADD 	ZL, Temp1 ; Add without Carry
    ADC 	ZH, Temp0 ; Add with Carry
    LPM 	Temp1, Z ; Load Program Memory
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
; Выводи только 3 цифры, так как байт может принимать значения 0..255
Display:
;	LDI 	Temp1, Bit0 ; Load Immediate
;	OUT 	DigPORT, Temp1			  
;	LDS 	Temp1, Digits ; Load Direct from data space
;	RCALL	Decoder
;	OUT 	SegPORT, Temp1     
;	LDI 	Temp1, DisplayDelay
;	RCALL 	Delayus         

	LDI 	Temp1, Bit1 ; Load Immediate
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+1 ; Load Direct from data space
    RCALL 	Decoder        
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayus   

	LDI 	Temp1, Bit2 ; Load Immediate
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+2 ; Load Direct from data space
    RCALL 	Decoder               
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayus      

	LDI 	Temp1, Bit3 ; Load Immediate
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+3 ; Load Direct from data space
    RCALL 	Decoder        
	OUT 	SegPORT, Temp1     
 	LDI 	Temp1, DisplayDelay
	RCALL 	Delayus
RET
;=================================================
; Инициализация UART
UART_Init:
	; Configure Baud Divider
	LDI 	Temp1, LOW(UART_BaudDivider)
	OUT 	UBRRL, Temp1
	LDI 	Temp1, HIGH(UART_BaudDivider)
	OUT 	UBRRH, Temp1
	OUT 	UCSRA, Temp0
	; Enable UART Interrupts
	LDI 	Temp1, (1<<RXEN)|(1<<TXEN)|(1<<RXCIE)|(0<<TXCIE)|(0<<UDRIE)
	OUT 	UCSRB, Temp1	
	; Set Frame Bits: 8 data bits, 1 stop bit, no parity
	LDI 	Temp1, (1<<URSEL)|(1<<UCSZ0)|(1<<UCSZ1)
	OUT 	UCSRC, Temp1
RET
; Отправка байта
UART_Send:	
	SBIS 	UCSRA, UDRE			
	RJMP	UART_Send			
	OUT		UDR, Temp1
RET
; Прием байта
UART_Receive:	
	SBIS	UCSRA, RXC			
	RJMP	UART_Receive		
	IN		Temp1, UDR				
RET
;=================================================
