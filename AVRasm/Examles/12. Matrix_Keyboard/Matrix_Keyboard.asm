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
	.equ	LedDDR					= DDRA
	.equ	LedPORT					= PORTA	
	.equ	BtnPORT					= PORTC
	.equ	BtnPIN					= PINC
	.equ	BtnDDR					= DDRC	
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
	.ORG 0x12
		RJMP 	TIMER0_OVF
;=================================================
; ���������� ������� 0 �� ������������ 
TIMER0_OVF:
	RCALL 	Shift  
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
	LDI 	Temp1, 0b00111000
	OUT 	BtnDDR, Temp1
	CLR 	Temp1
	OUT 	BtnPORT, Temp1	
	; ����������� �������
	; ��������� ������������ /256
	LDI 	Temp1, (1<<CS02)
	OUT 	TCCR0, Temp1 
	; �������� �������
	OUT  	TCNT0, Temp0
	OUT  	OCR0, Temp0
	; ���������� ���������� ������� 0 �� ������������
	LDI 	Temp1, (1<<TOIE0)
	OUT 	TIMSK, Temp1
	; ��������� ����������
	SEI
;=================================================
; �������� ��������� (����)
Main:
	; ���� ����������� �������
	RJMP	Main
;=================================================
; ������������ ����� ����������
Shift:
	CLR		Temp2
Shift1:
	LDI 	Temp1, 0b00011000
	OUT 	BtnPORT, Temp1
	IN		Temp3, BtnPIN
	ANDI	Temp3, 0b00000111
	CPI 	Temp3, 0b00000110
	BRNE	Shift2
	LDI		Temp2, Bit0
	RJMP	ShiftEnd
Shift2:
	CPI 	Temp3, 0b00000101
	BRNE	Shift3
	LDI		Temp2, Bit1
	RJMP	ShiftEnd
Shift3:
	CPI 	Temp3, 0b00000011
	BRNE	Shift4
	LDI		Temp2, Bit2
	RJMP	ShiftEnd
Shift4:
	LDI 	Temp1, 0b00101000
	OUT 	BtnPORT, Temp1
	IN		Temp3, BtnPIN
	ANDI	Temp3, 0b00000111
	CPI 	Temp3, 0b00000110
	BRNE	Shift5
	LDI		Temp2, Bit3
	RJMP	ShiftEnd
Shift5:
	CPI 	Temp3, 0b00000101
	BRNE	Shift6
	LDI		Temp2, Bit4
	RJMP	ShiftEnd
Shift6:
	CPI 	Temp3, 0b00000011
	BRNE	Shift7
	LDI		Temp2, Bit5
	RJMP	ShiftEnd
Shift7:
	LDI 	Temp1, 0b00110000
	OUT 	BtnPORT, Temp1
	IN		Temp3, BtnPIN
	ANDI	Temp3, 0b00000111
	CPI 	Temp3, 0b00000110
	BRNE	Shift8
	LDI		Temp2, Bit6
	RJMP	ShiftEnd
Shift8:
	CPI 	Temp3, 0b00000101
	BRNE	Shift9
	LDI		Temp2, Bit7
	RJMP	ShiftEnd
Shift9:
	CPI 	Temp3, 0b00000011
	BRNE	ShiftEnd
	LDI		Temp2, 0xFF
	RJMP	ShiftEnd
ShiftEnd:
	OUT 	LedPORT, Temp2
RET
