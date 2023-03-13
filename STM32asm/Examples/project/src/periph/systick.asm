@GNU AS

.syntax unified		@ синтаксис исходного кода
.thumb			@ тип используемых инструкций Thumb
.cpu cortex-m4		@ процессор
.fpu fpv4-sp-d16	@ сопроцессор

.include "src/stm32f40x_def.inc"


@ ****************************************************************************
@ *             Обработчик прерывания системного таймера SysTick             *
@ ****************************************************************************

.section .bss
@ Переменная в ОЗУ
SYSTICK_COUNTER:
		.word	0   		@ Значение необходимой задержки

.section .asmcode

@ Прерывание уменьшает значение счетчика SYSTICK_COUNTER на "1" (в случае если
@ значение счетчика больше "0"

.global ISR_SYSTICK

ISR_SYSTICK:
		PUSH	{ R0 , R1 , LR }
		LDR 	R1 , ADR_SYSTICK_COUNTER
		LDR     R0 , [R1 , 0]
		ORRS	R0 , R0 , 0       @ Проверка R0 на 0
		ITT	NE					  @ Если R0<>0 уменьшаем его на 1
		SUBNE	R0 , R0 , 1
		STRNE	R0 , [R1 , 0]
		POP	{ R0 , R1 , PC }

ADR_SYSTICK_COUNTER:
		.word	SYSTICK_COUNTER
@ ****************************************************************************
@ *                 Инициализация системного таймера SysTick                 *
@ ****************************************************************************
@ Для частоты AHB=168 Мгц
@ Частота счета 1000 Гц
@
@ Включение SysTick
.global SYSTICK_START

SYSTICK_START:
		PUSH	{ R0 , R1 , LR }
		LDR	R0 , ADR_SYSTICK_BASE

	@ установка значения пересчета для получения частоты 1000 гц
		LDR	R1 , =168000 - 1
		STR	R1 , [ R0 , STK_LOAD]

	@ источник частоты AHB (168 мгц) + прерывания + включаем SYSTICK
		LDR	R1 , ADR_STK_CTRL_CLKSOURSE_TICKINT_ENABLE
		STR	R1 , [ R0 , STK_CTRL]

	@ установка приоритета прерываний от SysTick
		LDR	R0 , ADR_SCB_BASE
		LDR	R1 , [ R0, SHPR3]
		ORR	R1 , R1 , 0x0F << 12
		STR	R1 , [ R0 , SHPR3]

	        POP	{ R0 , R1 , PC }

ADR_SYSTICK_BASE:
		.word	SYSTICK_BASE
ADR_STK_CTRL_CLKSOURSE_TICKINT_ENABLE:
		.word	STK_CTRL_CLKSOURSE +  STK_CTRL_TICKINT + STK_CTRL_ENABLE
ADR_SCB_BASE:
		.word	SCB_BASE

@ ****************************************************************************
@ *             Задержка средствами системного таймера SysTick               *
@ ****************************************************************************
@ Входной параметр: R0 - задержка в милисекундах
@ Выходной параметр: R0 = 0
@ Изменение других регистров: нет
.global SYSTICK_DELAY

SYSTICK_DELAY:
		PUSH 	{ R1 , LR }
		LDR 	R1 , ADR_SYSTICK_COUNTER  	@ адрес счетчика
		STR	R0 , [ R1 , 0]         		@ сохраним начальное значение
DELAY_LOOP:
		LDR	R0 , [ R1 , 0]	@ ждем обнуления счетчика
		ORRS	R0 , R0 , 0
		BNE	DELAY_LOOP
		POP 	{ R1 , PC }
