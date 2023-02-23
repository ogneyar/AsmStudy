
#ifndef _I2C_SCAN_ASM_
#define _I2C_SCAN_ASM_


;=================================================
; поиск устройства и вывод адреса в порт
I2C_Scan:
	push	R16 ; Data
	push	R17 ; Ask
	push	R18 ; I2C_Address
	push	R19 ; Counter
	push	R20 ; Null
	
	CLR		R20
	
	LDI		R19, 8 ; количество выводимых бит
	CLR		R18 ; I2C_Address = 0x00
Repeat_I2C_Scan:
	RCALL	I2C_Start ; команда СТАРТ
	
	MOV		Data, R18
	LSL 	Data 
	RCALL	I2C_send ; передача адреса записанного в R16
	;------------------------------------
	; проверяем ответло ли устройство
	CP	 	R17, R20 ; если устройство ответит (Ask=0)
	BREQ	AddressOn_send ; прекращаем сканировать
	; продолжаем если устройство не ответило
	;------------------------------------
	RCALL	I2C_Stop ; иначе команда СТОП

	INC 	R18 ; увеличиваем значение
	CPI		R18, 128 ; TW_MAX_ADDRESS - максимально возможное значение адреса устройства
	BRSH	Clear_I2C_Address ; Branch if Same or Higher (>=) пропускаем строку ниже если первое значение >= второму
	RJMP	Repeat_I2C_Scan ; повторяем
Clear_I2C_Address:
	CLR		R18
	RJMP	AddressOff_send
AddressOn_send:
	RCALL	I2C_Stop ; команда СТОП

	RCALL	AddressOn ; вывод в порт сообщения
Loop_I2C_Scan:
	CLC ; Clear Carry (сбрасываем флаг переноса)
	ROL		R18 ; круговой сдвиг влево (ROL 0b11110000 = 0b11100001)
	BRCC	Null_send ; если флаг Carry = 0 
	RJMP	One_send ; если флаг Carry = 1 
Null_send: 
	LDI		Data, '0'
	RCALL	USART_Transmit ; выводим в порт 0
	RJMP	Decrement_Bit
One_send:
	LDI		Data, '1'
	RCALL	USART_Transmit ; выводим в порт 1
	; RJMP	Decrement_Bit
Decrement_Bit:
	DEC		R19 ; количество выводимых бит
	CPI		R19, 0  ; сравниваем с нулём
	BREQ	End_I2C_Scan
	RJMP	Loop_I2C_Scan
AddressOff_send:
	RCALL	AddressOff ; вывод в порт сообщения
End_I2C_Scan:
	RCALL	EndSearchDevices ; вывод в порт сообщения
	
	pop		R20 ; Null
	pop		R19 ; Counter
	pop		R18 ; I2C_Address
	pop		R17 ; Ask
	pop		R16 ; Data
ret

;
Hello_W:
	push	R16 ; Data
	
	LDI 	R16, 'H'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 'l'
	RCALL 	USART_Transmit
	LDI 	R16, 'l'
	RCALL 	USART_Transmit
	LDI 	R16, 'o'
	RCALL 	USART_Transmit
	LDI 	R16, ' '
	RCALL 	USART_Transmit
			
	LDI 	R16, 'W'
	RCALL 	USART_Transmit
	LDI 	R16, 'o'
	RCALL 	USART_Transmit
	LDI 	R16, 'r'
	RCALL 	USART_Transmit
	LDI 	R16, 'l'
	RCALL 	USART_Transmit
	LDI 	R16, 'd'
	RCALL 	USART_Transmit
	LDI 	R16, '!'
	RCALL 	USART_Transmit
	LDI 	R16, '\n'
	RCALL 	USART_Transmit
	
	pop		R16 ; Data
RET

;
AddressOn: ;.db "Адрес устройства: 0b",0
	push	R16 ; Data
	
	LDI 	R16, '\n'
	RCALL 	USART_Transmit
	LDI 	R16, 'A'
	RCALL 	USART_Transmit
	LDI 	R16, 'd'
	RCALL 	USART_Transmit
	LDI 	R16, 'd'
	RCALL 	USART_Transmit
	LDI 	R16, 'r'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 's'
	RCALL 	USART_Transmit
	LDI 	R16, 's'
	RCALL 	USART_Transmit
	LDI 	R16, ' '
	RCALL 	USART_Transmit
	LDI 	R16, 'd'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 'v'
	RCALL 	USART_Transmit			
	LDI 	R16, 'i'
	RCALL 	USART_Transmit
	LDI 	R16, 'c'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, ':'
	RCALL 	USART_Transmit
	LDI 	R16, ' '
	RCALL 	USART_Transmit
	LDI 	R16, '0'
	RCALL 	USART_Transmit
	LDI 	R16, 'b'
	RCALL 	USART_Transmit
	
	pop		R16 ; Data
RET

;
AddressOff: ;.db "Нет найденных устройств!",0
	push	R16 ; Data
	
	LDI 	R16, '\n'
	RCALL 	USART_Transmit
	LDI 	R16, 'N'
	RCALL 	USART_Transmit
	LDI 	R16, 'o'
	RCALL 	USART_Transmit
	LDI 	R16, ' '
	RCALL 	USART_Transmit
	LDI 	R16, 'd'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 'v'
	RCALL 	USART_Transmit			
	LDI 	R16, 'i'
	RCALL 	USART_Transmit
	LDI 	R16, 'c'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 's'
	RCALL 	USART_Transmit
	LDI 	R16, '!'
	RCALL 	USART_Transmit
	
	pop		R16 ; Data
RET

;
EndSearchDevices: ;.db '\n','\n',"Поиск I2C устройств завершён!",'\n','\n',0
	push	R16 ; Data
	
	LDI 	R16, '\n'
	RCALL 	USART_Transmit
	LDI 	R16, '\n'
	RCALL 	USART_Transmit
	LDI 	R16, 'S'
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 'a'
	RCALL 	USART_Transmit
	LDI 	R16, 'r'
	RCALL 	USART_Transmit
	LDI 	R16, 'c'
	RCALL 	USART_Transmit
	LDI 	R16, 'h'
	RCALL 	USART_Transmit			
	LDI 	R16, ' '
	RCALL 	USART_Transmit
	LDI 	R16, 'e'
	RCALL 	USART_Transmit
	LDI 	R16, 'n'
	RCALL 	USART_Transmit
	LDI 	R16, 'd'
	RCALL 	USART_Transmit
	LDI 	R16, '!'
	RCALL 	USART_Transmit
	LDI 	R16, '\n'
	RCALL 	USART_Transmit
	
	pop		R16 ; Data
RET
;=================================================

#endif  /* _I2C_SCAN_ASM_ */

