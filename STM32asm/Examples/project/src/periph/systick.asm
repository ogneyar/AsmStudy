@GNU AS

.syntax unified		@ ��������� ��������� ����
.thumb			@ ��� ������������ ���������� Thumb
.cpu cortex-m4		@ ���������
.fpu fpv4-sp-d16	@ �����������

.include "src/stm32f40x_def.inc"


@ ****************************************************************************
@ *             ���������� ���������� ���������� ������� SysTick             *
@ ****************************************************************************

.section .bss
@ ���������� � ���
SYSTICK_COUNTER:
		.word	0   		@ �������� ����������� ��������

.section .asmcode

@ ���������� ��������� �������� �������� SYSTICK_COUNTER �� "1" (� ������ ����
@ �������� �������� ������ "0"

.global ISR_SYSTICK

ISR_SYSTICK:
		PUSH	{ R0 , R1 , LR }
		LDR 	R1 , ADR_SYSTICK_COUNTER
		LDR     R0 , [R1 , 0]
		ORRS	R0 , R0 , 0       @ �������� R0 �� 0
		ITT	NE					  @ ���� R0<>0 ��������� ��� �� 1
		SUBNE	R0 , R0 , 1
		STRNE	R0 , [R1 , 0]
		POP	{ R0 , R1 , PC }

ADR_SYSTICK_COUNTER:
		.word	SYSTICK_COUNTER
@ ****************************************************************************
@ *                 ������������� ���������� ������� SysTick                 *
@ ****************************************************************************
@ ��� ������� AHB=168 ���
@ ������� ����� 1000 ��
@
@ ��������� SysTick
.global SYSTICK_START

SYSTICK_START:
		PUSH	{ R0 , R1 , LR }
		LDR	R0 , ADR_SYSTICK_BASE

	@ ��������� �������� ��������� ��� ��������� ������� 1000 ��
		LDR	R1 , =168000 - 1
		STR	R1 , [ R0 , STK_LOAD]

	@ �������� ������� AHB (168 ���) + ���������� + �������� SYSTICK
		LDR	R1 , ADR_STK_CTRL_CLKSOURSE_TICKINT_ENABLE
		STR	R1 , [ R0 , STK_CTRL]

	@ ��������� ���������� ���������� �� SysTick
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
@ *             �������� ���������� ���������� ������� SysTick               *
@ ****************************************************************************
@ ������� ��������: R0 - �������� � ������������
@ �������� ��������: R0 = 0
@ ��������� ������ ���������: ���
.global SYSTICK_DELAY

SYSTICK_DELAY:
		PUSH 	{ R1 , LR }
		LDR 	R1 , ADR_SYSTICK_COUNTER  	@ ����� ��������
		STR	R0 , [ R1 , 0]         		@ �������� ��������� ��������
DELAY_LOOP:
		LDR	R0 , [ R1 , 0]	@ ���� ��������� ��������
		ORRS	R0 , R0 , 0
		BNE	DELAY_LOOP
		POP 	{ R1 , PC }
