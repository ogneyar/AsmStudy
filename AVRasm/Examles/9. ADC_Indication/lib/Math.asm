;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
; ���������� ��� ������ � �����������
;	SUB16X16		��������� 16-��������� �����
;	ADD16X16		�������� 16-��������� �����	
;	MUL16X16s		�������� ��������� 16-��������� �����
;	MUL16X16u		����������� ��������� 16-��������� �����
;	DIV16X16s		�������� ������� 16-��������� �����
;	DIV16X16u		����������� ������� 16-��������� �����
;	DIV16POWER2s	�������� ������� 16-���������� ����� �� ������� 2
;	DIV16POWER2u	����������� ������� 16-���������� ����� �� ������� 2
;	SIGN16			����� ����� 16-���������� �����
;	DEC2BCD			������� 8-���������� ����������� ����� � �������-���������� (BCD)
;	BCD2DEC			������� 8-���������� �������-����������� (BCD) ����� � ����������	
;	CP16X16			��������� 16-��������� �����
;	DIGITS8			���������� ���� 8-���������� �����
;	DIGITS16		���������� ���� 16-���������� �����
;=======================================================================
; ��������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	Temp1-Temp2 ��������� �� H � L
SUB16X16:
	SUB		Temp2, Temp4
	SBC		Temp1, Temp3
RET
;=======================================================================
; �������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	Temp1-Temp2 ��������� �� H � L
ADD16X16:
	ADD		Temp2, Temp4
	ADC		Temp1, Temp3
RET
;=======================================================================
; �������� ��������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	Temp1-Temp4 ��������� �� H � L
MUL16X16s:
    MULS    Temp3, Temp1    	; (signed)ah * (signed)bh
    MOV		Temp5, MulHigh
	MOV		Temp6, MulLow
	MUL     Temp4, Temp2    	; al * bl
    MOV		Temp7, MulHigh
	MOV		Temp8, MulLow
	MULSU   Temp3, Temp2    	; (signed)ah * bl
    SBC     Temp5, Temp0		; ��-�� �����. �����
    ADD     Temp7, MulLow
    ADC     Temp6, MulHigh
    ADC     Temp5, Temp0
    MULSU   Temp1, Temp4    	; (signed)bh * al
    SBC     Temp5, Temp0		; ��-�� �����. �����
    ADD     Temp7, MulLow
    ADC     Temp6, MulHigh
    ADC     Temp5, Temp0
	MOV		Temp1, Temp5			; move result
	MOV		Temp2, Temp6
	MOV		Temp3, Temp7
	MOV		Temp4, Temp8
RET
;=======================================================================
; ����������� ��������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	Temp1-Temp4 ��������� �� H � L
MUL16X16u:
    MUL    	Temp3, Temp1    	; (unsigned)ah * (unsigned)bh
    MOV		Temp5, MulHigh
	MOV		Temp6, MulLow
    MUL     Temp4, Temp2    	; al * bl
    MOV		Temp7, MulHigh
	MOV		Temp8, MulLow
    MUL	   	Temp3, Temp2    	; (unsigned)ah * bl
   	ADD     Temp7, MulLow
    ADC     Temp6, MulHigh
    ADC     Temp5, Temp0
    MUL   	Temp1, Temp4    	; (unsigned)bh * al
    ADD     Temp7, MulLow
    ADC     Temp6, MulHigh
    ADC     Temp5, Temp0
	MOV		Temp1, Temp5		; move result
	MOV		Temp2, Temp6
	MOV		Temp3, Temp7
	MOV		Temp4, Temp8
RET
;=======================================================================
; �������� ������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	Temp1-Temp2 ��������� �� H � L
;			R13-R14 ������� �� H � L
DIV16X16s:	
	MOV		R10,R16	;��������� ���� ����������
	EOR		R10,R18	;���� �������� � R10
	SBRS	R16,7	; ��������� ���� ��������
	RJMP	d16s_1	; ���� ������������� �� ���� ������
	COM		R16		; ����� ������ ���� ��������
	COM		R17		; ����������� � ��� ���
	SUBI	R17,LOW(-1)
	SBCI	R16,HIGH(-1)
d16s_1:	
	SBRS	R18,7	; ��������� ���� ��������
	RJMP	d16s_2
	COM		R18	
	COM		R19
	SUBI	R19,LOW(-1)
	SBCI	R18,HIGH(-1)
	; ����������� ������� � ��������
