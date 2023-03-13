@GNU AS

@ ���� ����������� ���� ����������������, �� �������������� ��� 
@ ������������ ����� Open407I-C, ����� STM32F4 Discovery
@.set DEVBOARD, STM32F4DISCO

.syntax unified		@ ��������� ��������� ����
.thumb			@ ��� ������������ ���������� Thumb
.cpu cortex-m4		@ ���������
.fpu fpv4-sp-d16	@ �����������

.include "stm32f40x_def.inc"

@ ����������� � ����������� �� ���������� �����
.ifdef DEVBOARD
   .equ GPIO_LED	,GPIOD_BASE       	@ ���� ����������� ����������
   .equ RCC_GPIO_EN	,RCC_AHB1ENR_GPIODEN_N  @ ��� ��������� GPIO
   .equ GPIO_ODR_NUM	,15			@ ����� ���� GPIO
.else
   .equ GPIO_LED	,GPIOH_BASE
   .equ RCC_GPIO_EN	,RCC_AHB1ENR_GPIOHEN_N
   .equ GPIO_ODR_NUM	,2
.endif

.equ GPIO_MODER_MDR	,1<<(GPIO_ODR_NUM*2)

.section .vectors

@ ������� �������� ����������
.word	0x20020000	@ ������� �����
.word	Start+1		@ ������ ������
.include "isr_vector.inc"	@ ������� ���������� �������� ����������

.section .asmcode

@ �������� ���������
Start:		
		BL	SYSCLK168_START

	        BL	SYSTICK_START
		
		BL	LCD_INIT
		BL	LCD_CLEAR

.equ	xpos, 9
.equ	ypos, 2

		MOV	R1, 1+xpos
		MOV	R0, 12+ypos
		MOV	R2, 1
line_pix:
		BL	LCD_PIXEL
		ADD	R1, R1, 3
		CMP	R1, 74
		BMI     line_pix

		ADR	R4, ADR_TEXT
		BL	LCD_PUTSTR

		MOV	R0, 40          @ Y
		MOV	R1, 16          @ X
		LDR	R4, =0xA0B1C2D3 @ ����� ��� ������
		MOV	R5, 8		@ ���������� ��������
		BL	LCD_PUTHEX      @ ����������������� ������

		MOV	R0, 0		@ Y1
		MOV	R1, 0           @ X1
        	MOV	R2, 1
		MOV	R3, 47          @ Y2
		MOV	R4, 83          @ X2
		BL	LCD_RECT        @ ������ �������������

		BL	LCD_REFRESH

		MOV     R0, 0         @ �������� 0, ����� �������������� ��� bitband
		MOV     R1, 1         @ �������� 1, ����� �������������� ��� bitband

		@ ������� ������������ GPIO_H
		LDR     R2, =(PERIPH_BB_BASE + (RCC_BASE + RCC_AHB1ENR) * 32 + RCC_GPIO_EN * 4)
		STR     R1, [R2]       @ ������ R1 ("1") �� ������ ���� ���������� � R2

		@ ��������� ����� GPIO_H pin_15
		LDR     R2, =(PERIPH_BASE + GPIO_LED + GPIO_MODER)  @ �����
		LDR     R3, =GPIO_MODER_MDR                         @ ��������
		LDR     R4, [R2]       @ ��������� �������� ��������
		ORR     R3, R3, R4     @ ����������, ��������� ���
		STR     R3, [R2]       @ ������ ������������ �������� � GPIOD_MODER

		LDR     R2, =(PERIPH_BB_BASE + (GPIO_LED + GPIO_ODR) * 32 + GPIO_ODR_NUM*4)  @ ����� ����

BLINK_LOOP:
		@ ������� ���������
		STR     R1, [R2]       @ ������ R1 ("1") �� ������ ���������� � R2
	
		BL      DELAY          @  �����
	
		@ �������� ���������
		STR     R0, [R2]        @ ������ R0 ("0") �� ������ ���������� � R2

		BL      DELAY           @  �����	

		B       BLINK_LOOP      @ ������ ����

DELAY:
		PUSH 	{ R0, LR }
		MOV	R0, 250   	@ �������� 250 ��.
		BL	SYSTICK_DELAY
		POP 	{ R0, PC }

ADR_TEXT:
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

		.byte   1
		.short  16,      20
                .word   1
                .ascii  "STM32F4"

		.byte	1
		.short  24,      38
                .word   1
                .ascii  "��"

		.byte	1
		.short  32,      10
                .word   1
                .ascii  "����������"

		.byte	0
		