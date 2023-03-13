@GNU AS
@ ***************************************************************************
@ *                ������  �������� ������ ����������������                 *
@ ***************************************************************************
@ * ������ ����������� DWT ������� (32-�� ��������� ������� �������� ������ *
@ * ���� AHB (��� STM32F407 168 ���)                                        *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * ������ �������� ��� ����������, �������� �����������                    *
@ * ������� ������:                                                         *
@ * 		BL	DWT_START  					    *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * ��� ���� ����� ��������� �������� �������� � R0 �������:                *
@ *             BL      DWT_GETCOUNTER                                      *
@ ***************************************************************************
@ * �������������: http://www.stm32asm.ru/407/f407_dwt_init.html            *
@ ***************************************************************************
@
.syntax unified		@ ��������� ��������� ����
.thumb			@ ��� ������������ ���������� Thumb
.cpu cortex-m4		@ ���������
.fpu fpv4-sp-d16	@ �����������


.equ DEMCR        ,0xE000EDFC @ Debug Exception and Monitor Control Register
.equ DWT_CTRL     ,0xE0001000 @ Control Register
.equ DWT_CYCCNT   ,0xE0001004 @ Cycle Count Register

.section .asmcode

.global DWT_START
DWT_START:
		PUSH	{R0, R1}
		@ �������� ��������� ��� TRCENA
		LDR	R0, =DEMCR
		LDR	R1, [R0]
		ORR	R1, (1 << 24)
		STR	R1, [R0]

		@ ��������� DWT
		LDR	R0, =DWT_CTRL
		LDR	R1, [R0]
		ORR	R1, 1
		STR	R1, [R0]
		POP	{R0, R1}
		BX	LR

.global DWT_GETCOUNTER
DWT_GETCOUNTER:
		@ ������ ��������
		LDR	R0, =DWT_CYCCNT
		LDR	R0, [R0]
		BX	LR