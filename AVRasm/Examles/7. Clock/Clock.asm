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
	.equ	DisplayDelay			= 5				; �������� ��� ������������ ���������
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
	.equ	SegPORT 				= PORTC			
	.equ	SegDDR  				= DDRC			
	.equ	DigPORT 				= PORTB			
	.equ	DigDDR  				= DDRB			
	.equ	Digit1  				= 0				
	.equ	Digit2  				= 1				
	.equ	Digit3  				= 2				
	.equ	Digit4  				= 3	
	.equ	BtnPORT					= PORTD
	.equ	BtnPIN					= PIND
	.equ	BtnDDR					= DDRD
	.equ	BtnMin					= 2
	.equ	BtnHour					= 3			
;=================================================
; ������� SRAM ������
.DSEG
	Digits:  			.byte		6					
;=================================================
; ������� EEPROM ������
.ESEG
	eDigits:  			.byte		6					
;=================================================
; ������� FLASH ������
.CSEG
;=================================================
; ������� ����������
	.ORG 0x00
		RJMP	RESET		
	.ORG 0x0C
		RJMP 	TIMER1_COMPA	
;=================================================
; ���������� ������� 1 �� ���������� ������ �
TIMER1_COMPA:
	RCALL	GetTime
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
	; ��������� ���������� ������
	CLR 	Flags
	; ����������� ����� �����-������
	; �������� ����������
	LDI 	Temp1, 0xFF
	OUT 	SegDDR, Temp1
	; ������� ����������
	LDI 	Temp1, (1<<Digit1)|(1<<Digit2)|(1<<Digit3)|(1<<Digit4)
	OUT 	DigDDR, Temp1
	LDI		Temp1, (0<<BtnMin)|(0<<BtnHour)
	OUT 	BtnDDR, Temp1 ; input mode
	OUT 	BtnPORT, Temp1 ; pull down
	; ��������� ��������
	; ���������� ���������� ������� 1 �� ���������� ������ �
	LDI 	Temp1, (1<<OCIE1A)
	OUT 	TIMSK, Temp1 
	; ��������� ������������ /256
	LDI 	Temp1, (1<<CS12)
	OUT 	TCCR1B, Temp1 
	; ��������� ����� ��������� 31250=0x7A12 (8000000/256=31250 - 1 ���. ��� 8���)
	LDI 	XH, HIGH(0x7A12)
	OUT 	OCR1AH, XH
	LDI 	XL, LOW(0x7A12)
	OUT 	OCR1AL, XL
 	; ��������� �������� ������� 1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; ��������� ����������
	SEI
;=================================================
; �������� ��������� (����)
Main:
	; �������� ��������� ���������
	RCALL	Display
	; �������� ��������� ��������� ������
	RCALL	GetButtons
	; ���� ����������� �������
	RJMP	Main
;=================================================
	.include "./lib/Delay.asm"
;=================================================
; ��������� ������������� ����� � ��� ����� ��� 7-����������� ����������
Decoder:
	LDI 	ZL, LOW(LedMatrix*2)   
	LDI 	ZH, HIGH(LedMatrix*2)  
	ADD 	ZL, Temp1                        
    ADC 	ZH, Temp0				
    LPM 	Temp1, Z                     
RET
LedMatrix:
			; hgfedcba   hgfedcba
	.db 	0b00111111, 0b00000110	;0,1
	.db 	0b01011011, 0b01001111	;2,3
	.db 	0b01100110, 0b01101101	;4,5
	.db 	0b01111101, 0b00000111	;6,7
	.db 	0b01111111, 0b01101111	;8,9
;=================================================
; ��������� ������������ ���������
Display:
	LDI 	Temp1, Bit0
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+5
	RCALL	Decoder
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+4
    RCALL 	Decoder 
	ORI		Temp1, SYMBOL_POINT ; Logical OR with Immediate (���������� ��� �������� � ������)
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+3
    RCALL 	Decoder            
	OUT 	SegPORT, Temp1     
 	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+2
    RCALL 	Decoder   
	ORI		Temp1, SYMBOL_POINT ; Logical OR with Immediate
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms
RET
;=================================================
; ��������� ������
GetButtons:
	IN 		Temp1,BtnPin		; ������ � �������� �� �����
	ANDI	Temp1,(1<<BtnMin)|(1<<BtnHour) ; Logical AND with Immediate
	CPI 	Temp1,0 			; ���������� � �����
	BREQ 	NoButtons 			; ���� ���� (��� �������) �����
	SUB 	Temp1,Flags			; ���������� ���������
	BREQ 	GetButtonsExit 		; ���� ����, �� ������ �� �� �����, �������
	CPI 	Temp1,(1<<BtnHour)	; �������� �� ��������� �����
	BREQ 	Press_hour ; Branch if Equal (Z=1)
	; ����� ���������� ������
	LDI 	Flags,(1<<BtnMin) 	; ������ ���������� ������
	LDS 	Temp1,Digits+2		; ������ ������� �����
	INC 	Temp1 				; ���������� ������� ����� 
	CPI 	Temp1,10	
	BREQ 	Tst2 		
	STS 	Digits+2,Temp1		; ������ ����� �����
	JMP 	GetButtonsExit 		; ����� 
Tst2:
	CLR 	Temp1  				; ��������� ����
	STS 	Digits+2,Temp1		; ������ ���� � ������ �����
	LDS 	Temp1,Digits+3		; ������ ������� �������� �����
	INC 	Temp1 				; ���������� ������� �������� ����� 
	CPI 	Temp1,6
	BREQ 	Tst3
	STS		Digits+3,Temp1		; ������ ����� �������� �����
	JMP 	GetButtonsExit 		; ����� 
