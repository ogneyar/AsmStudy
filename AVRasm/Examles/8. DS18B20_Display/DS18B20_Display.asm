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
	.equ	DisplayDelay			= 5				; Задержка для динамической индикации
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
	.equ	DS18B20_SEARCH_ROM 		= 0xF0			; Поиск адресов всех устройств по спецалгоритму
	.equ	DS18B20_READ_ROM 		= 0x33			; Считываение адреса единственного устройства
	.equ	DS18B20_MATCH_ROM 		= 0x55			; Активация конкретного устройства по его адресу
	.equ	DS18B20_SKIP_ROM 		= 0xCC 			; Обращение к единственному на шине устройству без указания его адреса
	.equ	DS18B20_ALARM_SEARCH 	= 0xEC			; Поиск устройств, у которых сработал ALARM (алгоритм поиска как у CMD_SERCH_ROM)
	.equ	DS18B20_CONVERT_T 		= 0x44			; Старт преобразования температуры
	.equ	DS18B20_W_SCRATCHPAD 	= 0x4E			; Запись во внутренний буфер (регистры)
	.equ	DS18B20_R_SCRATCHPAD 	= 0xBE			; Чтение внутреннего буфера (регистров)
	.equ	DS18B20_C_SCRATCHPAD 	= 0x48			; Сохранение регистров в EEPROM 
	.equ	DS18B20_RECALL_EE 		= 0xB8			; Заносит в буфер из EEPROM значение порога ALARM
	.equ	DS18B20_READ_POWER 		= 0xB4			; Определение, есть ли в шине устройства с паразитным питанием
	.equ	DS18B20_RES_9BIT 		= 0x1F			; Разрешение датчика (9 бит)
	.equ	DS18B20_RES_10BIT 		= 0x3F			; Разрешение датчика (10 бит)
	.equ	DS18B20_RES_11BIT 		= 0x5F			; Разрешение датчика (11 бит)
	.equ	DS18B20_RES_12BIT 		= 0x7F			; Разрешение датчика (12 бит)
;=================================================
	.equ	SegPORT 				= PORTC			
	.equ	SegDDR  				= DDRC			
	.equ	DigPORT 				= PORTB			
	.equ	DigDDR  				= DDRB			
	.equ	Digit1  				= 0				
	.equ	Digit2  				= 1				
	.equ	Digit3  				= 2				
	.equ	Digit4  				= 3		
	.equ	WirePORT 				= PORTD
	.equ	WirePIN  				= PIND			
	.equ	WireDDR  				= DDRD			
	.equ	TEMP_DQ  				= 5
; Сегмент SRAM памяти
.DSEG
	Digits:  			.byte		4	
	TempData:			.byte		9	; Буфер данных DS18B20
	TempCRC:			.byte		1	; Расчитываемая контр.сумма для DS18B20					
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
;=================================================
; Прерывание Таймера 1 по совпадению канала А
TIMER1_COMPA:
	CLI
	PUSH	Temp1
	PUSH	Temp2
	IN		Temp1,SREG
	PUSH	Temp1
	; Получение последнего измеренного значения температуры
	RCALL	DS18B20_GetTemp
	MOV		Temp5, Temp1
	; Запуск нового измерения температуры
	RCALL	DS18B20_ConvertTemp
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
	; Запуск первого измерения температуры
	RCALL	DS18B20_ConvertTemp
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
	.include "./lib/Delay.asm"
	.include "./lib/DS18B20.asm"
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
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D1
	LDS 	Temp1, Digits
D1:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms        

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D2
	LDS 	Temp1, Digits+1
	RCALL 	Decoder        
D2:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms   
	
	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D3
	LDS 	Temp1, Digits+2
	RCALL 	Decoder  
	ORI		Temp1, SYMBOL_POINT      
D3:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms   

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D4
	LDS 	Temp1, Digits+3
	RCALL 	Decoder  
D4:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms  
RET

