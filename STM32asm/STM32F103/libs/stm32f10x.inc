@ STM32F1

.equ FLASH_BASE           ,0x08000000  @ FLASH(up to 64 KB) base address in the alias region

.equ SRAM_BASE            ,0x20000000  @ SRAM(20 KB) base address in the alias region

.equ PERIPH_BASE          ,0x40000000  @ Peripheral base address in the alias region

.equ BKPSRAM_BASE         ,0x40006C00  @ Backup SRAM(4 KB) base address in the alias region

.equ FSMC_R_BASE          ,0xA0000000  @ FSMC registers base address

.equ USB_OTG_FS_BASE      ,0x50000000  @ USB OTG FS registers base address


@ Peripheral memory map
.equ APB1PERIPH_BASE       ,(PERIPH_BASE + 0x00000000)
.equ APB2PERIPH_BASE       ,(PERIPH_BASE + 0x00010000)
.equ AHB1PERIPH_BASE       ,(PERIPH_BASE + 0x00020000)


@ APB1 peripherals
.equ TIM2_BASE             ,(APB1PERIPH_BASE + 0x0000)
.equ TIM3_BASE             ,(APB1PERIPH_BASE + 0x0400)
.equ TIM4_BASE             ,(APB1PERIPH_BASE + 0x0800)
.equ TIM5_BASE             ,(APB1PERIPH_BASE + 0x0C00)
.equ TIM6_BASE             ,(APB1PERIPH_BASE + 0x1000)
.equ TIM7_BASE             ,(APB1PERIPH_BASE + 0x1400)
.equ TIM12_BASE            ,(APB1PERIPH_BASE + 0x1800)
.equ TIM13_BASE            ,(APB1PERIPH_BASE + 0x1C00)
.equ TIM14_BASE            ,(APB1PERIPH_BASE + 0x2000)
.equ RTC_BASE              ,(APB1PERIPH_BASE + 0x2800)
.equ WWDG_BASE             ,(APB1PERIPH_BASE + 0x2C00)
.equ IWDG_BASE             ,(APB1PERIPH_BASE + 0x3000)
.equ SPI2_BASE             ,(APB1PERIPH_BASE + 0x3800)
.equ SPI3_BASE             ,(APB1PERIPH_BASE + 0x3C00)
.equ USART2_BASE           ,(APB1PERIPH_BASE + 0x4400)
.equ USART3_BASE           ,(APB1PERIPH_BASE + 0x4800)
.equ UART4_BASE            ,(APB1PERIPH_BASE + 0x4C00)
.equ UART5_BASE            ,(APB1PERIPH_BASE + 0x5000)
.equ I2C1_BASE             ,(APB1PERIPH_BASE + 0x5400)
.equ I2C2_BASE             ,(APB1PERIPH_BASE + 0x5800)
.equ USB_BASE              ,(APB1PERIPH_BASE + 0x5C00)
.equ CAN1_BASE             ,(APB1PERIPH_BASE + 0x6400)
.equ CAN2_BASE             ,(APB1PERIPH_BASE + 0x6800)
.equ BKP_BASE              ,(APB1PERIPH_BASE + 0x6C00)
.equ PWR_BASE              ,(APB1PERIPH_BASE + 0x7000)
.equ DAC_BASE              ,(APB1PERIPH_BASE + 0x7400)

@< APB2 peripherals */
.equ AFIO_BASE             ,(APB2PERIPH_BASE + 0x0000)
.equ EXTI_BASE             ,(APB2PERIPH_BASE + 0x0400)
.equ GPIOA_BASE            ,(APB2PERIPH_BASE + 0x0800)
.equ GPIOB_BASE            ,(APB2PERIPH_BASE + 0x0C00)
.equ GPIOC_BASE            ,(APB2PERIPH_BASE + 0x1000)
.equ GPIOD_BASE            ,(APB2PERIPH_BASE + 0x1400)
.equ GPIOE_BASE            ,(APB2PERIPH_BASE + 0x1800)
.equ GPIOF_BASE            ,(APB2PERIPH_BASE + 0x1C00)
.equ GPIOG_BASE            ,(APB2PERIPH_BASE + 0x2000)
.equ ADC1_BASE             ,(APB2PERIPH_BASE + 0x2400)
.equ ADC2_BASE             ,(APB2PERIPH_BASE + 0x2800)
.equ TIM1_BASE             ,(APB2PERIPH_BASE + 0x2C00)
.equ SPI1_BASE             ,(APB2PERIPH_BASE + 0x3000)
.equ TIM8_BASE             ,(APB2PERIPH_BASE + 0x3400)
.equ USART1_BASE           ,(APB2PERIPH_BASE + 0x3800)
.equ ADC3_BASE             ,(APB2PERIPH_BASE + 0x3C00)
.equ TIM9_BASE             ,(APB2PERIPH_BASE + 0x4C00)
.equ TIM10_BASE            ,(APB2PERIPH_BASE + 0x5000)
.equ TIM11_BASE            ,(APB2PERIPH_BASE + 0x5400)
.equ SDIO_BASE             ,(APB2PERIPH_BASE + 0x8000)


