
; БИБЛИОТЕКА ЗАДЕРЖЕК (8 МГц)
; Delay1us задержка повышенной точности в 1 мкс c учетом длительности RCALL и RET
; Delay5us задержка повышенной точности в 5 мкс c учетом длительности RCALL и RET
; Delay10us задержка повышенной точности в 10 мкс c учетом длительности RCALL и RET
; Delayus задержка высокой точности в несколько десятков микросекунд
; Delayms задержка высокой точности в несколько миллисекунд

;=================================================
; задержка повышенной точности в 1 мкс c учетом длительности RCALL и RET
; RCALL дает 3 + 1 NOP + 4 RET = 8 - 1 микросекунда при 8МГц
Delay1us:							
	NOP			
RET
;=================================================	
; задержка повышенной точности в 5 мкс c учетом длительности RCALL и RET
Delay5us:	
	PUSH	Temp1	
	LDI		Temp1, 9	
Delay5us_loop:					
	DEC		Temp1	
	BRNE	Delay5us_loop	
	POP		Temp1
	NOP
	NOP				
RET
;=================================================			
; задержка повышенной точности в 10 мкс c учетом длительности RCALL и RET
Delay10us:	
	PUSH	Temp1	
	LDI		Temp1, 23	
Delay10us_loop:					
	DEC		Temp1	
	BRNE	Delay10us_loop	
	POP		Temp1				
RET
;=================================================		
; задержка высокой точности в несколько десятков микросекунд
; вход Temp1 количество необходимых десятков микросекунд
Delayus:
	PUSH	Temp2
Delayus_loop1:
	LDI		Temp2, 25
Delayus_loop2:
	DEC		Temp2	
	BRNE	Delayus_loop2
	NOP
	NOP
	DEC		Temp1
	BRNE	Delayus_loop1
	POP		Temp2
RET	
;=================================================
; задержка высокой точности в несколько миллисекунд
; вход Temp1 количество необходимых миллисекунд
Delayms:
	PUSH	Temp2
	MOV		Temp2, Temp1
Delayms_loop:	
	LDI		Temp1, 100
	RCALL	Delayus
	DEC		Temp2
	BRNE	Delayms_loop
	POP		Temp2
RET
