@GNU AS

@ ***************************************************************************
@ *                  МОДУЛЬ УПРАВЛЕНИЯ LCD НА PCD8544                       *
@ ***************************************************************************
@ * Процедуры:								    *
@ *     LCD_INIT:     Инициализация GPIO, SPI2, LCD                         *
@ *     LCD_REFRESH:  Вывод содержимого буфера на LCD                       *
@ *     LCD_CLEAR:    Очистка буфера                                        *
@ *     LCD_PIXEL:    Вывод пиксела (R0:Y, R1:X, R2:[1/0])                  *
@ *     LCD_CHAR:     Вывод символа (R0:Y, R1:X, R2:[1/0], R3:char)         *
@ *                                                                         *
@ *  ПРИМЕЧАНИЕ !                                                           *
@ *  - Все процедуры не портят регистры!                                    *
@ *  - допустимые координаты: 0<X<84, 0<Y<48                                *
@ *  - вывод символов LCD_CHAR с точностью до пискела                       *
@ *  - в знакогенераторе нет прописных (маленьких) букв                     *
@ *                                                                         *
@ ***************************************************************************
@
@ подключение к GPIOB

.equ pCS	, 11
.equ pDC	, 12
.equ pRST	, 14

@ аппаратные выводы SPI2
.equ pMOSI      , 15
.equ pSCK	, 13

.syntax unified     @ синтаксис исходного кода
.thumb              @ тип используемых инструкций Thumb
.cpu cortex-m4      @ процессор
.fpu fpv4-sp-d16    @ сопроцессор

.equ PERIPH_BASE           ,0x40000000  @< Peripheral base address in the alias region
.equ PERIPH_BB_BASE        ,0x42000000  @< Peripheral base address in the bit-band region
.equ AHB1PERIPH_BASE       ,0x00020000
.equ APB1PERIPH_BASE       ,0x00000000
.equ RCC_BASE              ,(AHB1PERIPH_BASE + 0x3800)
.equ RCC_AHB1ENR	   ,0x30
.equ RCC_AHB1ENR_GPIOBEN_N ,0x01
.equ RCC_APB1ENR	   ,0x40
.equ RCC_APB1ENR_SPI2EN_N  ,14
.equ GPIOB_BASE            ,(AHB1PERIPH_BASE + 0x0400)
.equ GPIO_AFRH 		   ,0x24  @ регистр указания альтернативных функций
.equ GPIO_MODER_MODER_GENERAL_OUT ,0x00000001
.equ GPIO_MODER_MODER_ALT_MODE    ,0x00000002
.equ GPIO_MODER		   ,0x00
.equ GPIO_OSPEEDR          ,0x08
.equ GPIO_OSPEEDER_VH      ,0x00000003  @ Very high speed
.equ SPI2_BASE             ,(APB1PERIPH_BASE + 0x3800)
.equ SPI_CR1               ,0x00
.equ SPI_SR_TXE            ,0x02               @<Transmit buffer Empty */
.equ  SPI_SR_BSY           ,0x80               @<Busy flag */
.equ GPIO_ODR              ,0x14                            
.equ SPI_CR1_BIDIOE        ,0x4000             @<Output enable in bidirectional mode */
.equ SPI_CR1_BIDIMODE      ,0x8000             @<Bidirectional data mode enable */
.equ  SPI_CR1_SSI          ,0x0100             @<Internal slave select */
.equ  SPI_CR1_SSM          ,0x0200             @<Software slave management */
.equ  SPI_CR1_SPE          ,0x0040             @<SPI Enable */
.equ  SPI_CR1_MSTR         ,0x0004             @<Master Selection */
.equ  SPI_BaudRatePrescaler_2     ,0x0000             @ Делитель частоты SPI
.equ  SPI_SR		   ,0x08
.equ  SPI_DR		   ,0X0C

.section .asmcode

.global LCD_INIT
LCD_INIT:
		PUSH	{R0, R1, R2, R3, R4, R5, LR}

		MOV	R0, 0
		MOV	R1, 1
	@ включаем тактирование периферии
		@ включим GPIO_B
		LDR	R2, =(PERIPH_BB_BASE+(RCC_BASE+RCC_AHB1ENR)*32+RCC_AHB1ENR_GPIOBEN_N*4)
		STR	R1, [R2]

		@ включим SPI 2
		LDR	R2, =(PERIPH_BB_BASE+(RCC_BASE+RCC_APB1ENR)*32+RCC_APB1ENR_SPI2EN_N*4)
		STR	R1, [R2]        	

	@ настраиваем GPIO
		@ зададим альтернативную функцию выводов pSCK и pMOSI
		LDR	R2, =(PERIPH_BASE + GPIOB_BASE)
		LDR	R3, =( (0x05<<((pSCK-8)*4)) | (0x05<<((pMOSI-8)*4)) )
		LDR	R4, [R2, GPIO_AFRH]
		ORR	R3, R3, R4
		STR	R3, [R2, GPIO_AFRH]

		@ зададим режим выводов pMOSI, pSCK, pDC, pCS, pRST (GPIOx_MODER)
		@	- альтернативную функцию для выводов pMOSI и pSCK
		@ 	- general purpose для выводов 14, 12, 10
.equ moderMOSI, GPIO_MODER_MODER_ALT_MODE<<(pMOSI*2)
.equ moderSCK,  GPIO_MODER_MODER_ALT_MODE<<(pSCK*2)
.equ moderCS,   GPIO_MODER_MODER_GENERAL_OUT<<(pCS*2)
.equ moderDC,   GPIO_MODER_MODER_GENERAL_OUT<<(pDC*2)
.equ moderRST,  GPIO_MODER_MODER_GENERAL_OUT<<(pRST*2)
		LDR	R3,=(moderMOSI | moderSCK | moderDC | moderRST | moderCS)
		LDR	R4, [R2, GPIO_MODER]
		ORR	R3, R4, R3
		STR	R3, [R2, GPIO_MODER]

		@ зададим скорость GPIOx_OSPEEDR
.equ ospMOSI,   GPIO_OSPEEDER_VH<<(pMOSI*2)
.equ ospSCK,    GPIO_OSPEEDER_VH<<(pSCK*2)
.equ ospDC,     GPIO_OSPEEDER_VH<<(pDC*2)
.equ ospRST,    GPIO_OSPEEDER_VH<<(pRST*2)
.equ ospCS,     GPIO_OSPEEDER_VH<<(pCS*2)
		LDR	R3,=(ospMOSI | ospSCK | ospDC | ospRST | ospCS)
		LDR	R4,[R2, GPIO_OSPEEDR]
		ORR	R3, R4, R3
		STR	R3, [R2, GPIO_OSPEEDR]
	
	@ настройка и включение интерфейса SPI
.equ spi_dir, SPI_CR1_BIDIOE | SPI_CR1_BIDIMODE    @ SPI_Direction_1Line_Tx
.equ spi_mode_master, SPI_CR1_MSTR | SPI_CR1_SSI   @ SPI_Mode_Master
.equ spi_nss, SPI_CR1_SSM | SPI_CR1_SPE		   @ SPI_NSS_Soft & SPI_Enable
.equ spi_brpresc,  SPI_BaudRatePrescaler_2         @ делитель частоты для SPI
                @ включаем SPI2 с нужной конфигурацией
		LDR	R2, =(PERIPH_BASE + SPI2_BASE)
		LDR	R3, =(spi_dir | spi_mode_master | spi_nss | spi_brpresc)
		LDR	R4, [R2, SPI_CR1]
		ORR	R3, R3, R4
		STR	R3, [R2, SPI_CR1]
	
	@ работа с дисплеем
                @ аппаратный сброс LCD
		BL	LCD_CS0       
		BL	LCD_DC0
		
		BL	LCD_RST0
		
		MOV	R0, 1
		BL	SYSTICK_DELAY

		BL	LCD_RST1   

@		MOV	R0, 2           @ некоторые дисплеи после сброса тоже   
@		BL	SYSTICK_DELAY   @ требуют задержку, но не pcd8544

		@ отправка команд настройки LCD
		MOV	R5, 0x21        
		BL	LCD_SENDDATA

		MOV	R5, 0xC1
		BL	LCD_SENDDATA

		MOV	R5, 0x06
		BL	LCD_SENDDATA

		MOV	R5, 0x13
		BL	LCD_SENDDATA

		MOV	R5, 0x20
		BL	LCD_SENDDATA

		MOV	R5, 0x0C
		BL	LCD_SENDDATA

		BL	SPI2_WAIT_BSY	@ ожидание конца посылки настройки
		
		BL	LCD_CS1

		POP 	{R0, R1, R2, R3, R4,  R5, PC}


	@ отправка байта по spi с ожиданием флага TXE - - - - - - - - - - - -
LCD_SENDDATA:
		LDR	R2, =(PERIPH_BASE + SPI2_BASE)
spi2_txe_wait:
		LDR 	R3, [R2, SPI_SR]
		TST	R3, SPI_SR_TXE
                BEQ 	spi2_txe_wait
                STR	R5, [R2, SPI_DR]
		BX 	LR

	@ ожидание конца передачи - - - - - - - - - - - - - - - - - - - - - -
SPI2_WAIT_BSY:
		LDR	R2, =(PERIPH_BASE + SPI2_BASE)
