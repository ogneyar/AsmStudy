
; I2C сканер на микроконтроллере ATtiny2313A

.INCLUDE "../libs/tn2313Adef.inc" ; загрузка предопределений для ATtiny2313A
#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 8000000		; Частота МК

	.equ 	DIVIDER					= 8				; делитель
	.equ 	BAUD 					= 9600			; Скорость обмена по UART
	.equ 	UART_BaudDivider		= F_CPU/DIVIDER/BAUD-1
	
	.equ 	I2C_DIVIDER				= 1				; делитель
	.equ 	I2C_BAUD 				= 100000		; Скорость обмена по I2C
	.equ 	I2C_UBRR				= F_CPU/I2C_DIVIDER/I2C_BAUD ; количество тиков в 10 мкс (1секунду/100 000) около 100 KHz

;	.equ 	I2C_Address_Device		= 0x27							; адрес устройства 
;	.equ 	I2C_Address_Write		= (I2C_Address_Device << 1)		; адрес устройства на запись
;	.equ 	I2C_Address_Read		= (I2C_Address_Write & 0x01)	; адрес устройства на чтение

;=================================================	
	.def 	Data					= R16			; регистр данных
	.def 	Ask						= R17			; регистр данных
	.def 	I2C_Address				= R18			; регистр адреса
	.def 	Counter					= R19			; регистр счёичик
	.def 	Null 					= R23 			; регистр для флага

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
; Переменные во флеш памяти
; Program_name: .db "Search address I2C device on ATtiny2313A",'\n',0
Hello_String: .db '\n',"Поиск I2C устройства начался! ",'\n','\n',0
AddressOn: .db "Адрес устройства: 0b",0
AddressOff: .db "Нет найденных устройств!",0
EndSearchDevices: .db '\n','\n',"Поиск I2C устройств завершён!",'\n','\n',0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/usart.asm"    ; подключение библиотеки USART (ей требуется UBRR)
#include "../libs/i2c.asm"    	; подключение библиотеки I2C (ей требуется I2C_UBRR)

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI 	R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, R16 ; установка младшего байта указателя стека 
	; LDI 	R16, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	; OUT 	SPH, R16 ; установка старшего байта указателя стека 

;==============================================================
; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		R16					; Очищаем R16
RAM_Flush:
	ST 		Z+, R16
	; CPI		ZH, HIGH(RAMEND+1)	
	; BRNE	RAM_Flush			
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

;=================================================
	; инициализация USART
	mSetZ	UART_BaudDivider
	RCALL 	USART_Init
	
	; вывод в порт названия программы
	; mSetStr Program_name
	; RCALL 	USART_Print_String

	; вывод в порт приветствия
	mSetStr Hello_String
	RCALL 	USART_Print_String
	
	; инициализация I2C
	RCALL 	I2C_Init 

	; -- поиск I2C устройств --	
	RCALL 	I2C_Scan

;=================================================
; Основная программа (цикл)
Main:
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================




;=================================================
; поиск устройства и вывод адреса в порт
I2C_Scan:
	push	R16 ; Data
	push	R17 ; Ask
	push	R18 ; I2C_Address
	push	R19 ; Counter
	
	LDI		Counter, 8 ; количество выводимых бит
	CLR		I2C_Address ; I2C_Address = 0x00
Repeat_I2C_Scan:
	RCALL	I2C_Start ; команда СТАРТ
	
	MOV		Data, I2C_Address
	LSL 	Data 
	RCALL	I2C_send ; передача адреса записанного в R16
	;------------------------------------
	; проверяем ответло ли устройство
	CP	 	Ask, Null ; если устройство ответит (Ask=0)
	BREQ	AddressOn_send ; прекращаем сканировать
	; продолжаем если устройство не ответило
	;------------------------------------
	RCALL	I2C_Stop ; иначе команда СТОП

	INC 	I2C_Address ; увеличиваем значение
	CPI		I2C_Address, 128 ; TW_MAX_ADDRESS - максимально возможное значение адреса устройства
	BRSH	Clear_I2C_Address ; Branch if Same or Higher (>=) пропускаем строку ниже если первое значение >= второму
	RJMP	Repeat_I2C_Scan ; повторяем
Clear_I2C_Address:
	CLR		I2C_Address
	RJMP	AddressOff_send
AddressOn_send:
	RCALL	I2C_Stop ; команда СТОП

	mSetStr	AddressOn
	RCALL	USART_Print_String ; вывод в порт AddressOn
Loop_I2C_Scan:
	CLC ; Clear Carry (сбрасываем флаг переноса)
	ROL		I2C_Address ; круговой сдвиг влево (ROL 0b11110000 = 0b11100001)
	BRCC	Null_send ; если флаг Carry = 0 
	RJMP	One_send ; если флаг Carry = 1 
Null_send: 
	LDI		Data, '0'
	RCALL	USART_Transmit ; выводим в порт 0
	RJMP	Decrement_Bit
One_send:
	LDI		Data, '1'
	RCALL	USART_Transmit ; выводим в порт 1
	; RJMP	Decrement_Bit
Decrement_Bit:
	DEC		Counter ; количество выводимых бит
	CPI		Counter, 0  ; сравниваем с нулём
	BREQ	End_I2C_Scan
	RJMP	Loop_I2C_Scan
AddressOff_send:
	mSetStr	AddressOff
	RCALL	USART_Print_String ; вывод в порт AddressOff
End_I2C_Scan:
	mSetStr	EndSearchDevices
	RCALL	USART_Print_String
	
	pop		R19 ; Counter
	pop		R18 ; I2C_Address
	pop		R17 ; Ask
	pop		R16 ; Temp1
ret
