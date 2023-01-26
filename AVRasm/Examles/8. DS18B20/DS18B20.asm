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
	.equ	DS18B20_SEARCH_ROM 		= 0xF0			; ����� ������� ���� ��������� �� �������������
	.equ	DS18B20_READ_ROM 		= 0x33			; ����������� ������ ������������� ����������
	.equ	DS18B20_MATCH_ROM 		= 0x55			; ��������� ����������� ���������� �� ��� ������
	.equ	DS18B20_SKIP_ROM 		= 0xCC 			; ��������� � ������������� �� ���� ���������� ��� �������� ��� ������
	.equ	DS18B20_ALARM_SEARCH 	= 0xEC			; ����� ���������, � ������� �������� ALARM (�������� ������ ��� � CMD_SERCH_ROM)
	.equ	DS18B20_CONVERT_T 		= 0x44			; ����� �������������� �����������
	.equ	DS18B20_W_SCRATCHPAD 	= 0x4E			; ������ �� ���������� ����� (��������)
	.equ	DS18B20_R_SCRATCHPAD 	= 0xBE			; ������ ����������� ������ (���������)
	.equ	DS18B20_C_SCRATCHPAD 	= 0x48			; ���������� ��������� � EEPROM 
	.equ	DS18B20_RECALL_EE 		= 0xB8			; ������� � ����� �� EEPROM �������� ������ ALARM
	.equ	DS18B20_READ_POWER 		= 0xB4			; �����������, ���� �� � ���� ���������� � ���������� ��������
	.equ	DS18B20_RES_9BIT 		= 0x1F			; ���������� ������� (9 ���)
	.equ	DS18B20_RES_10BIT 		= 0x3F			; ���������� ������� (10 ���)
	.equ	DS18B20_RES_11BIT 		= 0x5F			; ���������� ������� (11 ���)
	.equ	DS18B20_RES_12BIT 		= 0x7F			; ���������� ������� (12 ���)
;=================================================
	.equ	SegPORT 				= PORTC			
	.equ	SegDDR  				= DDRC			
	.equ	DigPORT 				= PORTB			
	.equ	DigDDR  				= DDRB			
	.equ	Digit1  				= 0				
	.equ	Digit2  				= 1				
	.equ	Digit3  				= 2				
	.equ	Digit4  				= 3		
	.equ	WirePORT 				= PORTD
	.equ	WirePIN  				= PIND			
	.equ	WireDDR  				= DDRD			
	.equ	TEMP_DQ  				= 5
; ������� SRAM ������
.DSEG
	Digits:  			.byte		4	
	TempData:			.byte		9	; ����� ������ DS18B20
	TempCRC:			.byte		1	; ������������� �����.����� ��� DS18B20					
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
	; ��������� ���������� ����������� �������� �����������
	RCALL	DS18B20_GetTemp
	MOV		Temp5, Temp1
	; ������ ������ ��������� �����������
	RCALL	DS18B20_ConvertTemp
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
	; ������ ������� ��������� �����������
	RCALL	DS18B20_ConvertTemp
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
	.include "./lib/DS18B20.asm"
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
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D1
	LDS 	Temp1, Digits
D1:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms        

	LDI 	Temp1, Bit1
	OUT 	DigPORT, Temp1			  
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D2
	LDS 	Temp1, Digits+1
	RCALL 	Decoder        
D2:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms   
	
	LDI 	Temp1, Bit2
	OUT 	DigPORT, Temp1			  
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D3
	LDS 	Temp1, Digits+2
	RCALL 	Decoder  
	ORI		Temp1, SYMBOL_POINT      
D3:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms   

	LDI 	Temp1, Bit3
	OUT 	DigPORT, Temp1			  
	LDI		Temp1, SYMBOL_MINUS
	CPI		Temp5, 0x00
	BRNE	D4
	LDS 	Temp1, Digits+3
	RCALL 	Decoder  
D4:	 
	OUT 	SegPORT, Temp1     
	LDI 	Temp1, DisplayDelay
	RCALL 	Delayms  
RET

