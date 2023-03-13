@GNU AS

@ ≈сли определение ниже закомментировано, то предполагаетс€ что 
@ использована плата Open407I-C, иначе STM32F4 Discovery
@.set DEVBOARD, STM32F4DISCO

.syntax unified		@ синтаксис исходного кода
.thumb			@ тип используемых инструкций Thumb
.cpu cortex-m4		@ процессор
.fpu fpv4-sp-d16	@ сопроцессор

.include "src/stm32f40x_def.inc"

@ ќпределени€ в зависимости от отладочной платы
.ifdef DEVBOARD
   .equ GPIO_LED	,GPIOD_BASE       	@ порт подключени€ светодиода
   .equ RCC_GPIO_EN	,RCC_AHB1ENR_GPIODEN_N  @ бит включени€ GPIO
   .equ GPIO_ODR_NUM	,15			@ номер пина GPIO
.else
   .equ GPIO_LED	,GPIOH_BASE
   .equ RCC_GPIO_EN	,RCC_AHB1ENR_GPIOHEN_N
   .equ GPIO_ODR_NUM	,2
.endif

.equ GPIO_MODER_MDR	,2<<(GPIO_ODR_NUM*2)

.section .vectors

@ таблица векторов прерываний
.word	0x20020000	@ ¬ершина стека
.word	Start+1		@ ¬ектор сброса
.include "src/isr_vector.inc"	@ таблица указателей векторов прерываний

.section .asmcode

@ основна€ программа
Start:		
		BL	SYSCLK168_START

                BL	SYSTICK_START

		MOV     R0, 0  @ «начение 0, будет использоватьс€ дл€ bitband
		MOV     R1, 1  @ значение 1, будет использоватьс€ дл€ bitband

		@ включим тактирование GPIO_H
		LDR     R2, =(PERIPH_BB_BASE + (RCC_BASE + RCC_AHB1ENR) * 32 + RCC_AHB1ENR_GPIOHEN_N * 4)  @ адрес
		STR     R1, [R2]    @ запись R1 ("1") по адресу бита указанному в R2

		@ установим режим GPIO_H pin_15
		LDR     R2, =(PERIPH_BASE + GPIO_LED + GPIO_MODER)  @ адрес
		LDR     R3, =GPIO_MODER_MDR                     @ значение
		LDR     R4, [R2]    @ прочитали значение регистра
		ORR     R3, R3, R4  @ логическое, побитовое »Ћ»
		STR     R3, [R2]    @ запись обновленного значени€ в GPIOD_MODER

		LDR     R2, =(PERIPH_BB_BASE + (GPIO_LED + GPIO_ODR) * 32 + GPIO_ODR_NUM*4)  @ адрес бита

BLINK_LOOP:
		@ включим светодиод
		STR     R1, [R2]   @ запись R1 ("1") по адресу указанному в R2
	
		BL      DELAY      @  пауза
	
		@ выключим светодиод
		STR     R0, [R2]   @ запись R0 ("0") по адресу указанному в R2

		BL      DELAY      @  пауза	

		B       BLINK_LOOP @ делаем цикл

DELAY:
		PUSH 	{ R0, LR }
		MOV	R0, 250   	@ задержка 250 мс.
		BL 	SYSTICK_DELAY
		POP 	{ R0, PC }
		