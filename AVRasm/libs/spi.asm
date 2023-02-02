
#ifndef _SPI_ASM_
#define _SPI_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

#define DDR_SPI 	DDRB
#define DD_RES 		PORTB0
#define DD_DC 		PORTB1
#define DD_SS 		PORTB2 	; Slave Select
#define DD_MOSI 	PORTB3
#define DD_MISO 	PORTB4
#define DD_SCK 		PORTB5

#define DD_Speed  	R16
#define DD_Temp 	R17
	

;=================================================
; -- Подпрограмма инициализации SPI -- 
SPI_Master_Init: ; ожидаем в R16 значение от 0 - 3 (скорость SPI)
	push	R16	
	push	R17
	push	R18
	
	LDI		R18, (1 << DD_MOSI) | (1 << DD_SCK) | (1 << DD_DC) | (1 << DD_RES) | (1 << DD_SS)
	mOUT 	DDR_SPI, R18	
	
	; Разрешить работу SPI, режим Master, установить скорость тактов
	; SPI2X SPR1 SPR0 - 0 0 0 = fck/4; 0 0 1 = fck/16; 0 1 0 = fck/64; 0 1 1 = fck/128;      1 0 0 = fck/2; 1 0 1 = fck/8; 1 1 0 = fck/32; 1 1 1 = fck/64
	LDI		R18, (1 << SPE) | (1 << MSTR) ; | (1 << SPR1) | (1 << SPR0);
	

    ; RJMP   TEST_SPI


	; R16 = 0 -> fck/128 = 125KHz
	LDI		DD_Temp, 0
	CPSE	R16, DD_Temp ; если 0
	ORI		R18, (1 << SPR1) | (1 << SPR0)
	; R16 = 1 -> fck/64  = 250KHz
	LDI		DD_Temp, 1
	CPSE	R16, DD_Temp ; если 1
	ORI		R18, (1 << SPR1)
	; R16 = 2 -> fck/16  = 1MHz
	LDI		DD_Temp, 2
	CPSE	R16, DD_Temp ; если 2
	ORI		R18, (1 << SPR0)
	; R16 = 3 -> fck/4   = 4KHz
	LDI		DD_Temp, 3
	CPSE	R16, DD_Temp ; если 3
	ORI		R18, 0
    RJMP   END_TEST_SPI

	
; TEST_SPI:
;     ORI		R18, (1 << SPR1) | (1 << SPR0)    
; END_TEST_SPI:


	mOUT 	SPCR, R18
	
	LDI		R18, SPI2X
	mOUT 	SPSR, R18

	pop		R18
	pop		R17
	pop		R16
ret

;
SPI_Master_SendByte: ; ожидаем в R16 байт данных
    ; Запуск передачи данных
	STS 	SPDR, R16
	NOP
SPI_Wait_SPIF: ; Ожидание завершения передачи   
	LDS 	R16, SPSR
	SBRS 	R16, SPIF ; Skip if Bit in Register Set
	RJMP 	SPI_Wait_SPIF
ret
;=================================================

#endif  /* _SPI_ASM_ */
