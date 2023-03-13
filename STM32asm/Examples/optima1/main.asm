@GNU AS

@ Ќастройки компил€тора
.syntax unified   @ тип синтаксиса
.thumb            @ тип используемых инструкций Thumb
.cpu cortex-m4    @ микроконтроллер

.include "stm32f40x.inc"   @ определени€ микроконтроллера

@ макрос псевдокоманды MOV32 нам теперь не нужен, € убрал его

@ таблица векторов прерываний
.section .text

.word	0x20020000	@ ¬ершина стека
.word	Reset+1		@ ¬ектор сброса

Reset:
                MOV     R0, 0  @ «начение 0, будет использоватьс€ дл€ bitband
		MOV     R1, 1  @ значение 1, будет использоватьс€ дл€ bitband

		@ включим тактирование GPIO_D
		LDR     R2, =(PERIPH_BB_BASE + (RCC_BASE + RCC_AHB1ENR) * 32 + RCC_AHB1ENR_GPIODEN_N * 4)  @ адрес
		STR     R1, [R2]    @ запись R1 ("1") по адресу бита указанному в R2

		@ установим режим GPIO_D pin_15
		LDR     R2, =(PERIPH_BASE + GPIOD_BASE + GPIO_MODER)  @ адрес
		LDR     R3, =GPIO_MODER_MODER15_0                     @ значение
		LDR     R4, [R0]    @ прочитали значение регистра
		ORR     R3, R3, R4  @ логическое, побитовое »Ћ»
		STR     R3, [R2]    @ запись обновленного значени€ в GPIOD_MODER

		LDR     R2, =(PERIPH_BB_BASE + (GPIOD_BASE + GPIO_ODR) * 32 + 15*4)  @ адрес бита

BLINK_LOOP:
		@ включим светодиод
		STR     R1, [R2]   @ запись R1 ("1") по адресу указанному в R2
	
		BL      DELAY      @  пауза
	
		@ выключим светодиод
		STR     R0, [R2]   @ запись R0 ("0") по адресу указанному в R2

		BL      DELAY      @  пауза	

		B       BLINK_LOOP @ делаем цикл

DELAY:
		LDR     R3, =0x00100000   @ повтор цикла 0x0010 0000 раз.
Delay_loop:	
		SUBS     R3, R3, 1
		BNE     Delay_loop
		BX      LR
