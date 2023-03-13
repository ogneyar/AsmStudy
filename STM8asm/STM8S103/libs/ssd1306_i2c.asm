
    #ifdef _SSD1306_I2C_ASM_
    ; nothing
    #else
    #define _SSD1306_I2C_ASM_ 1

    #include "../libs/i2c.asm"
    #include "../libs/defines.inc"  ; подключение файла 'определений'


; ================================================
; подпрограмма инициализации SSD1306
SSD1306_Init:
    push    A

    call    I2C_Init
    
    ; OLED_DISPLAY_OFF ; 0xAE
	LD   	A, #OLED_DISPLAY_OFF
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CLOCKDIV ; 0xD5
	LD 	    A, #OLED_CLOCKDIV 	  
	CALL 	SSD1306_Write_Command ; передача байта по I2C
    ; value
	LD 	    A, #$80
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CHARGEPUMP ; 0x8D
	LD 	    A, #OLED_CHARGEPUMP
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LD 	    A, #$14
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_ADDRESSING_MODE ; 0x20
	LD 	    A, #OLED_ADDRESSING_MODE
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HORIZONTAL (0x00) or OLED_VERTICAL (0x01)
	LD 	    A, #OLED_HORIZONTAL
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_H ; 0xA1
	LD 	    A, #OLED_NORMAL_H
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMAL_V ; 0xC8
	LD 	    A, #OLED_NORMAL_V
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_CONTRAST ; 0x81
	LD 	    A, #OLED_CONTRAST
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LD 	    A, #$7F
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_SETVCOMDETECT; 0xDB
	LD 	    A, #OLED_SETVCOMDETECT
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; value
	LD 	    A, #$40
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_NORMALDISPLAY ; 0xA6
	LD 	    A, #OLED_NORMALDISPLAY
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETCOMPINS ; 0xDA
	LD 	    A, #OLED_SETCOMPINS
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_HEIGHT_32 (0x02) or OLED_HEIGHT_64 (0x12)
    #ifdef SSD1306_128x32
	LD 	    A, #OLED_HEIGHT_32
    #else
	LD 	    A, #OLED_HEIGHT_64
    #endif
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_SETMULTIPLEX ; 0xA8
	LD 	    A, #OLED_SETMULTIPLEX
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; OLED_32 (0x1F) or OLED_64 (0x3F)
    #ifdef SSD1306_128x32
	LD 	    A, #OLED_32
    #else
	LD 	    A, #OLED_64
    #endif
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	;---------------------------------------
	; OLED_DISPLAY_ON ; 0xAF
	LD 	    A, #OLED_DISPLAY_ON
	CALL 	SSD1306_Write_Command ; передача байта по I2C

    pop     A

    ret
; ================================================


; ================================================
; Подпрограмма передачи команд (ей требуется I2C_Address_Device)
SSD1306_Write_Command: ; в регистре A ожидается байт данных (payload)
    ld      XL, A
	push	A

    call    I2C_Wait_Busy

    CALL 	I2C_Start

	LD		A, #I2C_Address_Device
	CALL 	I2C_Write_Address

	LD		A, #OLED_COMMAND_MODE ; send command
	CALL 	I2C_Write

	LD		A, XL ; I2C_Payload
	CALL 	I2C_Write

	CALL 	I2C_Stop
    
	pop		A
    
    ret
; ================================================


; ================================================
; Подпрограмма передачи данных (ей требуется I2C_Address_Device)
SSD1306_Write_Data: ; в регистре A ожидается байт данных (payload)
    ld      XL, A
	push	A

    call    I2C_Wait_Busy

    CALL 	I2C_Start

	LD		A, #I2C_Address_Device
	CALL 	I2C_Write_Address

	LD		A, #OLED_DATA_MODE ; send command
	CALL 	I2C_Write

	LD		A, XL ; I2C_Payload
	CALL 	I2C_Write

	CALL 	I2C_Stop
    
	pop		A
    
    ret
