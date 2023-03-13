@GNU AS

@ ��������� �����������
.syntax unified   @ ��� ����������
.thumb            @ ��� ������������ ���������� Thumb
.cpu cortex-m4    @ ���������������

@ ���� ����������� ���� ����������������, �� �������������� ��� 
@ ������������ ����� Open407I-C, ����� STM32F4 Discovery
@.set DEVBOARD, STM32F4DISCO

.include "src/stm32f40x_def.inc"   @ ����������� ����������������

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

@ ������� �������� ����������
.section .text

.word	0x20020000	@ ������� �����
.word	Reset+1		@ ������ ������

Reset:
                MOV     R0, 0  @ �������� 0, ����� �������������� ��� bitband
		MOV     R1, 1  @ �������� 1, ����� �������������� ��� bitband

		@ ������� ������������ GPIO_LED
		LDR     R2, =(PERIPH_BB_BASE + (RCC_BASE + RCC_AHB1ENR) * 32 + RCC_GPIO_EN * 4)  @ �����
		STR     R1, [R2]    @ ������ R1 ("1") �� ������ ���� ���������� � R2

		@ ��������� ����� GPIO_LED pin_15
		LDR     R2, =(PERIPH_BASE + GPIO_LED + GPIO_MODER)  @ �����
		LDR     R3, =GPIO_MODER_MDR                     @ ��������
		LDR     R4, [R2]    @ ��������� �������� ��������
		ORR     R3, R3, R4  @ ����������, ��������� ���
		STR     R3, [R2]    @ ������ ������������ �������� � GPIOD_MODER

		LDR     R2, =(PERIPH_BB_BASE + (GPIO_LED + GPIO_ODR) * 32 + GPIO_ODR_NUM*4)  @ ����� ����

BLINK_LOOP:
		@ ������� ���������
		STR     R1, [R2]   @ ������ R1 ("1") �� ������ ���������� � R2
	
		BL      DELAY      @  �����
	
		@ �������� ���������
		STR     R0, [R2]   @ ������ R0 ("0") �� ������ ���������� � R2

		BL      DELAY      @  �����	

		B       BLINK_LOOP @ ������ ����
