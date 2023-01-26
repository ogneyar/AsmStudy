;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
; БИБЛИОТЕКА ДЛЯ РАБОТЫ С МАТЕМАТИКОЙ
;	SUB16X16		вычитание 16-разрядных чисел
;	ADD16X16		сложение 16-разрядных чисел	
;	MUL16X16s		знаковое умножение 16-разрядных чисел
;	MUL16X16u		беззнаковое умножение 16-разрядных чисел
;	DIV16X16s		знаковое деление 16-разрядных чисел
;	DIV16X16u		беззнаковое деление 16-разрядных чисел
;	DIV16POWER2s	знаковое деление 16-разрядного числа на степень 2
;	DIV16POWER2u	беззнаковое деление 16-разрядного числа на степень 2
;	SIGN16			смена знака 16-разрядного числа
;	DEC2BCD			перевол 8-разрядного десятичного числа в двоично-десятичное (BCD)
;	BCD2DEC			перевол 8-разрядного двоично-десятичного (BCD) числа в десятичное	
;	CP16X16			сравнение 16-разрядных чисел
;	DIGITS8			вычисление цифр 8-разрядного числа
;	DIGITS16		вычисление цифр 16-разрядного числа
;=======================================================================
; вычитание 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	Temp1-Temp2 результат от H к L
SUB16X16:
	SUB		Temp2, Temp4
	SBC		Temp1, Temp3
RET
;=======================================================================
; сложение 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	Temp1-Temp2 результат от H к L
ADD16X16:
	ADD		Temp2, Temp4
	ADC		Temp1, Temp3
RET
;=======================================================================
; знаковое умножение 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	Temp1-Temp4 результат от H к L
MUL16X16s:
    MULS    Temp3, Temp1    	; (signed)ah * (signed)bh
    MOV		Temp5, MulHigh
	MOV		Temp6, MulLow
	MUL     Temp4, Temp2    	; al * bl
    MOV		Temp7, MulHigh
	MOV		Temp8, MulLow
	MULSU   Temp3, Temp2    	; (signed)ah * bl
    SBC     Temp5, Temp0		; из-за отриц. чисел
    ADD     Temp7, MulLow
    ADC     Temp6, MulHigh
    ADC     Temp5, Temp0
    MULSU   Temp1, Temp4    	; (signed)bh * al
    SBC     Temp5, Temp0		; из-за отриц. чисел
    ADD     Temp7, MulLow
    ADC     Temp6, MulHigh
    ADC     Temp5, Temp0
	MOV		Temp1, Temp5			; move result
	MOV		Temp2, Temp6
	MOV		Temp3, Temp7
	MOV		Temp4, Temp8
RET
;=======================================================================
; беззнаковое умножение 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	Temp1-Temp4 результат от H к L
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
; знаковое деление 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	Temp1-Temp2 результат от H к L
;			R13-R14 остаток от H к L
DIV16X16s:	
	MOV		R10,R16	;вычисляем знак результата
	EOR		R10,R18	;знак хранится в R10
	SBRS	R16,7	; проверяем знак делимого
	RJMP	d16s_1	; если положительное то идем дальше
	COM		R16		; иначе меняем знак делимого
	COM		R17		; преобразуем в доп код
	SUBI	R17,LOW(-1)
	SBCI	R16,HIGH(-1)
d16s_1:	
	SBRS	R18,7	; проверяем знак делителя
	RJMP	d16s_2
	COM		R18	
	COM		R19
	SUBI	R19,LOW(-1)
	SBCI	R18,HIGH(-1)
	; подготовили делимое и делитель
d16s_2:	
	; очищаем остаток и флаг переноса
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
; беззнаковое деление 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	Temp1-Temp2 результат от H к L
;			R13-R14 остаток от H к L
;=================================================
DIV16X16u:	
	; очищаем остаток и флаг переноса
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
; знаковое деление 16-разрядного числа на степень 2
; 	вход: 	Temp1-Temp2 делимое от H к L
;			Temp5 степень 2
;	выход:	Temp1-Temp2 результат от H к L
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
; беззнаковое деление 16-разрядного числа на степень 2
; 	вход: 	Temp1-Temp2 делимое от H к L
;			Temp5 степень 2
;	выход:	Temp1-Temp2 результат от H к L
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
; смена знака 16-разрядного числа
; 	вход: 	Temp1-Temp2 число от H к L
;	выход:	Temp1-Temp2 результат от H к L
SIGN16:
	COM		Temp1
	COM		Temp2
	SUBI	Temp2,LOW(-1)
	SBCI	Temp2,HIGH(-1)
RET	
;=======================================================================
; перевол 8-разрядного десятичного числа в двоично-десятичное (BCD)
; 	вход: 	Temp1 десятичное число
;	выход:	Temp1 BCD число
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
; перевол 8-разрядного двоично-десятичного (BCD) числа в десятичное
; 	вход: 	Temp1 BCD число
;	выход:	Temp1 десятичное число
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
; сравнение 16-разрядных чисел
; 	вход: 	Temp1-Temp2 первый аргумент от H к L
; 			Temp3-Temp4 второй аргумент от H к L
;	выход:	смотри флаги
CP16X16:
	CP		Temp2, Temp4
	CPC		Temp1, Temp3
RET
;=======================================================================
; вычисление цифр 8-разрядного числа
; 	вход: 	Temp1 аргумент
;	выход:	Temp1-Temp3 цифры от H к L
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
	; сотни
	INC		R26	
	RJMP	DIG8_1
DIG8_2:	
	LDI		Temp2,10
DIG8_3:
	CP		Temp1,Temp2
	BRLO	DIG8_4
	SUB		Temp1,Temp2
	; тысячи
	INC		R27		
	RJMP	DIG8_3
DIG8_4:
	; в Temp1 остались только единицы
	MOV		Temp3,Temp1
	MOV		Temp1,R26		
	MOV		Temp2,R27
RET
;=======================================================================
; вычисление цифр 16-разрядного числа
; 	вход: 	Temp1-Temp2 аргумент от H к L
;	выход:	Temp1-Temp5 цифры от H к L
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
	; десятки тысяч
	INC		R26	
	RJMP	DIG16_1
DIG16_2:	
	LDI		Temp3,HIGH(1000)
	LDI		Temp4,LOW(1000)
DIG16_3:
	RCALL	CP16X16	
	BRLO	DIG16_4
	RCALL	SUB16X16
	; тысячи
	INC		R27		
	RJMP	DIG16_3
DIG16_4:
	LDI		Temp3,HIGH(100)
	LDI		Temp4,LOW(100)
DIG16_5:
	RCALL	CP16X16	
	BRLO	DIG16_6
	RCALL	SUB16X16
	; сотни
	INC		R28	
	RJMP	DIG16_5
DIG16_6:
	LDI		Temp3,HIGH(10)
	LDI		Temp4,LOW(10)
DIG16_7:
	RCALL	CP16X16	
	BRLO	DIG16_8
	RCALL	SUB16X16
	; десятки
	INC		R29
	RJMP	DIG16_7
DIG16_8:
	; в Temp1-Temp2 остались только единицы
	MOV		Temp5,Temp2
	MOV		Temp1,R26		
	MOV		Temp2,R27
	MOV		Temp3,R28
	MOV		Temp4,R29
RET
