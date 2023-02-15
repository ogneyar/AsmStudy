

#ifndef _I2C_INC_
#define _I2C_INC_

/* ---------------------------------------------------------------------------------------
Библиотеке требуются значения:
    I2C_UBRR - для задержек
        I2C_UBRR = F_CPU / I2C_BAUD (I2C_BAUD - 100KHz или 400KHz) 10 000 000 / 100 000 = 100
    R16 - для отправки байта
    R17 - для приёма байта
--------------------------------------------------------------------------------------- */

// пины
#ifndef SDA
#define SDA			PB3
#endif

#ifndef SCL
#define SCL			PB4
#endif

// управление линиями
; #define SDA_1		CBI     DDRB, SDA
; #define SDA_0		SBI     DDRB, SDA
; #define SCL_1		CBI     DDRB, SCL
; #define SCL_0		SBI     DDRB, SCL


; -- Подпрограмма инициализации I2C -- 
I2C_Init: ; требуется значение I2C_UBRR
    push    R17
	; таймер вкючаем в режим CTC
	LDI 	R17, (1 << WGM01)
	OUT 	TCCR0A, R17
	; делитель на 1
    LDI 	R17, (1 << CS00)
	OUT 	TCCR0B, R17
	; регистр сравнения
  	LDI 	R17, I2C_UBRR
	OUT 	OCR0A, R17	
    pop     R17
ret

; -- Подпрограмма задержки -- 
I2C_Delay: ; требуется значение I2C_UBRR
    push    R19
    LDI     R19, 0
    OUT     TCNT0, R19 ; обнуляем счётчик
loop_I2C_Delay:
	IN		R19, TCNT0
	CPI		R19, I2C_UBRR
	BRCS	loop_I2C_Delay ; Branch if Carry Set (если TCNT0 < UBRR)
    pop     R19
ret

; -- I2C команда СТАРТ -- 
I2C_Start:
    SBI     DDRB, SDA ; SDA_0
	RCALL   I2C_Delay
    SBI     DDRB, SCL ; SCL_0
	RCALL   I2C_Delay
ret

; -- I2C команда СТОП -- 
I2C_Stop:
	SBI     DDRB, SDA ; SDA_0
	RCALL   I2C_Delay
	CBI     DDRB, SCL ; SCL_1
	RCALL   I2C_Delay
	CBI     DDRB, SDA ; SDA_1
	RCALL   I2C_Delay
ret

; -- Подпрограмма отправки байта по I2C -- 
I2C_Write: ; data в регистре R16, ask вернётся в R17
;---------------------------------------------------- 
; повторная инициализация необходима из-за USARTа, там например делитель на 8, тут на 1
	RCALL	I2C_Init
;---------------------------------------------------- 
    LDI     R17, 8 ; i = 8
repeat_I2C_Send:
    CLC ; clear Carry
    ROL     R16
    BRCC    set_0_I2C_Send ; Branch if Carry Cleared
    BRCS    set_1_I2C_Send ; Branch if Carry Set
set_0_I2C_Send:
    SBI     DDRB, SDA ; SDA_0
    RJMP    continue_I2C_Send
set_1_I2C_Send:
    CBI     DDRB, SDA ; SDA_1    
    RJMP    continue_I2C_Send
continue_I2C_Send:
	RCALL   I2C_Delay
	CBI     DDRB, SCL ; SCL_1 - фронт
	RCALL   I2C_Delay
	SBI     DDRB, SCL ; SCL_0 - спад
    DEC     R17
    BRNE    repeat_I2C_Send ; if R17 != 0
    
	CBI     DDRB, SDA ; SDA_1 - отпустить дата
	RCALL   I2C_Delay
	CBI     DDRB, SCL ; SCL_1 - фронт такта
	RCALL   I2C_Delay
	
    IN      R17, PINB
	ANDI    R17, (1 << SDA) ; читаем линию сда (если устройство ответит Ask (R17) будет равен 0)
	SBI     DDRB, SCL ; SCL_0 - спад
ret

; -- Подпрограмма приёма байта по I2C -- 
I2C_Read:
	; регистр сравнения
  	LDI 	R17, I2C_UBRR
	OUT 	OCR0A, R17	
    ;
    ;
    ;
ret



; // получение байта
; uint8_t i2c_read(uint8_t ack){
; 	uint8_t byte=0, i=8;
; 	while(i--)
; 	{
; 		SCL_1;// фронт такта
; 		I2C_DELAY;
; 		if(SDA_PIN & (1 << SDA)) byte|=(1<<i);// если SDA 1 в и-тый бит пишем 1
; 		SCL_0;// спад такта
; 		I2C_DELAY;
; 	}
; 	if(ack) SDA_0;// ask или nask
; 	else SDA_1;
	
; 	SCL_1;//
; 	I2C_DELAY;// такт на получения ответа или неответа
; 	SCL_0;//
; 	I2C_DELAY;
; 	SDA_1;// отпустить сда если притянут
; 	return byte;
; }



#endif  /* _I2C_INC_ */
