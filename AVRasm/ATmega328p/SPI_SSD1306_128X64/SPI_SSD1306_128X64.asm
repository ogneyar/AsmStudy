
; OLED SSD1306 SPI на микроконтроллере ATmega328p

; разкомментируй строку ниже если используешь LGT8F328P
#define __LGT8F__ ; for LGT8F328P

#define PORT_RES 	PORTB0
#define PORT_DC  	PORTB1
#define PORT_CS 	PORTB2

#define OLED_WIDTH              128
#define OLED_HEIGHT_32          0x02
#define OLED_HEIGHT_64          0x12
#define OLED_64                 0x3F
#define OLED_32                 0x1F

#define OLED_DISPLAY_OFF        0xAE
#define OLED_DISPLAY_ON         0xAF

#define OLED_COMMAND_MODE       0x00
#define OLED_ONE_COMMAND_MODE   0x80
#define OLED_DATA_MODE          0x40
#define OLED_ONE_DATA_MODE      0xC0

#define OLED_ADDRESSING_MODE    0x20
#define OLED_HORIZONTAL         0x00
#define OLED_VERTICAL           0x01

#define OLED_NORMAL_V           0xC8
#define OLED_FLIP_V             0xC0
#define OLED_NORMAL_H           0xA1
#define OLED_FLIP_H             0xA0

#define OLED_CONTRAST           0x81
#define OLED_SETCOMPINS         0xDA
#define OLED_SETVCOMDETECT      0xDB
#define OLED_CLOCKDIV           0xD5
#define OLED_SETMULTIPLEX       0xA8
#define OLED_COLUMNADDR         0x21
#define OLED_PAGEADDR           0x22
#define OLED_CHARGEPUMP         0x8D

#define OLED_NORMALDISPLAY      0xA6
#define OLED_INVERTDISPLAY      0xA7



.INCLUDE "../libs/m328Pdef.inc" ; загрузка предопределений для ATmega328p 
#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
; Имена регистров, а также различные константы
#ifdef __LGT8F__
	.equ 	F_CPU 					= 32000000		; Частота МК LGT8F328P
#else
	.equ 	F_CPU 					= 16000000		; Частота МК ATmega328p
#endif
	.equ 	DIVIDER					= 8				; 8 при U2X0 = 1, 16 при U2X0 = 0
	.equ 	BAUD 					= 115200		; Скорость обмена по UART
	.equ 	UBRR 					= F_CPU/DIVIDER/BAUD-1
	.equ 	I2C_Frequency 			= 100000			; Частота шины I2C (Nano работает даже на 1MHz)
	.equ 	I2C_BaudDivider 		= ((F_CPU/I2C_Frequency)-16)/2	; prescaler = 1
;	.equ 	I2C_Address_Device		= 0x27							; адрес устройства 
;	.equ 	I2C_Address_Write		= (I2C_Address_Device << 1)		; адрес устройства на запись
;	.equ 	I2C_Address_Read		= (I2C_Address_Write & 0x01)	; адрес устройства на чтение
;=================================================
	.def 	USART_Data				= R16			; регистр данных USART
	.def 	I2C_Data				= R17			; регистр данных I2C
	.def 	I2C_Address				= R18			; регистр адреса I2C устройства (0x27 для )
	.def 	Temp0					= R19			; регистр для временных данных
	.def 	Temp1					= R20			; регистр для временных данных
 	.def 	Temp2					= R21			; регистр для временных данных
	.def 	Flag 					= R25 			; регистр для флага
;=================================================	
	.set 	_delay_ms 				= 50 			; установка переменной времени задержки 
	
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
	.ORG 0x16 					; OC1Aaddr
		RJMP 	TIMER1_COMPA
		
;=================================================
; Прерывание Таймера 1 по совпадению канала А
TIMER1_COMPA: ; в R20 находится счётчик миллисекунд (0-255)
	push	R16
	push	R17
	mIN		R17, SREG
	CLI
	CLR		R16
	mOUT 	TCNT1H, R16
	mOUT 	TCNT1L, R16
	
	CPSE	R20, R16 	; Compare, Skip if Equal
	RJMP	TC_Label_1
	RJMP	TC_Label_2

TC_Label_1:
	DEC		R20
