
#ifndef _USART_ASM_
#define _USART_ASM_

#ifndef TxD
#define TxD		PB4
#endif

;========================================= без прерываний
; инициализация USART
USART_Init: ; требуется значение UBRR, используется для задержек
	; таймер вкючаем установкой делителя
	RCALL 	Timer0_divider
	; -- устанавливаем пин 4 порта B на выход -- 
	SBI 	DDRB, TxD
	SBI 	PORTB, TxD
ret

; установка делителя
Timer0_divider:
    push    R17
	LDI 	R17, (1 << CS01) ; на 8
	; LDI 	R17, (1 << CS00) ; на 1
	OUT 	TCCR0, R17
    pop     R17
ret

; -- Подпрограмма передача байта в порт -- 
USART_Send_Byte: ; data в регистре R16 (Data)  ; требуется значение UBRR, используется для задержек
    push    R17        
;---------------------------------------------------- 
; повторная инициализация необходима из-за I2C, там например делитель на 1, тут на 8
	; таймер вкючаем установкой делителя
	RCALL 	Timer0_divider
;---------------------------------------------------- 
	CBI		PORTB, TxD ; старт бит
	RCALL	Wait_TCNT 
    ; --------------------------- передача байта
    LDI     R17, 8 ; i = 8
repeat_USART_Send_Byte:
    CLC ; clear Carry
    ROR     R16
    BRCC    set_0_USART_Send_Byte ; Branch if Carry Cleared
    BRCS    set_1_USART_Send_Byte ; Branch if Carry Set
set_0_USART_Send_Byte:
    CBI		PORTB, TxD 
    RJMP    continue_USART_Send_Byte
set_1_USART_Send_Byte:
    SBI		PORTB, TxD 
    RJMP    continue_USART_Send_Byte
continue_USART_Send_Byte:
	RCALL	Wait_TCNT
    DEC     R17
    BRNE    repeat_USART_Send_Byte ; if R17 != 0
    ; ---------------------------
	SBI		PORTB, TxD ; стоп бит
	RCALL	Wait_TCNT
    pop     R17
ret

; -- Подпрограмма задержки -- 
Wait_TCNT: ; требуется значение UBRR
    push    R19
    LDI     R19, 0
    OUT     TCNT0, R19 ; обнуляем счётчик
loop_Wait_TCNT:
	IN		R19, TCNT0
	CPI		R19, UBRR
	BRCS	loop_Wait_TCNT ; Branch if Carry Set (если TCNT0 < UBRR)
    pop     R19
ret


; -- Подпрограмма вывода строки в порт -- 
USART_Print_String: ; use macro mSetStr
    push    R16
loop_USART_Print_String:
	LPM		R16, Z
	CPI		R16, 0
	BREQ	End_USART_Print_String
	RCALL 	USART_Send_Byte
	INC		ZL
	BRCC	continue_USART_Print_String
	INC		ZH
continue_USART_Print_String:
	RJMP	loop_USART_Print_String
End_USART_Print_String:
    pop     R16
ret
;=================================================

#endif  /* _USART_ASM_ */