d16s_2:	
	; ������� ������� � ���� ��������
	CLR		R14
	CLR		R13
	CLC
	LDI		R31,17	; init loop counter
d16s_3:		
	ROL		R17		; shift left dividend
	ROL		R16
	DEC		R31		; decrement counter
	BRNE	d16s_5	; if done
	SBRS	R10,7	; if MSB in sign register set
	RJMP	d16s_4
	COM		R16		; change sign of result
	COM		R17
	SUBI	R17,LOW(-1)
	SBCI	R16,HIGH(-1)
d16s_4:	
	RET
d16s_5:	
	ROL		R14		; shift dividend into remainder
	ROL		R13
	SUB		R14,R19	; remainder = remainder - divisor
	SBC		R13,R18
	BRCC	d16s_6	; if result negative
	ADD		R14,R19	; restore remainder
	ADC		R13,R18
	CLC				; clear carry to be shifted into result
	RJMP	d16s_3	; else
d16s_6:	
	SEC				; set carry to be shifted into result
	RJMP	d16s_3
;=======================================================================
; ����������� ������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	Temp1-Temp2 ��������� �� H � L
;			R13-R14 ������� �� H � L
;=================================================
DIV16X16u:	
	; ������� ������� � ���� ��������
	CLR		R14
	CLR		R13
	CLC
	LDI		R31,17	;init loop counter
d16u_1:	
	ROL		R17		;shift left dividend
	ROL		R16
	DEC		R31		;decrement counter
	BRNE	d16u_2	;if done
	RET			;    return
d16u_2:	
	ROL		R14	;shift dividend into remainder
	ROL		R13
	SUB		R14,R19	;remainder = remainder - divisor
	SBC		R13,R18	;
	BRCC	d16u_3	;if result negative
	ADD		R14,R19	;restore remainder
	ADC		R13,R18
	CLC				;clear carry to be shifted into result
	RJMP	d16u_1	;else
d16u_3:	
	SEC			;    set carry to be shifted into result
	RJMP	d16u_1
;=======================================================================
; �������� ������� 16-���������� ����� �� ������� 2
; 	����: 	Temp1-Temp2 ������� �� H � L
;			Temp5 ������� 2
;	�����:	Temp1-Temp2 ��������� �� H � L
DIV16POWER2s:
	TST		Temp5
	BREQ	DIV16POWER2s_2
DIV16POWER2s_1:
	ASR		Temp1
	ROR		Temp2
	DEC		Temp5
	BRNE	DIV16POWER2s_1
DIV16POWER2s_2:
RET
;=======================================================================
; ����������� ������� 16-���������� ����� �� ������� 2
; 	����: 	Temp1-Temp2 ������� �� H � L
;			Temp5 ������� 2
;	�����:	Temp1-Temp2 ��������� �� H � L
DIV16POWER2u:
	TST		Temp5
	BREQ	DIV16POWER2u_2
DIV16POWER2u_1:
	LSR		Temp1
	ROR		Temp2
	DEC		Temp5
	BRNE	DIV16POWER2u_1
DIV16POWER2u_2:
RET
;=======================================================================
; ����� ����� 16-���������� �����
; 	����: 	Temp1-Temp2 ����� �� H � L
;	�����:	Temp1-Temp2 ��������� �� H � L
SIGN16:
	COM		Temp1
	COM		Temp2
	SUBI	Temp2,LOW(-1)
	SBCI	Temp2,HIGH(-1)
RET	
;=======================================================================
; ������� 8-���������� ����������� ����� � �������-���������� (BCD)
; 	����: 	Temp1 ���������� �����
;	�����:	Temp1 BCD �����
DEC2BCD: 
	PUSH 	Temp2
	PUSH 	Temp3
	PUSH 	Temp4
	CPI 	Temp1,10
	BRLO 	Dec2Bcd_exit
	PUSH 	Temp1
	CLR 	Temp3
	LDI 	Temp2,10   
Dec2Bcd_1: 
	SUB 	Temp1,Temp2 
	INC 	Temp3
	CPI 	Temp1,10    
	BRGE 	Dec2Bcd_1
	CLR 	Temp4
	CLR 	Temp1 
