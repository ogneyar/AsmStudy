
#ifndef _DELAY_INC_
#define _DELAY_INC_

#ifndef F_CPU
#define F_CPU 1000000
#endif

#define DELAY_DATA_1000 F_CPU/5 ; ( ( _delay_ms / 1000 ) * F_CPU / 5 )
#define DELAY_DATA_500 F_CPU/10
#define DELAY_DATA_100 F_CPU/50
#define DELAY_DATA_10 F_CPU/500

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