TC_Label_2:

	CBI		TIFR1, OCF1A

	mOUT	SREG, R17
	pop	R17
	pop	R16
RETI 

;=================================================
; Переменные во флеш памяти
Program_name: .db "Test SPI Master mode on ATmega328p/LGT8F328P ",0
Hello_String: .db '\n',"Проверка работы SPI!",'\n','\n',0
Cancel_String: .db '\n',"Конец передачи байта! ",'\n','\n',0
ErrorStr: .db '\n',"Непредвиденная ошибка!",'\n','\n',0

;=================================================
; Подключение библиотек
#include "../libs/delay.asm"    ; подключение файла 'задержек'
#include "../libs/usart.asm"    ; подключение файла 'задержек'
#include "../libs/spi.asm"    ; подключение файла 'задержек'

;=================================================
; Прерывание по сбросу, стартовая инициализация 
RESET:	
	; -- инициализация стека -- 
	LDI 	Temp1, LOW(RAMEND) ; младший байт конечного адреса ОЗУ в R16 
	OUT 	SPL, Temp1 ; установка младшего байта указателя стека 
	LDI 	Temp1, HIGH(RAMEND) ; старший байт конечного адреса ОЗУ в R16 
	OUT 	SPH, Temp1 ; установка старшего байта указателя стека 

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
		
;==============================================================
	; -- инициализация USART --
	LDI 	R16, LOW(UBRR)
	LDI 	R17, HIGH(UBRR)
	RCALL 	USART_Init 
		
	; вывод в порт приветствия
	mSetStr	Hello_String
	RCALL 	USART_Print_String

	; -- инициализация TimerCounter1 --
	RCALL	TimerCounter1_Init

	SEI

	; -- инициализация SPI --
	LDI 	R16, 2 ; 0 - 125KHz при Fcpu=16MHz, 1 - 250KHz при Fcpu=16MHz, 2 - 1MHz при Fcpu=16MHz, 3 - 4MHz при Fcpu=16MHz  (0 - 250KHz при Fcpu=32MHz, 1 - 500KHz при Fcpu=32MHz, 2 - 2MHz при Fcpu=32MHz, 3 - 8MHz при Fcpu=32MHz)
	RCALL 	SPI_Master_Init

	; -- инициализация дисплея --
	RCALL 	SSD1306_Init

	; вывод всех пикселей на экран
	RCALL 	SSD1306_Send_Data


	mSetStr Cancel_String
	RCALL 	USART_Print_String

	; RJMP 	ERROR

	; -- устанавливаем пин PB5 порта B на выход -- 
	LDI		Temp1, (1 << PORTB5)
	OUT 	DDRB, Temp1

;=================================================
; Основная программа (цикл)
Main:	
	SBI		PORTB, PORTB5
	LDI		R20, 200
	RCALL	Wait
	CBI		PORTB, PORTB5
	LDI		R20, 200
	RCALL	Wait
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 
;================================================= 




;=====================================================================
; OLED Init
;=====================================================================
SSD1306_Init:
	SBI 	PORTB, PORT_CS ; CS - pull up

	SBI 	PORTB, PORT_RES ; RST - pull up
	LDI		R20, 1
	RCALL	Wait ; delay(1)
	CBI 	PORTB, PORT_RES ; RST - pull down
	LDI		R20, 10
	RCALL	Wait ; delay(10)
	SBI 	PORTB, PORT_RES ; RST - pull up

	; beginCommand
    CBI 	PORTB, PORT_CS ; CS - pull down
	CBI 	PORTB, PORT_DC ; DC - pull down

	; for (uint8_t i = 0; i < 15; i++) sendByte(pgm_read_byte(&_oled_init[i]));		
	; OLED_DISPLAY_OFF
	LDI 	R16, OLED_DISPLAY_OFF
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_CLOCKDIV
	LDI 	R16, OLED_CLOCKDIV
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
    ; value
	LDI 	R16, 0x80
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_CHARGEPUMP
	LDI 	R16, OLED_CHARGEPUMP
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; value
	LDI 	R16, 0x14
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_ADDRESSING_MODE
	LDI 	R16, OLED_ADDRESSING_MODE
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_VERTICAL
	LDI 	R16, OLED_VERTICAL
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_NORMAL_H
	LDI 	R16, OLED_NORMAL_H
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_NORMAL_V
	LDI 	R16, OLED_NORMAL_V
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_CONTRAST
	LDI 	R16, OLED_CONTRAST
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; value
	LDI 	R16, 0x7F
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_SETVCOMDETECT
	LDI 	R16, OLED_SETVCOMDETECT
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; value
	LDI 	R16, 0x40
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_NORMALDISPLAY
	LDI 	R16, OLED_NORMALDISPLAY
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_DISPLAY_ON
	LDI 	R16, OLED_DISPLAY_ON
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_SETCOMPINS
	LDI 	R16, OLED_SETCOMPINS
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_HEIGHT_64
	LDI 	R16, OLED_HEIGHT_64
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_SETMULTIPLEX
	LDI 	R16, OLED_SETMULTIPLEX
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; OLED_64
	LDI 	R16, OLED_64
	RCALL 	SPI_Master_SendByte ; передача байта по SPI


    ; endTransmission
	SBI 	PORTB, PORT_CS ; CS - pull up
