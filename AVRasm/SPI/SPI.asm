
; Тестирование SPI на микроконтроллере ATmega328p

; разкомментируй строку ниже если используешь LGT8F328P
#define __LGT8F__ ; for LGT8F328P

.INCLUDE "../libs/m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
#ifdef __LGT8F__
	.equ 	F_CPU 					= 32000000		; Частота МК LGT8F328P
#else
	.equ 	F_CPU 					= 16000000		; Частота МК ATmega328p
#endif
	.equ 	DIVIDER					= 8				; 8 при U2X0 = 1, 16 при U2X0 = 0
	.equ 	BAUD 					= 115200		; Скорость обмена по UART
	.equ 	UBRR 					= F_CPU/DIVIDER/BAUD-1
	.equ 	I2C_Frequency 			= 100000			; Частота шины I2C (Nano работает даже на 1MHz)
	.equ 	I2C_BaudDivider 		= ((F_CPU/I2C_Frequency)-16)/2	; prescaler = 1
;	.equ 	I2C_Address_Device		= 0x27							; адрес устройства 
;	.equ 	I2C_Address_Write		= (I2C_Address_Device << 1)		; адрес устройства на запись
;	.equ 	I2C_Address_Read		= (I2C_Address_Write & 0x01)	; адрес устройства на чтение
;=================================================
	.def 	USART_Data				= R16			; регистр данных USART
	.def 	I2C_Data				= R17			; регистр данных I2C
	.def 	I2C_Address				= R18			; регистр адреса I2C устройства (0x27 для )
	.def 	Temp0					= R19			; регистр для временных данных
	.def 	Temp1					= R20			; регистр для временных данных
 	.def 	Temp2					= R21			; регистр для временных данных
	.def 	Flag 					= R25 			; регистр для флага
;=================================================	
	.set 	_delay_ms 				= 50 			; установка переменной времени задержки 
	
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
Program_name: .db "Test SPI Master mode on ATmega328p/LGT8F328P ",0
Hello_String: .db '\n',"Проверка работы SPI!",'\n','\n',0
Cancel_String: .db '\n',"Конец передачи байта! ",'\n','\n',0
ErrorStr: .db '\n',"Непредвиденная ошибка!",'\n','\n',0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/usart.asm"    ; подключение файла 'задержек'
#include "../libs/spi.asm"    ; подключение файла 'задержек'

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	Temp1, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, Temp1 ; установка младшего байта указателя стека 
	LDI 	Temp1, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, Temp1 ; установка старшего байта указателя стека 

;==============================================================
; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		R16					; Очищаем R16
RAM_Flush:
	ST 		Z+, R16				
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
	
;==============================================================
	; -- инициализация USART --
	LDI 	R16, LOW(UBRR)
	LDI 	R17, HIGH(UBRR)
	RCALL 	USART_Init 
		
	; вывод в порт приветствия
	mSetStr	Hello_String
	RCALL 	USART_Print_String

	; -- инициализация I2C --
	LDI 	R16, 0 ; 0 - 125KHz, 1 - 250KHz, 2 - 1MHz, 3 - 4MHz
	RCALL 	SPI_Master_Init
	
	; передача байта по SPI
	LDI 	R16, 0xaa
	RCALL 	SPI_Master_SendByte
	
	LDI		R16, 'H'
	RCALL 	USART_Transmit

	LDI		R16, 'e'
	RCALL 	USART_Transmit

	LDI		R16, 'l'
	RCALL 	USART_Transmit

	LDI		R16, 'l'
	RCALL 	USART_Transmit

	LDI		R16, 'o'
	RCALL 	USART_Transmit

	LDI		R16, '\n'
	RCALL 	USART_Transmit

	LDI		R16, '\n'
	RCALL 	USART_Transmit

	mSetStr 	Cancel_String
	RCALL 	USART_Print_String



	RJMP ERROR

;=================================================
; Основная программа (цикл)
Main:	
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================



;=================================================
ERROR:
	; -- устанавливаем пин PB5 порта PORTB на вывод -- 
	LDI		Temp1, (1 << PORTB5)
	OUT 	DDRB, Temp1
	mSetStr	ErrorStr
	RCALL	USART_Print_String ; вывод сообщения в порт
loop_ERROR:
	SBI 	PORTB, PORTB5 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PORTB5 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

