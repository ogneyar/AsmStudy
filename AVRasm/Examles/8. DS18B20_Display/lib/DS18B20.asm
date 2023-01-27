;// 				Author:  Skyer                            			   //
;// 				Website: www.smartep.ru                  			   //
;////////////////////////////////////////////////////////////////////////////
; БИБЛИОТЕКА ДЛЯ РАБОТЫ С ДАТЧИКОМ ТЕМПЕРАТУРЫ DS18B20
;	DS18B20_Init			инициализация датчика на шине
;	DS18B20_Resive			выполняет прием байта из линии
;	DS18B20_Send			выполняет передачу байта в линию
;	DS18B20_Read			считывает 9 байтов в буфер, подсчитывает CRC
;	CRC8					выполняет подсчет CRC8
;	DS18B20_SetResolution	установка разрешения датчика
;	DS18B20_ConvertTemp		отправка команды преобразования температуры
;	DS18B20_GetTemp			вычисление температуры
;	TempTable				таблица для преобразования дробной части температуры
;=======================================================================
; инициализация датчика на шине
; выполняет сброс линии и выдает наличие сигнала присутствия PRESENCE от датчика
; 	выход: Z-флаг при наличии сигнала присутствия взводим Z-флаг, иначе сбрасываем его	
DS18B20_Init:
	CBI		WirePORT, TEMP_DQ
	CBI		WireDDR, TEMP_DQ	; 0->DDR = Z-состояние
	SBIS	WirePIN, TEMP_DQ	; проверим наличие 1 в линии
	RJMP	DS18B20_Fault		; если нет - это ошибка
	SBI		WireDDR, TEMP_DQ	; иначе давим линию в 0
	LDI		Temp1, 48			; задержка в 480 микросекунд
	RCALL	Delayus			
	CBI		WireDDR, TEMP_DQ	; давим линию в 1
	LDI		Temp1, 6			; задержка в 60 микросекунд
	RCALL	Delayus			
	; начинаем ждать сигнал присутствия PRESENCE
	LDI		Temp1, 240			; ждем с запасом - 240 max
DS18B20_Wait:
	SBIS 	WirePIN, TEMP_DQ
	RJMP	DS18B20_Ok
	RCALL	Delay1us
	DEC		Temp1
	BRNE 	DS18B20_Wait
DS18B20_Fault:
	; PRESENCE не получен
	CLZ							; сбрасываем Z-флаг	
	RET
DS18B20_Ok:
	; PRESENCE получен, задержка в 480 микросекунд
	LDI		Temp1, 48
	RCALL	Delayus
	SEZ							; взводим Z-флаг
RET		
;=======================================================================
; выполняет прием байта из линии
; 	выход: Temp1 принятый байт
DS18B20_Resive:
	SER		Temp1 ; Set Register (Rd < $FF)
;=======================================================================
; выполняет передачу байта в линию
; если делать ВЫВОД 0хFF, то на выходе будет ПРИНЯТЫЙ байт
; 	вход: Temp1 отправляемый байт
DS18B20_Send:
	LDI		Temp2, 8			; число битов в байте
sw1_next:
	PUSH	Temp4
	IN		Temp4, SREG
	PUSH	Temp4				; сохраним флаги, т.к. будем запрещать прерывания
	CLI							; запрещаем прерывания
	SBI		WireDDR, TEMP_DQ	; 1->DDR = 0 на выходе						; давим линию в 0
	RCALL	Delay1us			; 1 мкс задержки
	ROR		Temp1				; выталкиваем выводимый бит (Rotate Right Through Carry) >> c переносом (Carry)
	BRCC	S0					; если бит C = 0 - обход (Branch if Carry Cleared)
	CBI		WireDDR, TEMP_DQ	; 0->DDR = Z-состояние						; линию в 1
s0:
	PUSH	Temp2
	LDI		Temp2, 9			; в некоторых случаях может потребоваться
								; увеличить это значение, но не более 13!
