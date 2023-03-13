@GNU AS

.syntax unified		@ ��������� ��������� ����
.thumb			@ ��� ������������ ���������� Thumb
.cpu cortex-m4		@ ���������
.fpu fpv4-sp-d16	@ �����������

@.include "stm32f40x_def.inc"

.section .vectors

@ ������� �������� ����������
.word	0x20020000	@ ������� �����
.word	Start+1		@ ������ ������
.include "isr_vector.inc"	@ ������� ���������� �������� ����������

.section .asmcode

.equ	xpos, 9
.equ	ypos, 2

MAIN_BASE_PRN:  @ ������������ ������ ������� ������
		PUSH	{LR}
		BL	LCD_CLEAR
		ADR	R4, ADR_TEXT1   @ ������� ����� ���������
		BL	LCD_PUTSTR      @
@		BL      MAIN_line_pix   @ ����� ������� (�������)
		BL	MAIN_rect	@ ������� �����
		POP	{PC}

MAIN_line_pix:  @ ������������ ��������� ���������� �����
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

MAIN_rect:      @ ������������ ��������� �����
		PUSH    {LR}
		MOV	R0, 0		@ Y1
		MOV	R1, 0           @ X1
        	MOV	R2, 1
		MOV	R3, 47          @ Y2
		MOV	R4, 83          @ X2
		BL	LCD_RECT        @ ������ �������������
		POP	{PC}
@ �������� ���������
Start:		
		BL	SYSCLK168_START

	        BL	SYSTICK_START
		
		BL	LCD_INIT

                BL	DWT_START	@ ����� �������� ������
MAIN_LOOP:
	@ ������ ����� ---------------------------------------------------------
		BL	MAIN_BASE_PRN   @ ������� �����, ����� ��������, �������

		ADR	R4, ADR_TEXT2   @ ������� ����� STM32 �� ����������
		BL	LCD_PUTSTR      @
		
		BL	LCD_REFRESH

		BL	DELAY		@ ����� ����� ������ ������ ------------

	@ ������ ����� ---------------------------------------------------------
		BL	MAIN_BASE_PRN   @ ������� �����, ����� ��������, �������

		ADR	R4, ADR_TEXT3   @ ������� ����� HEX �����:
		BL	LCD_PUTSTR      @

		MOV	R2, 1
		MOV	R0, 24           @ Y
		MOV	R1, 24           @ X
		LDR	R4, =0xA1B2C3D4  @ ����� ��� ������
		MOV	R5, 10		 @ ���������� ��������
		BL	LCD_PUTHEX       @ ���������� ������

		ADR	R4, ADR_TEXT4   @ ������� ����� DEC �����:
		BL	LCD_PUTSTR      @

		MOV	R2, 1
		MOV	R0, 40          @ Y
		MOV	R1, 10          @ X
		LDR	R4, =123456789  @ ����� ��� ������
		MOV	R5, 10		@ ���������� ��������
		BL	LCD_PUTDEC      @ ���������� ������

		BL	LCD_REFRESH

		BL	DELAY		@ ����� ����� ������ ������ ------------

	@ ������ ����� ---------------------------------------------------------
		BL	DWT_GETCOUNTER  @ ������� �������
		MOV	R10, R0		@

		BL	MAIN_BASE_PRN   @ ������� �����, ����� ��������, �������

		MOV	R3, 16          @ Y2
MAIN_LINE_todown:		
		MOV	R0, 16		@ Y1
		MOV	R1, 10          @ X1
		MOV	R2, 1           @ COLOR
		MOV	R4, 74          @ X2
		BL	LCD_LINE        @ ��������� ����� ����
		ADD	R3, R3, 8
		CMP	R3, 40
		BNE	MAIN_LINE_todown

		MOV	R4, 64          @ X2
MAIN_LINE_toleft:
		MOV	R0, 16		@ Y1
		MOV	R1, 10          @ X1
		MOV	R2, 1           @ COLOR
		MOV	R3, 36          @ Y2
		BL	LCD_LINE        @ ��������� �����
		SUB     R4, R4, 10
		CMP	R4, 4
		BNE	MAIN_LINE_toleft

		BL	DWT_GETCOUNTER  @ ������� �������
		SUB	R4, R0, R10
		MOV	R2, 1
		MOV	R0, 40          @ Y
		MOV	R1, 30          @ X
		MOV	R5, 5		@ ���������� ��������
		BL	LCD_PUTDEC      @ ���������� ������

		BL	LCD_REFRESH

		BL	DELAY		@ ����� ����� ������ ������ ------------

		BL	MAIN_LOOP


DELAY:          @ ��������
		PUSH 	{ R0, R1, R2, LR }

		MOV	R1, 1+xpos
		MOV	R0, 12+ypos
		MOV	R2, 1
line_pix1:      @ �� ����� �������� ������ ������� ����� ��� ��������
		BL	LCD_PIXEL

		PUSH	{R0}
		MOV	R0, 150   	@ �������� ��.
		BL	SYSTICK_DELAY

		BL	LCD_REFRESH
		POP	{R0}
		ADD	R1, R1, 3
		CMP	R1, 74
		BMI     line_pix1

		MOV	R0, 500   	@ �������� ��.
		BL	SYSTICK_DELAY

		POP 	{ R0, R1, R2, PC }

ADR_TEXT1:
		.byte   1
		.short  ypos,    3+xpos
		.word   1
		.byte   '�'

		.byte   1
		.short  3+ypos,  10+xpos
		.word   0
		.byte   '�'

		.byte   1
		.short  ypos,    17+xpos
                .word   1
		.byte   '�'

		.byte   1
		.short  3+ypos,  24+xpos
                .word   0
		.byte   '�'

		.byte   1
		.short  ypos,    31+xpos
                .word   1
		.byte   '�'

		.byte   1
		.short  3+ypos,  38+xpos
                .word   0
		.byte   '�'

		.byte   1
		.short  ypos,    45+xpos
                .word   1
		.byte   '�'

		.byte   1
		.short  3+ypos,  52+xpos
                .word   0
		.byte   '�'

		.byte   1
		.short  ypos,    59+xpos
                .word   1
		.byte   '�'

		.byte	0

ADR_TEXT2:
		.byte   1
		.short  18,      20
                .word   1
                .ascii  "STM32F4"

		.byte	1
		.short  28,      38
                .word   1
                .ascii  "��"

		.byte	1
		.short  38,      8
                .word   1
                .ascii  "����������"
		.byte	0

ADR_TEXT3:
		.byte   1
		.short  16,      2
                .word   1
                .ascii  "HEX �����:"
		.byte	0

ADR_TEXT4:
		.byte   1
		.short  32,      2
                .word   1
                .ascii  "DEC �����:"
		.byte	0

		