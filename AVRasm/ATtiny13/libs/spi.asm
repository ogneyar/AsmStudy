
#ifndef _SPI_ASM_
#define _SPI_ASM_

#ifndef SPI_MOSI
#define	SPI_MOSI	PB0	
#endif 
#ifndef SPI_SCK
#define	SPI_SCK		PB2	
#endif 
#ifndef SPI_CS
#define	SPI_CS		PB3	
#endif 
#ifndef SPI_DC
#define SPI_DC   	PB4
#endif 
#ifndef SPI_RES
#define SPI_RES  	PB1
#endif 

#ifndef SPI_PORT
#define	SPI_PORT	PORTB
#endif 
#ifndef SPI_DDR
#define	SPI_DDR		DDRB
#endif 
#ifndef SPI_PIN
#define	SPI_PIN		PINB
#endif 

#define	CS_PIN		(1 << SPI_CS)
#define	MOSI_PIN	(1 << SPI_MOSI)
#define	SCK_PIN		(1 << SPI_SCK)
#define	DC_PIN		(1 << SPI_DC)
#define	RES_PIN		(1 << SPI_RES)

;=================================================
; Инициализация SPI
SPI_Master_Init:
    push    R16
	SBI     SPI_PORT, SPI_CS ; deselect_chip();
    LDI     R16, MOSI_PIN | SCK_PIN | CS_PIN | RES_PIN | DC_PIN
	OUT     SPI_DDR, R16
	SBI     SPI_PORT, SPI_SCK ; SPI_SCK_HIGH();
    pop     R16
ret

; SPI передача данных
SPI_Transfer: ;  Data in R16
    push    R16
    push    R17
    SBI     SPI_PORT, SPI_MOSI ; SPI_MOSI_HIGH();
	
	LDI		R17, 8
loop_SPI_Transfer:
    CLC ; Clear Carry
    ROL     R16
    BRCS    send_one_SPI_Transfer; Branch if Carry Set
    BRCC    send_null_SPI_Transfer; Branch if Carry Cleared

send_one_SPI_Transfer:
    SBI     SPI_PORT, SPI_MOSI ; SPI_MOSI_HIGH();
    RJMP    continue__SPI_Transfer

send_null_SPI_Transfer:
    CBI     SPI_PORT, SPI_MOSI ; SPI_MOSI_LOW();
    RJMP    continue__SPI_Transfer

continue__SPI_Transfer:
	CBI     SPI_PORT, SPI_SCK ; SPI_SCK_LOW();
        
	SBI     SPI_PORT, SPI_SCK ; SPI_SCK_HIGH();

	DEC		R17 ; R17--
	BRNE	loop_SPI_Transfer

    SBI     SPI_PORT, SPI_MOSI ; SPI_MOSI_HIGH();
    pop     R17
    pop     R16
ret
;=================================================

#endif  /* _SPI_ASM_ */
