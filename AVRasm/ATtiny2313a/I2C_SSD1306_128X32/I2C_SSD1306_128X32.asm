
; OLED SSD1306 I2C на микроконтроллере ATtiny2313A

.INCLUDE "../libs/tn2313Adef.inc" ; загрузка предопределений для ATtiny2313A
#include "../libs/macro.inc"    ; подключение файла 'макросов'
#include "../libs/defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 8000000		; Частота МК
	
	.equ 	I2C_DIVIDER				= 1				; делитель
	.equ 	I2C_BAUD 				= 400000		; Скорость обмена по I2C
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
; Program_name: .db "OLED SSD1306 I2C on ATtiny2313A",0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/ssd1306_i2c.asm"    ; подключение библиотеки SSD1306

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
	; инициализация SSD1306
	RCALL 	SSD1306_Init

	; очистка экрана
	RCALL 	SSD1306_Clear

	; вывод данных на экран
	RCALL 	SSD1306_Test_Screen

;=================================================
; Основная программа (цикл)
Main:
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================

