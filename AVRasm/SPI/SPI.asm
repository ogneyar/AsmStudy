
; НЕ РАБОТАЕТ!!! 

; Светодиодная мигалка на микроконтроллере ATmega328p

.INCLUDE "../libs/m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
	.equ 	XTAL 					= 16000000 		; Частота МК
	.equ 	UART_BaudRate 			= 9600		; Скорость обмена по UART
	.equ 	UART_BaudDivider 		= (XTAL/8/UART_BaudRate-1) ; (XTAL/8/x-1) при U2X0 в 1, (XTAL/16/x-1) при U2X0 в 0
	.equ 	I2C_Frequency 			= 100000			; Частота шины I2C (Nano работает даже на 1MHz)
	.equ 	I2C_BaudDivider 		= ((XTAL/I2C_Frequency)-16)/2	; prescaler = 1
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
	; Test: .byte 1
	Test_String: .byte 100
	
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
Hello_String: .db '\n',"Проверка работы SPI!",'\n','\n',0
Cancel_String: .db '\n',"Крнец передачи байта!",'\n','\n',0
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


	; -- инициализация USART --
	LDI 	R16, LOW(UART_BaudDivider)
	LDI 	R17, HIGH(UART_BaudDivider)
	RCALL 	USART_Init 
		
	; вывод в порт приветствия
	SETstr 	Hello_String
	RCALL 	USART_Print_String

	; -- инициализация I2C --
	LDI 	R16, 0 ; 0 - 125KHz, 1 - 250KHz, 2 - 1MHz, 3 - 4MHz
	RCALL 	SPI_Master_Init
	
	; передача байта по SPI
	LDI 	R16, 0xaa
	RCALL 	SPI_Master_SendByte
	
	SETstr 	Cancel_String
	RCALL 	USART_Print_String


;=================================================
; Основная программа (цикл)
Main:	
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================


; 
SPI_Master_Init: ; ожидаем в R16 значение от 0 - 3
	push	R16	
	push	R17
	push	R18
	
	LDI		R17, (1 << PORTB3) | (1 << PORTB5) ; PORTB3 - MOSI, PORTB5 - SCK
	OUT 	DDRB, R17
	
	
	; Разрешить работу SPI, режим Master, установить скорость тактов
	; SPI2X SPR1 SPR0 - 0 0 0 = fck/4; 0 0 1 = fck/16; 0 1 0 = fck/64; 0 1 1 = fck/128;      1 0 0 = fck/2; 1 0 1 = fck/8; 1 1 0 = fck/32; 1 1 1 = fck/64
	LDI		R18, (1 << SPE) | (1 << MSTR) ; | (1 << SPR1) | (1 << SPR0);
	
	; R16 = 0 -> fck/128 = 125KHz
	LDI		R17, 0
	CPSE	R16, R17 ; если 0
	ORI		R18, (1 << SPR1) | (1 << SPR0)
	; R16 = 1 -> fck/64  = 250KHz
	LDI		R17, 1
	CPSE	R16, R17 ; если 1
	ORI		R18, (1 << SPR1)
	; R16 = 2 -> fck/16  = 1MHz
	LDI		R17, 2
	CPSE	R16, R17 ; если 2
	ORI		R18, (1 << SPR0)
	; R16 = 3 -> fck/4   = 4KHz
	LDI		R17, 3
	CPSE	R16, R17 ; если 3
	ORI		R18, 0
	
	UOUT 	SPCR, R18
	
	LDI		R17, SPI2X
	UOUT 	SPSR, R17
	
	pop		R18
	pop		R17
	pop		R16
ret

;
SPI_Master_SendByte:
    ; Запуск передачи данных
	STS 	SPDR, R16
	NOP
SPI_Wait_SPIF: ; Ожидание завершения передачи   
	LDS 	R16, SPSR
	SBRS 	R16, SPIF ; Skip if Bit in Register Set
	RJMP 	SPI_Wait_SPIF
ret




;=================================================
ERROR:
	; -- устанавливаем пин PB5 порта PORTB на вывод -- 
	LDI		Temp1, (1 << PORTB5)
	OUT 	DDRB, Temp1
	SETstr	ErrorStr
	RCALL	USART_Print_String ; вывод сообщения в порт
loop_ERROR:
	SBI 	PORTB, PORTB5 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PORTB5 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

