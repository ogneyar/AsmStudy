
#ifndef _SSD1306_ASM_
#define _SSD1306_ASM_

#include "../libs/defines.inc"  ; подключение файла 'определений'
#include "../libs/i2c.asm"    	; подключение библиотеки I2C (ей требуется I2C_UBRR)

; #define SSD1306_128x32
; #define SSD1306_128x64

; библиотеке требуется I2C_UBRR
; библиотеке требуется I2C_Address_Write

;=================================================
; Подпрограмма инициализации OLED экрана (ей требуется I2C_UBRR)
SSD1306_Init:

	; инициализация I2C
	RCALL 	I2C_Init 

	push	R18 ; I2C_Payload

	; for (uint8_t i = 0; i < 15; i++) sendByte(pgm_read_byte(&_oled_init[i]));	
	; OLED_DISPLAY_OFF ; 0xAE
	LDI 	R18, OLED_DISPLAY_OFF
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CLOCKDIV ; 0xD5
	LDI 	R18, OLED_CLOCKDIV 	  
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
    ; value
	LDI 	R18, 0x80
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CHARGEPUMP ; 0x8D
	LDI 	R18, OLED_CHARGEPUMP
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	R18, 0x14
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_ADDRESSING_MODE ; 0x20
	LDI 	R18, OLED_ADDRESSING_MODE
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HORIZONTAL (0x00) or OLED_VERTICAL (0x01)
	LDI 	R18, OLED_HORIZONTAL
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_H ; 0xA1
	LDI 	R18, OLED_NORMAL_H
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_V ; 0xC8
	LDI 	R18, OLED_NORMAL_V
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CONTRAST ; 0x81
	LDI 	R18, OLED_CONTRAST
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	R18, 0x7F
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_SETVCOMDETECT; 0xDB
	LDI 	R18, OLED_SETVCOMDETECT
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	R18, 0x40
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMALDISPLAY ; 0xA6
	LDI 	R18, OLED_NORMALDISPLAY
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETCOMPINS ; 0xDA
	LDI 	R18, OLED_SETCOMPINS
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HEIGHT_32 (0x02) or OLED_HEIGHT_64 (0x12)
	LDI 	R18, OLED_HEIGHT_64
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETMULTIPLEX ; 0xA8
	LDI 	R18, OLED_SETMULTIPLEX
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_32 (0x1F) or OLED_64 (0x3F)
	LDI 	R18, OLED_64
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_DISPLAY_ON ; 0xAF
	LDI 	R18, OLED_DISPLAY_ON
	RCALL 	SSD1306_Write_Command ; передача байта по I2C

	pop		R18 ; I2C_Payload
ret

; Подпрограмма передачи команд (ей требуется I2C_Address_Write)
SSD1306_Write_Command: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Write
	LDI		R16, OLED_COMMAND_MODE ; send command
	RCALL 	I2C_Write
	MOV		R16, R18 ; I2C_Payload
	RCALL 	I2C_Write
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret

; Подпрограмма передачи данных (ей требуется I2C_Address_Write)
SSD1306_Write_Data: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Write
	LDI		R16, OLED_DATA_MODE ; send data
	RCALL 	I2C_Write
	MOV		R16, R18 ; I2C_Payload
	RCALL 	I2C_Write
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret

; Подпрограмма передачи массива данных
SSD1306_Write_Array_Data: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	
	LDI		R16, OLED_ARRAY_DATA_MODE ; send data
	RCALL 	I2C_Write
	MOV		R16, R18 ; I2C_Payload
	RCALL 	I2C_Write
	
	pop		R16 ; Data
ret

; Подпрограмма установки адреса OLED экрана
SSD1306_SetColumnAndPage:
	push	R18	
	; Установка столбца
	LDI 	R18, OLED_COLUMNADDR
	RCALL 	SSD1306_Write_Command ; передача байта по I2C	
	; Начальный адрес
	LDI 	R18, 0
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; Конечный адрес
	LDI 	R18, 127
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
    
	; Установка строки
	LDI 	R18, OLED_PAGEADDR
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; Начальный адрес
	LDI 	R18, 0
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; Конечный адрес	
	LDI 	R18, 7
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	pop		R18
ret

; Подпрограмма отправки данных на OLED экран
SSD1306_Clear:
	push		R18 ; I2C_Payload
	push		R20 ; Flag

	; установка адреса OLED экрана
	RCALL 	SSD1306_SetColumnAndPage
    
	RCALL 	I2C_Start

	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Write

    ; Вывод всех пикселей на экран
	LDI		R20, 0xff ; Flag
	LDI 	R18, 0x00
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop1_SSD1306_Clear:
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop1_SSD1306_Clear

	LDI		R20, 0xff ; Flag
	LDI 	R18, 0x00
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop2_SSD1306_Clear:
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop2_SSD1306_Clear
	
	LDI		R20, 0xff ; Flag
	LDI 	R18, 0x00
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop3_SSD1306_Clear:
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop3_SSD1306_Clear
	
	LDI		R20, 0xff ; Flag
	LDI 	R18, 0x00
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop4_SSD1306_Clear:
	RCALL 	SSD1306_Write_Array_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop4_SSD1306_Clear

	RCALL 	I2C_Stop

	pop		R20 ; Flag
	pop		R18 ; I2C_Payload
ret

;=================================================

#endif  /* _SSD1306_ASM_ */
