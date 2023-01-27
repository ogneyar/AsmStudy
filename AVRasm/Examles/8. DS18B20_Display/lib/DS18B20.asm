;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
; ���������� ��� ������ � �������� ����������� DS18B20
;	DS18B20_Init			������������� ������� �� ����
;	DS18B20_Resive			��������� ����� ����� �� �����
;	DS18B20_Send			��������� �������� ����� � �����
;	DS18B20_Read			��������� 9 ������ � �����, ������������ CRC
;	CRC8					��������� ������� CRC8
;	DS18B20_SetResolution	��������� ���������� �������
;	DS18B20_ConvertTemp		�������� ������� �������������� �����������
;	DS18B20_GetTemp			���������� �����������
;	TempTable				������� ��� �������������� ������� ����� �����������
;=======================================================================
; ������������� ������� �� ����
; ��������� ����� ����� � ������ ������� ������� ����������� PRESENCE �� �������
; 	�����: Z-���� ��� ������� ������� ����������� ������� Z-����, ����� ���������� ���	
DS18B20_Init:
	CBI		WirePORT, TEMP_DQ
	CBI		WireDDR, TEMP_DQ	; 0->DDR = Z-���������
	SBIS	WirePIN, TEMP_DQ	; �������� ������� 1 � �����
	RJMP	DS18B20_Fault		; ���� ��� - ��� ������
	SBI		WireDDR, TEMP_DQ	; ����� ����� ����� � 0
	LDI		Temp1, 48			; �������� � 480 �����������
	RCALL	Delayus			
	CBI		WireDDR, TEMP_DQ	; ����� ����� � 1
	LDI		Temp1, 6			; �������� � 60 �����������
	RCALL	Delayus			
	; �������� ����� ������ ����������� PRESENCE
	LDI		Temp1, 240			; ���� � ������� - 240 max
DS18B20_Wait:
	SBIS 	WirePIN, TEMP_DQ
	RJMP	DS18B20_Ok
	RCALL	Delay1us
	DEC		Temp1
	BRNE 	DS18B20_Wait
DS18B20_Fault:
	; PRESENCE �� �������
	CLZ							; ���������� Z-����	
	RET
DS18B20_Ok:
	; PRESENCE �������, �������� � 480 �����������
	LDI		Temp1, 48
	RCALL	Delayus
	SEZ							; ������� Z-����
RET		
;=======================================================================
; ��������� ����� ����� �� �����
; 	�����: Temp1 �������� ����
DS18B20_Resive:
	SER		Temp1 ; Set Register (Rd < $FF)
;=======================================================================
; ��������� �������� ����� � �����
; ���� ������ ����� 0�FF, �� �� ������ ����� �������� ����
; 	����: Temp1 ������������ ����
DS18B20_Send:
	LDI		Temp2, 8			; ����� ����� � �����
sw1_next:
	PUSH	Temp4
	IN		Temp4, SREG
	PUSH	Temp4				; �������� �����, �.�. ����� ��������� ����������
	CLI							; ��������� ����������
	SBI		WireDDR, TEMP_DQ	; 1->DDR = 0 �� ������						; ����� ����� � 0
	RCALL	Delay1us			; 1 ��� ��������
	ROR		Temp1				; ����������� ��������� ��� (Rotate Right Through Carry) >> c ��������� (Carry)
	BRCC	S0					; ���� ��� C = 0 - ����� (Branch if Carry Cleared)
	CBI		WireDDR, TEMP_DQ	; 0->DDR = Z-���������						; ����� � 1
s0:
	PUSH	Temp2
	LDI		Temp2, 9			; � ��������� ������� ����� �������������
								; ��������� ��� ��������, �� �� ����� 13!
sw1_wait:
	RCALL	Delay1us
	DEC		Temp2
	BRNE	sw1_wait
	CLC	
	SBIC	WirePIN, TEMP_DQ
	SEC
	ROR		Temp3
	PUSH	Temp1
	LDI		Temp1, 9
	RCALL	Delayus				; 90 ����������� - ������������ ����-�����
	POP		Temp1
	CBI		WireDDR, TEMP_DQ	; 0->DDR = Z-���������
	POP		Temp2
	
	POP		Temp4
	OUT		SREG, Temp4
	POP		Temp4

	DEC		Temp2
	BRNE 	sw1_next		
	MOV		Temp1, Temp3
RET	
;=======================================================================
; ��������� 9 ������ � �����, ������������ CRC
; 	�����: � SRAM TempData - LS � MS
DS18B20_Read:
	CLR		Temp2
	STS		TempCRC, Temp2		; �������� CRC
	LDI		XL, LOW(TempData)
	LDI		XH, HIGH(TempData)
	LDI		Temp2, 9			; 9 ������
r1w_next:
	PUSH	Temp2
	RCALL	DS18B20_Resive		; ��������� 1 ����
	; Temp1=���������� �����, �������� ������� CRC
	ST		X+, Temp1			; ��������� �������� ����
	;RCALL	CRC8				; ������� ����������� �����
 	POP		Temp2
	DEC		Temp2
	BRNE	r1w_next
RET
;=======================================================================
; ��������� ������� CRC8
; ����������: ����� ������ ������� CRC ���������� ��������
; 	����: Temp1 ��������� ����
;	�����: � SRAM TempCRC - ����������� ����� CRC8
CRC8:
	PUSH	Temp1
	LDI		Temp3, 8
CRC8_loop:
	LDS		Temp2, TempCRC
	EOR		Temp1, Temp2 ; Exclusive OR
	ROR		Temp1 ; >>
	MOV		Temp1, Temp2
	BRCC 	Zero ; Branch if Carry Cleared
	LDI		Temp2, 0x18
	EOR		Temp1, Temp2
