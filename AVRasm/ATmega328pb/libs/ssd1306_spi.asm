
#ifndef _SSD1306_SPI_ASM_
#define _SSD1306_SPI_ASM_

#include "../libs/defines.inc"  ; подключение файла 'определений'
#include "../libs/spi.asm"    	; подключение библиотеки I2C (ей требуется I2C_UBRR)

#define PORT_RES 	PORTB0
#define PORT_DC  	PORTB1
#define PORT_CS 	PORTB2

;=====================================================================
; OLED Init
;=====================================================================
SSD1306_Init:
	SBI 	PORTB, PORT_CS ; CS - pull up

	SBI 	PORTB, PORT_RES ; RST - pull up
	; надо delay(1) ну и пусть будет delay(100)
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PORT_RES ; RST - pull down
	; надо delay(10) ну и пусть будет delay(100)
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	SBI 	PORTB, PORT_RES ; RST - pull up

	; beginCommand
    CBI 	PORTB, PORT_CS ; CS - pull down
	CBI 	PORTB, PORT_DC ; DC - pull down

	; for (uint8_t i = 0; i < 15; i++) sendByte(pgm_read_byte(&_oled_init[i]));		
	; OLED_DISPLAY_OFF
	LDI 	R16, OLED_DISPLAY_OFF
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_CLOCKDIV
	LDI 	R16, OLED_CLOCKDIV
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
    ; value
	LDI 	R16, 0x80
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_CHARGEPUMP
	LDI 	R16, OLED_CHARGEPUMP
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; value
	LDI 	R16, 0x14
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_ADDRESSING_MODE
	LDI 	R16, OLED_ADDRESSING_MODE
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_VERTICAL
	LDI 	R16, OLED_VERTICAL
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_NORMAL_H
	LDI 	R16, OLED_NORMAL_H
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_NORMAL_V
	LDI 	R16, OLED_NORMAL_V
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_CONTRAST
	LDI 	R16, OLED_CONTRAST
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; value
	LDI 	R16, 0x7F
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_SETVCOMDETECT
	LDI 	R16, OLED_SETVCOMDETECT
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; value
	LDI 	R16, 0x40
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_NORMALDISPLAY
	LDI 	R16, OLED_NORMALDISPLAY
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_DISPLAY_ON
	LDI 	R16, OLED_DISPLAY_ON
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_SETCOMPINS
	LDI 	R16, OLED_SETCOMPINS
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_HEIGHT_64
	LDI 	R16, OLED_HEIGHT_64
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_SETMULTIPLEX
	LDI 	R16, OLED_SETMULTIPLEX
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_64
	LDI 	R16, OLED_64
	RCALL 	SPI_Master_SendByte ; передача байта по SPI


    ; endTransmission
	SBI 	PORTB, PORT_CS ; CS - pull up
ret
;=====================================================================

SSD1306_Set_Column_And_Page:
	push 	R16
	
	; beginCommand
    CBI 	PORTB, PORT_CS ; CS - pull down
	CBI 	PORTB, PORT_DC ; DC - pull down

	; Установка столбца
	LDI 	R16, 0x21
	RCALL 	SPI_Master_SendByte ; передача байта по SPI	
	; Начальный адрес
	LDI 	R16, 0
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; Конечный адрес
	LDI 	R16, 127
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
    
	; Установка строки
	LDI 	R16, 0x22
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; Начальный адрес
	LDI 	R16, 0
	RCALL 	SPI_Master_SendByte ; передача байта по SPI	
	; Конечный адрес
	LDI 	R16, 7
	RCALL 	SPI_Master_SendByte ; передача байта по SPI

 	; endTransmission
	SBI 	PORTB, PORT_CS ; CS - pull up
	
	pop 	R16
ret

;=====================================================================
; OLED Send Data
;=====================================================================
SSD1306_Send_Data: ; ожидает данные в R16
	push 	Flag

	RCALL	SSD1306_Set_Column_And_Page
	
	; beginData
    CBI 	PORTB, PORT_CS ; CS - pull down
	SBI 	PORTB, PORT_DC ; DC - pull up	
    
    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_1:
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_1

	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_2:
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_2
	
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_3:
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_3
	
	LDI		Flag, 0xff
	; LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_4:
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_4
	
	pop 	Flag
ret
;=====================================================================


;=====================================================================
; OLED Clear
;=====================================================================
SSD1306_Clear:
	push 	R16
	
	RCALL	SSD1306_Set_Column_And_Page

	LDI 	R16, 0x00
	RCALL	SSD1306_Send_Data	
	
	pop 	R16
ret
;=====================================================================



;=====================================================================
; OLED Fill
;=====================================================================
SSD1306_Fill: ; ожидает данные в R16
	RCALL	SSD1306_Set_Column_And_Page

	RCALL	SSD1306_Send_Data	
ret
;=====================================================================


#endif  /* _SSD1306_SPI_ASM_ */