@ AHB1 peripherals
.equ DMA1_BASE             ,(AHB1PERIPH_BASE + 0x0000)
.equ DMA2_BASE             ,(AHB1PERIPH_BASE + 0x0400)
.equ RCC_BASE              ,(AHB1PERIPH_BASE + 0x1000) @ PERIPH_BASE | 0x00020000 | 0x1000
.equ FLASH_R_BASE          ,(AHB1PERIPH_BASE + 0x2000)
.equ CRC_BASE              ,(AHB1PERIPH_BASE + 0x3000)
.equ ETH_BASE         	   ,(AHB1PERIPH_BASE + 0x8000)

@***********************************************
@*                                             *
@*  Peripheral_declaration                     *
@*                                             *
@***********************************************  
.equ TIM2                , TIM2_BASE
.equ TIM3                , TIM3_BASE
.equ TIM4                , TIM4_BASE
.equ TIM5                , TIM5_BASE
.equ TIM6                , TIM6_BASE
.equ TIM7                , TIM7_BASE
.equ TIM12               , TIM12_BASE
.equ TIM13               , TIM13_BASE
.equ TIM14               , TIM14_BASE
.equ RTC                 , RTC_BASE
.equ WWDG                , WWDG_BASE
.equ IWDG                , IWDG_BASE
.equ SPI2                , SPI2_BASE
.equ SPI3                , SPI3_BASE
.equ USART2              , USART2_BASE
.equ USART3              , USART3_BASE
.equ UART4               , UART4_BASE
.equ UART5               , UART5_BASE
.equ I2C1                , I2C1_BASE
.equ I2C2                , I2C2_BASE
.equ USB                 , USB_BASE
.equ CAN1                , CAN1_BASE
.equ CAN2                , CAN2_BASE
.equ PWR                 , PWR_BASE
.equ DAC                 , DAC_BASE
.equ AFIO                , AFIO_BASE
.equ EXTI                , EXTI_BASE
.equ TIM1                , TIM1_BASE
.equ TIM8                , TIM8_BASE
.equ USART1              , USART1_BASE
.equ ADC                 , ADC_BASE
.equ ADC1                , ADC1_BASE
.equ ADC2                , ADC2_BASE
.equ ADC3                , ADC3_BASE
.equ SDIO                , SDIO_BASE
.equ SPI1                , SPI1_BASE
.equ TIM9                , TIM9_BASE
.equ TIM10               , TIM10_BASE
.equ TIM11               , TIM11_BASE
.equ GPIOA               , GPIOA_BASE
.equ GPIOB               , GPIOB_BASE
.equ GPIOC               , GPIOC_BASE
.equ GPIOD               , GPIOD_BASE
.equ GPIOE               , GPIOE_BASE
.equ GPIOF               , GPIOF_BASE
.equ GPIOG               , GPIOG_BASE
.equ CRC                 , CRC_BASE
.equ RCC                 , RCC_BASE
.equ FLASH               , FLASH_R_BASE
.equ DMA1                , DMA1_BASE
.equ DMA2                , DMA2_BASE
.equ ETH                 , ETH_BASE



@******************************************************************************/
@*                                                                            */
@*                         Reset and Clock Control                            */
@*                                                                            */
@******************************************************************************/

.equ  RCC_CR			                  ,(RCC + 0x00)
@*******************  Bit definition for RCC_CR register  ********************/
.equ  RCC_CR_HSION                        ,0x00000001
.equ  RCC_CR_HSIRDY                       ,0x00000002

.equ  RCC_CR_HSITRIM                      ,0x000000F8
.equ  RCC_CR_HSITRIM_0                    ,0x00000008 @ Bit 0
.equ  RCC_CR_HSITRIM_1                    ,0x00000010 @ Bit 1
.equ  RCC_CR_HSITRIM_2                    ,0x00000020 @ Bit 2
.equ  RCC_CR_HSITRIM_3                    ,0x00000040 @ Bit 3
.equ  RCC_CR_HSITRIM_4                    ,0x00000080 @ Bit 4

.equ  RCC_CR_HSICAL                       ,0x0000FF00
.equ  RCC_CR_HSICAL_0                     ,0x00000100 @ Bit 0
.equ  RCC_CR_HSICAL_1                     ,0x00000200 @ Bit 1
.equ  RCC_CR_HSICAL_2                     ,0x00000400 @ Bit 2
.equ  RCC_CR_HSICAL_3                     ,0x00000800 @ Bit 3
.equ  RCC_CR_HSICAL_4                     ,0x00001000 @ Bit 4
.equ  RCC_CR_HSICAL_5                     ,0x00002000 @ Bit 5
.equ  RCC_CR_HSICAL_6                     ,0x00004000 @ Bit 6
.equ  RCC_CR_HSICAL_7                     ,0x00008000 @ Bit 7

