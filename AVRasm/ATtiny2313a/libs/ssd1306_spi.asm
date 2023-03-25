
#ifndef _SSD1306_SPI_ASM_
#define _SSD1306_SPI_ASM_

#include "../libs/defines.inc"  ; подключение файла 'определений'
#include "../libs/spi.asm"    	; подключение библиотеки SPI
#include "../libs/delay.asm"    ; подключение файла 'задержек'

; #define SSD1306_128x32
; #define SSD1306_128x64


; инициализация экрана
SSD1306_Init:
	; -- инициализация SPI --
	RCALL 	SPI_Master_Init
	; display reset
	CBI 	SPI_PORT, SPI_RES ; RST - pull down
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

;
SSD1306_Write:
    ; beginTransmission
    CBI 	SPI_PORT, SPI_CS ; CS - pull down
	RCALL 	SPI_Transfer ; Data in R16
    ; endTransmission
	SBI 	SPI_PORT, SPI_CS ; CS - pull up
ret

;
SSD1306_Send_Data: ; данные ожидаются в R16
	; установка адреса экрана
	RCALL 	SSD1306_SetColumnAndPage

	; beginData
	SBI 	SPI_PORT, SPI_DC ; DC - pull up	
    
    ; Вывод всех пикселей на экран
;-------------------------------------- 1 - 256
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop1_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop1_SSD1306_Send_Data
;-------------------------------------- 2 - 256
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop2_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop2_SSD1306_Send_Data
;-------------------------------------- 3 - 256
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop3_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop3_SSD1306_Send_Data
;-------------------------------------- 4 - 256
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SSD1306_Write ; передача байта по SPI
loop4_SSD1306_Send_Data:
	RCALL 	SSD1306_Write ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	loop4_SSD1306_Send_Data
ret

;
SSD1306_SetColumnAndPage:
    push    R16
	; beginCommand
	CBI 	SPI_PORT, SPI_DC ; DC - pull down

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
    pop     R16
ret

; очистка экрана
SSD1306_Clear:
    push    R16

    LDI 	R16, 0x00
    RCALL 	SSD1306_Send_Data

    pop     R16
ret

;
SSD1306_Test_Screen:	
    push    R16
    
	RCALL	SSD1306_Clear

	LDI		R16, 0xaa
	RCALL	SSD1306_Send_Data
	
	RCALL 	Delay_1000ms
	
	RCALL	SSD1306_Clear

	RCALL 	Delay_1000ms

	LDI		R16, 0xff
	RCALL	SSD1306_Send_Data

    pop     R16
ret
;=================================================

#endif  /* _SSD1306_SPI_ASM_ */
