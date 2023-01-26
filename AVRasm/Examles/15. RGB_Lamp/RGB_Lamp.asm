
	.include "./lib/m16def.inc"		; Use AtMega16A
;=================================================
; ����� ���������, � ����� ��������� ���������
	.equ 	XTAL 					= 8000000 		; ������� ��
	.equ 	UART_BaudRate 			= 19200			; �������� ��� ����� �� UART
	.equ 	UART_BaudDivider 		= XTAL/(16*UART_BaudRate)-1
	.equ 	I2C_Frequency 			= 80000			; ������� ���� I2C
	.equ 	I2C_BaudDivider 		= (XTAL/(8*I2C_Frequency)-2)
	.equ	Bit0					= 0b00000001
	.equ	Bit1					= 0b00000010
	.equ	Bit2					= 0b00000100
	.equ	Bit3					= 0b00001000
	.equ	Bit4					= 0b00010000
	.equ	Bit5					= 0b00100000
	.equ	Bit6					= 0b01000000
	.equ	Bit7					= 0b10000000
	.def 	MulLow 					= R0			; ������� ������� ���������� ���������
	.def 	MulHigh 				= R1			; ������� ������� ���������� ���������
	.def 	Temp0 					= R15			; ������� � ������� ���������
	.def 	Temp1 					= R16
	.def 	Temp2 					= R17
	.def 	Temp3 					= R18
	.def 	Temp4 					= R19
	.def 	Temp5 					= R20
	.def 	Temp6 					= R21
	.def 	Temp7 					= R22
	.def 	Temp8 					= R23
	.def 	Counter 				= R24			; ������� �������
	.def 	Flags 					= R25 			; �������� �������
;=================================================
	.equ	Threshold				= 164
	.equ	RgbPORT					= PORTD
	.equ	RgbDDR					= DDRD
	.equ	RgbRed					= 2
	.equ	RgbGreen				= 3
	.equ	RgbBlue					= 4
;=================================================
; ������� SRAM ������
.DSEG
	Colors:  			.byte		4	
;=================================================
; ������� EEPROM ������
.ESEG
;=================================================
; ������� FLASH ������
.CSEG
;=================================================
; ������� ����������
	.ORG 0x00
		RJMP	RESET		
	.ORG 0x16
		RJMP 	TIMER0_OVF	
;=================================================
; ���������� ������� 1 �� ���������� ������ �
TIMER0_OVF:
	PUSH	Temp0
	PUSH	Temp1
	PUSH	Temp2
	PUSH	Temp3
	PUSH	Temp4
	IN		Temp1,SREG
	PUSH	Temp1

	CLR		Temp0
	OUT		TCNT0,Temp0

	CLR		Temp3

	LDS		Temp1, Colors+4	
	CPI		Temp1, Threshold
	BRCS	M0
	LDI 	Temp3, (0<<RgbRed)|(0<<RgbGreen)|(0<<RgbBlue)
	OUT 	RgbPORT, Temp3
	LDI		Temp1, 0
	RJMP	M1	
M0:
	INC		Temp1
	
M1:
	STS		Colors+4, Temp1
	LDS		Temp2, Colors+0
	CP		Temp1, Temp2
	BRCS	M2
	LDI		Temp4, Bit2
	ADD		Temp3, Temp4
M2:
	LDS		Temp2, Colors+1
	CP		Temp1, Temp2
	BRCS	M3
	LDI		Temp4, Bit3
	ADD		Temp3, Temp4
M3:
	LDS		Temp2, Colors+2
	CP		Temp1, Temp2
	BRCS	M4
	LDI		Temp4, Bit4
	ADD		Temp3, Temp4
M4:
	OUT		RgbPORT, Temp3
	
	POP		Temp1
	OUT		SREG,Temp1
	POP		Temp4
	POP		Temp3
	POP		Temp2
	POP		Temp1
	POP		Temp0
RETI
; ���������� �� ������, ��������� ������������� 
RESET:	
	; ������������� �����
	LDI 	Temp1, LOW(RAMEND)
	OUT 	SPL, Temp1
	LDI 	Temp1, HIGH(RAMEND)	
	OUT 	SPH, Temp1
	; ������� ��� � ��������� R0-R31
	LDI		ZL, LOW(SRAM_START)		; ����� ������ ��� � ������
	LDI		ZH, HIGH(SRAM_START)
	CLR		Temp1					; ������� R16
RAM_Flush:
	ST 		Z+, Temp1				
	CPI		ZH, HIGH(RAMEND+1)	
	BRNE	RAM_Flush			
	CPI		ZL, LOW(RAMEND+1)	
	BRNE	RAM_Flush
	LDI		ZL, (0x1F-2)			; ����� �������� R29
	CLR		ZH
Reg_Flush:
	ST		Z, ZH
	DEC		ZL
	BRNE	Reg_Flush
	CLR		ZL
	CLR		ZH
	; �������� � SRAM ��������� ������� (��������)
	; �� �������� �����-������ (IO) ���� �������
	; ���������� ������ ����������
	CLI
	; ����������� ����� �����-������
	LDI 	Temp1, (1<<RgbRed)|(1<<RgbGreen)|(1<<RgbBlue)
	OUT 	RgbDDR, Temp1
	; ����������� �������
	; ��������� ��������
	; ��� ������������
	LDI 	Temp1, (1<<CS00)|(0<<CS01)|(0<<CS02)
	OUT 	TCCR0, Temp1 
	; ���������� ���������� ������� 0 �� ������������
	LDI 	Temp1, (1<<TOIE0)
	OUT 	TIMSK, Temp1 
	OUT 	TCNT0,Temp0
	; ��������� ����������
	SEI
;=================================================
; �������� ��������� (����)
Main:
	LDI		Temp1, 5
	RCALL	ProcRed
	LDI		Temp1, 5
	RCALL	ProcGreen
	LDI		Temp1, 5
	RCALL	ProcBlue
	LDI		Temp1, 10
	RCALL	ProcWhite
Main2:
	LDI		Temp1, 100
	RCALL	ProcRGB
	RJMP	Main2
	; ���� ����������� �������
	RJMP	Main
;=================================================
	.include "./lib/Delay.asm"
;=================================================
// Temp1 �������� �������
// Temp2 �������
// Colors -  R (0) G (+1) B (+2) � �����
ProcGreen:
	LDI		Temp2, 0
	MOV		Temp3, Temp1
ProcGreen_Loop1:	
	LDI		Temp1, Threshold
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+1, Temp1
	LDI		Temp1, Threshold
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcGreen_Loop1
	LDI		Temp2, 0
ProcGreen_Loop2:	
	LDI		Temp1, Threshold
	STS		Colors+0, Temp1
	MOV		Temp1, Temp2
	STS		Colors+1, Temp1
	LDI		Temp1, Threshold
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcGreen_Loop2
RET
;==================
ProcRed:
	LDI		Temp2, 0
	MOV		Temp3, Temp1
ProcRed_Loop1:	
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	STS		Colors+1, Temp1
	LDI		Temp1, Threshold
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcRed_Loop1
	LDI		Temp2, 0
ProcRed_Loop2:	
	MOV		Temp1, Temp2
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	STS		Colors+1, Temp1
	LDI		Temp1, Threshold
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcRed_Loop2
RET
;==================
ProcBlue:
	LDI		Temp2, 0
	MOV		Temp3, Temp1
ProcBlue_Loop1:	
	LDI		Temp1, Threshold	
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	STS		Colors+1, Temp1
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcBlue_Loop1
	LDI		Temp2, 0
ProcBlue_Loop2:	
	LDI		Temp1, Threshold
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	STS		Colors+1, Temp1
	MOV		Temp1, Temp2
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcBlue_Loop2
RET
;==================
ProcWhite:
	LDI		Temp2, 0
	MOV		Temp3, Temp1
ProcWhite_Loop1:	
	LDI		Temp1, Threshold	
	SUB		Temp1, Temp2
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+1, Temp1
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcWhite_Loop1
	LDI		Temp2, 0
ProcWhite_Loop2:	
	MOV		Temp1, Temp2
	STS		Colors+0, Temp1
	STS		Colors+1, Temp1
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcWhite_Loop2
RET
;==================

ProcRGB:
	LDI		Temp2, 0
	MOV		Temp3, Temp1
ProcRGB_Loop1:	
	MOV		Temp1, Temp2	
	STS		Colors+0, Temp1
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcRGB_Loop1
	LDI		Temp2, 0
ProcRGB_Loop2:	
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+1, Temp1
	MOV		Temp1, Temp2
	STS		Colors+2, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcRGB_Loop2
	LDI		Temp2, 0
ProcRGB_Loop3:	
	LDI		Temp1, Threshold
	SUB		Temp1, Temp2
	STS		Colors+0, Temp1
	MOV		Temp1, Temp2
	STS		Colors+1, Temp1
	MOV		Temp1, Temp3
	RCALL	Delayms
	INC		Temp2
	CPI		Temp2, Threshold
	BRNE	ProcRGB_Loop3
RET
