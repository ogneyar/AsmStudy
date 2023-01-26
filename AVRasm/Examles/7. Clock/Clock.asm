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
	.equ	BtnMin					= 2
	.equ	BtnHour					= 3			
;=================================================
; Сегмент SRAM памяти
.DSEG
	Digits:  			.byte		6					
;=================================================
; Сегмент EEPROM памяти
.ESEG
	eDigits:  			.byte		6					
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
	RCALL	GetTime
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
	; обнуление индикатора кнопок
	CLR 	Flags
	; Настраиваем порты ввода-вывода
	; Сегменты индикатора
	LDI 	Temp1, 0xFF
	OUT 	SegDDR, Temp1
	; Разряды индикатора
	LDI 	Temp1, (1<<Digit1)|(1<<Digit2)|(1<<Digit3)|(1<<Digit4)
	OUT 	DigDDR, Temp1
	LDI		Temp1, (0<<BtnMin)|(0<<BtnHour)
	OUT 	BtnDDR, Temp1 ; input mode
	OUT 	BtnPORT, Temp1 ; pull down
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
	; Разрешаем прерывания
	SEI
;=================================================
; Основная программа (цикл)
Main:
	; Вызываем процедуру индикации
	RCALL	Display
	; Вызываем процедуру обработки кнопок
	RCALL	GetButtons
	; Цикл выполняется сначала
	RJMP	Main
;=================================================
	.include "./lib/Delay.asm"
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
	LDS 	Temp1, Digits+5
	RCALL	Decoder
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+4
    RCALL 	Decoder 
	ORI		Temp1, SYMBOL_POINT ; Logical OR with Immediate (логическое ИЛИ регистра с числом)
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+3
    RCALL 	Decoder            
	OUT 	SegPORT, Temp1     
 	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+2
    RCALL 	Decoder   
	ORI		Temp1, SYMBOL_POINT ; Logical OR with Immediate
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms
RET
;=================================================
; Обработка кнопок
GetButtons:
	IN 		Temp1,BtnPin		; читаем и обрезаем по маске
	ANDI	Temp1,(1<<BtnMin)|(1<<BtnHour) ; Logical AND with Immediate
	CPI 	Temp1,0 			; сравниваем с нулем
	BREQ 	NoButtons 			; если ноль (нет нажатых) выход
	SUB 	Temp1,Flags			; определяем изменения
	BREQ 	GetButtonsExit 		; если ноль, то нажато то же самое, выходим
	CPI 	Temp1,(1<<BtnHour)	; проверка на изменение часов
	BREQ 	Press_hour ; Branch if Equal (Z=1)
	; иначе измененены минуты
	LDI 	Flags,(1<<BtnMin) 	; запись индикатора кнопок
	LDS 	Temp1,Digits+2		; чтение разряда минут
	INC 	Temp1 				; увеличение разряда минут 
	CPI 	Temp1,10	
	BREQ 	Tst2 		
	STS 	Digits+2,Temp1		; запись числа минут
	JMP 	GetButtonsExit 		; выход 
Tst2:
	CLR 	Temp1  				; установка нуля
	STS 	Digits+2,Temp1		; запись нуля в разряд минут
	LDS 	Temp1,Digits+3		; чтение разряда десятков минут
	INC 	Temp1 				; увеличение разряда десятков минут 
	CPI 	Temp1,6
	BREQ 	Tst3
	STS		Digits+3,Temp1		; запись числа десятков минут
	JMP 	GetButtonsExit 		; выход 
Tst3:	
	CLR 	Temp1 				; установка нуля
	STS 	Digits+3,Temp1 		; запись нуля в разряд десятков минут
	JMP 	IncHour				; выход
	; изменение показаний часов
Press_hour:
	LDI 	Flags,(1<<BtnHour)	; запись индикатора кнопок
IncHour:
	LDS		Temp1,Digits+4 		; чтение 3-ого разряда
	INC 	Temp1 				; увеличение 3-ого разряда
	CPI 	Temp1,10
	BREQ 	Tst4 
	STS 	Digits+4,Temp1		; запись числа 3-ого разряда
	JMP 	Tst24 				; проверка на 24
Tst4:
	CLR 	Temp1 				; установка нуля
	STS 	Digits+4,Temp1		; запись нуля 3-ого разряда
	LDS 	Temp1,Digits+5		; чтение 4-ого разряда 
	INC 	Temp1 				; увеличение 4-ого разряда 
	STS 	Digits+5,Temp1 		; запись числа 4-ого разряда
