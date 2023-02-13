
; OLED SSD1306 I2C на микроконтроллере ATtiny88

.INCLUDE "../libs/tn88def.inc" ; загрузка предопределений для ATtiny88
#include "../libs/macro.inc"    ; подключение файла 'макросов'
#include "../libs/defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 16000000		; Частота МК
	
	.equ 	I2C_BAUD 				= 1000000		; Скорость обмена по I2C 1MHz
	.equ 	I2C_UBRR				= ((F_CPU/I2C_BAUD)-16)/2		; prescaler = 1

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
; Program_name: .db "OLED SSD1306 I2C on ATtiny88",0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/ssd1306.asm"    ; подключение библиотеки SSD1306

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI 	R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, R16 ; установка младшего байта указателя стека 
	LDI 	R16, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, R16 ; установка старшего байта указателя стека 

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

;=================================================	
	; инициализация SSD1306
	RCALL 	SSD1306_Init

	; очистка экрана
	RCALL 	SSD1306_Clear

	RCALL 	Delay_1000ms

	; вывод данных на экран
	RCALL 	SSD1306_Send_Data

;=================================================
; Основная программа (цикл)
Main:
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================


; Подпрограмма отправки данных на OLED экран
SSD1306_Send_Data:
	push		R18 ; I2C_Payload
	push		R20 ; Flag

	; установка адреса OLED экрана
	RCALL 	SSD1306_SetColumnAndPage
    
    ; Вывод всех пикселей на экран
	LDI		R20, 0xff ; Flag
	LDI 	R18, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop1_SSD1306_Send_Data:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop1_SSD1306_Send_Data

	LDI		R20, 0xff ; Flag
	LDI 	R18, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop2_SSD1306_Send_Data:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop2_SSD1306_Send_Data

; ------------------------------------------------------
; это надо видимо для экранов с буфером (:
	LDI		R20, 0xff ; Flag
	LDI 	R18, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop3_SSD1306_Send_Data:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop3_SSD1306_Send_Data
	
	LDI		R20, 0xff ; Flag
	LDI 	R18, 0xff
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop4_SSD1306_Send_Data:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop4_SSD1306_Send_Data
; ------------------------------------------------------

	pop		R20 ; Flag
	pop		R18 ; I2C_Payload
ret
