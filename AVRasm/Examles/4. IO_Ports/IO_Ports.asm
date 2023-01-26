;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
	.include "m16def.inc"		; ��������� ��� ATmega16A
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
	.equ	LedDDR					= DDRA
	.equ	LedPORT					= PORTA	
	.equ	BtnPORT					= PORTD
	.equ	BtnPIN					= PIND
	.equ	BtnDDR					= DDRD
	.equ	BtnStop					= 2		
	.equ	BtnDelay				= 100	
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
	CLI
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	CPI 	Temp3, 255 ; Compare with Immediate
	BREQ 	LeftToRight ; Branch if Equal (������� � ����� ���� ����� ���������� ��������) ���� Zero � HIGH
	CPI 	Temp3, 0
	BREQ 	RightToLeft ; Branch if Equal
	RJMP 	Timer1Out
LeftToRight: 
	LSR 	Temp2 ; Logical Shift Right (Temp2 >> 1)
	CPI 	Temp2, 0b00000001              
	BREQ 	ChangeDirection		
	RJMP 	Timer1Out       
RightToLeft: 
	LSL 	Temp2 ; Logical Shift Left (Temp2 << 1)
	CPI 	Temp2, 0b10000000           
	BREQ 	ChangeDirection ; Branch if Equal
	RJMP 	Timer1Out 
ChangeDirection:
	COM 	Temp3 ; One�s Complement (Rd < $FF - Rd) Temp3 = 0xFF - Temp3
Timer1Out:  
	OUT 	LedPORT, Temp2
RETI 
; ���������� ������� 0 �� ����������
TIMER0_COMP: ; Temp4 - �������, BtnDelay - ������ �� �������� ���������
	OUT  	TCNT0, Temp0
	SBIC 	BtnPIN, BtnStop ; Skip if Bit in I/O Register Cleared (���� ������ �������� ���������� ������ ����)
	INC 	Temp4
	SBIS 	BtnPIN, BtnStop ; Skip if Bit in I/O Registerr Set (���� ������ ������ ���������� ������ ����)
	CLR		Temp4
	CPI 	Temp4, BtnDelay ; Compare with Immediate
	BRLO 	Timer0Out ; Branch if Lower (������� � �����, ���� ��� ������� (���� �������� Carry � HIGH)) ���� Temp4 < BtnDelay
	CLR		Temp4
	RCALL 	ChangeInt ; ����� �������
Timer0Out:
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
	LDI 	Temp1, 0xFF
	OUT 	LedDDR, Temp1
	CBI 	BtnDDR, BtnStop
	; ����������� �������
	; ���������� ���������� ������� 1 �� ���������� ������ � � ������� 0
	LDI 	Temp1, (1<<OCIE1A)|(1<<OCIE0)
	OUT 	TIMSK, Temp1
	; ��������� ������������ /256
	LDI 	Temp1, (1<<CS12)
	OUT 	TCCR1B, Temp1 
	; ��������� ����� ��������� 15625=0x3D09 ((8000000/256)/2=15625 - 500 ����. ��� Fcpu=8���) 
	LDI 	XH, HIGH(0x3D09)
	OUT 	OCR1AH, XH
	LDI 	XL, LOW(0x3D09)
	OUT 	OCR1AL, XL
 	; ��������� �������� ������� 1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; ����������� ������ 0 ��� ��������� ������
	LDI	 	Temp1, (0<<CS02)|(1<<CS01)|(1<<CS00)
	OUT  	TCCR0, Temp1
	; ����� ��������� (125 = 0x7D) - ��� �������� 64 - ������� 1 �� (8000000/64=125000)/1000 = 125
	; 1��� ������ ���������� ��� Fcpu=8���
	LDI 	Temp1, 0x7D
	OUT  	OCR0, Temp1
	; �������� �������
	OUT  	TCNT0, Temp0
	; �������������� ����������
	LDI 	Temp2, 0x01
	CLR		Temp4
	CLR		Temp3
	; ��������� ����������
	SEI
;=================================================
; �������� ��������� (����)
Main:
	; ���� ����������� �������
	RJMP	Main
;=================================================
; ��������� ���������� � ��������� ���� �����������
ChangeInt:
	PUSH 	Temp1
	PUSH 	Temp2
	IN 		Temp1, TIMSK
	LDI		Temp2,(1<<OCIE1A)
	EOR		Temp1, Temp2 ; Exclusive OR (����������� ���)
	OUT		TIMSK, Temp1 ; ���� � OCIE1A ��� 1, ������ 0 � ��������
	LDI		Temp1, 0xFF
	OUT		LedPORT, Temp1
	POP 	Temp2
	POP 	Temp1
RET