Tst3:	
	CLR 	Temp1 				; ��������� ����
	STS 	Digits+3,Temp1 		; ������ ���� � ������ �������� �����
	JMP 	IncHour				; �����
	; ��������� ��������� �����
Press_hour:
	LDI 	Flags,(1<<BtnHour)	; ������ ���������� ������
IncHour:
	LDS		Temp1,Digits+4 		; ������ 3-��� �������
	INC 	Temp1 				; ���������� 3-��� �������
	CPI 	Temp1,10
	BREQ 	Tst4 
	STS 	Digits+4,Temp1		; ������ ����� 3-��� �������
	JMP 	Tst24 				; �������� �� 24
Tst4:
	CLR 	Temp1 				; ��������� ����
	STS 	Digits+4,Temp1		; ������ ���� 3-��� �������
	LDS 	Temp1,Digits+5		; ������ 4-��� ������� 
	INC 	Temp1 				; ���������� 4-��� ������� 
	STS 	Digits+5,Temp1 		; ������ ����� 4-��� �������
Tst24:	
	; �������� �� 24 ����
	LDS 	Temp1,Digits+5 		; ������ 6-��� �������
	CPI 	Temp1,2  			; �������� - ��� 24
	BRNE 	GetButtonsExit 		; ���� �� ���� �����
	; ���� � ��� 20 � ���-�� ����� �� ������� ������� ����� ���� �� ���� 25 
	LDS 	Temp1,Digits+4 		; ������ 5-��� �������
	CPI 	Temp1,4 			; ��������
	BRNE 	GetButtonsExit 		; ���� �� ���� �����
	; ����������� �������� �� 24 - �������� �����
	CLR 	Temp1				; ���� ���� ���������� �� ���� ����������
	STS 	Digits+4,Temp1		; ��������� 5-��� � 6-��� ��������
	STS 	Digits+5,Temp1
	RJMP 	GetButtonsExit 		; ����� 
Nobuttons:
	CLR 	Flags 				; ��������� ���������� ������
GetButtonsExit:
RET
;=================================================
; ���������� �������
GetTime:
	; ����������� �������
	LDS 	Temp1, Digits		; ������ ������ ������ - ������� ������
	INC 	Temp1				; ��������������
	CPI 	Temp1,10			; ��������� �� ����� �� ������� ������ �� 10
	BREQ 	Test1
	STS 	Digits,Temp1		; ���������� ������
	JMP 	GetTimeExit			; �������
	; ����������� ������� ������ 
Test1:
	; �������� ������� ������
	LDI 	Temp1,0
	STS		Digits,Temp1
	LDS		Temp1,Digits+1		; ������ ������ ������ - ������� ������
	INC		Temp1				; ��������������
	CPI		Temp1,6				; ��������� �� ����� �� ������� ������ �� 6
	BREQ	Test2
	STS 	Digits+1,Temp1
	JMP 	GetTimeExit
	; ������������� �����
Output1:
	CPI 	Counter,1
	BREQ 	GetTimeExit
	; ����������� ������� �����
Test2:
	; �������� ������� ������
	LDI		Temp1,0
	STS		Digits+1,Temp1
	LDS 	Temp1,Digits+2		; ������ ������ ������ - ������� �����
	INC 	Temp1				; ��������������
	CPI 	Temp1,10			; ��������� �� ����� �� ������� ����� �� 10
	BREQ 	Test3
	STS		Digits+2,Temp1
	JMP 	GetTimeExit
	; ����������� ������� �����
Test3:
	; �������� ������� �����
	LDI		Temp1,0
	STS		Digits+2,Temp1
	LDS 	Temp1,Digits+3		; ������ ��������� ������ - ������� �����
	INC 	Temp1				; ��������������
	CPI 	Temp1,6				; ��������� �� ����� �� ������� ����� �� 6
	BREQ 	Test4
	STS 	Digits+3,Temp1
	JMP 	GetTimeExit
	; ����������� ������� �����
Test4:
	; �������� ������� �����
	LDI		Temp1,0
	STS 	Digits+3,Temp1
	LDS 	Temp1,Digits+4		; ������ ����� ������ - ������� �����
	INC 	Temp1				; ��������������
	CPI 	Temp1,10			; ��������� �� ����� �� ������� ����� �� 10
	BREQ 	Test5
	STS		Digits+4,Temp1
	JMP		Check24
	; ����������� ������� �����
Test5:
	; �������� ������� �����
	LDI		Temp1,0
	STS		Digits+4,Temp1
	LDS 	Temp1,Digits+5		; ������ ������ ������ - ������� �����
	INC 	Temp1				; ��������������
	STS 	Digits+5,Temp1
	JMP 	Check24
Check24:
	; �������� �� 24 ����
	LDS 	Temp1,Digits+5 		; ������ 6-��� �������
	CPI 	Temp1,2  			; �������� - ��� 24
	BRNE 	GetTimeExit 		; ���� �� ���� �����
	; ���� � ��� 20 � ���-�� ����� 
	; �� ������� ������� ����� ���� �� ���� 25
	LDS 	Temp1,Digits+4 	; ������ 5-��� �������
	CPI 	Temp1,4 			; ��������
	BRNE 	GetTimeExit 		; ���� �� ���� �����
	; ����������� �������� �� 24 - �������� �����
	; ���� ���� ���������� �� ���� ����������
	LDI 	Temp1,0
	STS 	Digits+4,Temp1
	STS 	Digits+5,Temp1 		; ��������� 5-��� � 6-��� ��������
GetTimeExit:
RET
;=================================================