sw1_wait:
	RCALL	Delay1us
	DEC		Temp2
	BRNE	sw1_wait
	CLC	
	SBIC	WirePIN, TEMP_DQ
	SEC
	ROR		Temp3
	PUSH	Temp1
	LDI		Temp1, 9
	RCALL	Delayus				; 90 микросекунд - длительность тайм-слота
	POP		Temp1
	CBI		WireDDR, TEMP_DQ	; 0->DDR = Z-состояние
	POP		Temp2
	
	POP		Temp4
	OUT		SREG, Temp4
	POP		Temp4

	DEC		Temp2
	BRNE 	sw1_next		
	MOV		Temp1, Temp3
RET	
;=======================================================================
; считывает 9 байтов в буфер, подсчитывает CRC
; 	выход: в SRAM TempData - LS и MS
DS18B20_Read:
	CLR		Temp2
	STS		TempCRC, Temp2		; обнуляем CRC
	LDI		XL, LOW(TempData)
	LDI		XH, HIGH(TempData)
	LDI		Temp2, 9			; 9 байтов
r1w_next:
	PUSH	Temp2
	RCALL	DS18B20_Resive		; считываем 1 байт
	; Temp1=считанному байту, начинаем подсчет CRC
	ST		X+, Temp1			; сохраняем принятый байт
	;RCALL	CRC8				; считаем контрольную сумму
 	POP		Temp2
	DEC		Temp2
	BRNE	r1w_next
RET
;=======================================================================
; выполняет подсчет CRC8
; примечание: перед первым вызовом CRC необходимо обнулить
; 	вход: Temp1 считанный байт
;	выход: в SRAM TempCRC - контрольная сумма CRC8
CRC8:
	PUSH	Temp1
	LDI		Temp3, 8
CRC8_loop:
	LDS		Temp2, TempCRC
	EOR		Temp1, Temp2 ; Exclusive OR
	ROR		Temp1 ; >>
	MOV		Temp1, Temp2
	BRCC 	Zero ; Branch if Carry Cleared
	LDI		Temp2, 0x18
	EOR		Temp1, Temp2
Zero:
	ROR		Temp1
	STS		TempCRC, Temp1
	POP		Temp1
	; 4 следующие команды делают циклический сдвиг r0
	PUSH	Temp1
	ROR		Temp1
	POP		Temp1
	ROR		Temp1
	; сдвиг закончен
	PUSH	Temp1
	DEC		Temp3
	BRNE 	CRC8_loop
	POP		Temp1
	LDS		Temp1, TempCRC
RET
;=======================================================================
; установка разрешения датчика, по умолчанию используется разрешение 12 бит
; 	вход: Temp1 устанавливаемое разрешение
DS18B20_SetResolution:
	MOV		Temp3, Temp1
	; Reset 1-wire
	RCALL	DS18B20_Init
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send		
	; Set resolution
	LDI		Temp1,DS18B20_W_SCRATCHPAD	
	RCALL	DS18B20_Send		
	LDI		Temp1, 0xFF
	RCALL	DS18B20_Send		
	RCALL	DS18B20_Send		
	MOV		Temp1, Temp3
	RCALL	DS18B20_Send		
	; Reset 1-wire
	RCALL	DS18B20_Init
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send
	LDI		Temp1,DS18B20_C_SCRATCHPAD
	RCALL	DS18B20_Send			
RET
;=======================================================================
; отправка команды преобразования температуры
;	выход: в Temp1 0 при отсутствии ошибок и 255 при ошибке
DS18B20_ConvertTemp:
	; Reset 1-wire
	RCALL	DS18B20_Init
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send		
	; Convert temperature
	LDI		Temp1,DS18B20_CONVERT_T		
	RCALL	DS18B20_Send
	LDI		Temp1, 0x00		
