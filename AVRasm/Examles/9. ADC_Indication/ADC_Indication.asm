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
	.equ	BtnMode  				= 2
	.equ	ADCchmin				= 0x60
	.equ	ADCchmax				= 0x67
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
;=================================================
; ���������� ������� 1 �� ���������� ������ �
TIMER1_COMPA:
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
	; �������� ����������
	LDI 	Temp1, 0xFF
	OUT 	SegDDR, Temp1
	; ������� ����������
	LDI 	Temp1, (1<<Digit1)|(1<<Digit2)|(1<<Digit3)|(1<<Digit4)
	OUT 	DigDDR, Temp1
	; ��������� ����� ������
	CBI		BtnDDR, BtnMode
	; ��������� UART
	RCALL	UART_Init
	; ��������� ��� - ���������� ����� 5 �
	LDI 	Temp1, (1<<REFS0)|(0<<REFS1)|(1<<ADLAR)
	OUT 	ADMUX, Temp1	
	; ��������� ��������
	; ���������� ���������� ������� 1 �� ���������� ������ �
	LDI 	Temp1, (1<<OCIE1A)
	OUT 	TIMSK, Temp1 
	; ��������� ������������ /256
	LDI 	Temp1, (1<<CS12)
	OUT 	TCCR1B, Temp1 
	; ��������� ����� ��������� 3125 (8000000/256=31250 - 1 ���. ��� 8���)
	LDI 	XH, HIGH(3125)
	OUT 	OCR1AH, XH
	LDI 	XL, LOW(3125)
	OUT 	OCR1AL, XL
 	; ��������� �������� ������� 1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; ��������� ����������
	;SEI
;=================================================
; �������� ��������� (����)
Main:
	CLR		Temp1
	RCALL	ADC_GetValue
	RCALL	UART_Send
	; ��������� ������ �� ������
	SBIS	BtnPIN, BtnMode
	RJMP	M1
	; ������� ��������� ��� ��� ���������
	; ���������� ����� �����
	RCALL	DIGITS8
	; ���������� ����� ����� � ������
	STS		Digits+3, Temp3
	STS		Digits+2, Temp2
	STS		Digits+1, Temp1
	STS		Digits, Temp0
	RJMP	M2	
M1:
	; ������������� ��������� ��� � ������
	LDI		Temp2,50
	MUL		Temp1,Temp2	
	MOV		Temp1,R1
	MOV		Temp2,R0
	LDI		Temp3,0x00
	LDI		Temp4,0xFF
	RCALL	DIV16X16u	
	RCALL	DIGITS16
	STS		Digits, Temp4
	STS		Digits+1, Temp5
	MOV		Temp1,R14	
	LDI		Temp2,100
	MUL		Temp1,Temp2
	MOV		Temp1,R1
	MOV		Temp2,R0
	LDI		Temp3,0x01
	LDI		Temp4,0x00
	RCALL	DIV16X16u
	STS		Digits+2, Temp4
	STS		Digits+3, Temp5			
M2:	
	; �������� ��������� ���������
	RCALL	Display
	; ���� ����������� �������
	RJMP	Main
;=================================================
	.include "./lib/Delay.asm"
	.include "./lib/Math.asm"
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
	SBIS	BtnPIN, BtnMode
	RJMP	D1
	CLR		Temp1
	RJMP	D2	
D1:
	LDI 	Temp1, Bit0
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits
	RCALL	Decoder
	ORI		Temp1, SYMBOL_POINT
D2:	
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+1
    RCALL 	Decoder        
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+2
    RCALL 	Decoder               
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+3
    RCALL 	Decoder        
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms
RET
;=================================================
; ������ � ��� ����������, ������ �������������� � ��������, ����� �������� � Temp1
; ��������� Temp1
ADC_GetValue:
	; �������� ��������������� ����� ���
	LDI		Temp2, ADCchmin
	ADD		Temp2, Temp1
	OUT		ADMUX, Temp2 
	; ������ ������������ �������������� ���
	; 5 = 101 � ADPS ������� ��� XTAL/32
	LDI		Temp2, (1<<ADEN)|(0<<ADIE)|(1<<ADSC)|(0<<ADATE)|(5<<ADPS0)
	OUT		ADCSRA, Temp2
	; ���� ��������� ��������������
	SBIC	ADCSRA, ADSC
	RJMP	PC-1
	; ��������� ��������� ���
	; ADCL � ����� �������� ������ �� ��������� ��� ���������� ������
	IN		Temp1, ADCH		
RET
;=================================================
; ������������� UART
UART_Init:
	; Configure Baud Divider
	LDI 	Temp1, LOW(UART_BaudDivider)
	OUT 	UBRRL, Temp1
	LDI 	R16, HIGH(UART_BaudDivider)
	OUT 	UBRRH, Temp1
	OUT 	UCSRA, Temp0
	; Enable UART Interrupts
	LDI 	Temp1, (1<<RXEN)|(1<<TXEN)|(0<<RXCIE)|(0<<TXCIE)|(0<<UDRIE)
	OUT 	UCSRB, Temp1	
	; Set Frame Bits: 8 data bits, 1 stop bit, no parity
	LDI 	Temp1, (1<<URSEL)|(1<<UCSZ0)|(1<<UCSZ1)
	OUT 	UCSRC, Temp1
RET
; �������� �����
UART_Send:	
	SBIS 	UCSRA, UDRE			
	RJMP	UART_Send			
	OUT		UDR, Temp1
RET
; ����� �����
UART_Receive:	
	SBIS	UCSRA, RXC			
	RJMP	UART_Receive		
	IN		Temp1, UDR				
RET
;=================================================

