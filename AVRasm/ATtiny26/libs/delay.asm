
#ifndef _DELAY_INC_
#define _DELAY_INC_

#ifndef XTAL
#define XTAL 16000000
#endif

#define DELAY_DATA_1000 XTAL/5 ; ( ( _delay_ms / 1000 ) * XTAL / 5 )
#define DELAY_DATA_500 XTAL/10
#define DELAY_DATA_200 XTAL/25
#define DELAY_DATA_100 XTAL/50

; N = Time*Fcpu/(r+2) // где r — число регистров 
; N = T*F/5 // T = 500ms = 0,5s // N = 800 000 при 8 МГц
; 800 000 = 0,5 * 8 000 000 / 5

Delay_1000ms:
	cli ; запрещаем прерывания
	push	r16
	push	r17
	push	r18
	ldi 	r18, byte3(DELAY_DATA_1000) ; старший байт N
	ldi 	r17, high(DELAY_DATA_1000) ; средний байт N
	ldi 	r16, low(DELAY_DATA_1000) ; младший байт N
Loop_Delay_1000ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_1000ms ; Branch if Carry Cleared
	pop 	r18
	pop		r17
	pop		r16
	sei ; разрешаем прерывания	 
ret

Delay_500ms:
	cli ; запрещаем прерывания
	push	r16
	push	r17
	push	r18
	ldi 	r18, byte3(DELAY_DATA_500) ; старший байт N
	ldi 	r17, high(DELAY_DATA_500) ; средний байт N
	ldi 	r16, low(DELAY_DATA_500) ; младший байт N
Loop_Delay_500ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_500ms ; Branch if Carry Cleared
	pop 	r18
	pop		r17
	pop		r16
	sei ; разрешаем прерывания	 
ret

Delay_200ms:
	cli ; запрещаем прерывания
	push	r16
	push	r17
	push	r18
	ldi 	r18, byte3(DELAY_DATA_200) ; старший байт N
	ldi 	r17, high(DELAY_DATA_200) ; средний байт N
	ldi 	r16, low(DELAY_DATA_200) ; младший байт N
Loop_Delay_200ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_200ms ; Branch if Carry Cleared
	pop 	r18
	pop		r17
	pop		r16
	sei ; разрешаем прерывания	 
ret 

Delay_100ms:
	cli ; запрещаем прерывания
	push	r16
	push	r17
	push	r18
	ldi 	r18, byte3(DELAY_DATA_100) ; старший байт N
	ldi 	r17, high(DELAY_DATA_100) ; средний байт N
	ldi 	r16, low(DELAY_DATA_100) ; младший байт N
Loop_Delay_100ms: 
	subi 	r16, 1 ; Subtract Immediate
	sbci 	r17, 0 ; Subtract Immediate with Carry
	sbci 	r18, 0
	brcc 	Loop_Delay_100ms ; Branch if Carry Cleared
	pop 	r18
	pop		r17
	pop		r16
	sei ; разрешаем прерывания	 
ret 


#endif  /* _DELAY_INC_ */
