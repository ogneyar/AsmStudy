
#ifndef _DELAY_INC_
#define _DELAY_INC_

#ifndef XTAL
#define XTAL 10000000 ; 10MHz у ATtint85V
#endif

#define DELAY_DATA_1000 XTAL/5 ; ( ( _delay_ms / 1000 ) * XTAL / 5 )
#define DELAY_DATA_500 XTAL/10
#define DELAY_DATA_250 XTAL/20
#define DELAY_DATA_100 XTAL/50
#define DELAY_DATA_50 XTAL/100
#define DELAY_DATA_10 XTAL/500

; N = Time*Fcpu/(r+2) // где r — число регистров 
; N = T*F/5 // T = 500ms = 0,5s // N = 120 000 при 1,2 МГц
; 120 000 = 0,5 * 1 200 000 / 5

Delay_1000ms:
	push	r16
	push	r17
	push	r18
	push	r19	
	; сохраняем статус регистры
	IN		r19, SREG
	cli ; запрещаем прерывания
	ldi 	r18, byte3(DELAY_DATA_1000) ; старший байт N
	ldi 	r17, high(DELAY_DATA_1000) ; средний байт N
	ldi 	r16, low(DELAY_DATA_1000) ; младший байт N
Loop_Delay_1000ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_1000ms ; Branch if Carry Cleared
	; возвращяем статус регистры
	OUT	SREG, r19
	pop 	r19
	pop 	r18
	pop		r17
	pop		r16 
ret

Delay_500ms:
	cli ; запрещаем прерывания
	push	r16
	push	r17
	push	r18
	push	r19	
	; сохраняем статус регистры
	IN		r19, SREG
	cli ; запрещаем прерывания
	ldi 	r18, byte3(DELAY_DATA_500) ; старший байт N
	ldi 	r17, high(DELAY_DATA_500) ; средний байт N
	ldi 	r16, low(DELAY_DATA_500) ; младший байт N
Loop_Delay_500ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_500ms ; Branch if Carry Cleared
	; возвращяем статус регистры
	OUT	SREG, r19
	pop 	r19
	pop 	r18
	pop		r17
	pop		r16 
ret

Delay_250ms:
	cli ; запрещаем прерывания
	push	r16
	push	r17
	push	r18
	push	r19	
	; сохраняем статус регистры
	IN		r19, SREG
	cli ; запрещаем прерывания
	ldi 	r18, byte3(DELAY_DATA_250) ; старший байт N
	ldi 	r17, high(DELAY_DATA_250) ; средний байт N
	ldi 	r16, low(DELAY_DATA_250) ; младший байт N
Loop_Delay_250ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_250ms ; Branch if Carry Cleared
	; возвращяем статус регистры
	OUT	SREG, r19
	pop 	r19
	pop 	r18
	pop		r17
	pop		r16 
ret

Delay_100ms:
	push	r16
	push	r17
	push	r18
	push	r19	
	; сохраняем статус регистры
	IN		r19, SREG
	cli ; запрещаем прерывания
	ldi 	r18, byte3(DELAY_DATA_100) ; старший байт N
	ldi 	r17, high(DELAY_DATA_100) ; средний байт N
	ldi 	r16, low(DELAY_DATA_100) ; младший байт N
Loop_Delay_100ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_100ms ; Branch if Carry Cleared
	; возвращяем статус регистры
	OUT	SREG, r19
	pop 	r19
	pop 	r18
	pop		r17
	pop		r16	 
ret 

Delay_50ms:
	push	r16
	push	r17
	push	r18
	push	r19	
	; сохраняем статус регистры
	IN		r19, SREG
	cli ; запрещаем прерывания
	ldi 	r18, byte3(DELAY_DATA_50) ; старший байт N
	ldi 	r17, high(DELAY_DATA_50) ; средний байт N
	ldi 	r16, low(DELAY_DATA_50) ; младший байт N
Loop_Delay_50ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_50ms ; Branch if Carry Cleared
	; возвращяем статус регистры
	OUT	SREG, r19
	pop 	r19
	pop 	r18
	pop		r17
	pop		r16
ret 

Delay_10ms:
	push	r16
	push	r17
	push	r18
	push	r19	
	; сохраняем статус регистры
	IN		r19, SREG
	cli ; запрещаем прерывания
	ldi 	r18, byte3(DELAY_DATA_10) ; старший байт N
	ldi 	r17, high(DELAY_DATA_10) ; средний байт N
	ldi 	r16, low(DELAY_DATA_10) ; младший байт N
Loop_Delay_10ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_10ms ; Branch if Carry Cleared
	; возвращяем статус регистры
	OUT	SREG, r19
	pop 	r19
	pop 	r18
	pop		r17
	pop		r16
ret 



#endif  /* _DELAY_INC_ */
