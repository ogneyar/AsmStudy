
#ifndef _SSD1306_I2C_ASM_
#define _SSD1306_I2C_ASM_

#include "../libs/defines.inc"  ; подключение файла 'определений'
#include "../libs/i2c.asm"    	; подключение библиотеки I2C (ей требуется I2C_UBRR)
#include "../libs/delay.asm"    ; подключение файла 'задержек'

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
	; OLED_DISPLAY_OFF
	LDI 	R18, OLED_DISPLAY_OFF
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CLOCKDIV
	LDI 	I2C_Payload, OLED_CLOCKDIV
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
    ; value
	LDI 	R18, 0x80
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CHARGEPUMP
	LDI 	R18, OLED_CHARGEPUMP
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	R18, 0x14
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_ADDRESSING_MODE
	LDI 	R18, OLED_ADDRESSING_MODE
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HORIZONTAL or OLED_VERTICAL
	LDI 	R18, OLED_VERTICAL
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_H
	LDI 	R18, OLED_NORMAL_H
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_V
	LDI 	R18, OLED_NORMAL_V
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CONTRAST
	LDI 	R18, OLED_CONTRAST
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	R18, 0x7F
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_SETVCOMDETECT
	LDI 	R18, OLED_SETVCOMDETECT
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LDI 	R18, 0x40
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMALDISPLAY
	LDI 	R18, OLED_NORMALDISPLAY
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETCOMPINS
	LDI 	R18, OLED_SETCOMPINS
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HEIGHT_32 or OLED_HEIGHT_64
	LDI 	R18, OLED_HEIGHT_32
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETMULTIPLEX
	LDI 	R18, OLED_SETMULTIPLEX
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_32 or OLED_64
	LDI 	R18, OLED_32
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_DISPLAY_ON
	LDI 	I2C_Payload, OLED_DISPLAY_ON
	RCALL 	SSD1306_Write_Command ; передача байта по I2C

	pop		R18 ; I2C_Payload
ret

; Подпрограмма передачи команд (ей требуется I2C_Address_Write)
SSD1306_Write_Command: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Send
	LDI		R16, OLED_COMMAND_MODE ; send command
	RCALL 	I2C_Send
	MOV		R16, R18 ; I2C_Payload
	RCALL 	I2C_Send
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret

; Подпрограмма передачи данных (ей требуется I2C_Address_Write)
SSD1306_Write_Data: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Send
	LDI		R16, OLED_DATA_MODE ; send data
	RCALL 	I2C_Send
	MOV		R16, R18 ; I2C_Payload
	RCALL 	I2C_Send
	RCALL 	I2C_Stop
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
	LDI 	R18, 3
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	pop		R18
ret

; Подпрограмма отправки данных на OLED экран
SSD1306_Clear:
	push	R16

	CLR		R16
	RCALL	SSD1306_Send_Data

	pop		R16
ret

; Подпрограмма отправки данных на OLED экран
SSD1306_Send_Data: ; данные ожидаются в R16
	push		R18 ; I2C_Payload
	push		R20 ; Flag

	; установка адреса OLED экрана
	RCALL 	SSD1306_SetColumnAndPage
    
    ; Вывод всех пикселей на экран
	LDI		R20, 0xff ; Flag
	MOV 	R18, R16
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop1_SSD1306_Send_Data:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop1_SSD1306_Send_Data

	LDI		R20, 0xff ; Flag
	MOV 	R18, R16
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop2_SSD1306_Send_Data:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		R20 ; Flag--
	BRNE	loop2_SSD1306_Send_Data

	pop		R20 ; Flag
	pop		R18 ; I2C_Payload
ret

; Подпрограмма отправки данных на OLED экран
SSD1306_Test_Screen:
	push	R16

	RCALL	SSD1306_Clear

	LDI		R16, 0xaa
	RCALL	SSD1306_Send_Data
	
	RCALL 	Delay_1000ms
	
	RCALL	SSD1306_Clear

	RCALL 	Delay_1000ms

	LDI		R16, 0xff
	RCALL	SSD1306_Send_Data

	pop		R16
ret
;=================================================

#endif  /* _SSD1306_I2C_ASM_ */