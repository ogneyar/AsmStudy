@GNU AS

@ Настройки компилятора
.syntax unified   @ тип синтаксиса
.thumb            @ тип используемых инструкций Thumb
.cpu cortex-m4    @ микроконтроллер

.section .asmcode

.global DELAY
DELAY:
		LDR     R3, =0x00100000   @ повтор цикла 0x0010 0000 раз.
Delay_loop:	
		SUBS     R3, R3, 1
		BNE     Delay_loop
		BX      LR
