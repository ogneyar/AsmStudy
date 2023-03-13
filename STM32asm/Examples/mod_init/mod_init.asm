@ ***************************************************************************
@ *                             Модуль  конфигурации                        *
@ ***************************************************************************
@ * Модуль  конфигурации  осуществляет автоматическую загрузку конфигурации *
@ * по указанному списку адресов / значений                                 *
@ ***************************************************************************
@ * Входные параметры:														*
@ *		R0	Адрес списка значений											*
@ * Выходные параметры:														*
@ *		R0	Результат исполнения											*
@ *-------------------------------------------------------------------------*
@ *                           Формат списка значений                        *
@ *																			*
@ * Значения  для  конфигурации состоят из 2-4 слов формата word (32 бита), *
@ * первое  слово (operation) всегда присутствует в элементах списка конфи- *
@ * гурации, остальные поля присутствуют в зависимости от этого кода:		*
@ * 	operation	код операции											*
@ *		adress		Адрес регистра											*
@ *		value		Значение регистра 										*
@ *		valuemask	Маска значения регистра									*
@ *		waitcode	Адрес подпрограммы паузы или ожидания готовности		*
@ *																			*
@ *-------------------------------------------------------------------------*
@ *         				Формат слова operation							*
@ *																			*
@ * биты 15 -  0	Код операции											*
@ * биты 31 - 16	Дополнительные параметры								*
@ *																			*
@ *-------------------------------------------------------------------------*
@ *								  Коды  операций							*
@ *																			*
@ * 0x0001	(VAL_to_ADR)  Запись value[2] в adress[1]						*
@ *	0x0002  (VAL_ORR_ADR) Запись value[2] в adress[1] с ORR с значением     *
@ *						  adress											*
@ *	0x0003  (VAL_ORR_MASK_AND_ADR) Запись value[3] в adress[1] с ORR значе- *
@ * 							   ния adress с очищенным по mask[2] полем	*
@ *								   значения      							*
@ *																			*
@ * 0x0010	(BITBANG0_ADR) Bitband запись 0 в adress[1]						*
@ *	0x0011  (BITBANG1_ADR) Bitband запись 1 в adress[1] 					*
@ *																			*
@ *	0x0020  (WAIT_BITBANG0_ADR)  Ожидание установки bitband adress[1] в 0	*
@ *	0x0021  (WAIT_BITBANG1_ADR)  Ожидание установки bitband adress[1] в 1	*
@ *																			*
@ *	0x00FF  (END_INIT)	   Выход из конфигуратора							*
@ *																			*
@ *-------------------------------------------------------------------------*
@ *							Коды  ошибок исполнения							*
@ *																			*
@ *	Результат операции возвращается в регистре R0							*
@ *		0x00FF  Неизвестная инструкция										*
@ *		0x0000  Ошибки не было												*
@ *																			*
@ ***************************************************************************

.equ	VAL_to_ADR				, 0x01	@ 0x01, adr, val
.equ	VAL_ORR_ADR 			, 0x02	@ 0x02, adr, val
.equ	VAL_ORR_MASK_AND_ADR	, 0x03	@ 0x02, adr, mask, val
.equ	BITBANG0_ADR			, 0x10	@ 0x10, adr
.equ	BITBANG1_ADR			, 0x11	@ 0x11, adr
.equ	WAIT_BITBANG0_ADR		, 0x20	@ 0x20, adr
.equ	WAIT_BITBANG1_ADR		, 0x21	@ 0x21, adr
.equ	END_INIT				, 0xFF

.align
MOD_INIT_START:
		PUSH	{ R1 , R2 , R3 , LR }
		
		LDR		R1 , [ R0 ] , 4		@ Прочитали код операции

		MOV		R2 , VAL_to_ADR		
		CMP		R1 , R2				
		BEQ		MOD_INIT_OP_STR_VAL

		MOV		R2 , VAL_ORR_ADR
		CMP		R1 , R2				
		BEQ		MOD_INIT_OP_STR_VAL_ORR

		MOV		R2 , VAL_ORR_MASK_AND_ADR	
		CMP		R1 , R2				
		BEQ		MOD_INIT_OP_STR_VAL_MASK
		
		MOV		R2 , BITBANG0_ADR
		CMP		R1 , R2
		IT		EQ	
		MOVEQ	R2 , 0
		BEQ		MOD_INIT_OP_BitBand
		
		MOV		R2 , BITBANG1_ADR
		CMP		R1 , R2				
		BEQ		MOD_INIT_OP_BitBand1
		
		MOV		R2 , WAIT_BITBANG0_ADR
		CMP		R1 , R2
		IT		EQ	
		MOVEQ	R2 , 0
		BEQ		MOD_INIT_OP_WaitBitBand0

		MOV		R2 , WAIT_BITBANG1_ADR
		CMP		R1 , R2
		IT		EQ	
		MOVEQ	R2 , 0
		BEQ		MOD_INIT_OP_WaitBitBand1

		MOV		R2 , 0x00FF			@ Выход
		CMP		R1 , R2				
		ITE		NE					@ ошибка конфигурации-код не найден
		MOVNE	R0 , R2
		MOVEQ	R0 , 0x0000
MOD_INIT_EXIT:
		POP		{ R1 , R2 , R3 , PC }
		
	@ Запись значения по адресу
MOD_INIT_OP_STR_VAL:
		LDR		R1 , [ R0 ] , 4		@ Прочитали адрес
		LDR		R2 , [ R0 ] , 4		@ Прочитали значение
		B		MOD_INIT_OP_STR		@ запишем значение
		
	@ Запись значения по адресу с ORR
MOD_INIT_OP_STR_VAL_ORR:		
		LDR		R1 , [ R0 ] , 4		@ Прочитали адрес
		LDR		R2 , [ R0 ] , 4		@ Прочитали значение
		LDR		R3 , [ R1 ]			@ прочитали текущее значение
MOD_INIT_OP_STR_ORR:
		ORR		R2 , R2 , R3 
		B		MOD_INIT_OP_STR		@ запишем новое значение

	@ Запись значения по адресу с MASK
MOD_INIT_OP_STR_VAL_MASK:		
		LDR		R1 , [ R0 ] , 4		@ Прочитали адрес
		LDR		R2 , [ R0 ] , 4		@ Прочитали маску
		LDR		R3 , [ R1 ]			@ прочитали текущее значение
		AND		R3 , R3 , R2
		LDR		R2 , [ R0 ] , 4		@ Прочитали значение
		B		MOD_INIT_OP_STR_ORR		@ запишем новое значение
		
	@ Bitband запись в регистр
MOD_INIT_OP_BitBand1: 
		MOV		R2 , 1
MOD_INIT_OP_BitBand:
		LDR		R1 , [ R0 ] , 4		@ Прочитали адрес
MOD_INIT_OP_STR:
		STR		R2 , [ R1 ]			@ запишем значение
		B		MOD_INIT_START
		
	@ ожидание BitBand=0
MOD_INIT_OP_WaitBitBand0:
		LDR		R1 , [ R0 ] , 4		@ Прочитали адрес
MOD_INIT_OP_WaitBitBand0_Loop:
		LDR		R2 , [ R1 ]
		ORRS	R2, R2, R2
		BNE		MOD_INIT_OP_WaitBitBand0_Loop
		B		MOD_INIT_START
		
	@ ожидание BitBand=1
MOD_INIT_OP_WaitBitBand1:
		LDR		R1 , [ R0 ] , 4		@ Прочитали адрес
MOD_INIT_OP_WaitBitBand1_Loop:
		LDR		R2 , [ R1 ]
		ORRS	R2, R2, R2
		BEQ		MOD_INIT_OP_WaitBitBand1_Loop
		B		MOD_INIT_START
		
		