
; OLED ST7735 SPI на микроконтроллере ATtiny88

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
	RCALL 	ST7735_Init
	
	; очистка экрана
	RCALL	ST7735_Clear

	; задержка 1 сек
	RCALL 	Delay_1000ms
	
	mSetCol	_WHITE ; установка цвета
	RCALL	ST7735_Fill ; вывод всех пикселей на экран

	; задержка 1 сек
	RCALL 	Delay_1000ms
	
	mSetCol	_RED ; установка цвета
	RCALL	ST7735_Fill ; вывод всех пикселей на экран

	; задержка 1 сек
	RCALL 	Delay_1000ms
	
	mSetCol	_BLUE ; установка цвета
	RCALL	ST7735_Fill ; вывод всех пикселей на экран
	
	; задержка 1 сек
	RCALL 	Delay_1000ms
	
	mSetCol	_GREEN ; установка цвета
	RCALL	ST7735_Fill ; вывод всех пикселей на экран


;=================================================
; Основная программа (цикл)
Main:	
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;================================================= 


;
ST7735_Init:
	; display reset
	CBI 	PORT_SPI, DD_RES ; RST - pull down
	RCALL	Delay_10ms ; delay(10)
	SBI 	PORT_SPI, DD_RES ; RST - pull up
	RCALL	Delay_10ms ; delay(10)
	
    ; chip_select_enable();
    CBI 	PORT_SPI, DD_SS ; CS - pull down

	; ST77XX_SWRESET - Software reset, 0 args, w/delay
	LDI 	R16, ST77XX_SWRESET
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	RCALL	Delay_100ms
	RCALL	Delay_50ms

	; ST77XX_SLPOUT -  Out of sleep mode, 0 args, w/delay
	LDI 	R16, ST77XX_SLPOUT
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	RCALL	Delay_250ms

	; ST77XX_INVON - Invert display, no args
	LDI 	R16, ST77XX_INVON
	RCALL 	ST7735_Write_Command 	; передача команды по SPI

	; ST77XX_COLMOD - set color mode, 1 arg
	LDI 	R16, ST77XX_COLMOD
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	LDI 	R16,  0x05 ; 16-bit/pixel 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI

	; ST7735_GMCTRP1 - Gamma Adjustments (pos. polarity), 16 args
	LDI 	R16, ST7735_GMCTRP1
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	LDI 	R16,  0x02 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x1C
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x07 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x12
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x37 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x32
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x29 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x2D
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x29 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x25
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x2B 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x39
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x00 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x01
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x03 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x10
	RCALL 	ST7735_Write_Data 		; передача данных по SPI


	; ST7735_GMCTRN1 - Gamma Adjustments (neg. polarity), 16 args
	LDI 	R16, ST7735_GMCTRN1
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	LDI 	R16,  0x03 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x1D
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x07 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x06
	RCALL 	ST7735_Write_Data 		; передача данных по SPI	
	LDI 	R16,  0x2E 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x2C
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x29 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x2D
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x2E 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x2E
	RCALL 	ST7735_Write_Data 		; передача данных по SPI	
	LDI 	R16,  0x37 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x3F
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x00 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x00
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x02 
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16,  0x10
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	
	; ST77XX_DISPON - Main screen turn on, no args w/delay
	LDI 	R16, ST77XX_DISPON
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	RCALL	Delay_100ms

    ; chip_select_disable
	SBI 	PORT_SPI, DD_SS ; CS - pull up
ret

;
ST7735_Write_Command:
	; beginCommand
	CBI 	PORT_SPI, DD_DC ; DC - pull down	
	RCALL 	SPI_Master_SendByte ; Data in R16
	NOP
	NOP
	NOP
ret

;
ST7735_Write_Data:
	; beginData
	SBI 	PORT_SPI, DD_DC ; DC - pull up	
	RCALL 	SPI_Master_SendByte ; Data in R16
	NOP
	NOP
	NOP
ret

ST7735_Fill: ; ожидается цвет в ZL:ZH
    ; chip_select_enable();
    CBI 	PORT_SPI, DD_SS ; CS - pull down

	; st7735_set_column_and_page
	RCALL 	ST7735_SetColumnAndPage ; установка адреса экрана

	; ST77XX_RAMWR
	LDI 	R16, ST77XX_RAMWR
	RCALL 	ST7735_Write_Command 	; передача команды по SPI

	; st7735_display(color);
	RCALL 	ST7735_Display
	
    ; chip_select_disable
	SBI 	PORT_SPI, DD_SS ; CS - pull up
ret

; очистка экрана
ST7735_Clear:
	mSetCol	_BLACK
	RCALL	ST7735_Fill
ret

; установка адреса экрана
ST7735_SetColumnAndPage:
	; ST77XX_CASET
	LDI 	R16, ST77XX_CASET
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	LDI 	R16, 0x00
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16, 0x1a
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16, 0x00
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16, 0x6a
	RCALL 	ST7735_Write_Data 		; передача данных по SPI

	; ST77XX_RASET
	LDI 	R16, ST77XX_RASET
	RCALL 	ST7735_Write_Command 	; передача команды по SPI
	LDI 	R16, 0x00
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16, 0x00
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16, 0x00
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	LDI 	R16, 0xa0
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
ret

; вывод буфера на экран
ST7735_Display: 
	push	r16
	push	r17
	push	r18
	
	ldi 	r18, high(13040) ; средний байт N
	ldi 	r17, low(13040) ; младший байт N
Loop_ST7735_Display: ; цикл от 0 до 13040

	MOV 	R16, ZL
	RCALL 	ST7735_Write_Data 		; передача данных по SPI
	MOV 	R16, ZH
	RCALL 	ST7735_Write_Data 		; передача данных по SPI

	subi 	r17, 1 ; Subtract Immediate
	sbci 	r18, 0 ; Subtract Immediate with Carry
	brcc 	Loop_ST7735_Display ; Branch if Carry Cleared
	
	pop		r18
	pop		r17
	pop		r16	 
ret

