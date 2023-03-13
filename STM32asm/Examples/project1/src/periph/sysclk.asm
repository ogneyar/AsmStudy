@GNU AS

.syntax unified		@ синтаксис исходного кода
.thumb			@ тип используемых инструкций Thumb
.cpu cortex-m4		@ процессор
.fpu fpv4-sp-d16	@ сопроцессор

@ ***************************************************************************
@ *              ПРОЦЕДУРА НАСТРОЙКИ ТАКТИРОВАНИЯ STM32F4                   *
@ ***************************************************************************
@ * Процедура настраивает систему тактирования микроконтроллера на внешний  *
@ * кварцевый генератор, с использованием PLL и установкой необходимых де-  *
@ * лителей для шин и интерфейсов, ошибки при исполнении фиксируются        *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * Процедуру вызывать без параметров, регистры не сохраняются              *
@ * команда вызова:                                                         *
@ * 		BL SYSCLK168_START					    *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * Используемые регистры: R0, R1, R2, R3, R4, R6, R7 (не сохраняются)      *
@ * 	На входе: нет                                                       *
@ *     На выходе: R0 - статус результата настройки тактирования            *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * Статус результата:                                                      *
@ *                    0: Частота установлена                               *
@ *                    1: Не удалось запустить HSE                          *
@ *                    2: Не удалось запустить PLL                          *
@ *                    3: Не удалось переключиться на PLL                   *
@ ***************************************************************************
@ *                            НАСТРОЙКИ  ПРОЦЕДУРЫ                         *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ *  значения делителей и множителей                                        *
@ *                                                                         *
@ * PLL_VCO = (HSE_VALUE or HSI_VALUE / PLL_M) * PLL_N                      *

.equ PLL_M , 8
.equ PLL_N , 336

@ * Частота тактирования процессора, документированная 168 мгц              *
@ * SYSCLK = PLL_VCO / PLL_P                                                *
@
.equ PLL_P , 2

@ * Такт для USB (должен быть 48 мгц для нормальной работы)                 *
@ * USB OTG FS, SDIO and RNG Clock =  PLL_VCO / PLLQ                        *
@
.equ PLL_Q , 7

@ * -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  *
@ * значение таймаута при операциях ожидания готовности (степень двойки)    *

.equ timeout, 12

@ ***************************************************************************

@ -----------------------   Дальше настроек нет !!  -------------------------

.equ PERIPH_BASE           ,0x40000000  @< Peripheral base address in the alias region                                */
.equ APB1PERIPH_BASE       ,0x00000000
.equ AHB1PERIPH_BASE       ,0x00020000
.equ RCC_BASE              ,(AHB1PERIPH_BASE + 0x3800)
.equ RCC_CR                ,0x00000000
.equ RCC_CR_HSEON          ,0x00010000 @ включение HSE
.equ RCC_CR_HSERDY         ,0x00020000 @ флаг готовности HSE
.equ RCC_CR_PLLON          ,0x01000000
.equ RCC_CR_PLLRDY         ,0x02000000
.equ RCC_APB1ENR           ,0x40
.equ RCC_APB1ENR_PWREN     ,0x10000000
.equ PWR_BASE              ,(APB1PERIPH_BASE + 0x7000)
.equ PWR_CR				   ,0x00000000
.equ PWR_CR_VOS            ,0x4000     @< Regulator voltage scaling output selection */
.equ  RCC_CFGR             ,0x08
.equ  RCC_CFGR_HPRE_DIV1   ,0x00000000         @< SYSCLK not divided */
.equ  RCC_CFGR_PPRE2_DIV2  ,0x00008000         @< HCLK divided by 2 */
.equ  RCC_CFGR_PPRE1_DIV4  ,0x00001400         @< HCLK divided by 4 */
.equ  RCC_CFGR_SW          ,0x00000003         @< SW[1:0] bits (System clock Switch) */
.equ  RCC_CFGR_SW_PLL      ,0x00000002         @< PLL selected as system clock */
.equ  RCC_CFGR_SWS_PLL     ,0x00000008         @< PLL used as system clock */
.equ  RCC_PLLCFGR_PLLSRC_HSE  ,0x00400000
.equ  RCC_PLLCFGR          ,0x04
.equ FLASH_R_BASE          ,(AHB1PERIPH_BASE + 0x3C00)
.equ FLASH_ACR             ,0x00000000
.equ FLASH_ACR_ICEN        ,0x00000200 
.equ FLASH_ACR_DCEN        ,0x00000400 
.equ FLASH_ACR_LATENCY_5WS ,0x00000005 
.equ FLASH_ACR_PRFTEN      ,0x00000100 