.equ  RCC_CR_HSEON                        ,0x00010000
.equ  RCC_CR_HSERDY                       ,0x00020000
.equ  RCC_CR_HSEBYP                       ,0x00040000
.equ  RCC_CR_CSSON                        ,0x00080000
.equ  RCC_CR_PLLON                        ,0x01000000
.equ  RCC_CR_PLLRDY                       ,0x02000000



.equ  RCC_APB2ENR						  ,(RCC + 0x18)
@*******************  Bit definition for RCC_APB2ENR register  ***************/
.equ  RCC_APB2ENR_AFIOEN                  ,0x00000001
.equ  RCC_APB2ENR_AFIOEN_Pos              ,0
.equ  RCC_APB2ENR_IOAEN                   ,0x00000004
.equ  RCC_APB2ENR_IOAEN_Pos               ,2
.equ  RCC_APB2ENR_IOBEN                   ,0x00000008
.equ  RCC_APB2ENR_IOBEN_Pos               ,3
.equ  RCC_APB2ENR_IOCEN                   ,0x00000010
.equ  RCC_APB2ENR_IOCEN_Pos               ,4
.equ  RCC_APB2ENR_IODEN                   ,0x00000020
.equ  RCC_APB2ENR_IOEEN                   ,0x00000040
.equ  RCC_APB2ENR_IOFEN                   ,0x00000080
.equ  RCC_APB2ENR_IOGEN                   ,0x00000100
.equ  RCC_APB2ENR_ADC1EN                  ,0x00000200
.equ  RCC_APB2ENR_ADC2EN                  ,0x00000400
.equ  RCC_APB2ENR_TIM1EN                  ,0x00000800
.equ  RCC_APB2ENR_SPI1EN                  ,0x00001000
.equ  RCC_APB2ENR_TIM8EN                  ,0x00002000
.equ  RCC_APB2ENR_USART1EN                ,0x00004000
.equ  RCC_APB2ENR_ADC3EN                  ,0x00008000
.equ  RCC_APB2ENR_TIM9EN                  ,0x00080000
.equ  RCC_APB2ENR_TIM10EN                 ,0x00100000
.equ  RCC_APB2ENR_TIM11EN                 ,0x00200000



.equ GPIO_CRH                             ,0x04
@*****************  Bits definition for GPIO_CRH register  ***************/
.equ GPIOA_CRH                            ,(GPIOA + GPIO_CRH) @ 0x40010804
.equ GPIOB_CRH                            ,(GPIOB + GPIO_CRH) @ 0x40010C04
.equ GPIOC_CRH                            ,(GPIOC + GPIO_CRH) @ 0x40011004
.equ GPIOD_CRH                            ,(GPIOD + GPIO_CRH) @ 0x40011404
.equ GPIOE_CRH                            ,(GPIOE + GPIO_CRH) @ 0x40011804
.equ GPIOF_CRH                            ,(GPIOF + GPIO_CRH) @ 0x40011C04
.equ GPIOG_CRH                            ,(GPIOG + GPIO_CRH) @ 0x40012004

.equ GPIO_CRH_CNF13_Msk                   ,0x00C00000
.equ GPIO_CRH_CNF13_Pos 				  ,22
.equ GPIO_CRH_CNF13 				      ,0b11
.equ GPIO_CRH_CNF13_0 				      ,0b01
.equ GPIO_CRH_CNF13_1 				      ,0b10

.equ GPIO_CRH_MODE13_Msk                  ,0x00300000
.equ GPIO_CRH_MODE13_Pos 				  ,20
.equ GPIO_CRH_MODE13 				      ,0b11
.equ GPIO_CRH_MODE13_0 				      ,0b01
.equ GPIO_CRH_MODE13_1 				      ,0b10


.equ GPIO_BSRR                           ,0x10
@*****************  Bits definition for GPIO_BSRR register  ***************/
.equ GPIOA_BSRR                          ,(GPIOA + GPIO_BSRR) @ 0x40010810
.equ GPIOB_BSRR                          ,(GPIOB + GPIO_BSRR) @ 0x40010C10
.equ GPIOC_BSRR                          ,(GPIOC + GPIO_BSRR) @ 0x40011010
.equ GPIOD_BSRR                          ,(GPIOD + GPIO_BSRR) @ 0x40011410
.equ GPIOE_BSRR                          ,(GPIOE + GPIO_BSRR) @ 0x40011810
.equ GPIOF_BSRR                          ,(GPIOF + GPIO_BSRR) @ 0x40011C10
.equ GPIOG_BSRR                          ,(GPIOG + GPIO_BSRR) @ 0x40012010

.equ GPIO_BSRR_BS_13                     ,0x00002000
.equ GPIO_BSRR_BR_13                     ,0x20000000










