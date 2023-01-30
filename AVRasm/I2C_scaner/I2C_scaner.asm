
; Светодиодная мигалка на микроконтроллере ATmega328p

.INCLUDE "m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "macro.inc"    ; подключение файла 'макросов'
#include "defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	XTAL 					= 16000000 		; Частота МК
	.equ 	UART_BaudRate 			= 9600		; Скорость обмена по UART
	.equ 	UART_BaudDivider 		= XTAL/8/UART_BaudRate-1 ; (XTAL/8/x-1) при U2X0 в 1, (XTAL/16/x-1) при U2X0 в 0
	.equ 	I2C_Frequency 			= 100000			; Частота шины I2C (Nano работает даже на 1MHz)
	.equ 	I2C_BaudDivider 		= ((XTAL/I2C_Frequency)-16)/2	; prescaler = 1
;	.equ 	I2C_Address_Device		= 0x27							; адрес устройства 
;	.equ 	I2C_Address_Write		= (I2C_Address_Device << 1)		; адрес устройства на запись
;	.equ 	I2C_Address_Read		= (I2C_Address_Write & 0x01)	; адрес устройства на чтение
;=================================================
	.def 	USART_Data				= R16			; регистр данных USART
	.def 	I2C_Data				= R17			; регистр данных I2C
	.def 	I2C_Address				= R18			; регистр адреса I2C устройства (0x27 для )
	; .def 	Temp0					= R19			; регистр для временных данных
	.def 	Temp1					= R20			; регистр для временных данных
; 	.def 	Temp2					= R21			; регистр для временных данных
	.def 	Flag 					= R25 			; регистр для флага
;=================================================	
	.set 	_delay_ms 				= 50 			; установка переменной времени задержки 
;=================================================
; Сегмент SRAM памяти
.DSEG
	; Test: .byte 1
	; I2C_Address_Device: .db 0x00
;=================================================
; Сегмент EEPROM памяти
.ESEG
;=================================================
; Сегмент FLASH памяти
.CSEG
;=================================================
; Таблица прерываний
	.ORG 0x00
		RJMP	RESET
;=================================================
; Переменные во флеш памяти
Hello_String: 
	.db ' ','\n',"Поиск I2C устройства начался!",'\n','\n',0
AddressOn: .db "Адрес устройства: 0b",0
AddressOff: .db "Нет найденных устройств!",0
EndSearchDevices: .db '\n','\n',"Поиск I2C устройств завершён!",'\n','\n',0
ErrorStr: .db '\n',"Непредвиденная ошибка!",'\n','\n',0
;=================================================
; Подключение библиотек
#include "delay.lib"    ; подключение файла 'задержек'

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	Temp1, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, Temp1 ; установка младшего байта указателя стека 
	LDI 	Temp1, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, Temp1 ; установка старшего байта указателя стека 

	; -- устанавливаем пин PB5 порта PORTB на вывод -- 
	SBI 	DDRB, PORTB5 ; Set Bit
	; LDI		Temp1, (1 << PORTB5)
	; OUT 	DDRB, Temp1

	; -- инициализация USART --
	RCALL 	USART_Init 
		
	; вывод в порт приветствия
	SETstr 	Hello_String
	RCALL 	USART_Print_String

	; -- инициализация I2C --
	RCALL 	I2C_Init

	; обнуляем адрес устройства
	CLR		I2C_Address ; 0x00

	; -- поиск I2C устройств --
	RCALL 	I2C_Scan


;=================================================
; Основная программа (цикл)
Main:
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================



;=================================================
; -- функция инициализации I2C -- 
I2C_Init: 
	push	Temp1	
	CLR 	Temp1
	STS		TWSR, Temp1 ; TWSR = 0 => prescaler = 1
	LDI 	Temp1, I2C_BaudDivider
	STS		TWBR, Temp1 ; или макрос UOUT
	; порты PC4, PC5 на выход
	SBI 	DDRC, PORTC4 
	SBI 	DDRC, PORTC5 
	SBI 	PORTC, PORTC4 
	SBI 	PORTC, PORTC5 
	pop		Temp1
ret