ret
;=====================================================================



;=====================================================================
; OLED Send Data
;=====================================================================
SSD1306_Send_Data:
	; beginCommand
    CBI 	PORTB, PORT_CS ; CS - pull down
	CBI 	PORTB, PORT_DC ; DC - pull down

	; Установка столбца
	LDI 	R16, 0x21
	RCALL 	SPI_Master_SendByte ; передача байта по SPI	
	; Начальный адрес
	LDI 	R16, 0
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; Конечный адрес
	LDI 	R16, 127
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
    
	; Установка строки
	LDI 	R16, 0x22
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	; Начальный адрес
	LDI 	R16, 0
	RCALL 	SPI_Master_SendByte ; передача байта по SPI	
	; Конечный адрес
	LDI 	R16, 7
	RCALL 	SPI_Master_SendByte ; передача байта по SPI

 	; endTransmission
	SBI 	PORTB, PORT_CS ; CS - pull up

	; beginData
    CBI 	PORTB, PORT_CS ; CS - pull down
	SBI 	PORTB, PORT_DC ; DC - pull up
	
    
    ; Вывод всех пикселей на экран
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_1:
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_1

	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_2:
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_2
	
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_3:
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_3
	
	LDI		Flag, 0xff
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
send_0xff_256_pcs_4:
	LDI 	R16, 0xff
	RCALL 	SPI_Master_SendByte ; передача байта по SPI
	DEC		Flag ; Flag--
	BRNE	send_0xff_256_pcs_4
	RCALL 	USART_Transmit
ret
;=====================================================================




;
TimerCounter1_Init: ; Настраиваем таймеры
	; Разрешение прерывания таймера 1 по совпадению канала А 
	LDI 	R16, (1 << OCIE1A)
	mOUT 	TIMSK1, R16
	; Установка предделителя /256   ; CS12 CS11 CS10  -   1 0 1 - 1024, 1 0 0 - 256, 0 1 1 - 64, 0 1 0 - 8, 0 0 1 - 1
	LDI 	R16, (1 << CS12) ; | (1 << CS11) | (1 << CS10)
	mOUT 	TCCR1B, R16 
	; Установка числа сравнения 15625=0x3D09 ((8000000/256)/2=15625 - 500 мсек. при Fcpu=8мГц) 
	; при Fcpu=32MHz 32000000/256=125000тиков в секунду, делим на 1000 = 125 тиков в милисекунду  - 1мс
	LDI 	R16, 0
	mOUT 	OCR1AH, R16
	LDI 	R16, 125
	mOUT 	OCR1AL, R16
 	; Обнуление счетчика таймера 1
	CLR		R16
	mOUT 	TCNT1H, R16
	mOUT 	TCNT1L, R16
ret



Wait:
	CLR		R16
	CPSE	R20, R16
	RJMP	Wait
ret

;=================================================
ERROR:
	mSetStr	ErrorStr
	RCALL	USART_Print_String ; вывод сообщения в порт
loop_ERROR:
	SBI 	PORTB, PORTB5 ; включаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	CBI 	PORTB, PORTB5 ; выключаем светодиод
	RCALL	Delay_100ms ; функция задержки из файла delay.inc
	RJMP 	loop_ERROR ; беЗконечный цикл
;=================================================