Dec2Bcd_2: 
	ADD 	Temp4,Temp2 
	INC 	Temp1
	CP 		Temp1,Temp3
	BRNE 	Dec2Bcd_2  
	
	POP 	Temp1
	SUB 	Temp1,Temp4 
	SWAP 	Temp3
	ADD 	Temp1,Temp3
Dec2Bcd_exit:
	POP 	Temp4
	POP 	Temp3
	POP 	Temp2
RET
;=======================================================================
; ������� 8-���������� �������-����������� (BCD) ����� � ����������
; 	����: 	Temp1 BCD �����
;	�����:	Temp1 ���������� �����
BCD2DEC: 
	PUSH 	Temp2
	PUSH 	Temp3
	PUSH 	Temp1
	SWAP 	Temp1
	CLR 	Temp3
	CBR 	Temp1,0b11110000
	MOV 	Temp3,Temp1
	CLR 	Temp2
Bcd2Dec_1:
 	ADD 	Temp1,Temp3
	INC 	Temp2
	CPI 	Temp2,9
	BRNE 	Bcd2Dec_1
	MOV 	Temp2,Temp1
	POP 	Temp1 
	CBR 	Temp1,0b11110000
	ADD 	Temp1,temp2
	POP 	Temp3
	POP 	Temp2
RET
;=======================================================================
; ��������� 16-��������� �����
; 	����: 	Temp1-Temp2 ������ �������� �� H � L
; 			Temp3-Temp4 ������ �������� �� H � L
;	�����:	������ �����
CP16X16:
	CP		Temp2, Temp4
	CPC		Temp1, Temp3
RET
;=======================================================================
; ���������� ���� 8-���������� �����
; 	����: 	Temp1 ��������
;	�����:	Temp1-Temp3 ����� �� H � L
DIGITS8:
	CLR		R26
	CLR		R27
	CLR		R28
	CLR		R29
	CLR		R30
	LDI		Temp2,100
DIG8_1:
	CP		Temp1,Temp2
	BRLO	DIG8_2
	SUB		Temp1,Temp2
	; �����
	INC		R26	
	RJMP	DIG8_1
DIG8_2:	
	LDI		Temp2,10
DIG8_3:
	CP		Temp1,Temp2
	BRLO	DIG8_4
	SUB		Temp1,Temp2
	; ������
	INC		R27		
	RJMP	DIG8_3
DIG8_4:
	; � Temp1 �������� ������ �������
	MOV		Temp3,Temp1
	MOV		Temp1,R26		
	MOV		Temp2,R27
RET
;=======================================================================
; ���������� ���� 16-���������� �����
; 	����: 	Temp1-Temp2 �������� �� H � L
;	�����:	Temp1-Temp5 ����� �� H � L
DIGITS16:
	CLR		R26
	CLR		R27
	CLR		R28
	CLR		R29
	CLR		R30
	LDI		Temp3,HIGH(10000)
	LDI		Temp4,LOW(10000)
DIG16_1:
	RCALL	CP16X16	
	BRLO	DIG16_2
	RCALL	SUB16X16
	; ������� �����
	INC		R26	
	RJMP	DIG16_1
DIG16_2:	
	LDI		Temp3,HIGH(1000)
	LDI		Temp4,LOW(1000)
DIG16_3:
	RCALL	CP16X16	
	BRLO	DIG16_4
	RCALL	SUB16X16
	; ������
	INC		R27		
	RJMP	DIG16_3
DIG16_4:
	LDI		Temp3,HIGH(100)
	LDI		Temp4,LOW(100)
DIG16_5:
	RCALL	CP16X16	
	BRLO	DIG16_6
	RCALL	SUB16X16
	; �����
	INC		R28	
	RJMP	DIG16_5
DIG16_6:
	LDI		Temp3,HIGH(10)
	LDI		Temp4,LOW(10)
DIG16_7:
	RCALL	CP16X16	
	BRLO	DIG16_8
	RCALL	SUB16X16
	; �������
	INC		R29
	RJMP	DIG16_7
DIG16_8:
	; � Temp1-Temp2 �������� ������ �������
	MOV		Temp5,Temp2
	MOV		Temp1,R26		
	MOV		Temp2,R27
	MOV		Temp3,R28
	MOV		Temp4,R29
RET