@ значение для загрузки в RCC_PLLCFGR
.equ RCC_PLLCFGR_val, PLL_M|(PLL_N<<6)+(((PLL_P>>1)-1)<<16)+RCC_PLLCFGR_PLLSRC_HSE+(PLL_Q<<24)
 
.section .asmcode

.global SYSCLK168_START

SYSCLK168_START:
		PUSH	{ LR }
		LDR		R7, =(PERIPH_BASE + RCC_BASE)

    	@ Включаем HSE
    	LDR		R1, [R7, RCC_CR]
    	ORR		R1, R1, RCC_CR_HSEON
    	STR		R1, [R7, RCC_CR]

    	@ Ожидаем стабилизации частоты кварца		
		MOV		R0, 1   	     @ код ошибки при выходе по timeout
        ADD		R6, R7, RCC_CR       @ регистр для проверки
    	LDR		R2, =RCC_CR_HSERDY   @ бит для проверки
		BL		TST_BIT

        @ Включаем POWER control
        LDR		R1, [R7, RCC_APB1ENR]
        ORR		R1, R1, RCC_APB1ENR_PWREN
        STR		R1, [R7, RCC_APB1ENR]

	@ Вн. регулятор в режим "нагрузкa" (выходим из энергосбережения)
        LDR		R1, =(PERIPH_BASE + PWR_BASE + PWR_CR)
        LDR		R2, [R1]
        ORR		R2, R2, PWR_CR_VOS
        STR		R2, [R1]

	@ Установим делители шин 
    	LDR		R1, [R7, RCC_CFGR]             @ делитель шины AHB
    	ORR		R1, R1, RCC_CFGR_HPRE_DIV1     @ HCLK=SYSCLK
    	STR		R1, [R7, RCC_CFGR]

        LDR		R1, [R7, RCC_CFGR]             @ делитель шины APB2
        ORR		R1, R1, RCC_CFGR_PPRE2_DIV2    @ PCLK2=HCLK / 2
        STR		R1, [R7, RCC_CFGR]

        LDR		R1, [R7, RCC_CFGR]             @ делитель шины APB1
        ORR		R1, R1, RCC_CFGR_PPRE1_DIV4    @ PCLK1=HCLK / 4
        STR		R1, [R7, RCC_CFGR]

        @ Настройка PLL коэффициентами PLL_M, PLL_N, PLL_Q, PLL_P
        LDR		R1, =RCC_PLLCFGR_val @ расчитанное значение
        STR		R1, [R7, RCC_PLLCFGR]

	@ Включаем питание PLL
        LDR		R1, [R7, RCC_CR]
        ORR		R1, R1, RCC_CR_PLLON
        STR		R1, [R7, RCC_CR]

	@ Ожидаем готовности PLL
		ADD		R0, R0, 1
    	LDR		R2, =RCC_CR_PLLRDY
		BL		TST_BIT
	
	@ Настройка Flash prefetch, instruction cache, data cache и wait state
        LDR		R2, =(PERIPH_BASE + FLASH_R_BASE + FLASH_ACR)
        LDR		R1, [R2]
        LDR		R1, =(FLASH_ACR_ICEN + FLASH_ACR_DCEN + FLASH_ACR_LATENCY_5WS + FLASH_ACR_PRFTEN)
        STR		R1, [R2]

	@ Выбираем PLL источником такта
        LDR		R1, [R7, RCC_CFGR]
        BIC		R1, R1, RCC_CFGR_SW
        ORR		R1, R1, RCC_CFGR_SW_PLL
        STR		R1, [R7, RCC_CFGR]

	@ Ожидаем переключения на PLL
		ADD		R0, R0, 1
		ADD		R6, R7, RCC_CFGR
    	LDR     R2, =RCC_CFGR_SWS_PLL
		BL		TST_BIT

		MOV		R0, 0	         @ признак успешности выполнения
        B		exit

@ **************************************************************************
@ * Подпрограмма проверки готовности                                       *
@     R0 - статус на выход
@     R1 - адрес для чтения
@     R2 - бит карта для сравнения
@     R3 портиться !
@     R4 портиться !
TST_BIT:                         
		ADD   R3, R0, R0, lsl  timeout  @ timeout 
TST_ready:		
		@ проверка на таймаут
		SUBS	R3, R3, 1
		BEQ     exit        @ timeout истек, выходим !

		@ проверка готовности HSE
       	LDR		R4, [R6, 0]
    	TST		R4, R2
        BEQ 	TST_ready
        BX		LR

	@ выход из процедуры
 exit:
        POP		{ PC }
