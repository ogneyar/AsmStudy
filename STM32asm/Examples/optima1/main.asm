@GNU AS

@ ��������� �����������
.syntax unified   @ ��� ����������
.thumb            @ ��� ������������ ���������� Thumb
.cpu cortex-m4    @ ���������������

.include "stm32f40x.inc"   @ ����������� ����������������

@ ������ ������������� MOV32 ��� ������ �� �����, � ����� ���

@ ������� �������� ����������
.section .text

.word	0x20020000	@ ������� �����
.word	Reset+1		@ ������ ������

Reset:
                MOV     R0, 0  @ �������� 0, ����� �������������� ��� bitband
		MOV     R1, 1  @ �������� 1, ����� �������������� ��� bitband

		@ ������� ������������ GPIO_D
		LDR     R2, =(PERIPH_BB_BASE + (RCC_BASE + RCC_AHB1ENR) * 32 + RCC_AHB1ENR_GPIODEN_N * 4)  @ �����
		STR     R1, [R2]    @ ������ R1 ("1") �� ������ ���� ���������� � R2

		@ ��������� ����� GPIO_D pin_15
		LDR     R2, =(PERIPH_BASE + GPIOD_BASE + GPIO_MODER)  @ �����
		LDR     R3, =GPIO_MODER_MODER15_0                     @ ��������
		LDR     R4, [R0]    @ ��������� �������� ��������
		ORR     R3, R3, R4  @ ����������, ��������� ���
		STR     R3, [R2]    @ ������ ������������ �������� � GPIOD_MODER

		LDR     R2, =(PERIPH_BB_BASE + (GPIOD_BASE + GPIO_ODR) * 32 + 15*4)  @ ����� ����

BLINK_LOOP:
		@ ������� ���������
		STR     R1, [R2]   @ ������ R1 ("1") �� ������ ���������� � R2
	
		BL      DELAY      @  �����
	
		@ �������� ���������
		STR     R0, [R2]   @ ������ R0 ("0") �� ������ ���������� � R2

		BL      DELAY      @  �����	

		B       BLINK_LOOP @ ������ ����

DELAY:
		LDR     R3, =0x00100000   @ ������ ����� 0x0010 0000 ���.
Delay_loop:	
		SUBS     R3, R3, 1
		BNE     Delay_loop
		BX      LR
