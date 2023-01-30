
.def 	temp  = r16 ; рабочий регистр
.def	Razr0 = r17 ;счетчик задержки
.def	Razr1 = r18 ;счетчик задержки
.def	Razr2 = r19 ;счетчик задержки

; N = Time*Fcpu/(r+2) // где r — число регистров 
; N = T*F/5 // T = 500ms = 0,5s // N = 1 600 000 при 16 МГц
; 1 600 000 = 0,5 * 16 000 000 / 5
Del_500ms: 
	cli ;запрещаем прерывания
	push	Razr0
	push	Razr1
	push	Razr2
	ldi Razr2,byte3(1600000) ;старший байт N
	ldi Razr1,high(1600000) ;средний байт N
	ldi Razr0,low(1600000) ;младший байт N
R200_sub: 
	subi Razr0,1 
	sbci Razr1,0
	sbci Razr2,0
	brcc R200_sub
	pop	Razr2
	pop	Razr1
	pop	Razr0
	sei ;разрешаем прерывания	 
ret 