spi2_bsy_wait:
		LDR 	R3, [R2, SPI_SR]
		TST	R3, SPI_SR_BSY
                BNE 	spi2_bsy_wait
		BX 	LR

	@ управление линией CS - - - - - - - - - - - - - - - - - - - - - - -
LCD_CS0:
		LDR	R2, =(PERIPH_BB_BASE + (GPIOB_BASE + GPIO_ODR)*32 + pCS*4)
		STR	R0, [R2]
		BX	LR

LCD_CS1:
		LDR	R2, =(PERIPH_BB_BASE + (GPIOB_BASE + GPIO_ODR)*32 + pCS*4)
		STR	R1, [R2]
		BX	LR

	@ управление линией DC - - - - - - - - - - - - - - - - - - - - - - - -
LCD_DC0:
		LDR	R2, =(PERIPH_BB_BASE + (GPIOB_BASE + GPIO_ODR)*32 + pDC*4)
		STR	R0, [R2]
                BX	LR

LCD_DC1:
		LDR	R2, =(PERIPH_BB_BASE + (GPIOB_BASE + GPIO_ODR)*32 + pDC*4)
		STR	R1, [R2]
		BX	LR

	@ управление линией RST - - - - - - - - - - - - - - - - - - - - - - -
LCD_RST0:
		LDR	R2, =(PERIPH_BB_BASE + (GPIOB_BASE + GPIO_ODR)*32 + pRST*4)
		STR	R0, [R2]
		BX	LR

LCD_RST1:
		LDR	R2, =(PERIPH_BB_BASE + (GPIOB_BASE + GPIO_ODR)*32 + pRST*4)
		STR	R1, [R2]
		BX	LR


@ ***************************************************************************
@ *                             ОЧИСТКА БУФЕРА	                            *
@ ***************************************************************************
.section .bss
.align(4)
LCD_BUFF:
		.space 84*6, 0                  @ буфер дисплея в SRAM

.section .asmcode

.global LCD_CLEAR

LCD_CLEAR:
		PUSH	{R0, R1, R2}

		MOV	R0, 0			@ записываемое значение
		
		MOV	R1, (84 * 6)/4 		@ количество слов для записи
		
		LDR	R2, =LCD_BUFF  		@ адрес буфера
		
LCD_CLEAR_loop: @ обнуляем буфер записью по 4 байта (так быстрее)
                STR	R0, [R2], 4

		SUBS	R1, R1, 1
		BNE     LCD_CLEAR_loop

                POP	{R0, R1, R2}
                BX 	LR

@ **************************************************************************
@ *                 ОБНОВЛЕНИЕ ЭКРАНА СОДЕРЖИМЫМ БУФЕРА                    *
@ **************************************************************************
.global LCD_REFRESH

LCD_REFRESH:
@ очистка экрана (отладка)
		PUSH	{R0, R1, R2, R4, R5, R6, LR}
		MOV	R0, 0
		MOV	R1, 1

                BL	LCD_CS0
		BL	LCD_DC0

		MOV	R5, 0x40
		BL	LCD_SENDDATA
		
		MOV	R5, 0x80
		BL	LCD_SENDDATA

		BL	SPI2_WAIT_BSY

		BL	LCD_DC1

		MOV	R4, 84 * 6
		LDR	R6, =LCD_BUFF
		
LCD_REFRESH_loop:
		
                LDRB	R5, [R6], 1
		BL	LCD_SENDDATA

		SUBS	R4, R4, 1
		BNE     LCD_REFRESH_loop

		BL	SPI2_WAIT_BSY

                BL	LCD_CS1

                POP	{R0, R1, R2, R4, R5, R6, PC}

@ ***************************************************************************
@ *                           ВЫВОД ПИКСЕЛА                                 *
@ ***************************************************************************
@ * R0 - Y                                                                  *
@ * R1 - X                                                                  *
@ * R2 - цвет (0: белый, 1: черный)                                         *
@ ***************************************************************************

.global LCD_PIXEL
LCD_PIXEL:
                PUSH	{R0, R1, R2, R3, R4, R5, LR}
                        
		CMP	R0, 48		@ проверим допустимость координат
		BPL	LCD_PIXEL_exit
		CMP	R1, 84
		BPL	LCD_PIXEL_exit

		@ вычисляем адрес пиксела
		LSR	R3, R0, 3  	 @  y >> 3
		MOV	R4, 84
		MUL	R3, R3, R4       @ (y >> 3) * 84
		ADD	R5, R3, R1       @ (y >> 3) * 84 + x
		LDR	R4, =LCD_BUFF
		ADD	R5, R5, R4	 @ в R5 адрес бита
		LDRB	R4, [R5]         @ читаем байт бита

		@ вычисляем маску для наложения
		MOV     R3, 1
		AND	R0, R0, 0x07
		LSL	R3, R3, R0
                
		@ в зависимости от цвета: стираем или накладываем маску
		CMP	R2, 0x01	@ вывод/стирание ?
		ITEE	EQ
	ORREQ	R4, R4, R3      @ вывод маски
			RSBNE	R3, R3, 0xFF    @ инверсия маски
			ANDNE	R4, R4, R3      @ сброс по маске
			
		STRB	R4, [R5]	@ запись в буфер
