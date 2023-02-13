
; I2C сканер на микроконтроллере ATtiny88

.INCLUDE "../libs/tn88def.inc" ; загрузка предопределений для ATtiny88
#include "../libs/macro.inc"    ; подключение файла 'макросов'
#include "../libs/defines.inc"  ; подключение файла 'определений'

;=================================================
; Имена регистров, а также различные константы
	.equ 	F_CPU 					= 16000000		; Частота МК 16MHz

	.equ 	DIVIDER					= 8				; делитель
	.equ 	BAUD 					= 9600			; Скорость обмена по UART
	.equ 	UBRR 					= F_CPU/DIVIDER/BAUD-1
	
	.equ 	I2C_BAUD 				= 100000		; Скорость обмена по I2C
	.equ 	I2C_UBRR				= ((F_CPU/I2C_BAUD)-16)/2		; prescaler = 1
	
;	.equ 	I2C_Address_Device		= 0x27							; адрес устройства 
;	.equ 	I2C_Address_Write		= (I2C_Address_Device << 1)		; адрес устройства на запись
;	.equ 	I2C_Address_Read		= (I2C_Address_Write & 0x01)	; адрес устройства на чтение

;=================================================	
	.def 	Data					= R16			; регистр данных
	.def 	Counter					= R17			; регистр счёичик
	.def 	I2C_Address				= R18			; регистр адреса
	.def 	Null 					= R23 			; нулевой регистр
	.def 	Flag 					= R25 			; регистр для флага

;=================================================
; Сегмент SRAM памяти
.DSEG

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
; Program_name: .db "Search address I2C device on ATtiny88",0
Hello_String: .db '\n',"Поиск I2C устройства начался! ",'\n','\n',0
AddressOn: .db "Адрес устройства: 0b",0
AddressOff: .db "Нет найденных устройств!",0
EndSearchDevices: .db '\n','\n',"Поиск I2C устройств завершён!",'\n','\n',0
ErrorStr: .db '\n',"Непредвиденная ошибка!",'\n','\n',0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/usart.asm"    ; подключение библиотеки USART (ей требуется UBRR)
#include "../libs/i2c.asm"    	; подключение библиотеки I2C (ей требуется I2C_UBRR)

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	

;=================================================
	; -- инициализация стека -- 
	LDI 	R16, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, R16 ; установка младшего байта указателя стека 
	LDI 	R16, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, R16 ; установка старшего байта указателя стека 

;==============================================================
; Очистка ОЗУ и регистров R0-R31
	LDI		ZL, LOW(SRAM_START)		; Адрес начала ОЗУ в индекс
	LDI		ZH, HIGH(SRAM_START)
	CLR		R16					; Очищаем R16
RAM_Flush:
	ST 		Z+, R16
	CPI		ZH, HIGH(RAMEND+1)	
	BRNE	RAM_Flush			
	CPI		ZL, LOW(RAMEND+1)	
	BRNE	RAM_Flush
	LDI		ZL, (0x1F-2)			; Адрес регистра R29
	CLR		ZH
Reg_Flush:
	ST		Z, ZH
	DEC		ZL
	BRNE	Reg_Flush
	CLR		ZL
	CLR		ZH

;=================================================
	; инициализация USART
	RCALL 	USART_Init

	; вывод в порт приветствия
	mSetStr Hello_String
	RCALL 	USART_Print_String
	
	; инициализация I2C
	RCALL 	I2C_Init 

	; -- поиск I2C устройств --	
	RCALL 	I2C_Scan

;=================================================
; Основная программа (цикл)
Main:
	RJMP Main ; возврат к метке Main, повторяем все в цикле 
;=================================================




;=================================================
; поиск устройства и вывод адреса в порт
I2C_Scan:
	push	R16 ; Temp1
	push	R17 ; Counter
	push	R18 ; I2C_Address
	
	LDI		R17, 8 ; количество выводимых бит
	CLR		R18 ; I2C_Address = 0x00
Repeat_I2C_Scan:
	RCALL	I2C_Start ; команда СТАРТ
	;---------------------------------------
	; проверка на ошибки
Search_Status_TW_START:
	LDS 	R16, TWSR
	ANDI 	R16, TW_STATUS_MSK ; в файле defines определены статусы
	CPI 	R16, TW_START ; если не команда старт (в файле defines определены статусы)
	BRNE 	Search_Status_TW_RE_START
	RJMP	Continue_I2C_Scan
Search_Status_TW_RE_START:
	CPI 	R16, TW_RE_START; и не команда рестарт
	BRNE	Jamp_ERROR ; значит ошибка
	RJMP	Continue_I2C_Scan
Jamp_ERROR:
	RJMP	ERROR	
	; продолжаем если нет ошибок
	;---------------------------------------
Continue_I2C_Scan:
	MOV		R16, R18
	RCALL	I2C_Write_Address ; передача адреса записанного в R16
	;------------------------------------
	; проверяем ответло ли устройство
	LDS 	R16, TWSR
	ANDI 	R16, TW_STATUS_MSK ; в файле defines определены статусы
	CPI 	R16, TW_MT_SLA_ACK ; если устройство ответит
	BREQ	AddressOn_send ; прекращаем сканировать
	; продолжаем если устройство не ответило
	;------------------------------------
	RCALL	I2C_Stop ; иначе команда СТОП
	INC 	I2C_Address ; увеличиваем значение
	CPI		I2C_Address, TW_MAX_ADDRESS ; 127 - максимально возможное значение адреса устройства
	BRSH	Clear_I2C_Address ; Branch if Same or Higher (>=) пропускаем строку ниже если первое значение >= второму
	RJMP	Repeat_I2C_Scan ; повторяем
Clear_I2C_Address:
	CLR		I2C_Address
	RJMP	AddressOff_send
AddressOn_send:
	RCALL	I2C_Stop ; команда СТОП
	mSetStr	AddressOn
	RCALL	USART_Print_String ; вывод в порт AddressOn
Loop_I2C_Scan:
	CLC ; Clear Carry (сбрасываем флаг переноса)
	ROL		I2C_Address ; круговой сдвиг влево (ROL 0b11110000 = 0b11100001)
	BRCC	Null_send ; если флаг Carry = 0 
	RJMP	One_send ; если флаг Carry = 1 
Null_send: 
	LDI		Data, '0'
	RCALL	USART_Send_Byte ; выводим в порт 0
	RJMP	Decrement_Bit
One_send:
	LDI		Data, '1'
	RCALL	USART_Send_Byte ; выводим в порт 1
	; RJMP	Decrement_Bit
Decrement_Bit:
	DEC		R17 ; количество выводимых бит
	CPI		R17, 0  ; сравниваем с нулём
	BREQ	End_I2C_Scan
	RJMP	Loop_I2C_Scan
AddressOff_send:
	mSetStr	AddressOff
	RCALL	USART_Print_String ; вывод в порт AddressOff
End_I2C_Scan:
	mSetStr	EndSearchDevices
	RCALL	USART_Print_String
	
	pop		R18 ; I2C_Address
	pop		R17 ; Counter
	pop		R16 ; Temp1
ret


;=================================================
ERROR:
	mSetStr	ErrorStr
	RCALL	USART_Print_String ; вывод сообщения в порт
loop_ERROR:
	SBI 	PORTD, PD0 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTD, PD0 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

