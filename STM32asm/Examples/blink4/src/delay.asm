@GNU AS

@ ��������� �����������
.syntax unified   @ ��� ����������
.thumb            @ ��� ������������ ���������� Thumb
.cpu cortex-m4    @ ���������������

.section .asmcode

.global DELAY
DELAY:
		LDR     R3, =0x00100000   @ ������ ����� 0x0010 0000 ���.
Delay_loop:	
		SUBS     R3, R3, 1
		BNE     Delay_loop
		BX      LR
