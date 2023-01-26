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
	.equ	SonarPORT 				= PORTD			
	.equ	SonarPIN 				= PIND
	.equ	SonarDDR  				= DDRD
	.equ	SonarTrig  				= 6
	.equ	SonarEcho  				= 7
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
	CLI
	PUSH	Temp1
	PUSH	Temp2
	IN		Temp1,SREG
	PUSH	Temp1
	OUT 	TCNT1H, Temp0
	OUT 	TCNT1L, Temp0
	; �������� ��������� ���������� ����������
	RCALL	HCSR04_GetRange
	; ���������� ����� �����
	RCALL	DIGITS16
	; ���������� ����� ����� � ������
	STS		Digits+3, Temp2
	STS		Digits+2, Temp3
	STS		Digits+1, Temp4
	STS		Digits, Temp5
	POP		Temp1
	OUT		SREG, Temp1
	POP		Temp2
	POP		Temp1
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
	; �������������� ���������
	LDI		Temp1, (1<<SonarTrig)|(0<<SonarEcho)
	OUT		SonarDDR, Temp1
	; ��������� UART
	RCALL	UART_Init
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
	LDI 	Temp1, Bit0
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+3
	RCALL	Decoder
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+2
    RCALL 	Decoder        
	OUT 	SegPORT, Temp1     
    LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits+1
    RCALL 	Decoder 
	ORI		Temp1, SYMBOL_POINT              
	OUT 	SegPORT, Temp1     
    LDI 	Temp1, DisplayDelay
	RCALL 	Delayms

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDS 	Temp1, Digits
    RCALL 	Decoder        
	OUT 	SegPORT, Temp1     
    LDI 	Temp1, DisplayDelay
	RCALL 	Delayms
RET
;=================================================
; ������ � �������������� ����������� HC-SR04
; ��������� ���������, ��������� � �����������, 2 �����
; ��������� Temp1, Temp2
HCSR04_GetRange:
	CLR		Temp1
	CLR		Temp2
	CLR		Temp3
	CLR		Temp4
	CLR		Temp5
	CLR		YL
	CLR		YH
	SBI		SonarPORT, SonarTrig
	LDI		Temp1,15
	RCALL	Delayus
	CBI		SonarPORT, SonarTrig
	; ������� ����� Echo
Echo:
	SBIS	SonarPIN, SonarEcho		
	RJMP	Echo
	; �������� ����������� �����
EchoCount:
	ADIW	YL, 1					; 2 �����
	SBIC    SonarPIN, SonarEcho     ; 1/2 �����: false=1, true=2
	RJMP	EchoCount				; 2 �����
	; ����� ������ M=(2+1+2)*(N-1)+2+2+1(�� SBIS ������)=5*N
	; �������� ����� V=340,29 �/c
	; ���������� � �� = N*5/8000*340/2=M*5/800*17=N*85/800

	MOV		Temp1, YH
	RCALL	UART_send
	RCALL	Delay10us
	MOV		Temp1, YL
	RCALL	UART_send

	MOV		Temp1, YH
	MOV		Temp2, YL
	; ����� �� 32
	LDI		Temp3, 0
	LDI		Temp4, 32
	RCALL	DIV16X16u
	; �������� �� 85
	LDI		Temp3, 0
	LDI		Temp4, 85
	RCALL	MUL16X16u
	MOV		Temp1, Temp3
	MOV		Temp2, Temp4
	; ����� �� 25
	LDI		Temp3, 0
	LDI		Temp4, 25
	RCALL	DIV16X16u
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