LCD_PIXEL_exit:
	        POP	{R0, R1, R2, R3, R4, R5, PC}

@ ***************************************************************************
@ *                           ВЫВОД СИМВОЛА                                 *
@ ***************************************************************************
@ * R0 - Y                                                                  *
@ * R1 - X                                                                  *
@ * R2 - цвет (0: инверсия, 1: черный)                                      *
@ * R3 - символ                                                             *
@ ***************************************************************************

.include "font6x8.inc"  @ файл знакогенератора

.global LCD_CHAR
LCD_CHAR:
           PUSH	{R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, LR}

		CMP	R0, 48		@ проверим допустимость координат
		BPL	LCD_CHAR_exit
		CMP	R1, 84
		BPL	LCD_CHAR_exit
			
		CMP	R2, 0           @ если выводим символ в инверсии
		BNE	LCD_CHAR_noleftline
		PUSH	{R0, R1, R2}
		MOV	R4, 8           @ то рисуем слева от символа
		SUB	R1, R1, 1       @ вертикальную линию
		SUB	R0, R0, 1       @ чтобы символ не сливался
		MOV	R2, 1           @ с фоном
LCD_CHAR_leftline:
		BL	LCD_PIXEL
		ADD	R0, R0, 1
		SUBS	R4, R4, 1
		BNE     LCD_CHAR_leftline
		POP	{R0, R1, R2}
LCD_CHAR_noleftline:
		@ пересчитаем код char для нашего знакогенератора
                CMP	R3, 127
                ITTEE	MI
	ADRMI	R12, LCD_LAT_CHARS
	SUBMI	R3, R3, 32
			ADRPL	R12, LCD_RUS_CHARS
                       	SUBPL	R3, R3, 192      
		@ в R3:символ R12:адрес знакогенератора

		AND	R4, R0, 0x07
		MOV	R7, 7
		SUB	R4, R7, R4      @ в R4 битовая позиция в байте
			
		LSR	R5, R0, 3       @ в R5 байтовая позиция на экране

        	MOV	R6, 0 		@ счетчик цикла
LCD_CHAR_loop:
		MOV	R7, 6
		MUL	R8, R3, R7	@ код символа * 6

		ADD	R8, R8, R6	@ прибавили номер столбца символа
		ADD	R8, R8, R12	@ прибавили адрес знакогенератора

		LDRB	R8, [R8]	@ столбец (байт символа)
			
		CMP	R2, 0		@ в зависимости от цвета
		BNE     LCD_CHAR_noinv  
		RSB	R8, R8, 0xFF    @ инвертируем байт символа
		PUSH	{R0, R1, R2}
		SUB	R0, R0, 1       @ сверху вывод контрастной точки
		MOV	R2, 1           @ чтобы символ не сливался с
		BL	LCD_PIXEL       @ с фоном
		POP	{R0, R1, R2}
LCD_CHAR_noinv:
		AND	R8, R8, 0x7F

		LDR	R9, =LCD_BUFF
		MOV	R7, 84
		MUL	R7, R7, R5
		ADD	R9, R9, R7	
		ADD	R9, R9, R1      @ адрес в буфере
			
		RSB	R10, R4, 7      @ вывод верхней части символа
		LSL	R11, R8, R10
		LDR	R10, [R9]
		ORR	R11, R10, R11
		STRB	R11, [R9]

		CMP	R4, 7	           @ проверяем нужно ли выводить 
		BEQ	LCD_CHAR_loop_end  @ нижнюю часть символа

		ADD	R5, R5, 1       @ если экранные строки кончились
		CMP	R5, 6
		BEQ	LCD_CHAR_loop_end  @ то пропускаем их вывод

		LDR	R9, =LCD_BUFF
		MOV	R7, 84
		MUL	R7, R7, R5
		ADD	R9, R9, R7	
		ADD	R9, R9, R1
		SUB	R5, R5, 1			

		ADD	R10, R4, 1	@ вывод нижней части символа
		LSR	R11, R8, R10
		LDR	R10, [R9]
		ORR	R11, R10, R11
		STRB	R11, [R9]
LCD_CHAR_loop_end:			
		ADD	R1, R1, 1
		CMP	R1, 84
		BPL	LCD_CHAR_exit

			
		ADD 	R6, R6, 1
		CMP	R6, 6
		BNE	LCD_CHAR_loop
LCD_CHAR_exit:
	POP	{R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, PC}