; ================================================


; ================================================
; Подпрограмма передачи массива данных
SSD1306_Write_Array_Data: ; в регистре A ожидается байт данных (payload)
    ld      XL, A
	push	A
	    
	LD		A, #OLED_ARRAY_DATA_MODE ; send array data
	CALL 	I2C_Write

	LD		A, XL ; I2C_Payload
	CALL 	I2C_Write
	
	pop		A
    
    ret
; ================================================


; ================================================
; Подпрограмма установки адреса OLED экрана
SSD1306_SetColumnAndPage:
	push	A	

	; Установка столбца
	LD		A, #OLED_COLUMNADDR
	CALL 	SSD1306_Write_Command ; передача байта по I2C	
	; Начальный адрес
	LD		A, #0
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; Конечный адрес
	LD		A, #127
	CALL 	SSD1306_Write_Command ; передача байта по I2C
    
	; Установка строки
	LD		A, #OLED_PAGEADDR
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; Начальный адрес
	LD		A, #0
	CALL 	SSD1306_Write_Command ; передача байта по I2C
	; Конечный адрес	
    #ifdef SSD1306_128x32
	LD		A, #3
    #else
    LD		A, #7
    #endif
	CALL 	SSD1306_Write_Command ; передача байта по I2C
    
	pop		A
    
    ret
; ================================================


; ================================================
; Подпрограмма заливки экрана
SSD1306_Fill: ; данные ожидаются в регистре A
    ld      YL, A
	push	A

	; установка адреса OLED экрана
	CALL 	SSD1306_SetColumnAndPage
    
    call    I2C_Wait_Busy

	CALL 	I2C_Start

	LD		A, #I2C_Address_Device
	CALL 	I2C_Write_Address

    ; Вывод всех пикселей на экран
    LD		A, #$ff
    LD		XH, A ; Flag
	LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop1_SSD1306_Fill: 
    LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
    LD		A, XH
	DEC		A ; Flag--    
    LD		XH, A
    TNZ     A
	JRNE	loop1_SSD1306_Fill

    LD		A, #$ff
    LD		XH, A ; Flag
	LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop2_SSD1306_Fill:
    LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
    LD		A, XH
	DEC		A ; Flag--    
    LD		XH, A
    TNZ     A
	JRNE	loop2_SSD1306_Fill
    
    #ifdef SSD1306_128x32
	; nothing
    #else
	
    LD		A, #$ff
    LD		XH, A ; Flag
	LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop3_SSD1306_Fill: 
    LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
    LD		A, XH
	DEC		A ; Flag--    
    LD		XH, A
    TNZ     A
	JRNE	loop3_SSD1306_Fill

    LD		A, #$ff
    LD		XH, A ; Flag
	LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
loop4_SSD1306_Fill:
    LD		A, YL
	CALL 	SSD1306_Write_Array_Data ; передача байта по I2C
    LD		A, XH
	DEC		A ; Flag--    
    LD		XH, A
    TNZ     A
	JRNE	loop4_SSD1306_Fill

    #endif
    
	CALL 	I2C_Stop

	pop		A
    
    ret
; ================================================

; ================================================
; Подпрограмма очистка дисплея
SSD1306_Clear:
	push	A

    ld      A, #$00
	; заливаем цветом А
	CALL 	SSD1306_Fill

	pop		A
    
    ret
; ================================================


; ================================================
; Подпрограмма теста экрана
SSD1306_Test:
	push	A

    call    SSD1306_Clear

    call    delay

    ld      A, #$aa
	; заливаем цветом А
	CALL 	SSD1306_Fill

    call    delay

    call    SSD1306_Clear

    call    delay

    ld      A, #$ff
	; заливаем цветом А
	CALL 	SSD1306_Fill

	pop		A
    
    ret
; ================================================

    #endif ; _SSD1306_I2C_ASM_