@GNU AS

.syntax unified		@ синтаксис исходного кода
.thumb			@ тип используемых инструкций Thumb
.cpu cortex-m4		@ процессор
.fpu fpv4-sp-d16	@ сопроцессор

@.include "stm32f40x_def.inc"

.section .vectors

@ таблица векторов прерываний
.word	0x20020000	@ Вершина стека
.word	Start+1		@ Вектор сброса
.include "isr_vector.inc"	@ таблица указателей векторов прерываний

.section .asmcode

.equ	xpos, 9
.equ	ypos, 2

MAIN_BASE_PRN:  @ подпрограмма вывода шаблона экрана
		PUSH	{LR}
		BL	LCD_CLEAR
		ADR	R4, ADR_TEXT1   @ выводим текст хабрахабр
		BL	LCD_PUTSTR      @
@		BL      MAIN_line_pix   @ линия точками (пунктир)
		BL	MAIN_rect	@ выводим рамку
		POP	{PC}

MAIN_line_pix:  @ подпрограмма рисования пунктирной линии
		PUSH    {LR}
		MOV	R1, 1+xpos
		MOV	R0, 12+ypos
		MOV	R2, 1
line_pix:
		BL	LCD_PIXEL
		ADD	R1, R1, 3
		CMP	R1, 74
		BMI     line_pix
		POP     {PC}

MAIN_rect:      @ подпрограмма рисования рамки
		PUSH    {LR}
		MOV	R0, 0		@ Y1
		MOV	R1, 0           @ X1
        	MOV	R2, 1
		MOV	R3, 47          @ Y2
		MOV	R4, 83          @ X2
		BL	LCD_RECT        @ рисуем прямоугольник
		POP	{PC}
@ основная программа
Start:		
		BL	SYSCLK168_START

	        BL	SYSTICK_START
		
		BL	LCD_INIT

                BL	DWT_START	@ старт счетчика тактов
MAIN_LOOP:
	@ первый экран ---------------------------------------------------------
		BL	MAIN_BASE_PRN   @ выведем рамку, текст ХАБРАХАБ, пунктир

		ADR	R4, ADR_TEXT2   @ выводим текст STM32 НА АССЕМБЛЕРЕ
		BL	LCD_PUTSTR      @
		
		BL	LCD_REFRESH

		BL	DELAY		@ ПАУЗА ПЕРЕД СМЕНОЙ ЭКРАНА ------------

	@ второй экран ---------------------------------------------------------
		BL	MAIN_BASE_PRN   @ выведем рамку, текст ХАБРАХАБ, пунктир

		ADR	R4, ADR_TEXT3   @ выводим текст HEX ЧИСЛО:
		BL	LCD_PUTSTR      @

		MOV	R2, 1
		MOV	R0, 24           @ Y
		MOV	R1, 24           @ X
		LDR	R4, =0xA1B2C3D4  @ число для печати
		MOV	R5, 10		 @ количество символов
		BL	LCD_PUTHEX       @ десятичная печать

		ADR	R4, ADR_TEXT4   @ выводим текст DEC ЧИСЛО:
		BL	LCD_PUTSTR      @

		MOV	R2, 1
		MOV	R0, 40          @ Y
		MOV	R1, 10          @ X
		LDR	R4, =123456789  @ число для печати
		MOV	R5, 10		@ количество символов
		BL	LCD_PUTDEC      @ десятичная печать

		BL	LCD_REFRESH

		BL	DELAY		@ ПАУЗА ПЕРЕД СМЕНОЙ ЭКРАНА ------------

	@ третий экран ---------------------------------------------------------
		BL	DWT_GETCOUNTER  @ текущий счетчик
		MOV	R10, R0		@

		BL	MAIN_BASE_PRN   @ выведем рамку, текст ХАБРАХАБ, пунктир

		MOV	R3, 16          @ Y2
MAIN_LINE_todown:		
		MOV	R0, 16		@ Y1
		MOV	R1, 10          @ X1
		MOV	R2, 1           @ COLOR
		MOV	R4, 74          @ X2
		BL	LCD_LINE        @ рисование линий вниз
		ADD	R3, R3, 8
		CMP	R3, 40
		BNE	MAIN_LINE_todown

		MOV	R4, 64          @ X2
MAIN_LINE_toleft:
		MOV	R0, 16		@ Y1
		MOV	R1, 10          @ X1
		MOV	R2, 1           @ COLOR
		MOV	R3, 36          @ Y2
		BL	LCD_LINE        @ рисование линии
		SUB     R4, R4, 10
		CMP	R4, 4
		BNE	MAIN_LINE_toleft

		BL	DWT_GETCOUNTER  @ текущий счетчик
		SUB	R4, R0, R10
		MOV	R2, 1
		MOV	R0, 40          @ Y
		MOV	R1, 30          @ X
		MOV	R5, 5		@ количество символов
		BL	LCD_PUTDEC      @ десятичная печать

		BL	LCD_REFRESH

		BL	DELAY		@ ПАУЗА ПЕРЕД СМЕНОЙ ЭКРАНА ------------

		BL	MAIN_LOOP


DELAY:          @ задержка
		PUSH 	{ R0, R1, R2, LR }

		MOV	R1, 1+xpos
		MOV	R0, 12+ypos
		MOV	R2, 1
line_pix1:      @ во время задержки рисуем строчку точек для анимации
		BL	LCD_PIXEL

		PUSH	{R0}
		MOV	R0, 150   	@ задержка мс.
		BL	SYSTICK_DELAY

		BL	LCD_REFRESH
		POP	{R0}
		ADD	R1, R1, 3
		CMP	R1, 74
		BMI     line_pix1

		MOV	R0, 500   	@ задержка мс.
		BL	SYSTICK_DELAY

		POP 	{ R0, R1, R2, PC }

ADR_TEXT1:
		.byte   1
		.short  ypos,    3+xpos
		.word   1
		.byte   'Х'

		.byte   1
		.short  3+ypos,  10+xpos
		.word   0
		.byte   'А'

		.byte   1
		.short  ypos,    17+xpos
                .word   1
		.byte   'Б'

		.byte   1
		.short  3+ypos,  24+xpos
                .word   0
		.byte   'Р'

		.byte   1
		.short  ypos,    31+xpos
                .word   1
		.byte   'А'

		.byte   1
		.short  3+ypos,  38+xpos
                .word   0
		.byte   'Х'

		.byte   1
		.short  ypos,    45+xpos
                .word   1
		.byte   'А'

		.byte   1
		.short  3+ypos,  52+xpos
                .word   0
		.byte   'Б'

		.byte   1
		.short  ypos,    59+xpos
                .word   1
		.byte   'Р'

		.byte	0

ADR_TEXT2:
		.byte   1
		.short  18,      20
                .word   1
                .ascii  "STM32F4"

		.byte	1
		.short  28,      38
                .word   1
                .ascii  "НА"

		.byte	1
		.short  38,      8
                .word   1
                .ascii  "АССЕМБЛЕРЕ"
		.byte	0

ADR_TEXT3:
		.byte   1
		.short  16,      2
                .word   1
                .ascii  "HEX ЧИСЛО:"
		.byte	0

ADR_TEXT4:
		.byte   1
		.short  32,      2
                .word   1
                .ascii  "DEC ЧИСЛО:"
		.byte	0

		