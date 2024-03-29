
#ifndef _SPI_ASM_
#define _SPI_ASM_

#include "macro.inc" ; подключение файла с макросами (mIN, mOUT)

#define DDR_SPI 	DDRB
#define PORT_SPI 	PORTB
#define DD_RES 		PB0
#define DD_DC 		PB1
#define DD_SS 		PB2 	; Slave Select
#define DD_MOSI 	PB3
#define DD_MISO 	PB4
#define DD_SCK 		PB5

#define DD_Speed  	R16
#define DD_Temp 	R17
	

;=================================================
; -- Подпрограмма инициализации SPI -- 
SPI_Master_Init: ; ожидаем в R16 значение от 0 - 3 (скорость SPI)
	push	R16	; speed
	push	R17 ; temp
	push	R18 ; 
	
	LDI		R18, (1 << DD_MOSI) | (1 << DD_SCK) | (1 << DD_DC) | (1 << DD_RES) | (1 << DD_SS)
	mOUT 	DDR_SPI, R18
	
	; Разрешить работу SPI, режим Master, установить скорость тактов
	; SPI2X SPR1 SPR0 - 0 0 0 = fck/4; 0 0 1 = fck/16; 0 1 0 = fck/64; 0 1 1 = fck/128;      1 0 0 = fck/2; 1 0 1 = fck/8; 1 1 0 = fck/32; 1 1 1 = fck/64
	LDI		R18, (1 << SPE) | (1 << MSTR) ; | (1 << SPR1) | (1 << SPR0);


Speed_3: ; 4MHz при Fcpu=16MHz (8MHz при Fcpu=32MHz)
	; R16 = 3 -> fck/4   = 4MHz
	LDI		R17, 3
	CP		R16, R17 ; если 3
	BRNE	Speed_2
	ORI		R18, 0
	RJMP	EndSpeed
Speed_2: ; 1MHz при Fcpu=16MHz (2MHz при Fcpu=32MHz)
	; R16 = 2 -> fck/16  = 1MHz
	LDI		R17, 2
	CP		R16, R17 ; если 2
	BRNE	Speed_1
	ORI		R18, (1 << SPR0)
	RJMP	EndSpeed
Speed_1: ; 250KHz при Fcpu=16MHz (500KHz при Fcpu=32MHz)
	; R16 = 1 -> fck/64  = 250KHz
	LDI		R17, 1
	CP		R16, R17 ; если 1
	BRNE	Speed_0
	ORI		R18, (1 << SPR1)
	RJMP	EndSpeed
Speed_0: ; 125KHz при Fcpu=16MHz (250KHz при Fcpu=32MHz) - по умолчанию
	; R16 = 0 -> fck/128 = 125KHz
	ORI		R18, (1 << SPR1) | (1 << SPR0)
	; RJMP	EndSpeed
EndSpeed:
	mOUT 	SPCR, R18
	
	LDI		R18, SPI2X
	mOUT 	SPSR, R18

	pop		R18
	pop		R17
	pop		R16
ret

;
SPI_Master_SendByte: ; ожидаем в R16 байт данных
	push	R16
    ; Запуск передачи данных
	mOUT 	SPDR, R16
	NOP
SPI_Wait_SPIF: ; Ожидание завершения передачи   
	mIN 	R16, SPSR
	SBRS 	R16, SPIF ; Skip if Bit in Register Set
	RJMP 	SPI_Wait_SPIF
	pop		R16
ret

;
SPI_Slave_Init:
	; Set MISO output, all others input
	ldi 	r17, (1 << DD_MISO)
	out 	DDR_SPI,r17
	; Enable SPI
	ldi 	r17, (1 << SPE)
	out 	SPCR,r17
ret

;
SPI_Slave_Receive:
	; Wait for reception complete
	mIN 	R16, SPSR
	SBRS 	R16, SPIF ; Skip if Bit in Register Set
	rjmp 	SPI_Slave_Receive
	; Read received data and return
	in 		r16,SPDR
ret
;=================================================

#endif  /* _SPI_ASM_ */
