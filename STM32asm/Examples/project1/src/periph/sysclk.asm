@GNU AS

.syntax unified		@ ��������� ��������� ����
.thumb			@ ��� ������������ ���������� Thumb
.cpu cortex-m4		@ ���������
.fpu fpv4-sp-d16	@ �����������

@ ***************************************************************************
@ *              ��������� ��������� ������������ STM32F4                   *
@ ***************************************************************************
@ * ��������� ����������� ������� ������������ ���������������� �� �������  *
@ * ��������� ���������, � �������������� PLL � ���������� ����������� ��-  *
@ * ������� ��� ��� � �����������, ������ ��� ���������� �����������        *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * ��������� �������� ��� ����������, �������� �� �����������              *
@ * ������� ������:                                                         *
@ * 		BL SYSCLK168_START					    *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * ������������ ��������: R0, R1, R2, R3, R4, R6, R7 (�� �����������)      *
@ * 	�� �����: ���                                                       *
@ *     �� ������: R0 - ������ ���������� ��������� ������������            *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ * ������ ����������:                                                      *
@ *                    0: ������� �����������                               *
@ *                    1: �� ������� ��������� HSE                          *
@ *                    2: �� ������� ��������� PLL                          *
@ *                    3: �� ������� ������������� �� PLL                   *
@ ***************************************************************************
@ *                            ���������  ���������                         *
@ * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *
@ *  �������� ��������� � ����������                                        *
@ *                                                                         *
@ * PLL_VCO = (HSE_VALUE or HSI_VALUE / PLL_M) * PLL_N                      *

.equ PLL_M , 8
.equ PLL_N , 336

@ * ������� ������������ ����������, ����������������� 168 ���              *
@ * SYSCLK = PLL_VCO / PLL_P                                                *
@
.equ PLL_P , 2

@ * ���� ��� USB (������ ���� 48 ��� ��� ���������� ������)                 *
@ * USB OTG FS, SDIO and RNG Clock =  PLL_VCO / PLLQ                        *
@
.equ PLL_Q , 7

@ * -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  *
@ * �������� �������� ��� ��������� �������� ���������� (������� ������)    *

.equ timeout, 12

@ ***************************************************************************

@ -----------------------   ������ �������� ��� !!  -------------------------

.equ PERIPH_BASE           ,0x40000000  @< Peripheral base address in the alias region                                */
.equ APB1PERIPH_BASE       ,0x00000000
.equ AHB1PERIPH_BASE       ,0x00020000
.equ RCC_BASE              ,(AHB1PERIPH_BASE + 0x3800)
.equ RCC_CR                ,0x00000000
.equ RCC_CR_HSEON          ,0x00010000 @ ��������� HSE
.equ RCC_CR_HSERDY         ,0x00020000 @ ���� ���������� HSE
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

@ �������� ��� �������� � RCC_PLLCFGR
.equ RCC_PLLCFGR_val, PLL_M|(PLL_N<<6)+(((PLL_P>>1)-1)<<16)+RCC_PLLCFGR_PLLSRC_HSE+(PLL_Q<<24)
 
.section .asmcode

.global SYSCLK168_START

SYSCLK168_START:
		PUSH	{ LR }
		LDR		R7, =(PERIPH_BASE + RCC_BASE)

    	@ �������� HSE
    	LDR		R1, [R7, RCC_CR]
    	ORR		R1, R1, RCC_CR_HSEON
    	STR		R1, [R7, RCC_CR]

    	@ ������� ������������ ������� ������		
		MOV		R0, 1   	     @ ��� ������ ��� ������ �� timeout
        ADD		R6, R7, RCC_CR       @ ������� ��� ��������
    	LDR		R2, =RCC_CR_HSERDY   @ ��� ��� ��������
		BL		TST_BIT

        @ �������� POWER control
        LDR		R1, [R7, RCC_APB1ENR]
        ORR		R1, R1, RCC_APB1ENR_PWREN
        STR		R1, [R7, RCC_APB1ENR]

	@ ��. ��������� � ����� "�������a" (������� �� ����������������)
        LDR		R1, =(PERIPH_BASE + PWR_BASE + PWR_CR)
        LDR		R2, [R1]
        ORR		R2, R2, PWR_CR_VOS
        STR		R2, [R1]

	@ ��������� �������� ��� 
    	LDR		R1, [R7, RCC_CFGR]             @ �������� ���� AHB
    	ORR		R1, R1, RCC_CFGR_HPRE_DIV1     @ HCLK=SYSCLK
    	STR		R1, [R7, RCC_CFGR]

        LDR		R1, [R7, RCC_CFGR]             @ �������� ���� APB2
        ORR		R1, R1, RCC_CFGR_PPRE2_DIV2    @ PCLK2=HCLK / 2
        STR		R1, [R7, RCC_CFGR]

        LDR		R1, [R7, RCC_CFGR]             @ �������� ���� APB1
        ORR		R1, R1, RCC_CFGR_PPRE1_DIV4    @ PCLK1=HCLK / 4
        STR		R1, [R7, RCC_CFGR]

        @ ��������� PLL �������������� PLL_M, PLL_N, PLL_Q, PLL_P
        LDR		R1, =RCC_PLLCFGR_val @ ����������� ��������
        STR		R1, [R7, RCC_PLLCFGR]

	@ �������� ������� PLL
        LDR		R1, [R7, RCC_CR]
        ORR		R1, R1, RCC_CR_PLLON
        STR		R1, [R7, RCC_CR]

	@ ������� ���������� PLL
		ADD		R0, R0, 1
    	LDR		R2, =RCC_CR_PLLRDY
		BL		TST_BIT
	
	@ ��������� Flash prefetch, instruction cache, data cache � wait state
        LDR		R2, =(PERIPH_BASE + FLASH_R_BASE + FLASH_ACR)
        LDR		R1, [R2]
        LDR		R1, =(FLASH_ACR_ICEN + FLASH_ACR_DCEN + FLASH_ACR_LATENCY_5WS + FLASH_ACR_PRFTEN)
        STR		R1, [R2]

	@ �������� PLL ���������� �����
        LDR		R1, [R7, RCC_CFGR]
        BIC		R1, R1, RCC_CFGR_SW
        ORR		R1, R1, RCC_CFGR_SW_PLL
        STR		R1, [R7, RCC_CFGR]

	@ ������� ������������ �� PLL
		ADD		R0, R0, 1
		ADD		R6, R7, RCC_CFGR
    	LDR     R2, =RCC_CFGR_SWS_PLL
		BL		TST_BIT

		MOV		R0, 0	         @ ������� ���������� ����������
        B		exit

@ **************************************************************************
@ * ������������ �������� ����������                                       *
@     R0 - ������ �� �����
@     R1 - ����� ��� ������
@     R2 - ��� ����� ��� ���������
@     R3 ��������� !
@     R4 ��������� !
TST_BIT:                         
		ADD   R3, R0, R0, lsl  timeout  @ timeout 
TST_ready:		
		@ �������� �� �������
		SUBS	R3, R3, 1
		BEQ     exit        @ timeout �����, ������� !

		@ �������� ���������� HSE
       	LDR		R4, [R6, 0]
    	TST		R4, R2
        BEQ 	TST_ready
        BX		LR

	@ ����� �� ���������
 exit:
        POP		{ PC }