Tst24:	
	; проверка на 24 часа
	LDS 	Temp1,Digits+5 		; чтение 6-ого разряда
	CPI 	Temp1,2  			; максимум - это 24
	BRNE 	GetButtonsExit 		; если не ноль выход
	; если у нас 20 с чем-то часов то смотрим единицы часов чтоб не было 25 
	LDS 	Temp1,Digits+4 		; чтение 5-ого разряда
	CPI 	Temp1,4 			; разность
	BRNE 	GetButtonsExit 		; если не ноль выход
	; закончилась проверка на 24 - максимум часов
	CLR 	Temp1				; если день закончился то часы обнуляются
	STS 	Digits+4,Temp1		; обнуление 5-ого и 6-ого разрядов
	STS 	Digits+5,Temp1
	RJMP 	GetButtonsExit 		; выход 
Nobuttons:
	CLR 	Flags 				; обнуление индикатора кнопок
GetButtonsExit:
RET
;=================================================
; Увеличение времени
GetTime:
	; увеличиваем секунды
	LDS 	Temp1, Digits		; читаем первый разряд - единицы секунд
	INC 	Temp1				; инкрементируем
	CPI 	Temp1,10			; проверяем не дошли ли единицы секунд до 10
	BREQ 	Test1
	STS 	Digits,Temp1		; записываем разряд
	JMP 	GetTimeExit			; выходим
	; увеличиваем десятки секунд 
Test1:
	; обнуляем единицы секунд
	LDI 	Temp1,0
	STS		Digits,Temp1
	LDS		Temp1,Digits+1		; читаем второй разряд - десятки секунд
	INC		Temp1				; инкрементируем
	CPI		Temp1,6				; проверяем не дошли ли десятки секунд до 6
	BREQ	Test2
	STS 	Digits+1,Temp1
	JMP 	GetTimeExit
	; промежуточная метка
Output1:
	CPI 	Counter,1
	BREQ 	GetTimeExit
	; увеличиваем единицы минут
Test2:
	; обнуляем десятки секунд
	LDI		Temp1,0
	STS		Digits+1,Temp1
	LDS 	Temp1,Digits+2		; читаем третий разряд - единицы минут
	INC 	Temp1				; инкрементируем
	CPI 	Temp1,10			; проверяем не дошли ли единицы минут до 10
	BREQ 	Test3
	STS		Digits+2,Temp1
	JMP 	GetTimeExit
	; увеличиваем десятки минут
Test3:
	; обнуляем единицы минут
	LDI		Temp1,0
	STS		Digits+2,Temp1
	LDS 	Temp1,Digits+3		; читаем четвертый разряд - десятки минут
	INC 	Temp1				; инкрементируем
	CPI 	Temp1,6				; проверяем не дошли ли десятки минут до 6
	BREQ 	Test4
	STS 	Digits+3,Temp1
	JMP 	GetTimeExit
	; увеличиваем единицы часов
Test4:
	; обнуляем десятки минут
	LDI		Temp1,0
	STS 	Digits+3,Temp1
	LDS 	Temp1,Digits+4		; читаем пятый разряд - единицы часов
	INC 	Temp1				; инкрементируем
	CPI 	Temp1,10			; проверяем не дошли ли единицы часов до 10
	BREQ 	Test5
	STS		Digits+4,Temp1
	JMP		Check24
	; увеличиваем десятки часов
Test5:
	; обнуляем единицы часов
	LDI		Temp1,0
	STS		Digits+4,Temp1
	LDS 	Temp1,Digits+5		; читаем шестой разряд - десятки часов
	INC 	Temp1				; инкрементируем
	STS 	Digits+5,Temp1
	JMP 	Check24
Check24:
	; проверка на 24 часа
	LDS 	Temp1,Digits+5 		; чтение 6-ого разряда
	CPI 	Temp1,2  			; максимум - это 24
	BRNE 	GetTimeExit 		; если не ноль выход
	; если у нас 20 с чем-то часов 
	; то смотрим единицы часов чтоб не было 25
	LDS 	Temp1,Digits+4 	; чтение 5-ого разряда
	CPI 	Temp1,4 			; разность
	BRNE 	GetTimeExit 		; если не ноль выход
	; закончилась проверка на 24 - максимум часов
	; если день закончился то часы обнуляются
	LDI 	Temp1,0
	STS 	Digits+4,Temp1
	STS 	Digits+5,Temp1 		; обнуление 5-ого и 6-ого разрядов
GetTimeExit:
RET
;=================================================
