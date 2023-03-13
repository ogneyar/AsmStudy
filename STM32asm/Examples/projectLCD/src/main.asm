@GNU AS

@ Если определение ниже закомментировано, то предполагается что 
@ использована плата Open407I-C, иначе STM32F4 Discovery
@.set DEVBOARD, STM32F4DISCO

.syntax unified		@ синтаксис исходного кода
.thumb			@ тип используемых инструкций Thumb
.cpu cortex-m4		@ процессор
.fpu fpv4-sp-d16	@ сопроцессор

.include "stm32f40x_def.inc"

@ Определения в зависимости от отладочной платы
.ifdef DEVBOARD
   .equ GPIO_LED	,GPIOD_BASE       	@ порт подключения светодиода
   .equ RCC_GPIO_EN	,RCC_AHB1ENR_GPIODEN_N  @ бит включения GPIO
   .equ GPIO_ODR_NUM	,15			@ номер пина GPIO
.else
   .equ GPIO_LED	,GPIOH_BASE
   .equ RCC_GPIO_EN	,RCC_AHB1ENR_GPIOHEN_N
   .equ GPIO_ODR_NUM	,2
.endif

.equ GPIO_MODER_MDR	,1<<(GPIO_ODR_NUM*2)

.section .vectors

@ таблица векторов прерываний
.word	0x20020000	@ Вершина стека
.word	Start+1		@ Вектор сброса
.include "isr_vector.inc"	@ таблица указателей векторов прерываний

.section .asmcode

@ основная программа
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
		LDR	R4, =0xA0B1C2D3 @ число для печати
		MOV	R5, 8		@ количество символов
		BL	LCD_PUTHEX      @ шестнадцатеричная печать

		MOV	R0, 0		@ Y1
		MOV	R1, 0           @ X1
        	MOV	R2, 1
		MOV	R3, 47          @ Y2
		MOV	R4, 83          @ X2
		BL	LCD_RECT        @ рисуем прямоугольник

		BL	LCD_REFRESH

		MOV     R0, 0         @ Значение 0, будет использоваться для bitband
		MOV     R1, 1         @ значение 1, будет использоваться для bitband

		@ включим тактирование GPIO_H
		LDR     R2, =(PERIPH_BB_BASE + (RCC_BASE + RCC_AHB1ENR) * 32 + RCC_GPIO_EN * 4)
		STR     R1, [R2]       @ запись R1 ("1") по адресу бита указанному в R2

		@ установим режим GPIO_H pin_15
		LDR     R2, =(PERIPH_BASE + GPIO_LED + GPIO_MODER)  @ адрес
		LDR     R3, =GPIO_MODER_MDR                         @ значение
		LDR     R4, [R2]       @ прочитали значение регистра
		ORR     R3, R3, R4     @ логическое, побитовое ИЛИ
		STR     R3, [R2]       @ запись обновленного значения в GPIOD_MODER

		LDR     R2, =(PERIPH_BB_BASE + (GPIO_LED + GPIO_ODR) * 32 + GPIO_ODR_NUM*4)  @ адрес бита

BLINK_LOOP:
		@ включим светодиод
		STR     R1, [R2]       @ запись R1 ("1") по адресу указанному в R2
	
		BL      DELAY          @  пауза
	
		@ выключим светодиод
		STR     R0, [R2]        @ запись R0 ("0") по адресу указанному в R2

		BL      DELAY           @  пауза	

		B       BLINK_LOOP      @ делаем цикл

DELAY:
		PUSH 	{ R0, LR }
		MOV	R0, 250   	@ задержка 250 мс.
		BL	SYSTICK_DELAY
		POP 	{ R0, PC }

ADR_TEXT:
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

		.byte   1
		.short  16,      20
                .word   1
                .ascii  "STM32F4"

		.byte	1
		.short  24,      38
                .word   1
                .ascii  "НА"

		.byte	1
		.short  32,      10
                .word   1
                .ascii  "АССЕМБЛЕРЕ"

		.byte	0
		