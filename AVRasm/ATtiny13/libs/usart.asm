
#ifndef _USART_ASM_
#define _USART_ASM_

#ifndef TxD
#define TxD		PB4
#endif

;========================================= без прерываний
; инициализация USART
USART_Init: ; требуется значение UBRR
    push    R17
	; таймер вкючаем в режим CTC
	LDI 	R17, (1 << WGM01)
	OUT 	TCCR0A, R17
	; делитель на 8
    LDI 	R17, (1 << CS01)
	OUT 	TCCR0B, R17
	; регистр сравнения
  	LDI 	R17, UBRR
	OUT 	OCR0A, R17	
	; -- устанавливаем пин 4 порта B на выход -- 
	SBI 	DDRB, TxD
	SBI 	PORTB, TxD
    pop     R17
ret

;
USART_Send_Byte: ; data в регистре R16 (Data)

	CBI		PORTB, TxD ; старт бит

	OUT 	TCNT0, Null ; обнуляем счётчик
	RCALL	Wait_TCNT0		

    SBRC    Data, 0 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 0 ; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0
	
    SBRC    Data, 1 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 1 ; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0
	
    SBRC    Data, 2; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 2; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0
	
    SBRC    Data, 3 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 3 ; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0

    SBRC    Data, 4 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 4; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0
	
    SBRC    Data, 5 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 5 ; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0
	
    SBRC    Data, 6 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 6 ; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0
	
    SBRC    Data, 7 ; Skip if Bit in Register Cleared
    RCALL	USART_Send_One
    SBRS    Data, 7 ; Skip if Bit in Register Set
    RCALL	USART_Send_Zero

	RCALL	Wait_TCNT0

	SBI		PORTB, TxD ; стоп бит
	RCALL	Wait_TCNT0
ret

USART_Send_One:
	SBI		PORTB, TxD 
ret

USART_Send_Zero:
	CBI		PORTB, TxD 
ret

Wait_TCNT0:
	IN		R19, TCNT0
	CPI		R19, UBRR
	BRCS	Wait_TCNT0 ; Branch if Carry Set (если TCNT0 < UBRR)
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
;=================================================

#endif  /* _USART_ASM_ */