; I2C команда СТАРТ
I2C_Start: ; ожидается что в I2C_Address записан адрес устройства
	push	Temp1
	push	I2C_Data
	push	I2C_Address
	LSL 	I2C_Address ; << (адрес на запись)
	; ORI 	I2C_Address, 0x01 ; | (адрес на чтение)
	ANDI	I2C_Address, 0xff ; &
	LDI 	Temp1, (1 << TWINT) | (1 << TWEN) | (1 << TWSTA)
	STS		TWCR, Temp1 ; TWSTA - команда СТАРТ
	RCALL 	I2C_Wait
; проверка на ошибки
Search_Status_TW_START:
	LDS 	Temp1, TWSR
	ANDI 	Temp1, 0xF8
	CPI 	Temp1, TW_START ; если не команда старт (в файле defines определены статусы)
	BRNE 	Search_Status_TW_RE_START
	RJMP	Continue_I2C_Start
Search_Status_TW_RE_START:
	CPI 	Temp1, TW_RE_START; и не команда рестарт
	BRNE	Jamp_ERROR ; значит ошибка
	RJMP	Continue_I2C_Start
Jamp_ERROR:
	RJMP	ERROR
; продолжаем если нет ошибок
Continue_I2C_Start:
	MOV		I2C_Data, I2C_Address
	RCALL 	I2C_Write ; передача адреса
	RCALL 	I2C_Wait
	CLR		Flag
	LDS 	Temp1, TWSR
	ANDI 	Temp1, 0xF8
	; проверяем ответит ли устройство
	CPI 	Temp1, TW_MT_SLA_ACK ; в файле defines определены статусы
	BRNE 	End_I2C_Start
	LDI 	Flag, 1 ; если ответит выставляем флаг 
End_I2C_Start:
	pop		I2C_Address
	pop		I2C_Data
	pop		Temp1	
ret

; I2C команда СТОП
I2C_Stop:
	push	Temp1
	LDI 	Temp1, (1 << TWINT) | (1 << TWSTO) | (1 << TWEN)
	STS		TWCR, Temp1 ; TWSTO - команда СТОП
I2C_Wait_TWSTO: ; wait until transmission completet
	LDS 	Temp1, TWCR
	SBRC 	Temp1, TWSTO ; Skip if Bit in Register Clear
	RJMP 	I2C_Wait_TWSTO
	pop		Temp1
ret

; I2C, ожидание снятия флага TWINT
I2C_Wait: ; wait until transmission completet
	LDS 	Temp1, TWCR
	SBRS 	Temp1, TWINT ; Skip if Bit in Register Set
	RJMP 	I2C_Wait
ret
	
; I2C передача данных 
I2C_Write: ; ожидается что в I2C_Data записаны данные
	STS		TWDR, I2C_Data ; записываем данные	
	push	Temp1
	LDI 	Temp1, (1 << TWINT) | (1 << TWEN) 	
	STS		TWCR, Temp1 ; отправляем данные
	RCALL 	I2C_Wait ; ждём окончания отправки
	pop		Temp1
ret

; I2C приём данных
I2C_Read: ; данные будут записаны в I2C_Data 
	push	Temp1
	CPI 	Flag, 1 ; Ack
	BREQ	I2C_Read_Ack
	RJMP	I2C_Read_NoAck
I2C_Read_Ack:
	LDI 	Temp1, (1 << TWINT) | (1 << TWEN) | (1 << TWEA) ; TWEA - Enable Ack
	RJMP	End_I2C_Read
I2C_Read_NoAck:
	LDI 	Temp1, (1 << TWINT) | (1 << TWEN)
End_I2C_Read:
	STS		TWCR, Temp1
	RCALL 	I2C_Wait
	LDS		I2C_Data, TWDR
	pop		Temp1
ret

; поиск устройства и вывод адреса в порт
I2C_Scan:
	LDI		Temp1, 8 ; количество выводимых бит