Zero:
	ROR		Temp1
	STS		TempCRC, Temp1
	POP		Temp1
	; 4 ��������� ������� ������ ����������� ����� r0
	PUSH	Temp1
	ROR		Temp1
	POP		Temp1
	ROR		Temp1
	; ����� ��������
	PUSH	Temp1
	DEC		Temp3
	BRNE 	CRC8_loop
	POP		Temp1
	LDS		Temp1, TempCRC
RET
;=======================================================================
; ��������� ���������� �������, �� ��������� ������������ ���������� 12 ���
; 	����: Temp1 ��������������� ����������
DS18B20_SetResolution:
	MOV		Temp3, Temp1
	; Reset 1-wire
	RCALL	DS18B20_Init
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send		
	; Set resolution
	LDI		Temp1,DS18B20_W_SCRATCHPAD	
	RCALL	DS18B20_Send		
	LDI		Temp1, 0xFF
	RCALL	DS18B20_Send		
	RCALL	DS18B20_Send		
	MOV		Temp1, Temp3
	RCALL	DS18B20_Send		
	; Reset 1-wire
	RCALL	DS18B20_Init
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send
	LDI		Temp1,DS18B20_C_SCRATCHPAD
	RCALL	DS18B20_Send			
RET
;=======================================================================
; �������� ������� �������������� �����������
;	�����: � Temp1 0 ��� ���������� ������ � 255 ��� ������
DS18B20_ConvertTemp:
	; Reset 1-wire
	RCALL	DS18B20_Init
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send		
	; Convert temperature
	LDI		Temp1,DS18B20_CONVERT_T		
	RCALL	DS18B20_Send
	LDI		Temp1, 0x00		
RET
;=======================================================================
; ���������� �����������
;	�����: � SRAM TempDigit �� L � H (TempDigit ��� ������� ����� ����)
;	�����: Temp1 ��� ���������� ������ 0 � 255 ��� �������
DS18B20_GetTemp:
	; Reset 1-wire
	RCALL	DS18B20_Init
	BREQ	DNext ; Branch if Equal (if flag Zero=1)
	LDI		Temp1, 0xFF
	RET
DNext:
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send
	; Read ScratchPad
	LDI		Temp1,DS18B20_R_SCRATCHPAD	
	RCALL	DS18B20_Send			
	; Read bytes
	RCALL	DS18B20_Read
	; ��������� ����� �����
	LDS		Temp2,TempData		; Load LS
	LDS		Temp1,TempData+1	; Load MS
	CLR		Temp3
	; �������� ������������� �����������
	CPI 	Temp1,0x08 ; Compare with Immediate (Temp1 - 0x08)
	BRLO 	IsPlus ; Branch if Lower (if flag Carry=1 then Temp1 < 0x08)
IsMinus:
	; ���� ����������� ������������� ��...
	NEG 	Temp2 ; 0 - Temp2 (������� � ������������� ��������)
	COM 	Temp1 ; 0xff - Temp1 (0 ��������� �� 1, 1 �� 0)
	STS		TempData,Temp2
	STS		TempData+1,Temp1
	; ���������� ���� ������
	LDI		Temp3,SYMBOL_MINUS
IsPlus:
	STS		Digits,Temp3
	; �������� � Temp2 ����� �����
	ANDI 	Temp2, 0xF0
	OR 		Temp2, Temp1
	SWAP 	Temp2 ;  Swap Nibbles (Rd(3..0) - Rd(7..4))
	CLR		Temp1
IntLoop:
	CPI		Temp2,10 ; Compare with Immediate
	BRLO	IntNext ; Branch if Lower (Rd < x)
	SUBI	Temp2,10 ; ���������
	INC		Temp1
	JMP		IntLoop	
IntNext:
	; ������� 
	STS		Digits+1,Temp1
	; �������
	STS		Digits+2,Temp2
	; ��������� ������� �����
	LDS		Temp3,TempData		; Load LS
	ANDI	Temp3,0x0F			; �������� ������� �����
	; ������� �� �� 0.0625 ������� ��������� ��������
	LDI 	ZL,LOW(TempTable*2)   
	LDI 	ZH,HIGH(TempTable*2)
	CLR		R24
	LSL 	Temp3 ; Logical Shift Left <<
	ADD		ZL,Temp3
	ADC		ZH,R24

	LPM		Temp1,Z+ ; Load Program Memory and PostIncrement
	LPM		Temp2,Z+

	CPI		Temp2,6
	BRLO	FracAdd
	INC		Temp1
FracAdd:	
	STS  	Digits+3,Temp1
	LDI		Temp1, 0x00
RET
;=======================================================================
; ������� ��� �������������� ������� ����� �����������
TempTable: 
	; ������ � ������ ����� ����� �������
	; � ������������ ������ ��� ������� �����
	.db 0b00000000,0b00000000	;0,0,0,0
	.db 0b00000000,0b00000110	;0,6,2,5
	.db 0b00000001,0b00000010	;1,2,5,0
	.db 0b00000001,0b00001000	;1,8,7,5
	.db 0b00000010,0b00000101	;2,5,0,0
	.db 0b00000011,0b00000001	;3,1,2,5
	.db 0b00000011,0b00000111	;3,7,5,0
	.db 0b00000100,0b00000011	;4,3,7,5
	.db 0b00000101,0b00000000	;5,0,0,0
	.db 0b00000101,0b00000110	;5,6,2,5
	.db 0b00000110,0b00000010	;6,2,5,0
	.db 0b00000110,0b00001000	;6,8,7,5
	.db 0b00000111,0b00000101	;7,5,0,0
	.db 0b00001000,0b00000001	;8,1,2,5
	.db 0b00001000,0b00000111	;8,7,5,0
	.db 0b00001001,0b00000011	;9,3,7,5
