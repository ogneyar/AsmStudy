
; OLED SSD1306 SPI на микроконтроллере ATtiny13A

#define	SPI_MOSI	PB0	
#define	SPI_SCK		PB2	
#define	SPI_CS		PB3	
#define SPI_DC   	PB4
#define SPI_RES  	PB1

.INCLUDE "../libs/tn13Adef.inc" ; загрузка предопределений для ATtiny13A 
#include "../libs/macro.inc"    ; подключение файла 'макросов'
#include "../libs/defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 9600000		; Частота МК
	
;=================================================
	.def 	Data					= R16			; регистр данных
	.def 	Payload		  			= R18			; регистр данных
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
; Program_name: .db "OLED SSD1306 SPI Master mode on ATtiny13A ",0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/spi.asm"    ; подключение файла 'задержек'

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
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
		
;==============================================================
	; -- инициализация SPI --
	RCALL 	SPI_Master_Init

	; -- инициализация дисплея --
	RCALL 	SSD1306_Init

	; вывод всех пикселей на экран
	RCALL 	SSD1306_Send_Data


;=================================================
; Основная программа (цикл)
Main:	
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;================================================= 




;=====================================================================
; OLED Init
;=====================================================================
SSD1306_Init:
	CBI 	SPI_PORT, SPI_RES ; RST - pull down
	; LDI		Counter, 10
	; RCALL	Wait ; delay(10)
	RCALL	Delay_10ms ; delay(10)
	SBI 	SPI_PORT, SPI_RES ; RST - pull up

	; beginCommand
	CBI 	SPI_PORT, SPI_DC ; DC - pull down

	; for (uint8_t i = 0; i < 15; i++) sendByte(pgm_read_byte(&_oled_init[i]));		
	; OLED_DISPLAY_OFF
	LDI 	R16, OLED_DISPLAY_OFF
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_CLOCKDIV
	LDI 	R16, OLED_CLOCKDIV
	RCALL 	SSD1306_Write ; передача байта по SPI
    ; value
	LDI 	R16, 0x80
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_CHARGEPUMP
	LDI 	R16, OLED_CHARGEPUMP
	RCALL 	SSD1306_Write ; передача байта по SPI
	; value
	LDI 	R16, 0x14
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_ADDRESSING_MODE
	LDI 	R16, OLED_ADDRESSING_MODE
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_VERTICAL
	LDI 	R16, OLED_VERTICAL
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_NORMAL_H
	LDI 	R16, OLED_NORMAL_H
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_NORMAL_V
	LDI 	R16, OLED_NORMAL_V
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_CONTRAST
	LDI 	R16, OLED_CONTRAST
	RCALL 	SSD1306_Write ; передача байта по SPI
	; value
	LDI 	R16, 0x7F
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_SETVCOMDETECT
	LDI 	R16, OLED_SETVCOMDETECT
	RCALL 	SSD1306_Write ; передача байта по SPI
	; value
	LDI 	R16, 0x40
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_NORMALDISPLAY
	LDI 	R16, OLED_NORMALDISPLAY
	RCALL 	SSD1306_Write ; передача байта по SPI

	; OLED_SETCOMPINS
	LDI 	R16, OLED_SETCOMPINS
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_HEIGHT_64 or OLED_HEIGHT_32
	LDI 	R16, OLED_HEIGHT_64
	RCALL 	SSD1306_Write ; передача байта по SPI

	; OLED_SETMULTIPLEX
	LDI 	R16, OLED_SETMULTIPLEX
	RCALL 	SSD1306_Write ; передача байта по SPI
	; OLED_64 or OLED_32
	LDI 	R16, OLED_64
	RCALL 	SSD1306_Write ; передача байта по SPI
	
	; OLED_DISPLAY_ON
	LDI 	R16, OLED_DISPLAY_ON
	RCALL 	SSD1306_Write ; передача байта по SPI
ret
;=====================================================================

;
SSD1306_Write:
    ; beginTransmission
    CBI 	SPI_PORT, SPI_CS ; CS - pull down
	RCALL 	SPI_Transfer ; Data in R16
    ; endTransmission
	SBI 	SPI_PORT, SPI_CS ; CS - pull up
ret

;=====================================================================
; OLED Send Data
;=====================================================================
SSD1306_Send_Data:
	; beginCommand
	CBI 	PORTB, SPI_DC ; DC - pull down

	; Установка столбца
	LDI 	R16, 0x21
	RCALL 	SSD1306_Write ; передача байта по SPI	
	; Начальный адрес
	LDI 	R16, 0
	RCALL 	SSD1306_Write ; передача байта по SPI
	; Конечный адрес
	LDI 	R16, 127
	RCALL 	SSD1306_Write ; передача байта по SPI
    
	; Установка строки
	LDI 	R16, 0x22
	RCALL 	SSD1306_Write ; передача байта по SPI
	; Начальный адрес
	LDI 	R16, 0
	RCALL 	SSD1306_Write ; передача байта по SPI	
	; Конечный адрес
	LDI 	R16, 7
	RCALL 	SSD1306_Write ; передача байта по SPI

	; beginData
	SBI 	PORTB, SPI_DC ; DC - pull up	
    
    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
send_0xff_256_pcs_1:
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_1

	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
send_0xff_256_pcs_2:
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_2
	
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
send_0xff_256_pcs_3:
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_3
	
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
send_0xff_256_pcs_4:
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_4
ret
;=====================================================================