Repeat_I2C_Scan:
	RCALL	I2C_Start ; команда СТАРТ и передача адреса I2C_Address
	CPI		Flag, 1 ; если устройство ответит
	BREQ	AddressOn_send ; прекращаем сканировать
	RCALL	I2C_Stop ; иначе команда СТОП
	INC 	I2C_Address ; увеличиваем значение
	CPI		I2C_Address, 0x80 ; 127 - максимально возможное значение адреса устройства
	BRSH	Clear_I2C_Address ; Branch if Same or Higher (>=) пропускаем строку ниже если первое значение >= второму
	RJMP	Repeat_I2C_Scan ; повторяем
Clear_I2C_Address:
	CLR		I2C_Address
	RJMP	AddressOff_send
AddressOn_send:
	RCALL	I2C_Stop ; команда СТОП
	SETstr	AddressOn
	RCALL	USART_Print_String ; вывод в порт AddressOn
Loop_I2C_Scan:
	CLC ; Clear Carry (сбрасываем флаг переноса)
	ROL		I2C_Address ; круговой сдвиг влево (ROL 0b11110000 = 0b11100001)
	BRCC	Null_send ; если флаг Carry = 0 
	RJMP	One_send ; если флаг Carry = 1 
Null_send: 
	LDI		USART_Data, '0'
	RCALL	USART_Transmit ; выводим в порт 0
	RJMP	Decrement_Bit
One_send:
	LDI		USART_Data, '1'
	RCALL	USART_Transmit ; выводим в порт 1
	; RJMP	Decrement_Bit
Decrement_Bit:
	DEC		Temp1
	CPI		Temp1, 0
	BREQ	End_I2C_Scan
	RJMP	Loop_I2C_Scan
AddressOff_send:
	SETstr	AddressOff
	RCALL	USART_Print_String ; вывод в порт AddressOff
End_I2C_Scan:
	SETstr	EndSearchDevices
	RCALL	USART_Print_String
ret
;=================================================


;=================================================
; -- функция инициализации USART -- 
USART_Init:
	push	Temp1
	; устанавливаем битрейт
	LDI 	Temp1, LOW(UART_BaudDivider) ; (UBRR & 0xff) ; 16 ;
	UOUT 	UBRR0L, Temp1 ; uout - macros из файла macro.inc
	LDI 	Temp1, HIGH(UART_BaudDivider) ; ((UBRR >> 8) & 0xff) ; 0 ;
	UOUT 	UBRR0H, Temp1 
	LDI 	Temp1, (1 << U2X0)
	UOUT 	UCSR0A, Temp1	
	; включаем приём и передачу
	LDI 	Temp1, (1 << RXEN0) | (1 << TXEN0)
	UOUT 	UCSR0B, Temp1	
	; UPM01 - Enabled, Even Parity
	LDI 	Temp1, (1 << UCSZ01) | (1 << UCSZ00) ; (1 << UPM01) | 
	UOUT 	UCSR0C, Temp1
	pop		Temp1
ret

; -- функция передачи данных -- 
USART_Transmit: ; ожидается что в USART_Data записаны данные
	push	Temp1
wait_flag_UDRE0:
	; Wait for empty transmit buffer
	UIN 	Temp1, UCSR0A ; uin - macros из файла macro.inc
	SBRS 	Temp1, UDRE0 ; Skip if Bit in Register Set
	RJMP 	wait_flag_UDRE0
	; отправляем данные
	UOUT 	UDR0, USART_Data
	pop		Temp1
ret

; -- функция приёма данных -- 
USART_Receive:
	push	Temp1
wait_flag_RXC0:
	; Wait for data to be received
	UIN 	Temp1, UCSR0A
	SBRS 	Temp1, RXC0 ; Skip if Bit in Register Set
	RJMP	wait_flag_RXC0
	; принимаем данные
	UIN 	USART_Data, UDR0
	pop		Temp1
ret

; -- функция вывода строки в порт -- 
USART_Print_String: ; use macro SETstr
	LPM		USART_Data, Z+
	CPI		USART_Data, 0
	BREQ	End_print
	RCALL 	USART_Transmit
	RJMP	USART_Print_String
End_print:
ret
;=================================================


;=================================================
ERROR:
	SETstr	ErrorStr
	RCALL	USART_Print_String ; вывод сообщения в порт
loop_ERROR:
	SBI 	PORTB, PORTB5 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PORTB5 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

