
#ifndef _USART_WI_ASM_
#define _USART_WI_ASM_

#ifndef TxD
#define TxD		PB4
#endif

;=================================================
; инициализация USART
USART_Init: ; требуется значение UBRR
    push    R17
	; -- устанавливаем пин 4 порта B на выход -- 
	SBI 	DDRB, TxD ;

	; Разрешение прерывания таймера 0 по совпадению канала А 
	LDI 	R17, (1 << OCIE0A)
	OUT 	TIMSK0, R17
	
	; регистр сравнения
  	LDI 	R17, UBRR
	OUT 	OCR0A, R17

	; Разрешение прерывания глобално
	SEI
    pop     R17
ret

;
USART_Send_Byte:
    LDI 	R17, (1 << CS01) ; делитель на 8
	OUT 	TCCR0B, R17 ; T_START

	LDI		R19, 10 ; start byte + 8 byte + stop byte
repeat_Send_Byte:
	CPI		Flag, 1
	BRNE	repeat_Send_Byte ; если Flag = 0
	; если Flag = 1
	RCALL	USART_Send

	CLZ
	DEC		R19
	BRNE	repeat_Send_Byte
ret

;
USART_Send: ; data в регистре R16 (Data)
	CPI		Count, 8
	BRCS 	uart_Step_1 ; если Count < 8
	; если Count >= 8
	SBI		PORTB, TxD
	CLR		Start
	CLR		Temp
	CLR		Flag
	CLR		Count
	OUT 	TCCR0B, Temp ; T_STOP
	RJMP 	uart_Exit
uart_Step_1:
	CPI		Flag, 1
	BRNE 	uart_Exit ; если Flag = 0
	; если Flag = 1
	CPI		Start, 1
	BREQ 	uart_Step_3 ; если Start == 1
	; если Start = 0
	LDI		Start, 1
	LDI		Count, 0xff ; Count = -1
	RJMP 	switch_temp
uart_Step_3:
	MOV		Temp, Data	
	CPI		Count, 1
	BRCS 	uart_Step_3_1 ; если Count == 0
	; иначе
	MOV		R18, Count
repeat_uart_Step_3:  ;   temp = temp >> count;
	LSR		Temp
	DEC		R18
	BRNE	repeat_uart_Step_3 ; если R18 != 0
uart_Step_3_1:
	ANDI	Temp, 0x01 ; маска сбрасывает все биты кроме первого
switch_temp: 
	CPI		Temp, 1
	BREQ 	case_1 ; если Temp == 1
	RJMP 	case_0
case_1:
	SBI		PORTB, TxD
	RJMP 	uart_Step_7
case_0:
	CBI		PORTB, TxD
uart_Step_7:
	CPI		Count, 0xff
	BREQ	uart_Step_8 ; если Count == 0xff, то обнулить
	INC		Count
	CLR		Flag
	RJMP	uart_Exit
uart_Step_8:
	CLR		Count
   	CLR		Flag
uart_Exit:
ret

; -- Подпрограмма вывода строки в порт -- 
USART_Print_String: ; use macro mSetStr
	LPM		R16, Z+
	CPI		R16, 0
	BREQ	End_USART_Print_String
	RCALL 	USART_Send_Byte
	RJMP	USART_Print_String
End_USART_Print_String:
ret
;=========================================


#endif  /* _USART_WI_ASM_ */
