; Светодиодная мигалка на микроконтроллере ATmega328pb
.CSEG ; начало сегмента кода 
.ORG 0x0000 ; начальное значение для адресации 

; -- инициализация стека -- 
LDI R16, 0xff ; младший байт конечного адреса ОЗУ в R16 
STS 0x5d, R16 ; установка младшего байта указателя стека SPL
LDI R16, 0x08 ; старший байт конечного адреса ОЗУ в R16 
STS 0x5e, R16 ; установка старшего байта указателя стека SPH

; -- устанавливаем пин 3 порта D на выход -- 
LDS 	R16, 0x2A ; DDRD
ORI		R16, 0b00001000
STS 	0x2A, R16

; -- основной цикл программы -- 
Main: 	
	LDS 	R16, 0x2B ; PORTD
	ANDI	R16, 0b11110111
	STS 	0x2B, R16 ; подача на пин 3 низкого уровня 
	
	RCALL 	Wait ; вызываем функцию задержки по времени 	

	LDS 	R16, 0x2B ; PORTD
	ORI		R16, 0b00001000
	STS 	0x2B, R16 ; подача на пин 3 высокого уровня 
	
	RCALL 	Wait ; вызываем функцию задержки по времени 
		
	RJMP 	Main ; возврат к метке Main, повторяем все в цикле 

; -- функция задержки по времени -- 
Wait: ; F_CPU / 5 / 2 -> 8MHz / 10 -> N = 800000 =  0x0c3500 (500 милисекунд)
	LDI 	R18, 0x0c ; старший байт N
	LDI 	R17, 0x35 ; средний байт N
	LDI 	R16, 0x00 ; младший байт N
Loop_Wait: 
	SUBI 	R16, 1 
	SBCI 	R17, 0
	SBCI 	R18, 0
	BRCC 	Loop_Wait
RET ; возврат из подпрограммы Wait 