RET
;=======================================================================
; вычисление температуры
;	выход: в SRAM TempDigit от L к H (TempDigit это крайний левый знак)
;	выход: Temp1 при отсутствии ошибок 0 и 255 при ошибках
DS18B20_GetTemp:
	; Reset 1-wire
	RCALL	DS18B20_Init
	BREQ	DNext ; Branch if Equal (if flag Zero=1)
	LDI		Temp1, 0xFF
	RET
DNext:
	; Skip address
	LDI		Temp1,DS18B20_SKIP_ROM		
	RCALL	DS18B20_Send
	; Read ScratchPad
	LDI		Temp1,DS18B20_R_SCRATCHPAD	
	RCALL	DS18B20_Send			
	; Read bytes
	RCALL	DS18B20_Read
	; обработка целой части
	LDS		Temp2,TempData		; Load LS
	LDS		Temp1,TempData+1	; Load MS
	CLR		Temp3
	; проверка отрицательной температуры
	CPI 	Temp1,0x08 ; Compare with Immediate (Temp1 - 0x08)
	BRLO 	IsPlus ; Branch if Lower (if flag Carry=1 then Temp1 < 0x08)
IsMinus:
	; если температура отрицательная то...
	NEG 	Temp2 ; 0 - Temp2 (перевод в отрицательное значение)
	COM 	Temp1 ; 0xff - Temp1 (0 заменятся на 1, 1 на 0)
	STS		TempData,Temp2
	STS		TempData+1,Temp1
	; установили знак минуса
	LDI		Temp3,SYMBOL_MINUS
IsPlus:
	STS		Digits,Temp3
	; получаем в Temp2 целую часть
	ANDI 	Temp2, 0xF0
	OR 		Temp2, Temp1
	SWAP 	Temp2 ;  Swap Nibbles (Rd(3..0) - Rd(7..4))
	CLR		Temp1
IntLoop:
	CPI		Temp2,10 ; Compare with Immediate
	BRLO	IntNext ; Branch if Lower (Rd < x)
	SUBI	Temp2,10 ; вычитание
	INC		Temp1
	JMP		IntLoop	
IntNext:
	; десятки 
	STS		Digits+1,Temp1
	; единицы
	STS		Digits+2,Temp2
	; обработка дробной части
	LDS		Temp3,TempData		; Load LS
	ANDI	Temp3,0x0F			; Оставили дробную часть
	; умножая ее на 0.0625 получим табличное значение
	LDI 	ZL,LOW(TempTable*2)   
	LDI 	ZH,HIGH(TempTable*2)
	CLR		R24
	LSL 	Temp3 ; Logical Shift Left <<
	ADD		ZL,Temp3
	ADC		ZH,R24

	LPM		Temp1,Z+ ; Load Program Memory and PostIncrement
	LPM		Temp2,Z+

	CPI		Temp2,6
	BRLO	FracAdd
	INC		Temp1
FracAdd:	
	STS  	Digits+3,Temp1
	LDI		Temp1, 0x00
RET
;=======================================================================
; таблица для преобразования дробной части температуры
TempTable: 
	; первая и вторая цифры после запятой
	; в комментариях справа вся дробная часть
	.db 0b00000000,0b00000000	;0,0,0,0
	.db 0b00000000,0b00000110	;0,6,2,5
	.db 0b00000001,0b00000010	;1,2,5,0
	.db 0b00000001,0b00001000	;1,8,7,5
	.db 0b00000010,0b00000101	;2,5,0,0
	.db 0b00000011,0b00000001	;3,1,2,5
	.db 0b00000011,0b00000111	;3,7,5,0
	.db 0b00000100,0b00000011	;4,3,7,5
	.db 0b00000101,0b00000000	;5,0,0,0
	.db 0b00000101,0b00000110	;5,6,2,5
	.db 0b00000110,0b00000010	;6,2,5,0
	.db 0b00000110,0b00001000	;6,8,7,5
	.db 0b00000111,0b00000101	;7,5,0,0
	.db 0b00001000,0b00000001	;8,1,2,5
	.db 0b00001000,0b00000111	;8,7,5,0
	.db 0b00001001,0b00000011	;9,3,7,5
