
#ifndef _SSD1306_ASM_
#define _SSD1306_ASM_


#include "E:\VSCode\AsmStudy\AVRasm\ATtiny104\libs\defines.inc"  ; подключение файла 'определений'


; Подпрограмма инициализации OLED экрана
SSD1306_Init:
	push	R18 ; I2C_Payload
	; for (uint8_t i = 0; i < 15; i++) sendByte(pgm_read_byte(&_oled_init[i]));		
	; OLED_DISPLAY_OFF
	LDI 	R18, OLED_DISPLAY_OFF
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CLOCKDIV
	LDI 	R18, OLED_CLOCKDIV
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
	LDI 	R18, OLED_HEIGHT_64
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
	LDI 	R18, OLED_DISPLAY_ON
	RCALL 	SSD1306_Write_Command ; передача байта по I2C
	pop		R18 ; I2C_Payload
ret


; Подпрограмма установки колонок и строк
SSD1306_SetColumnAndPage:
	push	R18 ; I2C_Payload

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

	pop		R18 ; I2C_Payload
ret


; Подпрограмма отправки данных на OLED экран
SSD1306_Send_Data: ; data in R16
	push	R18 ; I2C_Payload
	push	R20 ; Flag
    
	RCALL	SSD1306_SetColumnAndPage

    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	MOV 	R18, R16
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
send_0xff_256_pcs_1:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_1
	
	LDI		Flag, 0xff
	MOV 	R18, R16
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
send_0xff_256_pcs_2:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_2
	
	pop		R20 ; Flag
	pop		R18 ; I2C_Payload
ret

; Подпрограмма очистки экрана
SSD1306_Clear:
	push	R18 ; I2C_Payload
	push	R20 ; Flag
    
	RCALL	SSD1306_SetColumnAndPage

    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	LDI 	R18, 0x00
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop_SSD1306_Clear:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		Flag ; Flag--
	BRNE	loop_SSD1306_Clear
	
    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	LDI 	R18, 0x00
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
loop_2_SSD1306_Clear:
	RCALL 	SSD1306_Write_Data ; передача байта по I2C
	DEC		Flag ; Flag--
	BRNE	loop_2_SSD1306_Clear
	
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
	MOV		R16, R18 ; R18 - payload
	RCALL 	I2C_Send
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret

; Подпрограмма передачи данных
SSD1306_Write_Data: ; в регистре R18 ожидается байт данных (payload)
	push	R16 ; Data
	RCALL 	I2C_Start
	LDI		R16, I2C_Address_Write
	RCALL 	I2C_Send
	LDI		R16, OLED_DATA_MODE ; send data
	RCALL 	I2C_Send
	MOV		R16, R18 ; R18 - payload
	RCALL 	I2C_Send
	RCALL 	I2C_Stop
	pop		R16 ; Data
ret
;=============================================================


#endif  /* _SSD1306_ASM_ */


