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
	.equ	SPI_DDR					= DDRB
	.equ	SPI_PORT				= PORTB	
	.equ	SPI_SS					= 4
	.equ	SPI_MOSI				= 5
	.equ	SPI_MISO				= 6
	.equ	SPI_SCK					= 7
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
; Прерывание по приему байта по UART
USART_RXC:
	PUSH	Temp1
	PUSH	Temp2
	IN		Temp1,SREG
	PUSH	Temp1
	IN		Temp1, UDR
	CPI		Temp1,0x00
	BRNE	U1
	LDI		Temp2, (1<<OCIE1A)	
	OUT 	TIMSK, Temp2 
	RJMP	U2
U1:
	CLR		Temp2
	OUT 	TIMSK, Temp2 
	CBI 	SPI_PORT, SPI_SS
	RCALL	SPI_MasterTransmit
	SBI 	SPI_PORT, SPI_SS
U2:

	POP		Temp1
	OUT		SREG, Temp1
	POP		Temp2
	POP		Temp1
RETI
; Прерывание Таймера 1 по совпадению канала А
TIMER1_COMPA:
	CLI
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	CPI		Temp2, 0xAA
	BREQ	T1
	LDI		Temp2, 0xAA
	RJMP	T2
T1:
	LDI		Temp2, 0x55
T2:
	MOV		Temp1, Temp2
	; Вывод в сдвиговый регистр по SPI
	CBI 	SPI_PORT, SPI_SS
	RCALL	SPI_MasterTransmit
	SBI 	SPI_PORT, SPI_SS
TimerExit:
RETI
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; Инициализация стека
	LDI 	Temp1, LOW(RAMEND)
	OUT 	SPL, Temp1
	LDI 	Temp1, HIGH(RAMEND)	
	OUT 	SPH, Temp1
	; Очистка ОЗУ и регистров R0-R31
	LDI		ZL,LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH,HIGH(SRAM_START)
	CLR		Temp1					; Очищаем R16
RAM_Flush:
	ST 		Z+,Temp1				
	CPI		ZH,HIGH(RAMEND+1)	
	BRNE	RAM_Flush			
	CPI		ZL,LOW(RAMEND+1)	
	BRNE	RAM_Flush
	LDI		ZL,(0x1F-2)				; Адрес регистра R29
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
	; Настройка SPI
	RCALL	SPI_MasterInit
	; Настройка UART
	RCALL	UART_Init
	; Настройка таймеров
	; Разрешение прерывания таймера 1 по совпадению канала А
	LDI 	Temp1, (1<<OCIE1A)
	OUT 	TIMSK, Temp1 
	; Установка предделителя /256
	LDI 	Temp1, (1<<CS12)
	OUT 	TCCR1B, Temp1 
	; Установка числа сравнения 31250=0x7A12 (8000000/256=31250 - 1 сек. при 8мгц)
	LDI 	XH, HIGH(0x7A12)
	OUT 	OCR1AH, XH
	LDI 	XL, LOW(0x7A12)
	OUT 	OCR1AL, XL
 	; Обнуление счетчика таймера 1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; Настраиваем порты ввода-вывода
	LDI		Temp1,(1<<SPI_MOSI)|(1<<SPI_SCK)|(1<<SPI_SS)
	OUT		SPI_DDR, Temp1
	LDI		Temp1,(1<<SPI_SS)
	OUT		SPI_PORT, Temp1
	; Инициализируем состояние светодиодов
	LDI		Temp2, 0xAA
	LDI		Temp1, 0xFF
	; Разрешаем прерывания
	SEI
;=================================================
; Основная программа (цикл)
Main:
	; Цикл выполняется сначала
	RJMP	Main
;=================================================
; Инициализация UART
UART_Init:
	; Configure Baud Divider
	LDI 	Temp1, LOW(UART_BaudDivider)
	OUT 	UBRRL, Temp1
	LDI 	R16, HIGH(UART_BaudDivider)
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
; Инициализация SPI
SPI_MasterInit:
; Включение SPI, режим мастера, передача старшим битом вперед
; Частота f / 2
	LDI 	Temp1, (1<<SPE)|(1<<MSTR)|(1<<SPR0)
	OUT 	SPCR, Temp1
	LDI 	Temp1, (1<<SPI2X)
	OUT 	SPSR, Temp1
RET
; Отправка байта по SPI (R16) 
SPI_MasterTransmit:
	; Старт передачи байта
	OUT		SPDR, Temp1
Wait_Transmit:
	; Ожидание завершения передачи
	SBIS	SPSR, SPIF
	RJMP	Wait_Transmit
	IN		Temp1, SPDR
RET

