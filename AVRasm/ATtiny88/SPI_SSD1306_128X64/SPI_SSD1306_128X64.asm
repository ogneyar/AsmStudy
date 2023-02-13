
; OLED SSD1306 SPI на микроконтроллере ATtiny88

#define	SPI_MOSI	PB0	
#define	SPI_SCK		PB2	
#define	SPI_CS		PB3	
#define SPI_DC   	PB4
#define SPI_RES  	PB1

.INCLUDE "../libs/tn88def.inc" ; загрузка предопределений для ATtiny88 
#include "../libs/macro.inc"    ; подключение файла 'макросов'
#include "../libs/defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 16000000		; Частота МК
	
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
; Program_name: .db "OLED SSD1306 SPI Master mode on ATtiny88",0

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
	LDI 	R16, High(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
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
		
;==============================================================
	; -- инициализация SPI --
	LDI 	DD_Speed, 2 ; 0 - 125KHz, 1 - 250KHz, 2 - 1MHz, 3 - 4MHz
	RCALL 	SPI_Master_Init

	; -- инициализация дисплея --
	RCALL 	SSD1306_Init
	
	; очистка экрана
	RCALL	SSD1306_Clear

	; задержка 1 сек
	RCALL 	Delay_1000ms

	; вывод всех пикселей на экран
	RCALL 	SSD1306_Send_Data

	; задержка 1 сек
	RCALL 	Delay_1000ms
	
	; очистка экрана
	RCALL	SSD1306_Clear

	; задержка 1 сек
	RCALL 	Delay_1000ms
	
	; вывод чередующихся пикселей на экран
	RCALL 	SSD1306_Send_Data_2


;=================================================
; Основная программа (цикл)
Main:	
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;================================================= 


;
SSD1306_Init:
	; display reset
	CBI 	PORT_SPI, DD_RES ; RST - pull down
	RCALL	Delay_10ms ; delay(10)
	SBI 	PORT_SPI, DD_RES ; RST - pull up

	; beginCommand
	CBI 	PORT_SPI, DD_DC ; DC - pull down

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

;
SSD1306_Write:
    ; beginTransmission
    CBI 	PORT_SPI, DD_SS ; CS - pull down
	RCALL 	SPI_Master_SendByte ; Data in R16
    ; endTransmission
	SBI 	PORT_SPI, DD_SS ; CS - pull up
ret

;
SSD1306_Send_Data:	
	; установка адреса экрана
	RCALL 	SSD1306_SetColumnAndPage

	; beginData
	SBI 	PORT_SPI, DD_DC ; DC - pull up	
    
    ; Вывод всех пикселей на экран
;-------------------------------------- 1 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop1_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop1_SSD1306_Send_Data
;-------------------------------------- 2 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop2_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop2_SSD1306_Send_Data
;-------------------------------------- 3 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop3_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop3_SSD1306_Send_Data
;-------------------------------------- 4 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop4_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop4_SSD1306_Send_Data
ret

;
SSD1306_Send_Data_2:	
	; установка адреса экрана
	RCALL 	SSD1306_SetColumnAndPage

	; beginData
	SBI 	PORT_SPI, DD_DC ; DC - pull up	
    
    ; Вывод всех пикселей на экран
;-------------------------------------- 1 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xaa
	RCALL 	SSD1306_Write ; передача байта по SPI
loop1_SSD1306_Send_Data_2:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop1_SSD1306_Send_Data_2
;-------------------------------------- 2 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xaa
	RCALL 	SSD1306_Write ; передача байта по SPI
loop2_SSD1306_Send_Data_2:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop2_SSD1306_Send_Data_2
;-------------------------------------- 3 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xaa
	RCALL 	SSD1306_Write ; передача байта по SPI
loop3_SSD1306_Send_Data_2:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop3_SSD1306_Send_Data_2
;-------------------------------------- 4 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0xaa
	RCALL 	SSD1306_Write ; передача байта по SPI
loop4_SSD1306_Send_Data_2:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop4_SSD1306_Send_Data_2
ret

;
SSD1306_SetColumnAndPage:
	; beginCommand
	CBI 	PORT_SPI, DD_DC ; DC - pull down

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
ret

; 
SSD1306_Clear:
	; установка адреса экрана
	RCALL 	SSD1306_SetColumnAndPage

	; beginData
	SBI 	PORT_SPI, DD_DC ; DC - pull up	  

    ; Вывод всех пикселей на экран
;-------------------------------------- 1 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0x00
	RCALL 	SSD1306_Write ; передача байта по SPI
loop1_SSD1306_Clear:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop1_SSD1306_Clear
;-------------------------------------- 2 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0x00
	RCALL 	SSD1306_Write ; передача байта по SPI
loop2_SSD1306_Clear:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop2_SSD1306_Clear
;-------------------------------------- 3 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0x00
	RCALL 	SSD1306_Write ; передача байта по SPI
loop3_SSD1306_Clear:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop3_SSD1306_Clear
;-------------------------------------- 4 - 256
	LDI		Flag, 0xff
	LDI 	R16, 0x00
	RCALL 	SSD1306_Write ; передача байта по SPI
loop4_SSD1306_Clear:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop4_SSD1306_Clear
ret

