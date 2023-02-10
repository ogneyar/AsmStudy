
; OLED SSD1306 I2C на микроконтроллере ATtiny13A

.INCLUDE "../libs/tn13Adef.inc" ; загрузка предопределений для ATtiny13A 
#include "../libs/macro.inc"    ; подключение файла 'макросов'
#include "../libs/defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 9600000		; Частота МК

	; .equ 	DIVIDER					= 8				; делитель
	; .equ 	BAUD 					= 9600			; Скорость обмена по UART
	; .equ 	UBRR 					= F_CPU/DIVIDER/BAUD-1
	
	.equ 	I2C_DIVIDER				= 1				; делитель
	.equ 	I2C_BAUD 				= 100000		; Скорость обмена по I2C
	.equ 	I2C_UBRR				= F_CPU/I2C_DIVIDER/I2C_BAUD ; количество тиков в 10 мкс (1секунду/100 000) около 100 KHz

	.equ 	I2C_Address_Device		= 0x3c							; адрес устройства 
	.equ 	I2C_Address_Write		= (I2C_Address_Device << 1)		; адрес устройства на запись
	.equ 	I2C_Address_Read		= (I2C_Address_Write & 0x01)	; адрес устройства на чтение

;=================================================	
	.def 	Data					= R16			; регистр данных
	.def 	Ask						= R17			; регистр данных
	.def 	I2C_Payload				= R18			; регистр данных
	.def 	Counter					= R19			; регистр счёичик
	.def 	Flag					= R20			; регистр для флага
	.def 	Null 					= R23 			; нулевой регистр 

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
; Program_name: .db "Search address I2C device on ATtiny13A",0
Hello_String: .db '\n',"Поиск I2C устройства начался! ",'\n','\n',0
AddressOn: .db "Адрес устройства: 0b",0
AddressOff: .db "Нет найденных устройств!",0
EndSearchDevices: .db '\n','\n',"Поиск I2C устройств завершён!",'\n','\n',0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
; #include "../libs/usart.asm"    ; подключение библиотеки USART (ей требуется UBRR)
#include "../libs/i2c.asm"    	; подключение библиотеки I2C (ей требуется I2C_UBRR)

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI 	R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, R16 ; установка младшего байта указателя стека 

;==============================================================
; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		R16					; Очищаем R16
RAM_Flush:
	ST 		Z+, R16
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
	; инициализация I2C
	RCALL 	I2C_Init 
	
	; инициализация SSD1306
	RCALL 	SSD1306_Init

	; вывод данных на экран
	RCALL 	SSD1306_Send_Data

;=================================================
; Основная программа (цикл)
Main:
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================



; Подпрограмма инициализации OLED экрана
SSD1306_Init:
	push	R18 ; I2C_Payload
	; for (uint8_t i = 0; i < 15; i++) sendByte(pgm_read_byte(&_oled_init[i]));		
	; OLED_DISPLAY_OFF
	LDI 	I2C_Payload, OLED_DISPLAY_OFF
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CLOCKDIV
	LDI 	I2C_Payload, OLED_CLOCKDIV
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
    ; value
	LDI 	I2C_Payload, 0x80
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CHARGEPUMP
	LDI 	I2C_Payload, OLED_CHARGEPUMP
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	I2C_Payload, 0x14
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_ADDRESSING_MODE
	LDI 	I2C_Payload, OLED_ADDRESSING_MODE
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HORIZONTAL or OLED_VERTICAL
	LDI 	I2C_Payload, OLED_VERTICAL
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_H
	LDI 	I2C_Payload, OLED_NORMAL_H
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_V
	LDI 	I2C_Payload, OLED_NORMAL_V
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CONTRAST
	LDI 	I2C_Payload, OLED_CONTRAST
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	I2C_Payload, 0x7F
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_SETVCOMDETECT
	LDI 	I2C_Payload, OLED_SETVCOMDETECT
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	I2C_Payload, 0x40
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMALDISPLAY
	LDI 	I2C_Payload, OLED_NORMALDISPLAY
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETCOMPINS
	LDI 	I2C_Payload, OLED_SETCOMPINS
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HEIGHT_32
	LDI 	I2C_Payload, OLED_HEIGHT_32
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETMULTIPLEX
	LDI 	I2C_Payload, OLED_SETMULTIPLEX
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_32 
	LDI 	I2C_Payload, OLED_32
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_DISPLAY_ON
	LDI 	I2C_Payload, OLED_DISPLAY_ON
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	pop		R18 ; I2C_Payload
ret

; Подпрограмма отправки данных на OLED экран
SSD1306_Send_Data:
	push		R18 ; I2C_Payload
	push		R20 ; Flag
	; Установка столбца
	LDI 	I2C_Payload, OLED_COLUMNADDR
	RCALL 	SSD1306_Write_Command ; передача байта по I2C	
	; Начальный адрес
	LDI 	I2C_Payload, 0
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; Конечный адрес
	LDI 	I2C_Payload, 127
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
    
	; Установка строки
	LDI 	I2C_Payload, OLED_PAGEADDR
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; Начальный адрес
	LDI 	I2C_Payload, 0
	RCALL 	SSD1306_Write_Command ; передача байта по I2C	
	; Конечный адрес
	LDI 	I2C_Payload, 3
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
    
    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	LDI 	I2C_Payload, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
send_0xff_256_pcs_1:
	; LDI 	I2C_Payload, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_1

	LDI		Flag, 0xff
	LDI 	I2C_Payload, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
send_0xff_256_pcs_2:
	; LDI 	I2C_Payload, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_2
	
	pop		R20 ; Flag
	pop		R18 ; I2C_Payload
ret

; Подпрограмма передачи команд
SSD1306_Write_Command: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Send
	LDI		R16, OLED_COMMAND_MODE ; send command
	RCALL 	I2C_Send
	MOV		R16, I2C_Payload ; R18 - payload
	RCALL 	I2C_Send
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret

; Подпрограмма передачи данных
SSD1306_Write_Data: ; в регистре R17 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Send
	LDI		R16, OLED_DATA_MODE ; send data
	RCALL 	I2C_Send
	MOV		R16, I2C_Payload ; R18 - payload
	RCALL 	I2C_Send
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret
