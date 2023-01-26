;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
	.include "./lib/m16def.inc"		; ��������� ��� ATmega16A
;=================================================
; ����� ���������, � ����� ��������� ���������
	.equ 	XTAL 					= 8000000 		; ������� ��
	.equ 	UART_BaudRate 			= 19200			; �������� ������ �� UART
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
	.equ	SYMBOL_MINUS 			= 0b01000000 	; ������ ������
	.equ	SYMBOL_POINT 			= 0b10000000 	; ������ �����
	.equ	DisplayDelay			= 50			; �������� ��� ������������ ���������
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
	.equ	PwmPORT					= PORTD
	.equ	PwmDDR					= DDRD
	.equ	PwmChA					= 5
	.equ	PwmChB					= 4
	.equ	BtnPORT					= PORTC
	.equ	BtnPIN					= PINC
	.equ	BtnDDR					= DDRC
	.equ	BtnChAup				= 2
	.equ	BtnChAdown				= 3
	.equ	BtnChBup				= 4
	.equ	BtnChBdown				= 5
	.equ	TimerDelay				= 100
	.equ	DeltaChA				= 10
	.equ	DeltaChB				= 5	
;=================================================
; ������� SRAM ������
.DSEG
	Digits:  			.byte		4					
;=================================================
; ������� EEPROM ������
.ESEG
	eDigits:  			.byte		4					
;=================================================
; ������� FLASH ������
.CSEG
;=================================================
; ������� ����������
	.ORG 0x00
		RJMP	RESET		
	.ORG 0x0C
		RJMP 	TIMER1_COMPA	
	.ORG 0x26
		RJMP 	TIMER0_COMP
;=================================================
; ���������� ������� 1 �� ���������� ������ �
TIMER1_COMPA:
RETI
; ���������� ������� 0 �� ����������
TIMER0_COMP:
	OUT  	TCNT0, Temp0
	IN		Temp3, OCR1AL
	IN  	Temp1, OCR1AH
	IN		Temp4, OCR1BL
	IN  	Temp1, OCR1BH
; ��������� ������ Up ������ �
T0_CheckChAup:
	SBIC 	BtnPIN, BtnChAup
	INC 	Temp5
	SBIS 	BtnPIN, BtnChAup
	CLR 	Temp5
	CPI 	Temp5, TimerDelay
	BRLO 	T0_CheckChAdown
	LDI		Temp1, DeltaChA
	ADD		Temp3, Temp1
	CLR 	Temp5
T0_CheckChAdown:
	SBIC 	BtnPIN, BtnChAdown
	INC 	Temp6
	SBIS 	BtnPIN, BtnChAdown
	CLR 	Temp6
	CPI 	Temp6, TimerDelay
	BRLO 	T0_CheckChBup
	LDI		Temp1, DeltaChA
	SUB		Temp3, Temp1
	CLR 	Temp6
T0_CheckChBup:
	SBIC 	BtnPIN, BtnChBup
	INC 	Temp7
	SBIS 	BtnPIN, BtnChBup
	CLR 	Temp7
	CPI 	Temp7, TimerDelay
	BRLO 	T0_CheckChBdown
	LDI		Temp1, DeltaChB
	ADD		Temp4, Temp1
	CLR 	Temp7
T0_CheckChBdown:
	SBIC 	BtnPIN, BtnChBdown
	INC 	Temp8
	SBIS 	BtnPIN, BtnChBdown
	CLR 	Temp8
	CPI 	Temp8, TimerDelay
	BRLO 	T0_Next
	LDI		Temp1, DeltaChB
	SUB		Temp4, Temp1
	CLR 	Temp8
T0_Next:
	OUT 	OCR1AH, Temp0
	OUT 	OCR1AL, Temp3
	OUT 	OCR1BH, Temp0
	OUT 	OCR1BL, Temp4
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
	LDI 	Temp1, (1<<PwmChA)|(1<<PwmChB)
	OUT 	PwmDDR, Temp1
	OUT 	PwmPORT, Temp1
	LDI		Temp1, (0<<BtnChAup)|(0<<BtnChAdown)|(0<<BtnChBup)|(0<<BtnChBdown)
	OUT 	BtnDDR, Temp1
	OUT 	BtnPORT, Temp1
	; ����������� �������
	; ����������� ��� �� ��� ������ ������� 1
	LDI 	Temp1, (2<<COM1A0)|(2<<COM1B0)|(0<<WGM11)|(1<<WGM10)
	OUT		TCCR1A, Temp1
	LDI 	Temp1, (0<<WGM13)|(1<<WGM12)|(1<<CS10)
	OUT		TCCR1B, Temp1
 	; �������� �������
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0 
	; ����������� ������ 0 ��� ��������� ������
	LDI 	Temp1, (1<<OCIE0)
	OUT 	TIMSK, Temp1
	LDI	 	Temp1, (0<<CS02)|(1<<CS01)|(1<<CS00)
	OUT  	TCCR0, Temp1
	; ����� ��������� - ��� �������� 64 - ������� 1 ��
	LDI 	Temp1, 0x7D
	OUT  	OCR0, Temp1
	; �������� �������
	OUT  	TCNT0, Temp0
	; ����������� ��� ������ �
	OUT		OCR1AH, Temp0
	LDI		Temp1, 0x00
	OUT		OCR1AL, Temp1
	; ����������� ��� ������ B
	OUT		OCR1BH, Temp0
	LDI		Temp1, 0x80
	OUT		OCR1BL, Temp1
	; ��������� ����������
	SEI
;=================================================
; �������� ��������� (����)
Main:
	; ���� ����������� �������
	RJMP	Main
;=================================================


