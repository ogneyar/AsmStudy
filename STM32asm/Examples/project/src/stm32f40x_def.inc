@ STM32F4

.equ FLASH_BASE            ,0x08000000  @< FLASH(up to 1 MB) base address in the alias region                         */

.equ CCMDATARAM_BASE       ,0x10000000  @< CCM(core coupled memory) data RAM(64 KB) base address in the alias region  */

.equ SRAM1_BASE            ,0x20000000  @< SRAM1(112 KB) base address in the alias region                             */
.equ SRAM2_BASE            ,0x2001C000  @< SRAM2(16 KB) base address in the alias region                              */

.equ PERIPH_BASE           ,0x40000000  @< Peripheral base address in the alias region                                */
.equ BKPSRAM_BASE          ,0x40024000  @< Backup SRAM(4 KB) base address in the alias region                         */

.equ FSMC_R_BASE           ,0xA0000000  @< FSMC registers base address                                                */

.equ SYSTICK_BASE      	   ,0xE000E010  @ System timer
.equ NVIC1_BASE            ,0xE000E100  @ NVIC, первая область
.equ SCB_BASE	           ,0xE000ED00  @ System control block (SCB) 
.equ FPU_ACC_BASE          ,0xE000ED88  @ Floating point unit coprocessor access control
.equ MEMPROTECT_BASE       ,0xE000ED90  @ Memory protect unit
.equ NVIC2_BASE            ,0xE000EF00  @ NVIC, вторая область
.equ FPU_BASE              ,0xE000EF30  @ Floating point unit

.equ CCMDATARAM_BB_BASE    ,0x12000000  @< CCM(core coupled memory) data RAM(64 KB) base address in the bit-band region  */
.equ SRAM1_BB_BASE         ,0x22000000  @< SRAM1(112 KB) base address in the bit-band region                             */
.equ SRAM2_BB_BASE         ,0x2201C000  @< SRAM2(16 KB) base address in the bit-band region                              */
.equ PERIPH_BB_BASE        ,0x42000000  @< Peripheral base address in the bit-band region                                */
.equ BKPSRAM_BB_BASE       ,0x42024000  @< Backup SRAM(4 KB) base address in the bit-band region                         */

@ Legacy defines */
.equ SRAM_BASE            ,SRAM1_BASE
.equ SRAM_BB_BASE         ,SRAM1_BB_BASE


@< Peripheral memory map */
.equ APB1PERIPH_BASE       ,0x00000000
.equ APB2PERIPH_BASE       ,0x00010000
.equ AHB1PERIPH_BASE       ,0x00020000
.equ AHB2PERIPH_BASE       ,0x10000000

@< APB1 peripherals */
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
.equ I2S2ext_BASE          ,(APB1PERIPH_BASE + 0x3400)
.equ SPI2_BASE             ,(APB1PERIPH_BASE + 0x3800)
.equ SPI3_BASE             ,(APB1PERIPH_BASE + 0x3C00)
.equ I2S3ext_BASE          ,(APB1PERIPH_BASE + 0x4000)
.equ USART2_BASE           ,(APB1PERIPH_BASE + 0x4400)
.equ USART3_BASE           ,(APB1PERIPH_BASE + 0x4800)
.equ UART4_BASE            ,(APB1PERIPH_BASE + 0x4C00)
.equ UART5_BASE            ,(APB1PERIPH_BASE + 0x5000)
.equ I2C1_BASE             ,(APB1PERIPH_BASE + 0x5400)
.equ I2C2_BASE             ,(APB1PERIPH_BASE + 0x5800)
.equ I2C3_BASE             ,(APB1PERIPH_BASE + 0x5C00)
.equ CAN1_BASE             ,(APB1PERIPH_BASE + 0x6400)
.equ CAN2_BASE             ,(APB1PERIPH_BASE + 0x6800)
.equ PWR_BASE              ,(APB1PERIPH_BASE + 0x7000)
.equ DAC_BASE              ,(APB1PERIPH_BASE + 0x7400)

@< APB2 peripherals */
.equ TIM1_BASE             ,(APB2PERIPH_BASE + 0x0000)
.equ TIM8_BASE             ,(APB2PERIPH_BASE + 0x0400)
.equ USART1_BASE           ,(APB2PERIPH_BASE + 0x1000)
.equ USART6_BASE           ,(APB2PERIPH_BASE + 0x1400)
.equ ADC1_BASE             ,(APB2PERIPH_BASE + 0x2000)
.equ ADC2_BASE             ,(APB2PERIPH_BASE + 0x2100)
.equ ADC3_BASE             ,(APB2PERIPH_BASE + 0x2200)
.equ ADC_BASE              ,(APB2PERIPH_BASE + 0x2300)
.equ SDIO_BASE             ,(APB2PERIPH_BASE + 0x2C00)
.equ SPI1_BASE             ,(APB2PERIPH_BASE + 0x3000)
.equ SYSCFG_BASE           ,(APB2PERIPH_BASE + 0x3800)
.equ EXTI_BASE             ,(APB2PERIPH_BASE + 0x3C00)
.equ TIM9_BASE             ,(APB2PERIPH_BASE + 0x4000)
.equ TIM10_BASE            ,(APB2PERIPH_BASE + 0x4400)
.equ TIM11_BASE            ,(APB2PERIPH_BASE + 0x4800)

@< AHB1 peripherals */
.equ GPIOA_BASE            ,(AHB1PERIPH_BASE + 0x0000)
.equ GPIOB_BASE            ,(AHB1PERIPH_BASE + 0x0400)
.equ GPIOC_BASE            ,(AHB1PERIPH_BASE + 0x0800)
.equ GPIOD_BASE            ,(AHB1PERIPH_BASE + 0x0C00)
.equ GPIOE_BASE            ,(AHB1PERIPH_BASE + 0x1000)
.equ GPIOF_BASE            ,(AHB1PERIPH_BASE + 0x1400)
.equ GPIOG_BASE            ,(AHB1PERIPH_BASE + 0x1800)
.equ GPIOH_BASE            ,(AHB1PERIPH_BASE + 0x1C00)
.equ GPIOI_BASE            ,(AHB1PERIPH_BASE + 0x2000)
.equ CRC_BASE              ,(AHB1PERIPH_BASE + 0x3000)
.equ RCC_BASE              ,(AHB1PERIPH_BASE + 0x3800)
.equ FLASH_R_BASE          ,(AHB1PERIPH_BASE + 0x3C00)
.equ DMA1_BASE             ,(AHB1PERIPH_BASE + 0x6000)
.equ DMA1_Stream0_BASE     ,(DMA1_BASE + 0x010)
.equ DMA1_Stream1_BASE     ,(DMA1_BASE + 0x028)
.equ DMA1_Stream2_BASE     ,(DMA1_BASE + 0x040)
.equ DMA1_Stream3_BASE     ,(DMA1_BASE + 0x058)
.equ DMA1_Stream4_BASE     ,(DMA1_BASE + 0x070)
.equ DMA1_Stream5_BASE     ,(DMA1_BASE + 0x088)
.equ DMA1_Stream6_BASE     ,(DMA1_BASE + 0x0A0)
.equ DMA1_Stream7_BASE     ,(DMA1_BASE + 0x0B8)
.equ DMA2_BASE             ,(AHB1PERIPH_BASE + 0x6400)
.equ DMA2_Stream0_BASE     ,(DMA2_BASE + 0x010)
.equ DMA2_Stream1_BASE     ,(DMA2_BASE + 0x028)
.equ DMA2_Stream2_BASE     ,(DMA2_BASE + 0x040)
.equ DMA2_Stream3_BASE     ,(DMA2_BASE + 0x058)
.equ DMA2_Stream4_BASE     ,(DMA2_BASE + 0x070)
.equ DMA2_Stream5_BASE     ,(DMA2_BASE + 0x088)
.equ DMA2_Stream6_BASE     ,(DMA2_BASE + 0x0A0)
.equ DMA2_Stream7_BASE     ,(DMA2_BASE + 0x0B8)
.equ ETH_BASE              ,(AHB1PERIPH_BASE + 0x8000)
.equ ETH_MAC_BASE          ,(ETH_BASE)
.equ ETH_MMC_BASE          ,(ETH_BASE + 0x0100)
.equ ETH_PTP_BASE          ,(ETH_BASE + 0x0700)
.equ ETH_DMA_BASE          ,(ETH_BASE + 0x1000)

@< AHB2 peripherals */
.equ DCMI_BASE             ,(AHB2PERIPH_BASE + 0x50000)
.equ CRYP_BASE             ,(AHB2PERIPH_BASE + 0x60000)
.equ HASH_BASE             ,(AHB2PERIPH_BASE + 0x60400)
.equ RNG_BASE              ,(AHB2PERIPH_BASE + 0x60800)

@< FSMC Bankx registers base address */
.equ FSMC_Bank1_R_BASE     ,(FSMC_R_BASE + 0x0000)
.equ FSMC_Bank1E_R_BASE    ,(FSMC_R_BASE + 0x0104)
.equ FSMC_Bank2_R_BASE     ,(FSMC_R_BASE + 0x0060)
.equ FSMC_Bank3_R_BASE     ,(FSMC_R_BASE + 0x0080)
.equ FSMC_Bank4_R_BASE     ,(FSMC_R_BASE + 0x00A0)

@ Debug MCU registers base address */
.equ DBGMCU_BASE           ,0xE0042000

@***********************************************
@*                                             *
@*  Peripheral_declaration                     *
@*                                             *
@***********************************************  
.equ TIM2              	 , TIM2_BASE
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
.equ I2S2ext             , I2S2ext_BASE
.equ SPI2                , SPI2_BASE
.equ SPI3                , SPI3_BASE
.equ I2S3ext             , I2S3ext_BASE
.equ USART2              , USART2_BASE
.equ USART3              , USART3_BASE
.equ UART4               , UART4_BASE
.equ UART5               , UART5_BASE
.equ I2C1                , I2C1_BASE
.equ I2C2                , I2C2_BASE
.equ I2C3                , I2C3_BASE
.equ CAN1                , CAN1_BASE
.equ CAN2                , CAN2_BASE
.equ PWR                 , PWR_BASE
.equ DAC                 , DAC_BASE
.equ TIM1                , TIM1_BASE
.equ TIM8                , TIM8_BASE
.equ USART1              , USART1_BASE
.equ USART6              , USART6_BASE
.equ ADC                 , ADC_BASE
.equ ADC1                , ADC1_BASE
.equ ADC2                , ADC2_BASE
.equ ADC3                , ADC3_BASE
.equ SDIO                , SDIO_BASE
.equ SPI1                , SPI1_BASE
.equ SYSCFG              , SYSCFG_BASE
.equ EXTI                , EXTI_BASE
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
.equ GPIOH               , GPIOH_BASE
.equ GPIOI               , GPIOI_BASE
.equ CRC                 , CRC_BASE
.equ RCC                 , RCC_BASE
.equ FLASH               , FLASH_R_BASE
.equ DMA1                , DMA1_BASE
.equ DMA1_Stream0        , DMA1_Stream0_BASE
.equ DMA1_Stream1        , DMA1_Stream1_BASE
.equ DMA1_Stream2        , DMA1_Stream2_BASE
.equ DMA1_Stream3        , DMA1_Stream3_BASE
.equ DMA1_Stream4        , DMA1_Stream4_BASE
.equ DMA1_Stream5        , DMA1_Stream5_BASE
.equ DMA1_Stream6        , DMA1_Stream6_BASE
.equ DMA1_Stream7        , DMA1_Stream7_BASE
.equ DMA2                , DMA2_BASE
.equ DMA2_Stream0        , DMA2_Stream0_BASE
.equ DMA2_Stream1        , DMA2_Stream1_BASE
.equ DMA2_Stream2        , DMA2_Stream2_BASE
.equ DMA2_Stream3        , DMA2_Stream3_BASE
.equ DMA2_Stream4        , DMA2_Stream4_BASE
.equ DMA2_Stream5        , DMA2_Stream5_BASE
.equ DMA2_Stream6        , DMA2_Stream6_BASE
.equ DMA2_Stream7        , DMA2_Stream7_BASE
.equ ETH                 , ETH_BASE
.equ DCMI                , DCMI_BASE
.equ CRYP                , CRYP_BASE
.equ HASH                , HASH_BASE
.equ RNG                 , RNG_BASE
.equ FSMC_Bank1          , FSMC_Bank1_R_BASE
.equ FSMC_Bank1E         , FSMC_Bank1E_R_BASE
.equ FSMC_Bank2          , FSMC_Bank2_R_BASE
.equ FSMC_Bank3          , FSMC_Bank3_R_BASE
.equ FSMC_Bank4          , FSMC_Bank4_R_BASE
.equ DBGMCU              , DBGMCU_BASE

@
@ addtogroup Exported_constants
@
@ addtogroup Peripheral_Registers_Bits_Definition
@
  
@******************************************************************************
@*                         Peripheral Registers_Bits_Definition               *
@******************************************************************************

@******************************************************************************
@*                                                                            *
@*                        Analog to Digital Converter                         *
@*                                                                            *
@******************************************************************************
@********************  Bit definition for ADC_SR register  ********************/
.equ  ADC_SR_AWD                          ,0x01               @<Analog watchdog flag */
.equ  ADC_SR_EOC                          ,0x02               @<End of conversion */
.equ  ADC_SR_JEOC                         ,0x04               @<Injected channel end of conversion */
.equ  ADC_SR_JSTRT                        ,0x08               @<Injected channel Start flag */
.equ  ADC_SR_STRT                         ,0x10               @<Regular channel Start flag */
.equ  ADC_SR_OVR                          ,0x20               @<Overrun flag */

@******************  Bit definition for ADC_CR1 register  ********************/
.equ  ADC_CR1_AWDCH                       ,0x0000001F        @<AWDCH[4:0] bits (Analog watchdog channel select bits) */
.equ  ADC_CR1_AWDCH_0                     ,0x00000001        @<Bit 0 */
.equ  ADC_CR1_AWDCH_1                     ,0x00000002        @<Bit 1 */
.equ  ADC_CR1_AWDCH_2                     ,0x00000004        @<Bit 2 */
.equ  ADC_CR1_AWDCH_3                     ,0x00000008        @<Bit 3 */
.equ  ADC_CR1_AWDCH_4                     ,0x00000010        @<Bit 4 */
.equ  ADC_CR1_EOCIE                       ,0x00000020        @<Interrupt enable for EOC */
.equ  ADC_CR1_AWDIE                       ,0x00000040        @<AAnalog Watchdog interrupt enable */
.equ  ADC_CR1_JEOCIE                      ,0x00000080        @<Interrupt enable for injected channels */
.equ  ADC_CR1_SCAN                        ,0x00000100        @<Scan mode */
.equ  ADC_CR1_AWDSGL                      ,0x00000200        @<Enable the watchdog on a single channel in scan mode */
.equ  ADC_CR1_JAUTO                       ,0x00000400        @<Automatic injected group conversion */
.equ  ADC_CR1_DISCEN                      ,0x00000800        @<Discontinuous mode on regular channels */
.equ  ADC_CR1_JDISCEN                     ,0x00001000        @<Discontinuous mode on injected channels */
.equ  ADC_CR1_DISCNUM                     ,0x0000E000        @<DISCNUM[2:0] bits (Discontinuous mode channel count) */
.equ  ADC_CR1_DISCNUM_0                   ,0x00002000        @<Bit 0 */
.equ  ADC_CR1_DISCNUM_1                   ,0x00004000        @<Bit 1 */
.equ  ADC_CR1_DISCNUM_2                   ,0x00008000        @<Bit 2 */
.equ  ADC_CR1_JAWDEN                      ,0x00400000        @<Analog watchdog enable on injected channels */
.equ  ADC_CR1_AWDEN                       ,0x00800000        @<Analog watchdog enable on regular channels */
.equ  ADC_CR1_RES                         ,0x03000000        @<RES[2:0] bits (Resolution) */
.equ  ADC_CR1_RES_0                       ,0x01000000        @<Bit 0 */
.equ  ADC_CR1_RES_1                       ,0x02000000        @<Bit 1 */
.equ  ADC_CR1_OVRIE                       ,0x04000000         @<overrun interrupt enable */
  
@******************  Bit definition for ADC_CR2 register  ********************/
.equ  ADC_CR2_ADON                        ,0x00000001        @<A/D Converter ON / OFF */
.equ  ADC_CR2_CONT                        ,0x00000002        @<Continuous Conversion */
.equ  ADC_CR2_DMA                         ,0x00000100        @<Direct Memory access mode */
.equ  ADC_CR2_DDS                         ,0x00000200        @<DMA disable selection (Single ADC) */
.equ  ADC_CR2_EOCS                        ,0x00000400        @<End of conversion selection */
.equ  ADC_CR2_ALIGN                       ,0x00000800        @<Data Alignment */
.equ  ADC_CR2_JEXTSEL                     ,0x000F0000        @<JEXTSEL[3:0] bits (External event select for injected group) */
.equ  ADC_CR2_JEXTSEL_0                   ,0x00010000        @<Bit 0 */
.equ  ADC_CR2_JEXTSEL_1                   ,0x00020000        @<Bit 1 */
.equ  ADC_CR2_JEXTSEL_2                   ,0x00040000        @<Bit 2 */
.equ  ADC_CR2_JEXTSEL_3                   ,0x00080000        @<Bit 3 */
.equ  ADC_CR2_JEXTEN                      ,0x00300000        @<JEXTEN[1:0] bits (External Trigger Conversion mode for injected channelsp) */
.equ  ADC_CR2_JEXTEN_0                    ,0x00100000        @<Bit 0 */
.equ  ADC_CR2_JEXTEN_1                    ,0x00200000        @<Bit 1 */
.equ  ADC_CR2_JSWSTART                    ,0x00400000        @<Start Conversion of injected channels */
.equ  ADC_CR2_EXTSEL                      ,0x0F000000        @<EXTSEL[3:0] bits (External Event Select for regular group) */
.equ  ADC_CR2_EXTSEL_0                    ,0x01000000        @<Bit 0 */
.equ  ADC_CR2_EXTSEL_1                    ,0x02000000        @<Bit 1 */
.equ  ADC_CR2_EXTSEL_2                    ,0x04000000        @<Bit 2 */
.equ  ADC_CR2_EXTSEL_3                    ,0x08000000        @<Bit 3 */
.equ  ADC_CR2_EXTEN                       ,0x30000000        @<EXTEN[1:0] bits (External Trigger Conversion mode for regular channelsp) */
.equ  ADC_CR2_EXTEN_0                     ,0x10000000        @<Bit 0 */
.equ  ADC_CR2_EXTEN_1                     ,0x20000000        @<Bit 1 */
.equ  ADC_CR2_SWSTART                     ,0x40000000        @<Start Conversion of regular channels */

@*****************  Bit definition for ADC_SMPR1 register  *******************/
.equ  ADC_SMPR1_SMP10                     ,0x00000007        @<SMP10[2:0] bits (Channel 10 Sample time selection) */
.equ  ADC_SMPR1_SMP10_0                   ,0x00000001        @<Bit 0 */
.equ  ADC_SMPR1_SMP10_1                   ,0x00000002        @<Bit 1 */
.equ  ADC_SMPR1_SMP10_2                   ,0x00000004        @<Bit 2 */
.equ  ADC_SMPR1_SMP11                     ,0x00000038        @<SMP11[2:0] bits (Channel 11 Sample time selection) */
.equ  ADC_SMPR1_SMP11_0                   ,0x00000008        @<Bit 0 */
.equ  ADC_SMPR1_SMP11_1                   ,0x00000010        @<Bit 1 */
.equ  ADC_SMPR1_SMP11_2                   ,0x00000020        @<Bit 2 */
.equ  ADC_SMPR1_SMP12                     ,0x000001C0        @<SMP12[2:0] bits (Channel 12 Sample time selection) */
.equ  ADC_SMPR1_SMP12_0                   ,0x00000040        @<Bit 0 */
.equ  ADC_SMPR1_SMP12_1                   ,0x00000080        @<Bit 1 */
.equ  ADC_SMPR1_SMP12_2                   ,0x00000100        @<Bit 2 */
.equ  ADC_SMPR1_SMP13                     ,0x00000E00        @<SMP13[2:0] bits (Channel 13 Sample time selection) */
.equ  ADC_SMPR1_SMP13_0                   ,0x00000200        @<Bit 0 */
.equ  ADC_SMPR1_SMP13_1                   ,0x00000400        @<Bit 1 */
.equ  ADC_SMPR1_SMP13_2                   ,0x00000800        @<Bit 2 */
.equ  ADC_SMPR1_SMP14                     ,0x00007000        @<SMP14[2:0] bits (Channel 14 Sample time selection) */
.equ  ADC_SMPR1_SMP14_0                   ,0x00001000        @<Bit 0 */
.equ  ADC_SMPR1_SMP14_1                   ,0x00002000        @<Bit 1 */
.equ  ADC_SMPR1_SMP14_2                   ,0x00004000        @<Bit 2 */
.equ  ADC_SMPR1_SMP15                     ,0x00038000        @<SMP15[2:0] bits (Channel 15 Sample time selection) */
.equ  ADC_SMPR1_SMP15_0                   ,0x00008000        @<Bit 0 */
.equ  ADC_SMPR1_SMP15_1                   ,0x00010000        @<Bit 1 */
.equ  ADC_SMPR1_SMP15_2                   ,0x00020000        @<Bit 2 */
.equ  ADC_SMPR1_SMP16                     ,0x001C0000        @<SMP16[2:0] bits (Channel 16 Sample time selection) */
.equ  ADC_SMPR1_SMP16_0                   ,0x00040000        @<Bit 0 */
.equ  ADC_SMPR1_SMP16_1                   ,0x00080000        @<Bit 1 */
.equ  ADC_SMPR1_SMP16_2                   ,0x00100000        @<Bit 2 */
.equ  ADC_SMPR1_SMP17                     ,0x00E00000        @<SMP17[2:0] bits (Channel 17 Sample time selection) */
.equ  ADC_SMPR1_SMP17_0                   ,0x00200000        @<Bit 0 */
.equ  ADC_SMPR1_SMP17_1                   ,0x00400000        @<Bit 1 */
.equ  ADC_SMPR1_SMP17_2                   ,0x00800000        @<Bit 2 */
.equ  ADC_SMPR1_SMP18                     ,0x07000000        @<SMP18[2:0] bits (Channel 18 Sample time selection) */
.equ  ADC_SMPR1_SMP18_0                   ,0x01000000        @<Bit 0 */
.equ  ADC_SMPR1_SMP18_1                   ,0x02000000        @<Bit 1 */
.equ  ADC_SMPR1_SMP18_2                   ,0x04000000        @<Bit 2 */

@*****************  Bit definition for ADC_SMPR2 register  *******************/
.equ  ADC_SMPR2_SMP0                      ,0x00000007        @<SMP0[2:0] bits (Channel 0 Sample time selection) */
.equ  ADC_SMPR2_SMP0_0                    ,0x00000001        @<Bit 0 */
.equ  ADC_SMPR2_SMP0_1                    ,0x00000002        @<Bit 1 */
.equ  ADC_SMPR2_SMP0_2                    ,0x00000004        @<Bit 2 */
.equ  ADC_SMPR2_SMP1                      ,0x00000038        @<SMP1[2:0] bits (Channel 1 Sample time selection) */
.equ  ADC_SMPR2_SMP1_0                    ,0x00000008        @<Bit 0 */
.equ  ADC_SMPR2_SMP1_1                    ,0x00000010        @<Bit 1 */
.equ  ADC_SMPR2_SMP1_2                    ,0x00000020        @<Bit 2 */
.equ  ADC_SMPR2_SMP2                      ,0x000001C0        @<SMP2[2:0] bits (Channel 2 Sample time selection) */
.equ  ADC_SMPR2_SMP2_0                    ,0x00000040        @<Bit 0 */
.equ  ADC_SMPR2_SMP2_1                    ,0x00000080        @<Bit 1 */
.equ  ADC_SMPR2_SMP2_2                    ,0x00000100        @<Bit 2 */
.equ  ADC_SMPR2_SMP3                      ,0x00000E00        @<SMP3[2:0] bits (Channel 3 Sample time selection) */
.equ  ADC_SMPR2_SMP3_0                    ,0x00000200        @<Bit 0 */
.equ  ADC_SMPR2_SMP3_1                    ,0x00000400        @<Bit 1 */
.equ  ADC_SMPR2_SMP3_2                    ,0x00000800        @<Bit 2 */
.equ  ADC_SMPR2_SMP4                      ,0x00007000        @<SMP4[2:0] bits (Channel 4 Sample time selection) */
.equ  ADC_SMPR2_SMP4_0                    ,0x00001000        @<Bit 0 */
.equ  ADC_SMPR2_SMP4_1                    ,0x00002000        @<Bit 1 */
.equ  ADC_SMPR2_SMP4_2                    ,0x00004000        @<Bit 2 */
.equ  ADC_SMPR2_SMP5                      ,0x00038000        @<SMP5[2:0] bits (Channel 5 Sample time selection) */
.equ  ADC_SMPR2_SMP5_0                    ,0x00008000        @<Bit 0 */
.equ  ADC_SMPR2_SMP5_1                    ,0x00010000        @<Bit 1 */
.equ  ADC_SMPR2_SMP5_2                    ,0x00020000        @<Bit 2 */
.equ  ADC_SMPR2_SMP6                      ,0x001C0000        @<SMP6[2:0] bits (Channel 6 Sample time selection) */
.equ  ADC_SMPR2_SMP6_0                    ,0x00040000        @<Bit 0 */
.equ  ADC_SMPR2_SMP6_1                    ,0x00080000        @<Bit 1 */
.equ  ADC_SMPR2_SMP6_2                    ,0x00100000        @<Bit 2 */
.equ  ADC_SMPR2_SMP7                      ,0x00E00000        @<SMP7[2:0] bits (Channel 7 Sample time selection) */
.equ  ADC_SMPR2_SMP7_0                    ,0x00200000        @<Bit 0 */
.equ  ADC_SMPR2_SMP7_1                    ,0x00400000        @<Bit 1 */
.equ  ADC_SMPR2_SMP7_2                    ,0x00800000        @<Bit 2 */
.equ  ADC_SMPR2_SMP8                      ,0x07000000        @<SMP8[2:0] bits (Channel 8 Sample time selection) */
.equ  ADC_SMPR2_SMP8_0                    ,0x01000000        @<Bit 0 */
.equ  ADC_SMPR2_SMP8_1                    ,0x02000000        @<Bit 1 */
.equ  ADC_SMPR2_SMP8_2                    ,0x04000000        @<Bit 2 */
.equ  ADC_SMPR2_SMP9                      ,0x38000000        @<SMP9[2:0] bits (Channel 9 Sample time selection) */
.equ  ADC_SMPR2_SMP9_0                    ,0x08000000        @<Bit 0 */
.equ  ADC_SMPR2_SMP9_1                    ,0x10000000        @<Bit 1 */
.equ  ADC_SMPR2_SMP9_2                    ,0x20000000        @<Bit 2 */

@*****************  Bit definition for ADC_JOFR1 register  *******************/
.equ  ADC_JOFR1_JOFFSET1                  ,0x0FFF            @<Data offset for injected channel 1 */

@*****************  Bit definition for ADC_JOFR2 register  *******************/
.equ  ADC_JOFR2_JOFFSET2                  ,0x0FFF            @<Data offset for injected channel 2 */

@*****************  Bit definition for ADC_JOFR3 register  *******************/
.equ  ADC_JOFR3_JOFFSET3                  ,0x0FFF            @<Data offset for injected channel 3 */

@*****************  Bit definition for ADC_JOFR4 register  *******************/
.equ  ADC_JOFR4_JOFFSET4                  ,0x0FFF            @<Data offset for injected channel 4 */

@******************  Bit definition for ADC_HTR register  ********************/
.equ  ADC_HTR_HT                          ,0x0FFF            @<Analog watchdog high threshold */

@******************  Bit definition for ADC_LTR register  ********************/
.equ  ADC_LTR_LT                          ,0x0FFF            @<Analog watchdog low threshold */

@******************  Bit definition for ADC_SQR1 register  *******************/
.equ  ADC_SQR1_SQ13                       ,0x0000001F        @<SQ13[4:0] bits (13th conversion in regular sequence) */
.equ  ADC_SQR1_SQ13_0                     ,0x00000001        @<Bit 0 */
.equ  ADC_SQR1_SQ13_1                     ,0x00000002        @<Bit 1 */
.equ  ADC_SQR1_SQ13_2                     ,0x00000004        @<Bit 2 */
.equ  ADC_SQR1_SQ13_3                     ,0x00000008        @<Bit 3 */
.equ  ADC_SQR1_SQ13_4                     ,0x00000010        @<Bit 4 */
.equ  ADC_SQR1_SQ14                       ,0x000003E0        @<SQ14[4:0] bits (14th conversion in regular sequence) */
.equ  ADC_SQR1_SQ14_0                     ,0x00000020        @<Bit 0 */
.equ  ADC_SQR1_SQ14_1                     ,0x00000040        @<Bit 1 */
.equ  ADC_SQR1_SQ14_2                     ,0x00000080        @<Bit 2 */
.equ  ADC_SQR1_SQ14_3                     ,0x00000100        @<Bit 3 */
.equ  ADC_SQR1_SQ14_4                     ,0x00000200        @<Bit 4 */
.equ  ADC_SQR1_SQ15                       ,0x00007C00        @<SQ15[4:0] bits (15th conversion in regular sequence) */
.equ  ADC_SQR1_SQ15_0                     ,0x00000400        @<Bit 0 */
.equ  ADC_SQR1_SQ15_1                     ,0x00000800        @<Bit 1 */
.equ  ADC_SQR1_SQ15_2                     ,0x00001000        @<Bit 2 */
.equ  ADC_SQR1_SQ15_3                     ,0x00002000        @<Bit 3 */
.equ  ADC_SQR1_SQ15_4                     ,0x00004000        @<Bit 4 */
.equ  ADC_SQR1_SQ16                       ,0x000F8000        @<SQ16[4:0] bits (16th conversion in regular sequence) */
.equ  ADC_SQR1_SQ16_0                     ,0x00008000        @<Bit 0 */
.equ  ADC_SQR1_SQ16_1                     ,0x00010000        @<Bit 1 */
.equ  ADC_SQR1_SQ16_2                     ,0x00020000        @<Bit 2 */
.equ  ADC_SQR1_SQ16_3                     ,0x00040000        @<Bit 3 */
.equ  ADC_SQR1_SQ16_4                     ,0x00080000        @<Bit 4 */
.equ  ADC_SQR1_L                          ,0x00F00000        @<L[3:0] bits (Regular channel sequence length) */
.equ  ADC_SQR1_L_0                        ,0x00100000        @<Bit 0 */
.equ  ADC_SQR1_L_1                        ,0x00200000        @<Bit 1 */
.equ  ADC_SQR1_L_2                        ,0x00400000         @<Bit 2 */
.equ  ADC_SQR1_L_3                        ,0x00800000         @<Bit 3 */

@******************  Bit definition for ADC_SQR2 register  *******************/
.equ  ADC_SQR2_SQ7                        ,0x0000001F         @<SQ7[4:0] bits (7th conversion in regular sequence) */
.equ  ADC_SQR2_SQ7_0                      ,0x00000001         @<Bit 0 */
.equ  ADC_SQR2_SQ7_1                      ,0x00000002         @<Bit 1 */
.equ  ADC_SQR2_SQ7_2                      ,0x00000004         @<Bit 2 */
.equ  ADC_SQR2_SQ7_3                      ,0x00000008         @<Bit 3 */
.equ  ADC_SQR2_SQ7_4                      ,0x00000010         @<Bit 4 */
.equ  ADC_SQR2_SQ8                        ,0x000003E0         @<SQ8[4:0] bits (8th conversion in regular sequence) */
.equ  ADC_SQR2_SQ8_0                      ,0x00000020         @<Bit 0 */
.equ  ADC_SQR2_SQ8_1                      ,0x00000040         @<Bit 1 */
.equ  ADC_SQR2_SQ8_2                      ,0x00000080         @<Bit 2 */
.equ  ADC_SQR2_SQ8_3                      ,0x00000100         @<Bit 3 */
.equ  ADC_SQR2_SQ8_4                      ,0x00000200         @<Bit 4 */
.equ  ADC_SQR2_SQ9                        ,0x00007C00         @<SQ9[4:0] bits (9th conversion in regular sequence) */
.equ  ADC_SQR2_SQ9_0                      ,0x00000400         @<Bit 0 */
.equ  ADC_SQR2_SQ9_1                      ,0x00000800         @<Bit 1 */
.equ  ADC_SQR2_SQ9_2                      ,0x00001000         @<Bit 2 */
.equ  ADC_SQR2_SQ9_3                      ,0x00002000         @<Bit 3 */
.equ  ADC_SQR2_SQ9_4                      ,0x00004000         @<Bit 4 */
.equ  ADC_SQR2_SQ10                       ,0x000F8000         @<SQ10[4:0] bits (10th conversion in regular sequence) */
.equ  ADC_SQR2_SQ10_0                     ,0x00008000         @<Bit 0 */
.equ  ADC_SQR2_SQ10_1                     ,0x00010000         @<Bit 1 */
.equ  ADC_SQR2_SQ10_2                     ,0x00020000         @<Bit 2 */
.equ  ADC_SQR2_SQ10_3                     ,0x00040000         @<Bit 3 */
.equ  ADC_SQR2_SQ10_4                     ,0x00080000         @<Bit 4 */
.equ  ADC_SQR2_SQ11                       ,0x01F00000         @<SQ11[4:0] bits (11th conversion in regular sequence) */
.equ  ADC_SQR2_SQ11_0                     ,0x00100000         @<Bit 0 */
.equ  ADC_SQR2_SQ11_1                     ,0x00200000         @<Bit 1 */
.equ  ADC_SQR2_SQ11_2                     ,0x00400000         @<Bit 2 */
.equ  ADC_SQR2_SQ11_3                     ,0x00800000         @<Bit 3 */
.equ  ADC_SQR2_SQ11_4                     ,0x01000000         @<Bit 4 */
.equ  ADC_SQR2_SQ12                       ,0x3E000000         @<SQ12[4:0] bits (12th conversion in regular sequence) */
.equ  ADC_SQR2_SQ12_0                     ,0x02000000         @<Bit 0 */
.equ  ADC_SQR2_SQ12_1                     ,0x04000000         @<Bit 1 */
.equ  ADC_SQR2_SQ12_2                     ,0x08000000         @<Bit 2 */
.equ  ADC_SQR2_SQ12_3                     ,0x10000000         @<Bit 3 */
.equ  ADC_SQR2_SQ12_4                     ,0x20000000         @<Bit 4 */

@******************  Bit definition for ADC_SQR3 register  *******************/
.equ  ADC_SQR3_SQ1                        ,0x0000001F         @<SQ1[4:0] bits (1st conversion in regular sequence) */
.equ  ADC_SQR3_SQ1_0                      ,0x00000001         @<Bit 0 */
.equ  ADC_SQR3_SQ1_1                      ,0x00000002         @<Bit 1 */
.equ  ADC_SQR3_SQ1_2                      ,0x00000004         @<Bit 2 */
.equ  ADC_SQR3_SQ1_3                      ,0x00000008         @<Bit 3 */
.equ  ADC_SQR3_SQ1_4                      ,0x00000010         @<Bit 4 */
.equ  ADC_SQR3_SQ2                        ,0x000003E0         @<SQ2[4:0] bits (2nd conversion in regular sequence) */
.equ  ADC_SQR3_SQ2_0                      ,0x00000020         @<Bit 0 */
.equ  ADC_SQR3_SQ2_1                      ,0x00000040         @<Bit 1 */
.equ  ADC_SQR3_SQ2_2                      ,0x00000080         @<Bit 2 */
.equ  ADC_SQR3_SQ2_3                      ,0x00000100         @<Bit 3 */
.equ  ADC_SQR3_SQ2_4                      ,0x00000200         @<Bit 4 */
.equ  ADC_SQR3_SQ3                        ,0x00007C00         @<SQ3[4:0] bits (3rd conversion in regular sequence) */
.equ  ADC_SQR3_SQ3_0                      ,0x00000400         @<Bit 0 */
.equ  ADC_SQR3_SQ3_1                      ,0x00000800         @<Bit 1 */
.equ  ADC_SQR3_SQ3_2                      ,0x00001000         @<Bit 2 */
.equ  ADC_SQR3_SQ3_3                      ,0x00002000         @<Bit 3 */
.equ  ADC_SQR3_SQ3_4                      ,0x00004000         @<Bit 4 */
.equ  ADC_SQR3_SQ4                        ,0x000F8000         @<SQ4[4:0] bits (4th conversion in regular sequence) */
.equ  ADC_SQR3_SQ4_0                      ,0x00008000         @<Bit 0 */
.equ  ADC_SQR3_SQ4_1                      ,0x00010000         @<Bit 1 */
.equ  ADC_SQR3_SQ4_2                      ,0x00020000         @<Bit 2 */
.equ  ADC_SQR3_SQ4_3                      ,0x00040000         @<Bit 3 */
.equ  ADC_SQR3_SQ4_4                      ,0x00080000         @<Bit 4 */
.equ  ADC_SQR3_SQ5                        ,0x01F00000         @<SQ5[4:0] bits (5th conversion in regular sequence) */
.equ  ADC_SQR3_SQ5_0                      ,0x00100000         @<Bit 0 */
.equ  ADC_SQR3_SQ5_1                      ,0x00200000         @<Bit 1 */
.equ  ADC_SQR3_SQ5_2                      ,0x00400000         @<Bit 2 */
.equ  ADC_SQR3_SQ5_3                      ,0x00800000         @<Bit 3 */
.equ  ADC_SQR3_SQ5_4                      ,0x01000000         @<Bit 4 */
.equ  ADC_SQR3_SQ6                        ,0x3E000000         @<SQ6[4:0] bits (6th conversion in regular sequence) */
.equ  ADC_SQR3_SQ6_0                      ,0x02000000         @<Bit 0 */
.equ  ADC_SQR3_SQ6_1                      ,0x04000000         @<Bit 1 */
.equ  ADC_SQR3_SQ6_2                      ,0x08000000         @<Bit 2 */
.equ  ADC_SQR3_SQ6_3                      ,0x10000000         @<Bit 3 */
.equ  ADC_SQR3_SQ6_4                      ,0x20000000         @<Bit 4 */

@******************  Bit definition for ADC_JSQR register  *******************/
.equ  ADC_JSQR_JSQ1                       ,0x0000001F         @<JSQ1[4:0] bits (1st conversion in injected sequence) */  
.equ  ADC_JSQR_JSQ1_0                     ,0x00000001         @<Bit 0 */
.equ  ADC_JSQR_JSQ1_1                     ,0x00000002         @<Bit 1 */
.equ  ADC_JSQR_JSQ1_2                     ,0x00000004         @<Bit 2 */
.equ  ADC_JSQR_JSQ1_3                     ,0x00000008         @<Bit 3 */
.equ  ADC_JSQR_JSQ1_4                     ,0x00000010         @<Bit 4 */
.equ  ADC_JSQR_JSQ2                       ,0x000003E0         @<JSQ2[4:0] bits (2nd conversion in injected sequence) */
.equ  ADC_JSQR_JSQ2_0                     ,0x00000020         @<Bit 0 */
.equ  ADC_JSQR_JSQ2_1                     ,0x00000040         @<Bit 1 */
.equ  ADC_JSQR_JSQ2_2                     ,0x00000080         @<Bit 2 */
.equ  ADC_JSQR_JSQ2_3                     ,0x00000100         @<Bit 3 */
.equ  ADC_JSQR_JSQ2_4                     ,0x00000200         @<Bit 4 */
.equ  ADC_JSQR_JSQ3                       ,0x00007C00         @<JSQ3[4:0] bits (3rd conversion in injected sequence) */
.equ  ADC_JSQR_JSQ3_0                     ,0x00000400         @<Bit 0 */
.equ  ADC_JSQR_JSQ3_1                     ,0x00000800         @<Bit 1 */
.equ  ADC_JSQR_JSQ3_2                     ,0x00001000         @<Bit 2 */
.equ  ADC_JSQR_JSQ3_3                     ,0x00002000         @<Bit 3 */
.equ  ADC_JSQR_JSQ3_4                     ,0x00004000         @<Bit 4 */
.equ  ADC_JSQR_JSQ4                       ,0x000F8000         @<JSQ4[4:0] bits (4th conversion in injected sequence) */
.equ  ADC_JSQR_JSQ4_0                     ,0x00008000         @<Bit 0 */
.equ  ADC_JSQR_JSQ4_1                     ,0x00010000         @<Bit 1 */
.equ  ADC_JSQR_JSQ4_2                     ,0x00020000         @<Bit 2 */
.equ  ADC_JSQR_JSQ4_3                     ,0x00040000         @<Bit 3 */
.equ  ADC_JSQR_JSQ4_4                     ,0x00080000         @<Bit 4 */
.equ  ADC_JSQR_JL                         ,0x00300000         @<JL[1:0] bits (Injected Sequence length) */
.equ  ADC_JSQR_JL_0                       ,0x00100000         @<Bit 0 */
.equ  ADC_JSQR_JL_1                       ,0x00200000         @<Bit 1 */

@******************  Bit definition for ADC_JDR1 register  *******************/
.equ  ADC_JDR1_JDATA                      ,0xFFFF            @<Injected data */

@******************  Bit definition for ADC_JDR2 register  *******************/
.equ  ADC_JDR2_JDATA                      ,0xFFFF            @<Injected data */

@******************  Bit definition for ADC_JDR3 register  *******************/
.equ  ADC_JDR3_JDATA                      ,0xFFFF            @<Injected data */

@******************  Bit definition for ADC_JDR4 register  *******************/
.equ  ADC_JDR4_JDATA                      ,0xFFFF            @<Injected data */

@*******************  Bit definition for ADC_DR register  ********************/
.equ  ADC_DR_DATA                         ,0x0000FFFF         @<Regular data */
.equ  ADC_DR_ADC2DATA                     ,0xFFFF0000         @<ADC2 data */

@******************  Bit definition for ADC_CSR register  ********************/
.equ  ADC_CSR_AWD1                        ,0x00000001         @<ADC1 Analog watchdog flag */
.equ  ADC_CSR_EOC1                        ,0x00000002         @<ADC1 End of conversion */
.equ  ADC_CSR_JEOC1                       ,0x00000004         @<ADC1 Injected channel end of conversion */
.equ  ADC_CSR_JSTRT1                      ,0x00000008         @<ADC1 Injected channel Start flag */
.equ  ADC_CSR_STRT1                       ,0x00000010         @<ADC1 Regular channel Start flag */
.equ  ADC_CSR_DOVR1                       ,0x00000020         @<ADC1 DMA overrun  flag */
.equ  ADC_CSR_AWD2                        ,0x00000100         @<ADC2 Analog watchdog flag */
.equ  ADC_CSR_EOC2                        ,0x00000200         @<ADC2 End of conversion */
.equ  ADC_CSR_JEOC2                       ,0x00000400         @<ADC2 Injected channel end of conversion */
.equ  ADC_CSR_JSTRT2                      ,0x00000800         @<ADC2 Injected channel Start flag */
.equ  ADC_CSR_STRT2                       ,0x00001000         @<ADC2 Regular channel Start flag */
.equ  ADC_CSR_DOVR2                       ,0x00002000         @<ADC2 DMA overrun  flag */
.equ  ADC_CSR_AWD3                        ,0x00010000         @<ADC3 Analog watchdog flag */
.equ  ADC_CSR_EOC3                        ,0x00020000         @<ADC3 End of conversion */
.equ  ADC_CSR_JEOC3                       ,0x00040000         @<ADC3 Injected channel end of conversion */
.equ  ADC_CSR_JSTRT3                      ,0x00080000         @<ADC3 Injected channel Start flag */
.equ  ADC_CSR_STRT3                       ,0x00100000         @<ADC3 Regular channel Start flag */
.equ  ADC_CSR_DOVR3                       ,0x00200000         @<ADC3 DMA overrun  flag */

@******************  Bit definition for ADC_CCR register  ********************/
.equ  ADC_CCR_MULTI                       ,0x0000001F         @<MULTI[4:0] bits (Multi-ADC mode selection) */  
.equ  ADC_CCR_MULTI_0                     ,0x00000001         @<Bit 0 */
.equ  ADC_CCR_MULTI_1                     ,0x00000002         @<Bit 1 */
.equ  ADC_CCR_MULTI_2                     ,0x00000004         @<Bit 2 */
.equ  ADC_CCR_MULTI_3                     ,0x00000008         @<Bit 3 */
.equ  ADC_CCR_MULTI_4                     ,0x00000010         @<Bit 4 */
.equ  ADC_CCR_DELAY                       ,0x00000F00         @<DELAY[3:0] bits (Delay between 2 sampling phases) */  
.equ  ADC_CCR_DELAY_0                     ,0x00000100         @<Bit 0 */
.equ  ADC_CCR_DELAY_1                     ,0x00000200         @<Bit 1 */
.equ  ADC_CCR_DELAY_2                     ,0x00000400         @<Bit 2 */
.equ  ADC_CCR_DELAY_3                     ,0x00000800         @<Bit 3 */
.equ  ADC_CCR_DDS                         ,0x00002000         @<DMA disable selection (Multi-ADC mode) */
.equ  ADC_CCR_DMA                         ,0x0000C000         @<DMA[1:0] bits (Direct Memory Access mode for multimode) */  
.equ  ADC_CCR_DMA_0                       ,0x00004000         @<Bit 0 */
.equ  ADC_CCR_DMA_1                       ,0x00008000         @<Bit 1 */
.equ  ADC_CCR_ADCPRE                      ,0x00030000         @<ADCPRE[1:0] bits (ADC prescaler) */  
.equ  ADC_CCR_ADCPRE_0                    ,0x00010000         @<Bit 0 */
.equ  ADC_CCR_ADCPRE_1                    ,0x00020000         @<Bit 1 */
.equ  ADC_CCR_VBATE                       ,0x00400000         @<VBAT Enable */
.equ  ADC_CCR_TSVREFE                     ,0x00800000         @<Temperature Sensor and VREFINT Enable */

@******************  Bit definition for ADC_CDR register  ********************/
.equ  ADC_CDR_DATA1                      ,0x0000FFFF         @<1st data of a pair of regular conversions */
.equ  ADC_CDR_DATA2                      ,0xFFFF0000         @<2nd data of a pair of regular conversions */

@*****************************************************************************/
@                                                                            */
@                         Controller Area Network                            */
@                                                                            */
@*****************************************************************************/
@<CAN control and status registers */
@******************  Bit definition for CAN_MCR register  ********************/
.equ  CAN_MCR_INRQ                        ,0x0001            @<Initialization Request */
.equ  CAN_MCR_SLEEP                       ,0x0002            @<Sleep Mode Request */
.equ  CAN_MCR_TXFP                        ,0x0004            @<Transmit FIFO Priority */
.equ  CAN_MCR_RFLM                        ,0x0008            @<Receive FIFO Locked Mode */
.equ  CAN_MCR_NART                        ,0x0010            @<No Automatic Retransmission */
.equ  CAN_MCR_AWUM                        ,0x0020            @<Automatic Wakeup Mode */
.equ  CAN_MCR_ABOM                        ,0x0040            @<Automatic Bus-Off Management */
.equ  CAN_MCR_TTCM                        ,0x0080            @<Time Triggered Communication Mode */
.equ  CAN_MCR_RESET                       ,0x8000            @<bxCAN software master reset */

@******************  Bit definition for CAN_MSR register  ********************/
.equ  CAN_MSR_INAK                        ,0x0001            @<Initialization Acknowledge */
.equ  CAN_MSR_SLAK                        ,0x0002            @<Sleep Acknowledge */
.equ  CAN_MSR_ERRI                        ,0x0004            @<Error Interrupt */
.equ  CAN_MSR_WKUI                        ,0x0008            @<Wakeup Interrupt */
.equ  CAN_MSR_SLAKI                       ,0x0010            @<Sleep Acknowledge Interrupt */
.equ  CAN_MSR_TXM                         ,0x0100            @<Transmit Mode */
.equ  CAN_MSR_RXM                         ,0x0200            @<Receive Mode */
.equ  CAN_MSR_SAMP                        ,0x0400            @<Last Sample Point */
.equ  CAN_MSR_RX                          ,0x0800            @<CAN Rx Signal */

@******************  Bit definition for CAN_TSR register  ********************/
.equ  CAN_TSR_RQCP0                       ,0x00000001         @<Request Completed Mailbox0 */
.equ  CAN_TSR_TXOK0                       ,0x00000002         @<Transmission OK of Mailbox0 */
.equ  CAN_TSR_ALST0                       ,0x00000004         @<Arbitration Lost for Mailbox0 */
.equ  CAN_TSR_TERR0                       ,0x00000008         @<Transmission Error of Mailbox0 */
.equ  CAN_TSR_ABRQ0                       ,0x00000080         @<Abort Request for Mailbox0 */
.equ  CAN_TSR_RQCP1                       ,0x00000100         @<Request Completed Mailbox1 */
.equ  CAN_TSR_TXOK1                       ,0x00000200         @<Transmission OK of Mailbox1 */
.equ  CAN_TSR_ALST1                       ,0x00000400         @<Arbitration Lost for Mailbox1 */
.equ  CAN_TSR_TERR1                       ,0x00000800         @<Transmission Error of Mailbox1 */
.equ  CAN_TSR_ABRQ1                       ,0x00008000         @<Abort Request for Mailbox 1 */
.equ  CAN_TSR_RQCP2                       ,0x00010000         @<Request Completed Mailbox2 */
.equ  CAN_TSR_TXOK2                       ,0x00020000         @<Transmission OK of Mailbox 2 */
.equ  CAN_TSR_ALST2                       ,0x00040000         @<Arbitration Lost for mailbox 2 */
.equ  CAN_TSR_TERR2                       ,0x00080000         @<Transmission Error of Mailbox 2 */
.equ  CAN_TSR_ABRQ2                       ,0x00800000         @<Abort Request for Mailbox 2 */
.equ  CAN_TSR_CODE                        ,0x03000000         @<Mailbox Code */

.equ  CAN_TSR_TME                         ,0x1C000000         @<TME[2:0] bits */
.equ  CAN_TSR_TME0                        ,0x04000000         @<Transmit Mailbox 0 Empty */
.equ  CAN_TSR_TME1                        ,0x08000000         @<Transmit Mailbox 1 Empty */
.equ  CAN_TSR_TME2                        ,0x10000000         @<Transmit Mailbox 2 Empty */

.equ  CAN_TSR_LOW                         ,0xE0000000         @<LOW[2:0] bits */
.equ  CAN_TSR_LOW0                        ,0x20000000         @<Lowest Priority Flag for Mailbox 0 */
.equ  CAN_TSR_LOW1                        ,0x40000000         @<Lowest Priority Flag for Mailbox 1 */
.equ  CAN_TSR_LOW2                        ,0x80000000         @<Lowest Priority Flag for Mailbox 2 */

@******************  Bit definition for CAN_RF0R register  *******************/
.equ  CAN_RF0R_FMP0                       ,0x03               @<FIFO 0 Message Pending */
.equ  CAN_RF0R_FULL0                      ,0x08               @<FIFO 0 Full */
.equ  CAN_RF0R_FOVR0                      ,0x10               @<FIFO 0 Overrun */
.equ  CAN_RF0R_RFOM0                      ,0x20               @<Release FIFO 0 Output Mailbox */

@******************  Bit definition for CAN_RF1R register  *******************/
.equ  CAN_RF1R_FMP1                       ,0x03               @<FIFO 1 Message Pending */
.equ  CAN_RF1R_FULL1                      ,0x08               @<FIFO 1 Full */
.equ  CAN_RF1R_FOVR1                      ,0x10               @<FIFO 1 Overrun */
.equ  CAN_RF1R_RFOM1                      ,0x20               @<Release FIFO 1 Output Mailbox */

@*******************  Bit definition for CAN_IER register  *******************/
.equ  CAN_IER_TMEIE                       ,0x00000001         @<Transmit Mailbox Empty Interrupt Enable */
.equ  CAN_IER_FMPIE0                      ,0x00000002         @<FIFO Message Pending Interrupt Enable */
.equ  CAN_IER_FFIE0                       ,0x00000004         @<FIFO Full Interrupt Enable */
.equ  CAN_IER_FOVIE0                      ,0x00000008         @<FIFO Overrun Interrupt Enable */
.equ  CAN_IER_FMPIE1                      ,0x00000010         @<FIFO Message Pending Interrupt Enable */
.equ  CAN_IER_FFIE1                       ,0x00000020         @<FIFO Full Interrupt Enable */
.equ  CAN_IER_FOVIE1                      ,0x00000040         @<FIFO Overrun Interrupt Enable */
.equ  CAN_IER_EWGIE                       ,0x00000100         @<Error Warning Interrupt Enable */
.equ  CAN_IER_EPVIE                       ,0x00000200         @<Error Passive Interrupt Enable */
.equ  CAN_IER_BOFIE                       ,0x00000400         @<Bus-Off Interrupt Enable */
.equ  CAN_IER_LECIE                       ,0x00000800         @<Last Error Code Interrupt Enable */
.equ  CAN_IER_ERRIE                       ,0x00008000         @<Error Interrupt Enable */
.equ  CAN_IER_WKUIE                       ,0x00010000         @<Wakeup Interrupt Enable */
.equ  CAN_IER_SLKIE                       ,0x00020000         @<Sleep Interrupt Enable */

@*******************  Bit definition for CAN_ESR register  *******************/
.equ  CAN_ESR_EWGF                        ,0x00000001         @<Error Warning Flag */
.equ  CAN_ESR_EPVF                        ,0x00000002         @<Error Passive Flag */
.equ  CAN_ESR_BOFF                        ,0x00000004         @<Bus-Off Flag */

.equ  CAN_ESR_LEC                         ,0x00000070         @<LEC[2:0] bits (Last Error Code) */
.equ  CAN_ESR_LEC_0                       ,0x00000010         @<Bit 0 */
.equ  CAN_ESR_LEC_1                       ,0x00000020         @<Bit 1 */
.equ  CAN_ESR_LEC_2                       ,0x00000040         @<Bit 2 */

.equ  CAN_ESR_TEC                         ,0x00FF0000         @<Least significant byte of the 9-bit Transmit Error Counter */
.equ  CAN_ESR_REC                         ,0xFF000000         @<Receive Error Counter */

@******************  Bit definition for CAN_BTR register  ********************/
.equ  CAN_BTR_BRP                         ,0x000003FF         @<Baud Rate Prescaler */
.equ  CAN_BTR_TS1                         ,0x000F0000         @<Time Segment 1 */
.equ  CAN_BTR_TS2                         ,0x00700000         @<Time Segment 2 */
.equ  CAN_BTR_SJW                         ,0x03000000         @<Resynchronization Jump Width */
.equ  CAN_BTR_LBKM                        ,0x40000000         @<Loop Back Mode (Debug) */
.equ  CAN_BTR_SILM                        ,0x80000000         @<Silent Mode */

@<Mailbox registers */
@*****************  Bit definition for CAN_TI0R register  ********************/
.equ  CAN_TI0R_TXRQ                       ,0x00000001         @<Transmit Mailbox Request */
.equ  CAN_TI0R_RTR                        ,0x00000002         @<Remote Transmission Request */
.equ  CAN_TI0R_IDE                        ,0x00000004         @<Identifier Extension */
.equ  CAN_TI0R_EXID                       ,0x001FFFF8         @<Extended Identifier */
.equ  CAN_TI0R_STID                       ,0xFFE00000         @<Standard Identifier or Extended Identifier */

@*****************  Bit definition for CAN_TDT0R register  *******************/
.equ  CAN_TDT0R_DLC                       ,0x0000000F         @<Data Length Code */
.equ  CAN_TDT0R_TGT                       ,0x00000100         @<Transmit Global Time */
.equ  CAN_TDT0R_TIME                      ,0xFFFF0000         @<Message Time Stamp */

@*****************  Bit definition for CAN_TDL0R register  *******************/
.equ  CAN_TDL0R_DATA0                     ,0x000000FF         @<Data byte 0 */
.equ  CAN_TDL0R_DATA1                     ,0x0000FF00         @<Data byte 1 */
.equ  CAN_TDL0R_DATA2                     ,0x00FF0000         @<Data byte 2 */
.equ  CAN_TDL0R_DATA3                     ,0xFF000000         @<Data byte 3 */

@*****************  Bit definition for CAN_TDH0R register  *******************/
.equ  CAN_TDH0R_DATA4                     ,0x000000FF         @<Data byte 4 */
.equ  CAN_TDH0R_DATA5                     ,0x0000FF00         @<Data byte 5 */
.equ  CAN_TDH0R_DATA6                     ,0x00FF0000         @<Data byte 6 */
.equ  CAN_TDH0R_DATA7                     ,0xFF000000         @<Data byte 7 */

@******************  Bit definition for CAN_TI1R register  *******************/
.equ  CAN_TI1R_TXRQ                       ,0x00000001         @<Transmit Mailbox Request */
.equ  CAN_TI1R_RTR                        ,0x00000002         @<Remote Transmission Request */
.equ  CAN_TI1R_IDE                        ,0x00000004         @<Identifier Extension */
.equ  CAN_TI1R_EXID                       ,0x001FFFF8         @<Extended Identifier */
.equ  CAN_TI1R_STID                       ,0xFFE00000         @<Standard Identifier or Extended Identifier */

@******************  Bit definition for CAN_TDT1R register  ******************/
.equ  CAN_TDT1R_DLC                       ,0x0000000F         @<Data Length Code */
.equ  CAN_TDT1R_TGT                       ,0x00000100         @<Transmit Global Time */
.equ  CAN_TDT1R_TIME                      ,0xFFFF0000         @<Message Time Stamp */

@******************  Bit definition for CAN_TDL1R register  ******************/
.equ  CAN_TDL1R_DATA0                     ,0x000000FF         @<Data byte 0 */
.equ  CAN_TDL1R_DATA1                     ,0x0000FF00         @<Data byte 1 */
.equ  CAN_TDL1R_DATA2                     ,0x00FF0000         @<Data byte 2 */
.equ  CAN_TDL1R_DATA3                     ,0xFF000000         @<Data byte 3 */

@******************  Bit definition for CAN_TDH1R register  ******************/
.equ  CAN_TDH1R_DATA4                     ,0x000000FF         @<Data byte 4 */
.equ  CAN_TDH1R_DATA5                     ,0x0000FF00         @<Data byte 5 */
.equ  CAN_TDH1R_DATA6                     ,0x00FF0000         @<Data byte 6 */
.equ  CAN_TDH1R_DATA7                     ,0xFF000000         @<Data byte 7 */

@******************  Bit definition for CAN_TI2R register  *******************/
.equ  CAN_TI2R_TXRQ                       ,0x00000001         @<Transmit Mailbox Request */
.equ  CAN_TI2R_RTR                        ,0x00000002         @<Remote Transmission Request */
.equ  CAN_TI2R_IDE                        ,0x00000004         @<Identifier Extension */
.equ  CAN_TI2R_EXID                       ,0x001FFFF8         @<Extended identifier */
.equ  CAN_TI2R_STID                       ,0xFFE00000         @<Standard Identifier or Extended Identifier */

@******************  Bit definition for CAN_TDT2R register  ******************/  
.equ  CAN_TDT2R_DLC                       ,0x0000000F         @<Data Length Code */
.equ  CAN_TDT2R_TGT                       ,0x00000100         @<Transmit Global Time */
.equ  CAN_TDT2R_TIME                      ,0xFFFF0000         @<Message Time Stamp */

@******************  Bit definition for CAN_TDL2R register  ******************/
.equ  CAN_TDL2R_DATA0                     ,0x000000FF         @<Data byte 0 */
.equ  CAN_TDL2R_DATA1                     ,0x0000FF00         @<Data byte 1 */
.equ  CAN_TDL2R_DATA2                     ,0x00FF0000         @<Data byte 2 */
.equ  CAN_TDL2R_DATA3                     ,0xFF000000         @<Data byte 3 */

@******************  Bit definition for CAN_TDH2R register  ******************/
.equ  CAN_TDH2R_DATA4                     ,0x000000FF         @<Data byte 4 */
.equ  CAN_TDH2R_DATA5                     ,0x0000FF00         @<Data byte 5 */
.equ  CAN_TDH2R_DATA6                     ,0x00FF0000         @<Data byte 6 */
.equ  CAN_TDH2R_DATA7                     ,0xFF000000         @<Data byte 7 */

@******************  Bit definition for CAN_RI0R register  *******************/
.equ  CAN_RI0R_RTR                        ,0x00000002         @<Remote Transmission Request */
.equ  CAN_RI0R_IDE                        ,0x00000004         @<Identifier Extension */
.equ  CAN_RI0R_EXID                       ,0x001FFFF8         @<Extended Identifier */
.equ  CAN_RI0R_STID                       ,0xFFE00000         @<Standard Identifier or Extended Identifier */

@******************  Bit definition for CAN_RDT0R register  ******************/
.equ  CAN_RDT0R_DLC                       ,0x0000000F         @<Data Length Code */
.equ  CAN_RDT0R_FMI                       ,0x0000FF00         @<Filter Match Index */
.equ  CAN_RDT0R_TIME                      ,0xFFFF0000         @<Message Time Stamp */

@******************  Bit definition for CAN_RDL0R register  ******************/
.equ  CAN_RDL0R_DATA0                     ,0x000000FF         @<Data byte 0 */
.equ  CAN_RDL0R_DATA1                     ,0x0000FF00         @<Data byte 1 */
.equ  CAN_RDL0R_DATA2                     ,0x00FF0000         @<Data byte 2 */
.equ  CAN_RDL0R_DATA3                     ,0xFF000000         @<Data byte 3 */

@******************  Bit definition for CAN_RDH0R register  ******************/
.equ  CAN_RDH0R_DATA4                     ,0x000000FF         @<Data byte 4 */
.equ  CAN_RDH0R_DATA5                     ,0x0000FF00         @<Data byte 5 */
.equ  CAN_RDH0R_DATA6                     ,0x00FF0000         @<Data byte 6 */
.equ  CAN_RDH0R_DATA7                     ,0xFF000000         @<Data byte 7 */

@******************  Bit definition for CAN_RI1R register  *******************/
.equ  CAN_RI1R_RTR                        ,0x00000002         @<Remote Transmission Request */
.equ  CAN_RI1R_IDE                        ,0x00000004         @<Identifier Extension */
.equ  CAN_RI1R_EXID                       ,0x001FFFF8         @<Extended identifier */
.equ  CAN_RI1R_STID                       ,0xFFE00000         @<Standard Identifier or Extended Identifier */

@******************  Bit definition for CAN_RDT1R register  ******************/
.equ  CAN_RDT1R_DLC                       ,0x0000000F         @<Data Length Code */
.equ  CAN_RDT1R_FMI                       ,0x0000FF00         @<Filter Match Index */
.equ  CAN_RDT1R_TIME                      ,0xFFFF0000         @<Message Time Stamp */

@******************  Bit definition for CAN_RDL1R register  ******************/
.equ  CAN_RDL1R_DATA0                     ,0x000000FF         @<Data byte 0 */
.equ  CAN_RDL1R_DATA1                     ,0x0000FF00         @<Data byte 1 */
.equ  CAN_RDL1R_DATA2                     ,0x00FF0000         @<Data byte 2 */
.equ  CAN_RDL1R_DATA3                     ,0xFF000000         @<Data byte 3 */

@******************  Bit definition for CAN_RDH1R register  ******************/
.equ  CAN_RDH1R_DATA4                     ,0x000000FF         @<Data byte 4 */
.equ  CAN_RDH1R_DATA5                     ,0x0000FF00         @<Data byte 5 */
.equ  CAN_RDH1R_DATA6                     ,0x00FF0000         @<Data byte 6 */
.equ  CAN_RDH1R_DATA7                     ,0xFF000000         @<Data byte 7 */

@<CAN filter registers */
@******************  Bit definition for CAN_FMR register  ********************/
.equ  CAN_FMR_FINIT                       ,0x01               @<Filter Init Mode */

@******************  Bit definition for CAN_FM1R register  *******************/
.equ  CAN_FM1R_FBM                        ,0x3FFF            @<Filter Mode */
.equ  CAN_FM1R_FBM0                       ,0x0001            @<Filter Init Mode bit 0 */
.equ  CAN_FM1R_FBM1                       ,0x0002            @<Filter Init Mode bit 1 */
.equ  CAN_FM1R_FBM2                       ,0x0004            @<Filter Init Mode bit 2 */
.equ  CAN_FM1R_FBM3                       ,0x0008            @<Filter Init Mode bit 3 */
.equ  CAN_FM1R_FBM4                       ,0x0010            @<Filter Init Mode bit 4 */
.equ  CAN_FM1R_FBM5                       ,0x0020            @<Filter Init Mode bit 5 */
.equ  CAN_FM1R_FBM6                       ,0x0040            @<Filter Init Mode bit 6 */
.equ  CAN_FM1R_FBM7                       ,0x0080            @<Filter Init Mode bit 7 */
.equ  CAN_FM1R_FBM8                       ,0x0100            @<Filter Init Mode bit 8 */
.equ  CAN_FM1R_FBM9                       ,0x0200            @<Filter Init Mode bit 9 */
.equ  CAN_FM1R_FBM10                      ,0x0400            @<Filter Init Mode bit 10 */
.equ  CAN_FM1R_FBM11                      ,0x0800            @<Filter Init Mode bit 11 */
.equ  CAN_FM1R_FBM12                      ,0x1000            @<Filter Init Mode bit 12 */
.equ  CAN_FM1R_FBM13                      ,0x2000            @<Filter Init Mode bit 13 */

@******************  Bit definition for CAN_FS1R register  *******************/
.equ  CAN_FS1R_FSC                        ,0x3FFF            @<Filter Scale Configuration */
.equ  CAN_FS1R_FSC0                       ,0x0001            @<Filter Scale Configuration bit 0 */
.equ  CAN_FS1R_FSC1                       ,0x0002            @<Filter Scale Configuration bit 1 */
.equ  CAN_FS1R_FSC2                       ,0x0004            @<Filter Scale Configuration bit 2 */
.equ  CAN_FS1R_FSC3                       ,0x0008            @<Filter Scale Configuration bit 3 */
.equ  CAN_FS1R_FSC4                       ,0x0010            @<Filter Scale Configuration bit 4 */
.equ  CAN_FS1R_FSC5                       ,0x0020            @<Filter Scale Configuration bit 5 */
.equ  CAN_FS1R_FSC6                       ,0x0040            @<Filter Scale Configuration bit 6 */
.equ  CAN_FS1R_FSC7                       ,0x0080            @<Filter Scale Configuration bit 7 */
.equ  CAN_FS1R_FSC8                       ,0x0100            @<Filter Scale Configuration bit 8 */
.equ  CAN_FS1R_FSC9                       ,0x0200            @<Filter Scale Configuration bit 9 */
.equ  CAN_FS1R_FSC10                      ,0x0400            @<Filter Scale Configuration bit 10 */
.equ  CAN_FS1R_FSC11                      ,0x0800            @<Filter Scale Configuration bit 11 */
.equ  CAN_FS1R_FSC12                      ,0x1000            @<Filter Scale Configuration bit 12 */
.equ  CAN_FS1R_FSC13                      ,0x2000            @<Filter Scale Configuration bit 13 */

@*****************  Bit definition for CAN_FFA1R register  *******************/
.equ  CAN_FFA1R_FFA                       ,0x3FFF            @<Filter FIFO Assignment */
.equ  CAN_FFA1R_FFA0                      ,0x0001            @<Filter FIFO Assignment for Filter 0 */
.equ  CAN_FFA1R_FFA1                      ,0x0002            @<Filter FIFO Assignment for Filter 1 */
.equ  CAN_FFA1R_FFA2                      ,0x0004            @<Filter FIFO Assignment for Filter 2 */
.equ  CAN_FFA1R_FFA3                      ,0x0008            @<Filter FIFO Assignment for Filter 3 */
.equ  CAN_FFA1R_FFA4                      ,0x0010            @<Filter FIFO Assignment for Filter 4 */
.equ  CAN_FFA1R_FFA5                      ,0x0020            @<Filter FIFO Assignment for Filter 5 */
.equ  CAN_FFA1R_FFA6                      ,0x0040            @<Filter FIFO Assignment for Filter 6 */
.equ  CAN_FFA1R_FFA7                      ,0x0080            @<Filter FIFO Assignment for Filter 7 */
.equ  CAN_FFA1R_FFA8                      ,0x0100            @<Filter FIFO Assignment for Filter 8 */
.equ  CAN_FFA1R_FFA9                      ,0x0200            @<Filter FIFO Assignment for Filter 9 */
.equ  CAN_FFA1R_FFA10                     ,0x0400            @<Filter FIFO Assignment for Filter 10 */
.equ  CAN_FFA1R_FFA11                     ,0x0800            @<Filter FIFO Assignment for Filter 11 */
.equ  CAN_FFA1R_FFA12                     ,0x1000            @<Filter FIFO Assignment for Filter 12 */
.equ  CAN_FFA1R_FFA13                     ,0x2000            @<Filter FIFO Assignment for Filter 13 */

@******************  Bit definition for CAN_FA1R register  *******************/
.equ  CAN_FA1R_FACT                       ,0x3FFF            @<Filter Active */
.equ  CAN_FA1R_FACT0                      ,0x0001            @<Filter 0 Active */
.equ  CAN_FA1R_FACT1                      ,0x0002            @<Filter 1 Active */
.equ  CAN_FA1R_FACT2                      ,0x0004            @<Filter 2 Active */
.equ  CAN_FA1R_FACT3                      ,0x0008            @<Filter 3 Active */
.equ  CAN_FA1R_FACT4                      ,0x0010            @<Filter 4 Active */
.equ  CAN_FA1R_FACT5                      ,0x0020            @<Filter 5 Active */
.equ  CAN_FA1R_FACT6                      ,0x0040            @<Filter 6 Active */
.equ  CAN_FA1R_FACT7                      ,0x0080            @<Filter 7 Active */
.equ  CAN_FA1R_FACT8                      ,0x0100            @<Filter 8 Active */
.equ  CAN_FA1R_FACT9                      ,0x0200            @<Filter 9 Active */
.equ  CAN_FA1R_FACT10                     ,0x0400            @<Filter 10 Active */
.equ  CAN_FA1R_FACT11                     ,0x0800            @<Filter 11 Active */
.equ  CAN_FA1R_FACT12                     ,0x1000            @<Filter 12 Active */
.equ  CAN_FA1R_FACT13                     ,0x2000            @<Filter 13 Active */

@******************  Bit definition for CAN_F0R1 register  *******************/
.equ  CAN_F0R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F0R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F0R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F0R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F0R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F0R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F0R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F0R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F0R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F0R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F0R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F0R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F0R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F0R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F0R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F0R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F0R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F0R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F0R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F0R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F0R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F0R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F0R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F0R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F0R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F0R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F0R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F0R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F0R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F0R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F0R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F0R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F1R1 register  *******************/
.equ  CAN_F1R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F1R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F1R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F1R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F1R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F1R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F1R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F1R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F1R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F1R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F1R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F1R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F1R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F1R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F1R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F1R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F1R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F1R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F1R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F1R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F1R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F1R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F1R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F1R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F1R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F1R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F1R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F1R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F1R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F1R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F1R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F1R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F2R1 register  *******************/
.equ  CAN_F2R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F2R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F2R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F2R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F2R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F2R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F2R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F2R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F2R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F2R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F2R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F2R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F2R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F2R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F2R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F2R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F2R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F2R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F2R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F2R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F2R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F2R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F2R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F2R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F2R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F2R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F2R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F2R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F2R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F2R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F2R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F2R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F3R1 register  *******************/
.equ  CAN_F3R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F3R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F3R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F3R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F3R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F3R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F3R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F3R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F3R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F3R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F3R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F3R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F3R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F3R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F3R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F3R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F3R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F3R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F3R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F3R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F3R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F3R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F3R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F3R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F3R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F3R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F3R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F3R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F3R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F3R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F3R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F3R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F4R1 register  *******************/
.equ  CAN_F4R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F4R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F4R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F4R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F4R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F4R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F4R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F4R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F4R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F4R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F4R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F4R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F4R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F4R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F4R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F4R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F4R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F4R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F4R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F4R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F4R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F4R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F4R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F4R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F4R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F4R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F4R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F4R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F4R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F4R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F4R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F4R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F5R1 register  *******************/
.equ  CAN_F5R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F5R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F5R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F5R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F5R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F5R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F5R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F5R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F5R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F5R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F5R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F5R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F5R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F5R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F5R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F5R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F5R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F5R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F5R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F5R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F5R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F5R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F5R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F5R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F5R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F5R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F5R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F5R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F5R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F5R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F5R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F5R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F6R1 register  *******************/
.equ  CAN_F6R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F6R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F6R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F6R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F6R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F6R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F6R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F6R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F6R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F6R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F6R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F6R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F6R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F6R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F6R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F6R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F6R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F6R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F6R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F6R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F6R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F6R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F6R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F6R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F6R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F6R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F6R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F6R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F6R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F6R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F6R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F6R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F7R1 register  *******************/
.equ  CAN_F7R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F7R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F7R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F7R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F7R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F7R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F7R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F7R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F7R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F7R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F7R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F7R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F7R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F7R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F7R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F7R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F7R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F7R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F7R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F7R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F7R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F7R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F7R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F7R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F7R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F7R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F7R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F7R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F7R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F7R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F7R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F7R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F8R1 register  *******************/
.equ  CAN_F8R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F8R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F8R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F8R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F8R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F8R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F8R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F8R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F8R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F8R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F8R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F8R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F8R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F8R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F8R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F8R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F8R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F8R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F8R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F8R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F8R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F8R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F8R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F8R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F8R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F8R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F8R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F8R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F8R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F8R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F8R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F8R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F9R1 register  *******************/
.equ  CAN_F9R1_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F9R1_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F9R1_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F9R1_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F9R1_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F9R1_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F9R1_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F9R1_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F9R1_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F9R1_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F9R1_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F9R1_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F9R1_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F9R1_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F9R1_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F9R1_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F9R1_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F9R1_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F9R1_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F9R1_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F9R1_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F9R1_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F9R1_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F9R1_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F9R1_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F9R1_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F9R1_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F9R1_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F9R1_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F9R1_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F9R1_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F9R1_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F10R1 register  ******************/
.equ  CAN_F10R1_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F10R1_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F10R1_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F10R1_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F10R1_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F10R1_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F10R1_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F10R1_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F10R1_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F10R1_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F10R1_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F10R1_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F10R1_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F10R1_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F10R1_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F10R1_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F10R1_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F10R1_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F10R1_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F10R1_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F10R1_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F10R1_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F10R1_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F10R1_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F10R1_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F10R1_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F10R1_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F10R1_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F10R1_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F10R1_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F10R1_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F10R1_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F11R1 register  ******************/
.equ  CAN_F11R1_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F11R1_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F11R1_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F11R1_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F11R1_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F11R1_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F11R1_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F11R1_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F11R1_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F11R1_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F11R1_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F11R1_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F11R1_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F11R1_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F11R1_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F11R1_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F11R1_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F11R1_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F11R1_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F11R1_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F11R1_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F11R1_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F11R1_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F11R1_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F11R1_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F11R1_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F11R1_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F11R1_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F11R1_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F11R1_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F11R1_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F11R1_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F12R1 register  ******************/
.equ  CAN_F12R1_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F12R1_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F12R1_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F12R1_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F12R1_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F12R1_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F12R1_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F12R1_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F12R1_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F12R1_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F12R1_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F12R1_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F12R1_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F12R1_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F12R1_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F12R1_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F12R1_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F12R1_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F12R1_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F12R1_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F12R1_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F12R1_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F12R1_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F12R1_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F12R1_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F12R1_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F12R1_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F12R1_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F12R1_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F12R1_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F12R1_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F12R1_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F13R1 register  ******************/
.equ  CAN_F13R1_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F13R1_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F13R1_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F13R1_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F13R1_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F13R1_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F13R1_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F13R1_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F13R1_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F13R1_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F13R1_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F13R1_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F13R1_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F13R1_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F13R1_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F13R1_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F13R1_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F13R1_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F13R1_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F13R1_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F13R1_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F13R1_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F13R1_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F13R1_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F13R1_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F13R1_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F13R1_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F13R1_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F13R1_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F13R1_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F13R1_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F13R1_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F0R2 register  *******************/
.equ  CAN_F0R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F0R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F0R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F0R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F0R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F0R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F0R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F0R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F0R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F0R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F0R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F0R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F0R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F0R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F0R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F0R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F0R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F0R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F0R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F0R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F0R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F0R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F0R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F0R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F0R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F0R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F0R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F0R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F0R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F0R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F0R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F0R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F1R2 register  *******************/
.equ  CAN_F1R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F1R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F1R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F1R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F1R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F1R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F1R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F1R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F1R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F1R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F1R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F1R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F1R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F1R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F1R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F1R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F1R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F1R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F1R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F1R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F1R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F1R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F1R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F1R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F1R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F1R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F1R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F1R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F1R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F1R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F1R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F1R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F2R2 register  *******************/
.equ  CAN_F2R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F2R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F2R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F2R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F2R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F2R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F2R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F2R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F2R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F2R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F2R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F2R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F2R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F2R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F2R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F2R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F2R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F2R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F2R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F2R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F2R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F2R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F2R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F2R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F2R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F2R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F2R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F2R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F2R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F2R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F2R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F2R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F3R2 register  *******************/
.equ  CAN_F3R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F3R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F3R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F3R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F3R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F3R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F3R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F3R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F3R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F3R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F3R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F3R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F3R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F3R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F3R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F3R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F3R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F3R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F3R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F3R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F3R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F3R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F3R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F3R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F3R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F3R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F3R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F3R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F3R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F3R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F3R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F3R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F4R2 register  *******************/
.equ  CAN_F4R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F4R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F4R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F4R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F4R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F4R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F4R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F4R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F4R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F4R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F4R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F4R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F4R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F4R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F4R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F4R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F4R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F4R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F4R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F4R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F4R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F4R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F4R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F4R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F4R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F4R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F4R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F4R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F4R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F4R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F4R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F4R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F5R2 register  *******************/
.equ  CAN_F5R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F5R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F5R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F5R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F5R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F5R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F5R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F5R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F5R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F5R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F5R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F5R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F5R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F5R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F5R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F5R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F5R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F5R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F5R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F5R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F5R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F5R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F5R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F5R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F5R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F5R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F5R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F5R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F5R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F5R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F5R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F5R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F6R2 register  *******************/
.equ  CAN_F6R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F6R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F6R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F6R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F6R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F6R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F6R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F6R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F6R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F6R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F6R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F6R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F6R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F6R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F6R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F6R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F6R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F6R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F6R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F6R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F6R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F6R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F6R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F6R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F6R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F6R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F6R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F6R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F6R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F6R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F6R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F6R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F7R2 register  *******************/
.equ  CAN_F7R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F7R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F7R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F7R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F7R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F7R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F7R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F7R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F7R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F7R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F7R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F7R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F7R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F7R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F7R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F7R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F7R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F7R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F7R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F7R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F7R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F7R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F7R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F7R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F7R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F7R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F7R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F7R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F7R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F7R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F7R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F7R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F8R2 register  *******************/
.equ  CAN_F8R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F8R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F8R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F8R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F8R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F8R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F8R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F8R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F8R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F8R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F8R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F8R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F8R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F8R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F8R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F8R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F8R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F8R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F8R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F8R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F8R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F8R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F8R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F8R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F8R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F8R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F8R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F8R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F8R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F8R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F8R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F8R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F9R2 register  *******************/
.equ  CAN_F9R2_FB0                        ,0x00000001         @<Filter bit 0 */
.equ  CAN_F9R2_FB1                        ,0x00000002         @<Filter bit 1 */
.equ  CAN_F9R2_FB2                        ,0x00000004         @<Filter bit 2 */
.equ  CAN_F9R2_FB3                        ,0x00000008         @<Filter bit 3 */
.equ  CAN_F9R2_FB4                        ,0x00000010         @<Filter bit 4 */
.equ  CAN_F9R2_FB5                        ,0x00000020         @<Filter bit 5 */
.equ  CAN_F9R2_FB6                        ,0x00000040         @<Filter bit 6 */
.equ  CAN_F9R2_FB7                        ,0x00000080         @<Filter bit 7 */
.equ  CAN_F9R2_FB8                        ,0x00000100         @<Filter bit 8 */
.equ  CAN_F9R2_FB9                        ,0x00000200         @<Filter bit 9 */
.equ  CAN_F9R2_FB10                       ,0x00000400         @<Filter bit 10 */
.equ  CAN_F9R2_FB11                       ,0x00000800         @<Filter bit 11 */
.equ  CAN_F9R2_FB12                       ,0x00001000         @<Filter bit 12 */
.equ  CAN_F9R2_FB13                       ,0x00002000         @<Filter bit 13 */
.equ  CAN_F9R2_FB14                       ,0x00004000         @<Filter bit 14 */
.equ  CAN_F9R2_FB15                       ,0x00008000         @<Filter bit 15 */
.equ  CAN_F9R2_FB16                       ,0x00010000         @<Filter bit 16 */
.equ  CAN_F9R2_FB17                       ,0x00020000         @<Filter bit 17 */
.equ  CAN_F9R2_FB18                       ,0x00040000         @<Filter bit 18 */
.equ  CAN_F9R2_FB19                       ,0x00080000         @<Filter bit 19 */
.equ  CAN_F9R2_FB20                       ,0x00100000         @<Filter bit 20 */
.equ  CAN_F9R2_FB21                       ,0x00200000         @<Filter bit 21 */
.equ  CAN_F9R2_FB22                       ,0x00400000         @<Filter bit 22 */
.equ  CAN_F9R2_FB23                       ,0x00800000         @<Filter bit 23 */
.equ  CAN_F9R2_FB24                       ,0x01000000         @<Filter bit 24 */
.equ  CAN_F9R2_FB25                       ,0x02000000         @<Filter bit 25 */
.equ  CAN_F9R2_FB26                       ,0x04000000         @<Filter bit 26 */
.equ  CAN_F9R2_FB27                       ,0x08000000         @<Filter bit 27 */
.equ  CAN_F9R2_FB28                       ,0x10000000         @<Filter bit 28 */
.equ  CAN_F9R2_FB29                       ,0x20000000         @<Filter bit 29 */
.equ  CAN_F9R2_FB30                       ,0x40000000         @<Filter bit 30 */
.equ  CAN_F9R2_FB31                       ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F10R2 register  ******************/
.equ  CAN_F10R2_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F10R2_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F10R2_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F10R2_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F10R2_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F10R2_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F10R2_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F10R2_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F10R2_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F10R2_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F10R2_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F10R2_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F10R2_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F10R2_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F10R2_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F10R2_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F10R2_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F10R2_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F10R2_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F10R2_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F10R2_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F10R2_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F10R2_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F10R2_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F10R2_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F10R2_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F10R2_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F10R2_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F10R2_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F10R2_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F10R2_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F10R2_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F11R2 register  ******************/
.equ  CAN_F11R2_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F11R2_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F11R2_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F11R2_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F11R2_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F11R2_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F11R2_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F11R2_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F11R2_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F11R2_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F11R2_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F11R2_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F11R2_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F11R2_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F11R2_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F11R2_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F11R2_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F11R2_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F11R2_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F11R2_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F11R2_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F11R2_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F11R2_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F11R2_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F11R2_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F11R2_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F11R2_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F11R2_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F11R2_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F11R2_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F11R2_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F11R2_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F12R2 register  ******************/
.equ  CAN_F12R2_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F12R2_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F12R2_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F12R2_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F12R2_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F12R2_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F12R2_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F12R2_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F12R2_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F12R2_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F12R2_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F12R2_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F12R2_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F12R2_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F12R2_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F12R2_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F12R2_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F12R2_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F12R2_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F12R2_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F12R2_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F12R2_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F12R2_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F12R2_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F12R2_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F12R2_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F12R2_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F12R2_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F12R2_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F12R2_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F12R2_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F12R2_FB31                      ,0x80000000         @<Filter bit 31 */

@******************  Bit definition for CAN_F13R2 register  ******************/
.equ  CAN_F13R2_FB0                       ,0x00000001         @<Filter bit 0 */
.equ  CAN_F13R2_FB1                       ,0x00000002         @<Filter bit 1 */
.equ  CAN_F13R2_FB2                       ,0x00000004         @<Filter bit 2 */
.equ  CAN_F13R2_FB3                       ,0x00000008         @<Filter bit 3 */
.equ  CAN_F13R2_FB4                       ,0x00000010         @<Filter bit 4 */
.equ  CAN_F13R2_FB5                       ,0x00000020         @<Filter bit 5 */
.equ  CAN_F13R2_FB6                       ,0x00000040         @<Filter bit 6 */
.equ  CAN_F13R2_FB7                       ,0x00000080         @<Filter bit 7 */
.equ  CAN_F13R2_FB8                       ,0x00000100         @<Filter bit 8 */
.equ  CAN_F13R2_FB9                       ,0x00000200         @<Filter bit 9 */
.equ  CAN_F13R2_FB10                      ,0x00000400         @<Filter bit 10 */
.equ  CAN_F13R2_FB11                      ,0x00000800         @<Filter bit 11 */
.equ  CAN_F13R2_FB12                      ,0x00001000         @<Filter bit 12 */
.equ  CAN_F13R2_FB13                      ,0x00002000         @<Filter bit 13 */
.equ  CAN_F13R2_FB14                      ,0x00004000         @<Filter bit 14 */
.equ  CAN_F13R2_FB15                      ,0x00008000         @<Filter bit 15 */
.equ  CAN_F13R2_FB16                      ,0x00010000         @<Filter bit 16 */
.equ  CAN_F13R2_FB17                      ,0x00020000         @<Filter bit 17 */
.equ  CAN_F13R2_FB18                      ,0x00040000         @<Filter bit 18 */
.equ  CAN_F13R2_FB19                      ,0x00080000         @<Filter bit 19 */
.equ  CAN_F13R2_FB20                      ,0x00100000         @<Filter bit 20 */
.equ  CAN_F13R2_FB21                      ,0x00200000         @<Filter bit 21 */
.equ  CAN_F13R2_FB22                      ,0x00400000         @<Filter bit 22 */
.equ  CAN_F13R2_FB23                      ,0x00800000         @<Filter bit 23 */
.equ  CAN_F13R2_FB24                      ,0x01000000         @<Filter bit 24 */
.equ  CAN_F13R2_FB25                      ,0x02000000         @<Filter bit 25 */
.equ  CAN_F13R2_FB26                      ,0x04000000         @<Filter bit 26 */
.equ  CAN_F13R2_FB27                      ,0x08000000         @<Filter bit 27 */
.equ  CAN_F13R2_FB28                      ,0x10000000         @<Filter bit 28 */
.equ  CAN_F13R2_FB29                      ,0x20000000         @<Filter bit 29 */
.equ  CAN_F13R2_FB30                      ,0x40000000         @<Filter bit 30 */
.equ  CAN_F13R2_FB31                      ,0x80000000         @<Filter bit 31 */

@*****************************************************************************/
@                                                                            */
@                          CRC calculation unit                              */
@                                                                            */
@*****************************************************************************/
@******************  Bit definition for CRC_DR register  *********************/
.equ  CRC_DR_DR                           ,0xFFFFFFFF @< Data register bits */


@******************  Bit definition for CRC_IDR register  ********************/
.equ  CRC_IDR_IDR                         ,0xFF         @< General-purpose 8-bit data register bits */


@*******************  Bit definition for CRC_CR register  ********************/
.equ  CRC_CR_RESET                        ,0x01         @< RESET bit */

@*****************************************************************************/
@                                                                            */
@                            Crypto Processor                                */
@                                                                            */
@*****************************************************************************/
@****************** Bits definition for CRYP_CR register  ********************/
.equ CRYP_CR_ALGODIR                      ,0x00000004 

.equ CRYP_CR_ALGOMODE                     ,0x00000038 
.equ CRYP_CR_ALGOMODE_0                   ,0x00000008 
.equ CRYP_CR_ALGOMODE_1                   ,0x00000010 
.equ CRYP_CR_ALGOMODE_2                   ,0x00000020 
.equ CRYP_CR_ALGOMODE_TDES_ECB            ,0x00000000 
.equ CRYP_CR_ALGOMODE_TDES_CBC            ,0x00000008 
.equ CRYP_CR_ALGOMODE_DES_ECB             ,0x00000010 
.equ CRYP_CR_ALGOMODE_DES_CBC             ,0x00000018 
.equ CRYP_CR_ALGOMODE_AES_ECB             ,0x00000020 
.equ CRYP_CR_ALGOMODE_AES_CBC             ,0x00000028 
.equ CRYP_CR_ALGOMODE_AES_CTR             ,0x00000030 
.equ CRYP_CR_ALGOMODE_AES_KEY             ,0x00000038 

.equ CRYP_CR_DATATYPE                     ,0x000000C0 
.equ CRYP_CR_DATATYPE_0                   ,0x00000040 
.equ CRYP_CR_DATATYPE_1                   ,0x00000080 
.equ CRYP_CR_KEYSIZE                      ,0x00000300 
.equ CRYP_CR_KEYSIZE_0                    ,0x00000100 
.equ CRYP_CR_KEYSIZE_1                    ,0x00000200 
.equ CRYP_CR_FFLUSH                       ,0x00004000 
.equ CRYP_CR_CRYPEN                       ,0x00008000 
@***************** Bits definition for CRYP_SR register  *********************/
.equ CRYP_SR_IFEM                         ,0x00000001 
.equ CRYP_SR_IFNF                         ,0x00000002 
.equ CRYP_SR_OFNE                         ,0x00000004 
.equ CRYP_SR_OFFU                         ,0x00000008 
.equ CRYP_SR_BUSY                         ,0x00000010 
@***************** Bits definition for CRYP_DMACR register  ******************/
.equ CRYP_DMACR_DIEN                      ,0x00000001 
.equ CRYP_DMACR_DOEN                      ,0x00000002 
@****************  Bits definition for CRYP_IMSCR register  ******************/
.equ CRYP_IMSCR_INIM                      ,0x00000001 
.equ CRYP_IMSCR_OUTIM                     ,0x00000002 
@***************** Bits definition for CRYP_RISR register  *******************/
.equ CRYP_RISR_OUTRIS                     ,0x00000001 
.equ CRYP_RISR_INRIS                      ,0x00000002 
@***************** Bits definition for CRYP_MISR register  *******************/
.equ CRYP_MISR_INMIS                      ,0x00000001 
.equ CRYP_MISR_OUTMIS                     ,0x00000002 

@*****************************************************************************/
@                                                                            */
@                      Digital to Analog Converter                           */
@                                                                            */
@*****************************************************************************/
@*******************  Bit definition for DAC_CR register  ********************/
.equ  DAC_CR_EN1                          ,0x00000001         @<DAC channel1 enable */
.equ  DAC_CR_BOFF1                        ,0x00000002         @<DAC channel1 output buffer disable */
.equ  DAC_CR_TEN1                         ,0x00000004         @<DAC channel1 Trigger enable */

.equ  DAC_CR_TSEL1                        ,0x00000038         @<TSEL1[2:0] (DAC channel1 Trigger selection) */
.equ  DAC_CR_TSEL1_0                      ,0x00000008         @<Bit 0 */
.equ  DAC_CR_TSEL1_1                      ,0x00000010         @<Bit 1 */
.equ  DAC_CR_TSEL1_2                      ,0x00000020         @<Bit 2 */

.equ  DAC_CR_WAVE1                        ,0x000000C0         @<WAVE1[1:0] (DAC channel1 noise/triangle wave generation enable) */
.equ  DAC_CR_WAVE1_0                      ,0x00000040         @<Bit 0 */
.equ  DAC_CR_WAVE1_1                      ,0x00000080         @<Bit 1 */

.equ  DAC_CR_MAMP1                        ,0x00000F00         @<MAMP1[3:0] (DAC channel1 Mask/Amplitude selector) */
.equ  DAC_CR_MAMP1_0                      ,0x00000100         @<Bit 0 */
.equ  DAC_CR_MAMP1_1                      ,0x00000200         @<Bit 1 */
.equ  DAC_CR_MAMP1_2                      ,0x00000400         @<Bit 2 */
.equ  DAC_CR_MAMP1_3                      ,0x00000800         @<Bit 3 */

.equ  DAC_CR_DMAEN1                       ,0x00001000         @<DAC channel1 DMA enable */
.equ  DAC_CR_EN2                          ,0x00010000         @<DAC channel2 enable */
.equ  DAC_CR_BOFF2                        ,0x00020000         @<DAC channel2 output buffer disable */
.equ  DAC_CR_TEN2                         ,0x00040000         @<DAC channel2 Trigger enable */

.equ  DAC_CR_TSEL2                        ,0x00380000         @<TSEL2[2:0] (DAC channel2 Trigger selection) */
.equ  DAC_CR_TSEL2_0                      ,0x00080000         @<Bit 0 */
.equ  DAC_CR_TSEL2_1                      ,0x00100000         @<Bit 1 */
.equ  DAC_CR_TSEL2_2                      ,0x00200000         @<Bit 2 */

.equ  DAC_CR_WAVE2                        ,0x00C00000         @<WAVE2[1:0] (DAC channel2 noise/triangle wave generation enable) */
.equ  DAC_CR_WAVE2_0                      ,0x00400000         @<Bit 0 */
.equ  DAC_CR_WAVE2_1                      ,0x00800000         @<Bit 1 */

.equ  DAC_CR_MAMP2                        ,0x0F000000         @<MAMP2[3:0] (DAC channel2 Mask/Amplitude selector) */
.equ  DAC_CR_MAMP2_0                      ,0x01000000         @<Bit 0 */
.equ  DAC_CR_MAMP2_1                      ,0x02000000         @<Bit 1 */
.equ  DAC_CR_MAMP2_2                      ,0x04000000         @<Bit 2 */
.equ  DAC_CR_MAMP2_3                      ,0x08000000         @<Bit 3 */

.equ  DAC_CR_DMAEN2                       ,0x10000000         @<DAC channel2 DMA enabled */

@****************  Bit definition for DAC_SWTRIGR register  ******************/
.equ  DAC_SWTRIGR_SWTRIG1                 ,0x01               @<DAC channel1 software trigger */
.equ  DAC_SWTRIGR_SWTRIG2                 ,0x02               @<DAC channel2 software trigger */

@****************  Bit definition for DAC_DHR12R1 register  ******************/
.equ  DAC_DHR12R1_DACC1DHR                ,0x0FFF            @<DAC channel1 12-bit Right aligned data */

@****************  Bit definition for DAC_DHR12L1 register  ******************/
.equ  DAC_DHR12L1_DACC1DHR                ,0xFFF0            @<DAC channel1 12-bit Left aligned data */

@*****************  Bit definition for DAC_DHR8R1 register  ******************/
.equ  DAC_DHR8R1_DACC1DHR                 ,0xFF               @<DAC channel1 8-bit Right aligned data */

@****************  Bit definition for DAC_DHR12R2 register  ******************/
.equ  DAC_DHR12R2_DACC2DHR                ,0x0FFF            @<DAC channel2 12-bit Right aligned data */

@****************  Bit definition for DAC_DHR12L2 register  ******************/
.equ  DAC_DHR12L2_DACC2DHR                ,0xFFF0            @<DAC channel2 12-bit Left aligned data */

@*****************  Bit definition for DAC_DHR8R2 register  ******************/
.equ  DAC_DHR8R2_DACC2DHR                 ,0xFF               @<DAC channel2 8-bit Right aligned data */

@****************  Bit definition for DAC_DHR12RD register  ******************/
.equ  DAC_DHR12RD_DACC1DHR                ,0x00000FFF         @<DAC channel1 12-bit Right aligned data */
.equ  DAC_DHR12RD_DACC2DHR                ,0x0FFF0000         @<DAC channel2 12-bit Right aligned data */

@****************  Bit definition for DAC_DHR12LD register  ******************/
.equ  DAC_DHR12LD_DACC1DHR                ,0x0000FFF0         @<DAC channel1 12-bit Left aligned data */
.equ  DAC_DHR12LD_DACC2DHR                ,0xFFF00000         @<DAC channel2 12-bit Left aligned data */

@*****************  Bit definition for DAC_DHR8RD register  ******************/
.equ  DAC_DHR8RD_DACC1DHR                 ,0x00FF            @<DAC channel1 8-bit Right aligned data */
.equ  DAC_DHR8RD_DACC2DHR                 ,0xFF00            @<DAC channel2 8-bit Right aligned data */

@******************  Bit definition for DAC_DOR1 register  *******************/
.equ  DAC_DOR1_DACC1DOR                   ,0x0FFF            @<DAC channel1 data output */

@******************  Bit definition for DAC_DOR2 register  *******************/
.equ  DAC_DOR2_DACC2DOR                   ,0x0FFF            @<DAC channel2 data output */

@*******************  Bit definition for DAC_SR register  ********************/
.equ  DAC_SR_DMAUDR1                      ,0x00002000         @<DAC channel1 DMA underrun flag */
.equ  DAC_SR_DMAUDR2                      ,0x20000000         @<DAC channel2 DMA underrun flag */

@*****************************************************************************/
@                                                                            */
@                                 Debug MCU                                  */
@                                                                            */
@*****************************************************************************/

@*****************************************************************************/
@                                                                            */
@                                    DCMI                                    */
@                                                                            */
@*****************************************************************************/
@*******************  Bits definition for DCMI_CR register  ******************/
.equ DCMI_CR_CAPTURE                      ,0x00000001 
.equ DCMI_CR_CM                           ,0x00000002 
.equ DCMI_CR_CROP                         ,0x00000004 
.equ DCMI_CR_JPEG                         ,0x00000008 
.equ DCMI_CR_ESS                          ,0x00000010 
.equ DCMI_CR_PCKPOL                       ,0x00000020 
.equ DCMI_CR_HSPOL                        ,0x00000040 
.equ DCMI_CR_VSPOL                        ,0x00000080 
.equ DCMI_CR_FCRC_0                       ,0x00000100 
.equ DCMI_CR_FCRC_1                       ,0x00000200 
.equ DCMI_CR_EDM_0                        ,0x00000400 
.equ DCMI_CR_EDM_1                        ,0x00000800 
.equ DCMI_CR_CRE                          ,0x00001000 
.equ DCMI_CR_ENABLE                       ,0x00004000 

@*******************  Bits definition for DCMI_SR register  ******************/
.equ DCMI_SR_HSYNC                        ,0x00000001 
.equ DCMI_SR_VSYNC                        ,0x00000002 
.equ DCMI_SR_FNE                          ,0x00000004 

@*******************  Bits definition for DCMI_RISR register  ****************/
.equ DCMI_RISR_FRAME_RIS                  ,0x00000001 
.equ DCMI_RISR_OVF_RIS                    ,0x00000002 
.equ DCMI_RISR_ERR_RIS                    ,0x00000004 
.equ DCMI_RISR_VSYNC_RIS                  ,0x00000008 
.equ DCMI_RISR_LINE_RIS                   ,0x00000010 

@*******************  Bits definition for DCMI_IER register  *****************/
.equ DCMI_IER_FRAME_IE                    ,0x00000001 
.equ DCMI_IER_OVF_IE                      ,0x00000002 
.equ DCMI_IER_ERR_IE                      ,0x00000004 
.equ DCMI_IER_VSYNC_IE                    ,0x00000008 
.equ DCMI_IER_LINE_IE                     ,0x00000010 

@*******************  Bits definition for DCMI_MISR register  ****************/
.equ DCMI_MISR_FRAME_MIS                  ,0x00000001 
.equ DCMI_MISR_OVF_MIS                    ,0x00000002 
.equ DCMI_MISR_ERR_MIS                    ,0x00000004 
.equ DCMI_MISR_VSYNC_MIS                  ,0x00000008 
.equ DCMI_MISR_LINE_MIS                   ,0x00000010 

@*******************  Bits definition for DCMI_ICR register  *****************/
.equ DCMI_ICR_FRAME_ISC                   ,0x00000001 
.equ DCMI_ICR_OVF_ISC                     ,0x00000002 
.equ DCMI_ICR_ERR_ISC                     ,0x00000004 
.equ DCMI_ICR_VSYNC_ISC                   ,0x00000008 
.equ DCMI_ICR_LINE_ISC                    ,0x00000010 

@*****************************************************************************/
@                                                                            */
@                             DMA Controller                                 */
@                                                                            */
@*****************************************************************************/
@*******************  Bits definition for DMA_SxCR register  *****************/ 
.equ DMA_SxCR_CHSEL                       ,0x0E000000 
.equ DMA_SxCR_CHSEL_0                     ,0x02000000 
.equ DMA_SxCR_CHSEL_1                     ,0x04000000 
.equ DMA_SxCR_CHSEL_2                     ,0x08000000  
.equ DMA_SxCR_MBURST                      ,0x01800000 
.equ DMA_SxCR_MBURST_0                    ,0x00800000 
.equ DMA_SxCR_MBURST_1                    ,0x01000000 
.equ DMA_SxCR_PBURST                      ,0x00600000 
.equ DMA_SxCR_PBURST_0                    ,0x00200000 
.equ DMA_SxCR_PBURST_1                    ,0x00400000 
.equ DMA_SxCR_ACK                         ,0x00100000 
.equ DMA_SxCR_CT                          ,0x00080000   
.equ DMA_SxCR_DBM                         ,0x00040000 
.equ DMA_SxCR_PL                          ,0x00030000 
.equ DMA_SxCR_PL_0                        ,0x00010000 
.equ DMA_SxCR_PL_1                        ,0x00020000 
.equ DMA_SxCR_PINCOS                      ,0x00008000 
.equ DMA_SxCR_MSIZE                       ,0x00006000 
.equ DMA_SxCR_MSIZE_0                     ,0x00002000 
.equ DMA_SxCR_MSIZE_1                     ,0x00004000 
.equ DMA_SxCR_PSIZE                       ,0x00001800 
.equ DMA_SxCR_PSIZE_0                     ,0x00000800 
.equ DMA_SxCR_PSIZE_1                     ,0x00001000 
.equ DMA_SxCR_MINC                        ,0x00000400 
.equ DMA_SxCR_PINC                        ,0x00000200 
.equ DMA_SxCR_CIRC                        ,0x00000100 
.equ DMA_SxCR_DIR                         ,0x000000C0 
.equ DMA_SxCR_DIR_0                       ,0x00000040 
.equ DMA_SxCR_DIR_1                       ,0x00000080 
.equ DMA_SxCR_PFCTRL                      ,0x00000020 
.equ DMA_SxCR_TCIE                        ,0x00000010 
.equ DMA_SxCR_HTIE                        ,0x00000008 
.equ DMA_SxCR_TEIE                        ,0x00000004 
.equ DMA_SxCR_DMEIE                       ,0x00000002 
.equ DMA_SxCR_EN                          ,0x00000001 

@*******************  Bits definition for DMA_SxCNDTR register  **************/
.equ DMA_SxNDT                            ,0x0000FFFF 
.equ DMA_SxNDT_0                          ,0x00000001 
.equ DMA_SxNDT_1                          ,0x00000002 
.equ DMA_SxNDT_2                          ,0x00000004 
.equ DMA_SxNDT_3                          ,0x00000008 
.equ DMA_SxNDT_4                          ,0x00000010 
.equ DMA_SxNDT_5                          ,0x00000020 
.equ DMA_SxNDT_6                          ,0x00000040 
.equ DMA_SxNDT_7                          ,0x00000080 
.equ DMA_SxNDT_8                          ,0x00000100 
.equ DMA_SxNDT_9                          ,0x00000200 
.equ DMA_SxNDT_10                         ,0x00000400 
.equ DMA_SxNDT_11                         ,0x00000800 
.equ DMA_SxNDT_12                         ,0x00001000 
.equ DMA_SxNDT_13                         ,0x00002000 
.equ DMA_SxNDT_14                         ,0x00004000 
.equ DMA_SxNDT_15                         ,0x00008000 

@*******************  Bits definition for DMA_SxFCR register  ****************/ 
.equ DMA_SxFCR_FEIE                       ,0x00000080 
.equ DMA_SxFCR_FS                         ,0x00000038 
.equ DMA_SxFCR_FS_0                       ,0x00000008 
.equ DMA_SxFCR_FS_1                       ,0x00000010 
.equ DMA_SxFCR_FS_2                       ,0x00000020 
.equ DMA_SxFCR_DMDIS                      ,0x00000004 
.equ DMA_SxFCR_FTH                        ,0x00000003 
.equ DMA_SxFCR_FTH_0                      ,0x00000001 
.equ DMA_SxFCR_FTH_1                      ,0x00000002 

@*******************  Bits definition for DMA_LISR register  *****************/ 
.equ DMA_LISR_TCIF3                       ,0x08000000 
.equ DMA_LISR_HTIF3                       ,0x04000000 
.equ DMA_LISR_TEIF3                       ,0x02000000 
.equ DMA_LISR_DMEIF3                      ,0x01000000 
.equ DMA_LISR_FEIF3                       ,0x00400000 
.equ DMA_LISR_TCIF2                       ,0x00200000 
.equ DMA_LISR_HTIF2                       ,0x00100000 
.equ DMA_LISR_TEIF2                       ,0x00080000 
.equ DMA_LISR_DMEIF2                      ,0x00040000 
.equ DMA_LISR_FEIF2                       ,0x00010000 
.equ DMA_LISR_TCIF1                       ,0x00000800 
.equ DMA_LISR_HTIF1                       ,0x00000400 
.equ DMA_LISR_TEIF1                       ,0x00000200 
.equ DMA_LISR_DMEIF1                      ,0x00000100 
.equ DMA_LISR_FEIF1                       ,0x00000040 
.equ DMA_LISR_TCIF0                       ,0x00000020 
.equ DMA_LISR_HTIF0                       ,0x00000010 
.equ DMA_LISR_TEIF0                       ,0x00000008 
.equ DMA_LISR_DMEIF0                      ,0x00000004 
.equ DMA_LISR_FEIF0                       ,0x00000001 

@*******************  Bits definition for DMA_HISR register  *****************/ 
.equ DMA_HISR_TCIF7                       ,0x08000000 
.equ DMA_HISR_HTIF7                       ,0x04000000 
.equ DMA_HISR_TEIF7                       ,0x02000000 
.equ DMA_HISR_DMEIF7                      ,0x01000000 
.equ DMA_HISR_FEIF7                       ,0x00400000 
.equ DMA_HISR_TCIF6                       ,0x00200000 
.equ DMA_HISR_HTIF6                       ,0x00100000 
.equ DMA_HISR_TEIF6                       ,0x00080000 
.equ DMA_HISR_DMEIF6                      ,0x00040000 
.equ DMA_HISR_FEIF6                       ,0x00010000 
.equ DMA_HISR_TCIF5                       ,0x00000800 
.equ DMA_HISR_HTIF5                       ,0x00000400 
.equ DMA_HISR_TEIF5                       ,0x00000200 
.equ DMA_HISR_DMEIF5                      ,0x00000100 
.equ DMA_HISR_FEIF5                       ,0x00000040 
.equ DMA_HISR_TCIF4                       ,0x00000020 
.equ DMA_HISR_HTIF4                       ,0x00000010 
.equ DMA_HISR_TEIF4                       ,0x00000008 
.equ DMA_HISR_DMEIF4                      ,0x00000004 
.equ DMA_HISR_FEIF4                       ,0x00000001 

@*******************  Bits definition for DMA_LIFCR register  ****************/ 
.equ DMA_LIFCR_CTCIF3                     ,0x08000000 
.equ DMA_LIFCR_CHTIF3                     ,0x04000000 
.equ DMA_LIFCR_CTEIF3                     ,0x02000000 
.equ DMA_LIFCR_CDMEIF3                    ,0x01000000 
.equ DMA_LIFCR_CFEIF3                     ,0x00400000 
.equ DMA_LIFCR_CTCIF2                     ,0x00200000 
.equ DMA_LIFCR_CHTIF2                     ,0x00100000 
.equ DMA_LIFCR_CTEIF2                     ,0x00080000 
.equ DMA_LIFCR_CDMEIF2                    ,0x00040000 
.equ DMA_LIFCR_CFEIF2                     ,0x00010000 
.equ DMA_LIFCR_CTCIF1                     ,0x00000800 
.equ DMA_LIFCR_CHTIF1                     ,0x00000400 
.equ DMA_LIFCR_CTEIF1                     ,0x00000200 
.equ DMA_LIFCR_CDMEIF1                    ,0x00000100 
.equ DMA_LIFCR_CFEIF1                     ,0x00000040 
.equ DMA_LIFCR_CTCIF0                     ,0x00000020 
.equ DMA_LIFCR_CHTIF0                     ,0x00000010 
.equ DMA_LIFCR_CTEIF0                     ,0x00000008 
.equ DMA_LIFCR_CDMEIF0                    ,0x00000004 
.equ DMA_LIFCR_CFEIF0                     ,0x00000001 

@*******************  Bits definition for DMA_HIFCR  register  ****************/ 
.equ DMA_HIFCR_CTCIF7                     ,0x08000000 
.equ DMA_HIFCR_CHTIF7                     ,0x04000000 
.equ DMA_HIFCR_CTEIF7                     ,0x02000000 
.equ DMA_HIFCR_CDMEIF7                    ,0x01000000 
.equ DMA_HIFCR_CFEIF7                     ,0x00400000 
.equ DMA_HIFCR_CTCIF6                     ,0x00200000 
.equ DMA_HIFCR_CHTIF6                     ,0x00100000 
.equ DMA_HIFCR_CTEIF6                     ,0x00080000 
.equ DMA_HIFCR_CDMEIF6                    ,0x00040000 
.equ DMA_HIFCR_CFEIF6                     ,0x00010000 
.equ DMA_HIFCR_CTCIF5                     ,0x00000800 
.equ DMA_HIFCR_CHTIF5                     ,0x00000400 
.equ DMA_HIFCR_CTEIF5                     ,0x00000200 
.equ DMA_HIFCR_CDMEIF5                    ,0x00000100 
.equ DMA_HIFCR_CFEIF5                     ,0x00000040 
.equ DMA_HIFCR_CTCIF4                     ,0x00000020 
.equ DMA_HIFCR_CHTIF4                     ,0x00000010 
.equ DMA_HIFCR_CTEIF4                     ,0x00000008 
.equ DMA_HIFCR_CDMEIF4                    ,0x00000004 
.equ DMA_HIFCR_CFEIF4                     ,0x00000001 

@*****************************************************************************/
@                                                                            */
@                    External Interrupt/Event Controller                     */
@                                                                            */
@*****************************************************************************/
@******************  Bit definition for EXTI_IMR register  *******************/
.equ  EXTI_IMR_MR0                        ,0x00000001         @< Interrupt Mask on line 0 */
.equ  EXTI_IMR_MR1                        ,0x00000002         @< Interrupt Mask on line 1 */
.equ  EXTI_IMR_MR2                        ,0x00000004         @< Interrupt Mask on line 2 */
.equ  EXTI_IMR_MR3                        ,0x00000008         @< Interrupt Mask on line 3 */
.equ  EXTI_IMR_MR4                        ,0x00000010         @< Interrupt Mask on line 4 */
.equ  EXTI_IMR_MR5                        ,0x00000020         @< Interrupt Mask on line 5 */
.equ  EXTI_IMR_MR6                        ,0x00000040         @< Interrupt Mask on line 6 */
.equ  EXTI_IMR_MR7                        ,0x00000080         @< Interrupt Mask on line 7 */
.equ  EXTI_IMR_MR8                        ,0x00000100         @< Interrupt Mask on line 8 */
.equ  EXTI_IMR_MR9                        ,0x00000200         @< Interrupt Mask on line 9 */
.equ  EXTI_IMR_MR10                       ,0x00000400         @< Interrupt Mask on line 10 */
.equ  EXTI_IMR_MR11                       ,0x00000800         @< Interrupt Mask on line 11 */
.equ  EXTI_IMR_MR12                       ,0x00001000         @< Interrupt Mask on line 12 */
.equ  EXTI_IMR_MR13                       ,0x00002000         @< Interrupt Mask on line 13 */
.equ  EXTI_IMR_MR14                       ,0x00004000         @< Interrupt Mask on line 14 */
.equ  EXTI_IMR_MR15                       ,0x00008000         @< Interrupt Mask on line 15 */
.equ  EXTI_IMR_MR16                       ,0x00010000         @< Interrupt Mask on line 16 */
.equ  EXTI_IMR_MR17                       ,0x00020000         @< Interrupt Mask on line 17 */
.equ  EXTI_IMR_MR18                       ,0x00040000         @< Interrupt Mask on line 18 */
.equ  EXTI_IMR_MR19                       ,0x00080000         @< Interrupt Mask on line 19 */

@******************  Bit definition for EXTI_EMR register  *******************/
.equ  EXTI_EMR_MR0                        ,0x00000001         @< Event Mask on line 0 */
.equ  EXTI_EMR_MR1                        ,0x00000002         @< Event Mask on line 1 */
.equ  EXTI_EMR_MR2                        ,0x00000004         @< Event Mask on line 2 */
.equ  EXTI_EMR_MR3                        ,0x00000008         @< Event Mask on line 3 */
.equ  EXTI_EMR_MR4                        ,0x00000010         @< Event Mask on line 4 */
.equ  EXTI_EMR_MR5                        ,0x00000020         @< Event Mask on line 5 */
.equ  EXTI_EMR_MR6                        ,0x00000040         @< Event Mask on line 6 */
.equ  EXTI_EMR_MR7                        ,0x00000080         @< Event Mask on line 7 */
.equ  EXTI_EMR_MR8                        ,0x00000100         @< Event Mask on line 8 */
.equ  EXTI_EMR_MR9                        ,0x00000200         @< Event Mask on line 9 */
.equ  EXTI_EMR_MR10                       ,0x00000400         @< Event Mask on line 10 */
.equ  EXTI_EMR_MR11                       ,0x00000800         @< Event Mask on line 11 */
.equ  EXTI_EMR_MR12                       ,0x00001000         @< Event Mask on line 12 */
.equ  EXTI_EMR_MR13                       ,0x00002000         @< Event Mask on line 13 */
.equ  EXTI_EMR_MR14                       ,0x00004000         @< Event Mask on line 14 */
.equ  EXTI_EMR_MR15                       ,0x00008000         @< Event Mask on line 15 */
.equ  EXTI_EMR_MR16                       ,0x00010000         @< Event Mask on line 16 */
.equ  EXTI_EMR_MR17                       ,0x00020000         @< Event Mask on line 17 */
.equ  EXTI_EMR_MR18                       ,0x00040000         @< Event Mask on line 18 */
.equ  EXTI_EMR_MR19                       ,0x00080000         @< Event Mask on line 19 */

@*****************  Bit definition for EXTI_RTSR register  *******************/
.equ  EXTI_RTSR_TR0                       ,0x00000001         @< Rising trigger event configuration bit of line 0 */
.equ  EXTI_RTSR_TR1                       ,0x00000002         @< Rising trigger event configuration bit of line 1 */
.equ  EXTI_RTSR_TR2                       ,0x00000004         @< Rising trigger event configuration bit of line 2 */
.equ  EXTI_RTSR_TR3                       ,0x00000008         @< Rising trigger event configuration bit of line 3 */
.equ  EXTI_RTSR_TR4                       ,0x00000010         @< Rising trigger event configuration bit of line 4 */
.equ  EXTI_RTSR_TR5                       ,0x00000020         @< Rising trigger event configuration bit of line 5 */
.equ  EXTI_RTSR_TR6                       ,0x00000040         @< Rising trigger event configuration bit of line 6 */
.equ  EXTI_RTSR_TR7                       ,0x00000080         @< Rising trigger event configuration bit of line 7 */
.equ  EXTI_RTSR_TR8                       ,0x00000100         @< Rising trigger event configuration bit of line 8 */
.equ  EXTI_RTSR_TR9                       ,0x00000200         @< Rising trigger event configuration bit of line 9 */
.equ  EXTI_RTSR_TR10                      ,0x00000400         @< Rising trigger event configuration bit of line 10 */
.equ  EXTI_RTSR_TR11                      ,0x00000800         @< Rising trigger event configuration bit of line 11 */
.equ  EXTI_RTSR_TR12                      ,0x00001000         @< Rising trigger event configuration bit of line 12 */
.equ  EXTI_RTSR_TR13                      ,0x00002000         @< Rising trigger event configuration bit of line 13 */
.equ  EXTI_RTSR_TR14                      ,0x00004000         @< Rising trigger event configuration bit of line 14 */
.equ  EXTI_RTSR_TR15                      ,0x00008000         @< Rising trigger event configuration bit of line 15 */
.equ  EXTI_RTSR_TR16                      ,0x00010000         @< Rising trigger event configuration bit of line 16 */
.equ  EXTI_RTSR_TR17                      ,0x00020000         @< Rising trigger event configuration bit of line 17 */
.equ  EXTI_RTSR_TR18                      ,0x00040000         @< Rising trigger event configuration bit of line 18 */
.equ  EXTI_RTSR_TR19                      ,0x00080000         @< Rising trigger event configuration bit of line 19 */

@*****************  Bit definition for EXTI_FTSR register  *******************/
.equ  EXTI_FTSR_TR0                       ,0x00000001         @< Falling trigger event configuration bit of line 0 */
.equ  EXTI_FTSR_TR1                       ,0x00000002         @< Falling trigger event configuration bit of line 1 */
.equ  EXTI_FTSR_TR2                       ,0x00000004         @< Falling trigger event configuration bit of line 2 */
.equ  EXTI_FTSR_TR3                       ,0x00000008         @< Falling trigger event configuration bit of line 3 */
.equ  EXTI_FTSR_TR4                       ,0x00000010         @< Falling trigger event configuration bit of line 4 */
.equ  EXTI_FTSR_TR5                       ,0x00000020         @< Falling trigger event configuration bit of line 5 */
.equ  EXTI_FTSR_TR6                       ,0x00000040         @< Falling trigger event configuration bit of line 6 */
.equ  EXTI_FTSR_TR7                       ,0x00000080         @< Falling trigger event configuration bit of line 7 */
.equ  EXTI_FTSR_TR8                       ,0x00000100         @< Falling trigger event configuration bit of line 8 */
.equ  EXTI_FTSR_TR9                       ,0x00000200         @< Falling trigger event configuration bit of line 9 */
.equ  EXTI_FTSR_TR10                      ,0x00000400         @< Falling trigger event configuration bit of line 10 */
.equ  EXTI_FTSR_TR11                      ,0x00000800         @< Falling trigger event configuration bit of line 11 */
.equ  EXTI_FTSR_TR12                      ,0x00001000         @< Falling trigger event configuration bit of line 12 */
.equ  EXTI_FTSR_TR13                      ,0x00002000         @< Falling trigger event configuration bit of line 13 */
.equ  EXTI_FTSR_TR14                      ,0x00004000         @< Falling trigger event configuration bit of line 14 */
.equ  EXTI_FTSR_TR15                      ,0x00008000         @< Falling trigger event configuration bit of line 15 */
.equ  EXTI_FTSR_TR16                      ,0x00010000         @< Falling trigger event configuration bit of line 16 */
.equ  EXTI_FTSR_TR17                      ,0x00020000         @< Falling trigger event configuration bit of line 17 */
.equ  EXTI_FTSR_TR18                      ,0x00040000         @< Falling trigger event configuration bit of line 18 */
.equ  EXTI_FTSR_TR19                      ,0x00080000         @< Falling trigger event configuration bit of line 19 */

@*****************  Bit definition for EXTI_SWIER register  ******************/
.equ  EXTI_SWIER_SWIER0                   ,0x00000001         @< Software Interrupt on line 0 */
.equ  EXTI_SWIER_SWIER1                   ,0x00000002         @< Software Interrupt on line 1 */
.equ  EXTI_SWIER_SWIER2                   ,0x00000004         @< Software Interrupt on line 2 */
.equ  EXTI_SWIER_SWIER3                   ,0x00000008         @< Software Interrupt on line 3 */
.equ  EXTI_SWIER_SWIER4                   ,0x00000010         @< Software Interrupt on line 4 */
.equ  EXTI_SWIER_SWIER5                   ,0x00000020         @< Software Interrupt on line 5 */
.equ  EXTI_SWIER_SWIER6                   ,0x00000040         @< Software Interrupt on line 6 */
.equ  EXTI_SWIER_SWIER7                   ,0x00000080         @< Software Interrupt on line 7 */
.equ  EXTI_SWIER_SWIER8                   ,0x00000100         @< Software Interrupt on line 8 */
.equ  EXTI_SWIER_SWIER9                   ,0x00000200         @< Software Interrupt on line 9 */
.equ  EXTI_SWIER_SWIER10                  ,0x00000400         @< Software Interrupt on line 10 */
.equ  EXTI_SWIER_SWIER11                  ,0x00000800         @< Software Interrupt on line 11 */
.equ  EXTI_SWIER_SWIER12                  ,0x00001000         @< Software Interrupt on line 12 */
.equ  EXTI_SWIER_SWIER13                  ,0x00002000         @< Software Interrupt on line 13 */
.equ  EXTI_SWIER_SWIER14                  ,0x00004000         @< Software Interrupt on line 14 */
.equ  EXTI_SWIER_SWIER15                  ,0x00008000         @< Software Interrupt on line 15 */
.equ  EXTI_SWIER_SWIER16                  ,0x00010000         @< Software Interrupt on line 16 */
.equ  EXTI_SWIER_SWIER17                  ,0x00020000         @< Software Interrupt on line 17 */
.equ  EXTI_SWIER_SWIER18                  ,0x00040000         @< Software Interrupt on line 18 */
.equ  EXTI_SWIER_SWIER19                  ,0x00080000         @< Software Interrupt on line 19 */

@******************  Bit definition for EXTI_PR register  ********************/
.equ  EXTI_PR_PR0                         ,0x00000001         @< Pending bit for line 0 */
.equ  EXTI_PR_PR1                         ,0x00000002         @< Pending bit for line 1 */
.equ  EXTI_PR_PR2                         ,0x00000004         @< Pending bit for line 2 */
.equ  EXTI_PR_PR3                         ,0x00000008         @< Pending bit for line 3 */
.equ  EXTI_PR_PR4                         ,0x00000010         @< Pending bit for line 4 */
.equ  EXTI_PR_PR5                         ,0x00000020         @< Pending bit for line 5 */
.equ  EXTI_PR_PR6                         ,0x00000040         @< Pending bit for line 6 */
.equ  EXTI_PR_PR7                         ,0x00000080         @< Pending bit for line 7 */
.equ  EXTI_PR_PR8                         ,0x00000100         @< Pending bit for line 8 */
.equ  EXTI_PR_PR9                         ,0x00000200         @< Pending bit for line 9 */
.equ  EXTI_PR_PR10                        ,0x00000400         @< Pending bit for line 10 */
.equ  EXTI_PR_PR11                        ,0x00000800         @< Pending bit for line 11 */
.equ  EXTI_PR_PR12                        ,0x00001000         @< Pending bit for line 12 */
.equ  EXTI_PR_PR13                        ,0x00002000         @< Pending bit for line 13 */
.equ  EXTI_PR_PR14                        ,0x00004000         @< Pending bit for line 14 */
.equ  EXTI_PR_PR15                        ,0x00008000         @< Pending bit for line 15 */
.equ  EXTI_PR_PR16                        ,0x00010000         @< Pending bit for line 16 */
.equ  EXTI_PR_PR17                        ,0x00020000         @< Pending bit for line 17 */
.equ  EXTI_PR_PR18                        ,0x00040000         @< Pending bit for line 18 */
.equ  EXTI_PR_PR19                        ,0x00080000         @< Pending bit for line 19 */

@*****************************************************************************/
@                                                                            */
@                                    FLASH                                   */
@                                                                            */
@*****************************************************************************/
.equ FLASH_ACR				  ,0x00000000
@******************  Bits definition for FLASH_ACR register  *****************/
.equ FLASH_ACR_LATENCY                    ,0x00000007 
.equ FLASH_ACR_LATENCY_0WS                ,0x00000000 
.equ FLASH_ACR_LATENCY_1WS                ,0x00000001 
.equ FLASH_ACR_LATENCY_2WS                ,0x00000002 
.equ FLASH_ACR_LATENCY_3WS                ,0x00000003 
.equ FLASH_ACR_LATENCY_4WS                ,0x00000004 
.equ FLASH_ACR_LATENCY_5WS                ,0x00000005 
.equ FLASH_ACR_LATENCY_6WS                ,0x00000006 
.equ FLASH_ACR_LATENCY_7WS                ,0x00000007 

.equ FLASH_ACR_PRFTEN                     ,0x00000100 
.equ FLASH_ACR_ICEN                       ,0x00000200 
.equ FLASH_ACR_DCEN                       ,0x00000400 
.equ FLASH_ACR_ICRST                      ,0x00000800 
.equ FLASH_ACR_DCRST                      ,0x00001000 
.equ FLASH_ACR_BYTE0_ADDRESS              ,0x40023C00 
.equ FLASH_ACR_BYTE2_ADDRESS              ,0x40023C03 

@******************  Bits definition for FLASH_SR register  ******************/
.equ FLASH_SR_EOP                         ,0x00000001 
.equ FLASH_SR_SOP                         ,0x00000002 
.equ FLASH_SR_WRPERR                      ,0x00000010 
.equ FLASH_SR_PGAERR                      ,0x00000020 
.equ FLASH_SR_PGPERR                      ,0x00000040 
.equ FLASH_SR_PGSERR                      ,0x00000080 
.equ FLASH_SR_BSY                         ,0x00010000 

@******************  Bits definition for FLASH_CR register  ******************/
.equ FLASH_CR_PG                          ,0x00000001 
.equ FLASH_CR_SER                         ,0x00000002 
.equ FLASH_CR_MER                         ,0x00000004 
.equ FLASH_CR_SNB_0                       ,0x00000008 
.equ FLASH_CR_SNB_1                       ,0x00000010 
.equ FLASH_CR_SNB_2                       ,0x00000020 
.equ FLASH_CR_SNB_3                       ,0x00000040 
.equ FLASH_CR_PSIZE_0                     ,0x00000100 
.equ FLASH_CR_PSIZE_1                     ,0x00000200 
.equ FLASH_CR_STRT                        ,0x00010000 
.equ FLASH_CR_EOPIE                       ,0x01000000 
.equ FLASH_CR_LOCK                        ,0x80000000 

@******************  Bits definition for FLASH_OPTCR register  ***************/
.equ FLASH_OPTCR_OPTLOCK                  ,0x00000001 
.equ FLASH_OPTCR_OPTSTRT                  ,0x00000002 
.equ FLASH_OPTCR_BOR_LEV_0                ,0x00000004 
.equ FLASH_OPTCR_BOR_LEV_1                ,0x00000008 
.equ FLASH_OPTCR_BOR_LEV                  ,0x0000000C 
.equ FLASH_OPTCR_WDG_SW                   ,0x00000020 
.equ FLASH_OPTCR_nRST_STOP                ,0x00000040 
.equ FLASH_OPTCR_nRST_STDBY               ,0x00000080 
.equ FLASH_OPTCR_RDP_0                    ,0x00000100 
.equ FLASH_OPTCR_RDP_1                    ,0x00000200 
.equ FLASH_OPTCR_RDP_2                    ,0x00000400 
.equ FLASH_OPTCR_RDP_3                    ,0x00000800 
.equ FLASH_OPTCR_RDP_4                    ,0x00001000 
.equ FLASH_OPTCR_RDP_5                    ,0x00002000 
.equ FLASH_OPTCR_RDP_6                    ,0x00004000 
.equ FLASH_OPTCR_RDP_7                    ,0x00008000 
.equ FLASH_OPTCR_nWRP_0                   ,0x00010000 
.equ FLASH_OPTCR_nWRP_1                   ,0x00020000 
.equ FLASH_OPTCR_nWRP_2                   ,0x00040000 
.equ FLASH_OPTCR_nWRP_3                   ,0x00080000 
.equ FLASH_OPTCR_nWRP_4                   ,0x00100000 
.equ FLASH_OPTCR_nWRP_5                   ,0x00200000 
.equ FLASH_OPTCR_nWRP_6                   ,0x00400000 
.equ FLASH_OPTCR_nWRP_7                   ,0x00800000 
.equ FLASH_OPTCR_nWRP_8                   ,0x01000000 
.equ FLASH_OPTCR_nWRP_9                   ,0x02000000 
.equ FLASH_OPTCR_nWRP_10                  ,0x04000000 
.equ FLASH_OPTCR_nWRP_11                  ,0x08000000 

@*****************************************************************************/
@                                                                            */
@                       Flexible Static Memory Controller                    */
@                                                                            */
@*****************************************************************************/
@*****************  Bit definition for FSMC_BCR1 register  *******************/
.equ  FSMC_BCR1_MBKEN                     ,0x00000001         @<Memory bank enable bit */
.equ  FSMC_BCR1_MUXEN                     ,0x00000002         @<Address/data multiplexing enable bit */

.equ  FSMC_BCR1_MTYP                      ,0x0000000C         @<MTYP[1:0] bits (Memory type) */
.equ  FSMC_BCR1_MTYP_0                    ,0x00000004         @<Bit 0 */
.equ  FSMC_BCR1_MTYP_1                    ,0x00000008         @<Bit 1 */

.equ  FSMC_BCR1_MWID                      ,0x00000030         @<MWID[1:0] bits (Memory data bus width) */
.equ  FSMC_BCR1_MWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_BCR1_MWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_BCR1_FACCEN                    ,0x00000040         @<Flash access enable */
.equ  FSMC_BCR1_BURSTEN                   ,0x00000100         @<Burst enable bit */
.equ  FSMC_BCR1_WAITPOL                   ,0x00000200         @<Wait signal polarity bit */
.equ  FSMC_BCR1_WRAPMOD                   ,0x00000400         @<Wrapped burst mode support */
.equ  FSMC_BCR1_WAITCFG                   ,0x00000800         @<Wait timing configuration */
.equ  FSMC_BCR1_WREN                      ,0x00001000         @<Write enable bit */
.equ  FSMC_BCR1_WAITEN                    ,0x00002000         @<Wait enable bit */
.equ  FSMC_BCR1_EXTMOD                    ,0x00004000         @<Extended mode enable */
.equ  FSMC_BCR1_ASYNCWAIT                 ,0x00008000         @<Asynchronous wait */
.equ  FSMC_BCR1_CBURSTRW                  ,0x00080000         @<Write burst enable */

@*****************  Bit definition for FSMC_BCR2 register  *******************/
.equ  FSMC_BCR2_MBKEN                     ,0x00000001         @<Memory bank enable bit */
.equ  FSMC_BCR2_MUXEN                     ,0x00000002         @<Address/data multiplexing enable bit */

.equ  FSMC_BCR2_MTYP                      ,0x0000000C         @<MTYP[1:0] bits (Memory type) */
.equ  FSMC_BCR2_MTYP_0                    ,0x00000004         @<Bit 0 */
.equ  FSMC_BCR2_MTYP_1                    ,0x00000008         @<Bit 1 */

.equ  FSMC_BCR2_MWID                      ,0x00000030         @<MWID[1:0] bits (Memory data bus width) */
.equ  FSMC_BCR2_MWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_BCR2_MWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_BCR2_FACCEN                    ,0x00000040         @<Flash access enable */
.equ  FSMC_BCR2_BURSTEN                   ,0x00000100         @<Burst enable bit */
.equ  FSMC_BCR2_WAITPOL                   ,0x00000200         @<Wait signal polarity bit */
.equ  FSMC_BCR2_WRAPMOD                   ,0x00000400         @<Wrapped burst mode support */
.equ  FSMC_BCR2_WAITCFG                   ,0x00000800         @<Wait timing configuration */
.equ  FSMC_BCR2_WREN                      ,0x00001000         @<Write enable bit */
.equ  FSMC_BCR2_WAITEN                    ,0x00002000         @<Wait enable bit */
.equ  FSMC_BCR2_EXTMOD                    ,0x00004000         @<Extended mode enable */
.equ  FSMC_BCR2_ASYNCWAIT                 ,0x00008000         @<Asynchronous wait */
.equ  FSMC_BCR2_CBURSTRW                  ,0x00080000         @<Write burst enable */

@*****************  Bit definition for FSMC_BCR3 register  *******************/
.equ  FSMC_BCR3_MBKEN                     ,0x00000001         @<Memory bank enable bit */
.equ  FSMC_BCR3_MUXEN                     ,0x00000002         @<Address/data multiplexing enable bit */

.equ  FSMC_BCR3_MTYP                      ,0x0000000C         @<MTYP[1:0] bits (Memory type) */
.equ  FSMC_BCR3_MTYP_0                    ,0x00000004         @<Bit 0 */
.equ  FSMC_BCR3_MTYP_1                    ,0x00000008         @<Bit 1 */

.equ  FSMC_BCR3_MWID                      ,0x00000030         @<MWID[1:0] bits (Memory data bus width) */
.equ  FSMC_BCR3_MWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_BCR3_MWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_BCR3_FACCEN                    ,0x00000040         @<Flash access enable */
.equ  FSMC_BCR3_BURSTEN                   ,0x00000100         @<Burst enable bit */
.equ  FSMC_BCR3_WAITPOL                   ,0x00000200         @<Wait signal polarity bit. */
.equ  FSMC_BCR3_WRAPMOD                   ,0x00000400         @<Wrapped burst mode support */
.equ  FSMC_BCR3_WAITCFG                   ,0x00000800         @<Wait timing configuration */
.equ  FSMC_BCR3_WREN                      ,0x00001000         @<Write enable bit */
.equ  FSMC_BCR3_WAITEN                    ,0x00002000         @<Wait enable bit */
.equ  FSMC_BCR3_EXTMOD                    ,0x00004000         @<Extended mode enable */
.equ  FSMC_BCR3_ASYNCWAIT                 ,0x00008000         @<Asynchronous wait */
.equ  FSMC_BCR3_CBURSTRW                  ,0x00080000         @<Write burst enable */

@*****************  Bit definition for FSMC_BCR4 register  *******************/
.equ  FSMC_BCR4_MBKEN                     ,0x00000001         @<Memory bank enable bit */
.equ  FSMC_BCR4_MUXEN                     ,0x00000002         @<Address/data multiplexing enable bit */

.equ  FSMC_BCR4_MTYP                      ,0x0000000C         @<MTYP[1:0] bits (Memory type) */
.equ  FSMC_BCR4_MTYP_0                    ,0x00000004         @<Bit 0 */
.equ  FSMC_BCR4_MTYP_1                    ,0x00000008         @<Bit 1 */

.equ  FSMC_BCR4_MWID                      ,0x00000030         @<MWID[1:0] bits (Memory data bus width) */
.equ  FSMC_BCR4_MWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_BCR4_MWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_BCR4_FACCEN                    ,0x00000040         @<Flash access enable */
.equ  FSMC_BCR4_BURSTEN                   ,0x00000100         @<Burst enable bit */
.equ  FSMC_BCR4_WAITPOL                   ,0x00000200         @<Wait signal polarity bit */
.equ  FSMC_BCR4_WRAPMOD                   ,0x00000400         @<Wrapped burst mode support */
.equ  FSMC_BCR4_WAITCFG                   ,0x00000800         @<Wait timing configuration */
.equ  FSMC_BCR4_WREN                      ,0x00001000         @<Write enable bit */
.equ  FSMC_BCR4_WAITEN                    ,0x00002000         @<Wait enable bit */
.equ  FSMC_BCR4_EXTMOD                    ,0x00004000         @<Extended mode enable */
.equ  FSMC_BCR4_ASYNCWAIT                 ,0x00008000         @<Asynchronous wait */
.equ  FSMC_BCR4_CBURSTRW                  ,0x00080000         @<Write burst enable */

@*****************  Bit definition for FSMC_BTR1 register  ******************/
.equ  FSMC_BTR1_ADDSET                    ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BTR1_ADDSET_0                  ,0x00000001         @<Bit 0 */
.equ  FSMC_BTR1_ADDSET_1                  ,0x00000002         @<Bit 1 */
.equ  FSMC_BTR1_ADDSET_2                  ,0x00000004         @<Bit 2 */
.equ  FSMC_BTR1_ADDSET_3                  ,0x00000008         @<Bit 3 */

.equ  FSMC_BTR1_ADDHLD                    ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BTR1_ADDHLD_0                  ,0x00000010         @<Bit 0 */
.equ  FSMC_BTR1_ADDHLD_1                  ,0x00000020         @<Bit 1 */
.equ  FSMC_BTR1_ADDHLD_2                  ,0x00000040         @<Bit 2 */
.equ  FSMC_BTR1_ADDHLD_3                  ,0x00000080         @<Bit 3 */

.equ  FSMC_BTR1_DATAST                    ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BTR1_DATAST_0                  ,0x00000100         @<Bit 0 */
.equ  FSMC_BTR1_DATAST_1                  ,0x00000200         @<Bit 1 */
.equ  FSMC_BTR1_DATAST_2                  ,0x00000400         @<Bit 2 */
.equ  FSMC_BTR1_DATAST_3                  ,0x00000800         @<Bit 3 */

.equ  FSMC_BTR1_BUSTURN                   ,0x000F0000         @<BUSTURN[3:0] bits (Bus turnaround phase duration) */
.equ  FSMC_BTR1_BUSTURN_0                 ,0x00010000         @<Bit 0 */
.equ  FSMC_BTR1_BUSTURN_1                 ,0x00020000         @<Bit 1 */
.equ  FSMC_BTR1_BUSTURN_2                 ,0x00040000         @<Bit 2 */
.equ  FSMC_BTR1_BUSTURN_3                 ,0x00080000         @<Bit 3 */

.equ  FSMC_BTR1_CLKDIV                    ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BTR1_CLKDIV_0                  ,0x00100000         @<Bit 0 */
.equ  FSMC_BTR1_CLKDIV_1                  ,0x00200000         @<Bit 1 */
.equ  FSMC_BTR1_CLKDIV_2                  ,0x00400000         @<Bit 2 */
.equ  FSMC_BTR1_CLKDIV_3                  ,0x00800000         @<Bit 3 */

.equ  FSMC_BTR1_DATLAT                    ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BTR1_DATLAT_0                  ,0x01000000         @<Bit 0 */
.equ  FSMC_BTR1_DATLAT_1                  ,0x02000000         @<Bit 1 */
.equ  FSMC_BTR1_DATLAT_2                  ,0x04000000         @<Bit 2 */
.equ  FSMC_BTR1_DATLAT_3                  ,0x08000000         @<Bit 3 */

.equ  FSMC_BTR1_ACCMOD                    ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BTR1_ACCMOD_0                  ,0x10000000         @<Bit 0 */
.equ  FSMC_BTR1_ACCMOD_1                  ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_BTR2 register  *******************/
.equ  FSMC_BTR2_ADDSET                    ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BTR2_ADDSET_0                  ,0x00000001         @<Bit 0 */
.equ  FSMC_BTR2_ADDSET_1                  ,0x00000002         @<Bit 1 */
.equ  FSMC_BTR2_ADDSET_2                  ,0x00000004         @<Bit 2 */
.equ  FSMC_BTR2_ADDSET_3                  ,0x00000008         @<Bit 3 */

.equ  FSMC_BTR2_ADDHLD                    ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BTR2_ADDHLD_0                  ,0x00000010         @<Bit 0 */
.equ  FSMC_BTR2_ADDHLD_1                  ,0x00000020         @<Bit 1 */
.equ  FSMC_BTR2_ADDHLD_2                  ,0x00000040         @<Bit 2 */
.equ  FSMC_BTR2_ADDHLD_3                  ,0x00000080         @<Bit 3 */

.equ  FSMC_BTR2_DATAST                    ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BTR2_DATAST_0                  ,0x00000100         @<Bit 0 */
.equ  FSMC_BTR2_DATAST_1                  ,0x00000200         @<Bit 1 */
.equ  FSMC_BTR2_DATAST_2                  ,0x00000400         @<Bit 2 */
.equ  FSMC_BTR2_DATAST_3                  ,0x00000800         @<Bit 3 */

.equ  FSMC_BTR2_BUSTURN                   ,0x000F0000         @<BUSTURN[3:0] bits (Bus turnaround phase duration) */
.equ  FSMC_BTR2_BUSTURN_0                 ,0x00010000         @<Bit 0 */
.equ  FSMC_BTR2_BUSTURN_1                 ,0x00020000         @<Bit 1 */
.equ  FSMC_BTR2_BUSTURN_2                 ,0x00040000         @<Bit 2 */
.equ  FSMC_BTR2_BUSTURN_3                 ,0x00080000         @<Bit 3 */

.equ  FSMC_BTR2_CLKDIV                    ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BTR2_CLKDIV_0                  ,0x00100000         @<Bit 0 */
.equ  FSMC_BTR2_CLKDIV_1                  ,0x00200000         @<Bit 1 */
.equ  FSMC_BTR2_CLKDIV_2                  ,0x00400000         @<Bit 2 */
.equ  FSMC_BTR2_CLKDIV_3                  ,0x00800000         @<Bit 3 */

.equ  FSMC_BTR2_DATLAT                    ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BTR2_DATLAT_0                  ,0x01000000         @<Bit 0 */
.equ  FSMC_BTR2_DATLAT_1                  ,0x02000000         @<Bit 1 */
.equ  FSMC_BTR2_DATLAT_2                  ,0x04000000         @<Bit 2 */
.equ  FSMC_BTR2_DATLAT_3                  ,0x08000000         @<Bit 3 */

.equ  FSMC_BTR2_ACCMOD                    ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BTR2_ACCMOD_0                  ,0x10000000         @<Bit 0 */
.equ  FSMC_BTR2_ACCMOD_1                  ,0x20000000         @<Bit 1 */

@******************  Bit definition for FSMC_BTR3 register  *******************/
.equ  FSMC_BTR3_ADDSET                    ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BTR3_ADDSET_0                  ,0x00000001         @<Bit 0 */
.equ  FSMC_BTR3_ADDSET_1                  ,0x00000002         @<Bit 1 */
.equ  FSMC_BTR3_ADDSET_2                  ,0x00000004         @<Bit 2 */
.equ  FSMC_BTR3_ADDSET_3                  ,0x00000008         @<Bit 3 */

.equ  FSMC_BTR3_ADDHLD                    ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BTR3_ADDHLD_0                  ,0x00000010         @<Bit 0 */
.equ  FSMC_BTR3_ADDHLD_1                  ,0x00000020         @<Bit 1 */
.equ  FSMC_BTR3_ADDHLD_2                  ,0x00000040         @<Bit 2 */
.equ  FSMC_BTR3_ADDHLD_3                  ,0x00000080         @<Bit 3 */

.equ  FSMC_BTR3_DATAST                    ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BTR3_DATAST_0                  ,0x00000100         @<Bit 0 */
.equ  FSMC_BTR3_DATAST_1                  ,0x00000200         @<Bit 1 */
.equ  FSMC_BTR3_DATAST_2                  ,0x00000400         @<Bit 2 */
.equ  FSMC_BTR3_DATAST_3                  ,0x00000800         @<Bit 3 */

.equ  FSMC_BTR3_BUSTURN                   ,0x000F0000         @<BUSTURN[3:0] bits (Bus turnaround phase duration) */
.equ  FSMC_BTR3_BUSTURN_0                 ,0x00010000         @<Bit 0 */
.equ  FSMC_BTR3_BUSTURN_1                 ,0x00020000         @<Bit 1 */
.equ  FSMC_BTR3_BUSTURN_2                 ,0x00040000         @<Bit 2 */
.equ  FSMC_BTR3_BUSTURN_3                 ,0x00080000         @<Bit 3 */

.equ  FSMC_BTR3_CLKDIV                    ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BTR3_CLKDIV_0                  ,0x00100000         @<Bit 0 */
.equ  FSMC_BTR3_CLKDIV_1                  ,0x00200000         @<Bit 1 */
.equ  FSMC_BTR3_CLKDIV_2                  ,0x00400000         @<Bit 2 */
.equ  FSMC_BTR3_CLKDIV_3                  ,0x00800000         @<Bit 3 */

.equ  FSMC_BTR3_DATLAT                    ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BTR3_DATLAT_0                  ,0x01000000         @<Bit 0 */
.equ  FSMC_BTR3_DATLAT_1                  ,0x02000000         @<Bit 1 */
.equ  FSMC_BTR3_DATLAT_2                  ,0x04000000         @<Bit 2 */
.equ  FSMC_BTR3_DATLAT_3                  ,0x08000000         @<Bit 3 */

.equ  FSMC_BTR3_ACCMOD                    ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BTR3_ACCMOD_0                  ,0x10000000         @<Bit 0 */
.equ  FSMC_BTR3_ACCMOD_1                  ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_BTR4 register  *******************/
.equ  FSMC_BTR4_ADDSET                    ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BTR4_ADDSET_0                  ,0x00000001         @<Bit 0 */
.equ  FSMC_BTR4_ADDSET_1                  ,0x00000002         @<Bit 1 */
.equ  FSMC_BTR4_ADDSET_2                  ,0x00000004         @<Bit 2 */
.equ  FSMC_BTR4_ADDSET_3                  ,0x00000008         @<Bit 3 */

.equ  FSMC_BTR4_ADDHLD                    ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BTR4_ADDHLD_0                  ,0x00000010         @<Bit 0 */
.equ  FSMC_BTR4_ADDHLD_1                  ,0x00000020         @<Bit 1 */
.equ  FSMC_BTR4_ADDHLD_2                  ,0x00000040         @<Bit 2 */
.equ  FSMC_BTR4_ADDHLD_3                  ,0x00000080         @<Bit 3 */

.equ  FSMC_BTR4_DATAST                    ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BTR4_DATAST_0                  ,0x00000100         @<Bit 0 */
.equ  FSMC_BTR4_DATAST_1                  ,0x00000200         @<Bit 1 */
.equ  FSMC_BTR4_DATAST_2                  ,0x00000400         @<Bit 2 */
.equ  FSMC_BTR4_DATAST_3                  ,0x00000800         @<Bit 3 */

.equ  FSMC_BTR4_BUSTURN                   ,0x000F0000         @<BUSTURN[3:0] bits (Bus turnaround phase duration) */
.equ  FSMC_BTR4_BUSTURN_0                 ,0x00010000         @<Bit 0 */
.equ  FSMC_BTR4_BUSTURN_1                 ,0x00020000         @<Bit 1 */
.equ  FSMC_BTR4_BUSTURN_2                 ,0x00040000         @<Bit 2 */
.equ  FSMC_BTR4_BUSTURN_3                 ,0x00080000         @<Bit 3 */

.equ  FSMC_BTR4_CLKDIV                    ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BTR4_CLKDIV_0                  ,0x00100000         @<Bit 0 */
.equ  FSMC_BTR4_CLKDIV_1                  ,0x00200000         @<Bit 1 */
.equ  FSMC_BTR4_CLKDIV_2                  ,0x00400000         @<Bit 2 */
.equ  FSMC_BTR4_CLKDIV_3                  ,0x00800000         @<Bit 3 */

.equ  FSMC_BTR4_DATLAT                    ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BTR4_DATLAT_0                  ,0x01000000         @<Bit 0 */
.equ  FSMC_BTR4_DATLAT_1                  ,0x02000000         @<Bit 1 */
.equ  FSMC_BTR4_DATLAT_2                  ,0x04000000         @<Bit 2 */
.equ  FSMC_BTR4_DATLAT_3                  ,0x08000000         @<Bit 3 */

.equ  FSMC_BTR4_ACCMOD                    ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BTR4_ACCMOD_0                  ,0x10000000         @<Bit 0 */
.equ  FSMC_BTR4_ACCMOD_1                  ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_BWTR1 register  ******************/
.equ  FSMC_BWTR1_ADDSET                   ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BWTR1_ADDSET_0                 ,0x00000001         @<Bit 0 */
.equ  FSMC_BWTR1_ADDSET_1                 ,0x00000002         @<Bit 1 */
.equ  FSMC_BWTR1_ADDSET_2                 ,0x00000004         @<Bit 2 */
.equ  FSMC_BWTR1_ADDSET_3                 ,0x00000008         @<Bit 3 */

.equ  FSMC_BWTR1_ADDHLD                   ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BWTR1_ADDHLD_0                 ,0x00000010         @<Bit 0 */
.equ  FSMC_BWTR1_ADDHLD_1                 ,0x00000020         @<Bit 1 */
.equ  FSMC_BWTR1_ADDHLD_2                 ,0x00000040         @<Bit 2 */
.equ  FSMC_BWTR1_ADDHLD_3                 ,0x00000080         @<Bit 3 */

.equ  FSMC_BWTR1_DATAST                   ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BWTR1_DATAST_0                 ,0x00000100         @<Bit 0 */
.equ  FSMC_BWTR1_DATAST_1                 ,0x00000200         @<Bit 1 */
.equ  FSMC_BWTR1_DATAST_2                 ,0x00000400         @<Bit 2 */
.equ  FSMC_BWTR1_DATAST_3                 ,0x00000800         @<Bit 3 */

.equ  FSMC_BWTR1_CLKDIV                   ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BWTR1_CLKDIV_0                 ,0x00100000         @<Bit 0 */
.equ  FSMC_BWTR1_CLKDIV_1                 ,0x00200000         @<Bit 1 */
.equ  FSMC_BWTR1_CLKDIV_2                 ,0x00400000         @<Bit 2 */
.equ  FSMC_BWTR1_CLKDIV_3                 ,0x00800000         @<Bit 3 */

.equ  FSMC_BWTR1_DATLAT                   ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BWTR1_DATLAT_0                 ,0x01000000         @<Bit 0 */
.equ  FSMC_BWTR1_DATLAT_1                 ,0x02000000         @<Bit 1 */
.equ  FSMC_BWTR1_DATLAT_2                 ,0x04000000         @<Bit 2 */
.equ  FSMC_BWTR1_DATLAT_3                 ,0x08000000         @<Bit 3 */

.equ  FSMC_BWTR1_ACCMOD                   ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BWTR1_ACCMOD_0                 ,0x10000000         @<Bit 0 */
.equ  FSMC_BWTR1_ACCMOD_1                 ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_BWTR2 register  ******************/
.equ  FSMC_BWTR2_ADDSET                   ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BWTR2_ADDSET_0                 ,0x00000001         @<Bit 0 */
.equ  FSMC_BWTR2_ADDSET_1                 ,0x00000002         @<Bit 1 */
.equ  FSMC_BWTR2_ADDSET_2                 ,0x00000004         @<Bit 2 */
.equ  FSMC_BWTR2_ADDSET_3                 ,0x00000008         @<Bit 3 */

.equ  FSMC_BWTR2_ADDHLD                   ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BWTR2_ADDHLD_0                 ,0x00000010         @<Bit 0 */
.equ  FSMC_BWTR2_ADDHLD_1                 ,0x00000020         @<Bit 1 */
.equ  FSMC_BWTR2_ADDHLD_2                 ,0x00000040         @<Bit 2 */
.equ  FSMC_BWTR2_ADDHLD_3                 ,0x00000080         @<Bit 3 */

.equ  FSMC_BWTR2_DATAST                   ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BWTR2_DATAST_0                 ,0x00000100         @<Bit 0 */
.equ  FSMC_BWTR2_DATAST_1                 ,0x00000200         @<Bit 1 */
.equ  FSMC_BWTR2_DATAST_2                 ,0x00000400         @<Bit 2 */
.equ  FSMC_BWTR2_DATAST_3                 ,0x00000800         @<Bit 3 */

.equ  FSMC_BWTR2_CLKDIV                   ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BWTR2_CLKDIV_0                 ,0x00100000         @<Bit 0 */
.equ  FSMC_BWTR2_CLKDIV_1                 ,0x00200000         @<Bit 1*/
.equ  FSMC_BWTR2_CLKDIV_2                 ,0x00400000         @<Bit 2 */
.equ  FSMC_BWTR2_CLKDIV_3                 ,0x00800000         @<Bit 3 */

.equ  FSMC_BWTR2_DATLAT                   ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BWTR2_DATLAT_0                 ,0x01000000         @<Bit 0 */
.equ  FSMC_BWTR2_DATLAT_1                 ,0x02000000         @<Bit 1 */
.equ  FSMC_BWTR2_DATLAT_2                 ,0x04000000         @<Bit 2 */
.equ  FSMC_BWTR2_DATLAT_3                 ,0x08000000         @<Bit 3 */

.equ  FSMC_BWTR2_ACCMOD                   ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BWTR2_ACCMOD_0                 ,0x10000000         @<Bit 0 */
.equ  FSMC_BWTR2_ACCMOD_1                 ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_BWTR3 register  ******************/
.equ  FSMC_BWTR3_ADDSET                   ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BWTR3_ADDSET_0                 ,0x00000001         @<Bit 0 */
.equ  FSMC_BWTR3_ADDSET_1                 ,0x00000002         @<Bit 1 */
.equ  FSMC_BWTR3_ADDSET_2                 ,0x00000004         @<Bit 2 */
.equ  FSMC_BWTR3_ADDSET_3                 ,0x00000008         @<Bit 3 */

.equ  FSMC_BWTR3_ADDHLD                   ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BWTR3_ADDHLD_0                 ,0x00000010         @<Bit 0 */
.equ  FSMC_BWTR3_ADDHLD_1                 ,0x00000020         @<Bit 1 */
.equ  FSMC_BWTR3_ADDHLD_2                 ,0x00000040         @<Bit 2 */
.equ  FSMC_BWTR3_ADDHLD_3                 ,0x00000080         @<Bit 3 */

.equ  FSMC_BWTR3_DATAST                   ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BWTR3_DATAST_0                 ,0x00000100         @<Bit 0 */
.equ  FSMC_BWTR3_DATAST_1                 ,0x00000200         @<Bit 1 */
.equ  FSMC_BWTR3_DATAST_2                 ,0x00000400         @<Bit 2 */
.equ  FSMC_BWTR3_DATAST_3                 ,0x00000800         @<Bit 3 */

.equ  FSMC_BWTR3_CLKDIV                   ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BWTR3_CLKDIV_0                 ,0x00100000         @<Bit 0 */
.equ  FSMC_BWTR3_CLKDIV_1                 ,0x00200000         @<Bit 1 */
.equ  FSMC_BWTR3_CLKDIV_2                 ,0x00400000         @<Bit 2 */
.equ  FSMC_BWTR3_CLKDIV_3                 ,0x00800000         @<Bit 3 */

.equ  FSMC_BWTR3_DATLAT                   ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BWTR3_DATLAT_0                 ,0x01000000         @<Bit 0 */
.equ  FSMC_BWTR3_DATLAT_1                 ,0x02000000         @<Bit 1 */
.equ  FSMC_BWTR3_DATLAT_2                 ,0x04000000         @<Bit 2 */
.equ  FSMC_BWTR3_DATLAT_3                 ,0x08000000         @<Bit 3 */

.equ  FSMC_BWTR3_ACCMOD                   ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BWTR3_ACCMOD_0                 ,0x10000000         @<Bit 0 */
.equ  FSMC_BWTR3_ACCMOD_1                 ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_BWTR4 register  ******************/
.equ  FSMC_BWTR4_ADDSET                   ,0x0000000F         @<ADDSET[3:0] bits (Address setup phase duration) */
.equ  FSMC_BWTR4_ADDSET_0                 ,0x00000001         @<Bit 0 */
.equ  FSMC_BWTR4_ADDSET_1                 ,0x00000002         @<Bit 1 */
.equ  FSMC_BWTR4_ADDSET_2                 ,0x00000004         @<Bit 2 */
.equ  FSMC_BWTR4_ADDSET_3                 ,0x00000008         @<Bit 3 */

.equ  FSMC_BWTR4_ADDHLD                   ,0x000000F0         @<ADDHLD[3:0] bits (Address-hold phase duration) */
.equ  FSMC_BWTR4_ADDHLD_0                 ,0x00000010         @<Bit 0 */
.equ  FSMC_BWTR4_ADDHLD_1                 ,0x00000020         @<Bit 1 */
.equ  FSMC_BWTR4_ADDHLD_2                 ,0x00000040         @<Bit 2 */
.equ  FSMC_BWTR4_ADDHLD_3                 ,0x00000080         @<Bit 3 */

.equ  FSMC_BWTR4_DATAST                   ,0x0000FF00         @<DATAST [3:0] bits (Data-phase duration) */
.equ  FSMC_BWTR4_DATAST_0                 ,0x00000100         @<Bit 0 */
.equ  FSMC_BWTR4_DATAST_1                 ,0x00000200         @<Bit 1 */
.equ  FSMC_BWTR4_DATAST_2                 ,0x00000400         @<Bit 2 */
.equ  FSMC_BWTR4_DATAST_3                 ,0x00000800         @<Bit 3 */

.equ  FSMC_BWTR4_CLKDIV                   ,0x00F00000         @<CLKDIV[3:0] bits (Clock divide ratio) */
.equ  FSMC_BWTR4_CLKDIV_0                 ,0x00100000         @<Bit 0 */
.equ  FSMC_BWTR4_CLKDIV_1                 ,0x00200000         @<Bit 1 */
.equ  FSMC_BWTR4_CLKDIV_2                 ,0x00400000         @<Bit 2 */
.equ  FSMC_BWTR4_CLKDIV_3                 ,0x00800000         @<Bit 3 */

.equ  FSMC_BWTR4_DATLAT                   ,0x0F000000         @<DATLA[3:0] bits (Data latency) */
.equ  FSMC_BWTR4_DATLAT_0                 ,0x01000000         @<Bit 0 */
.equ  FSMC_BWTR4_DATLAT_1                 ,0x02000000         @<Bit 1 */
.equ  FSMC_BWTR4_DATLAT_2                 ,0x04000000         @<Bit 2 */
.equ  FSMC_BWTR4_DATLAT_3                 ,0x08000000         @<Bit 3 */

.equ  FSMC_BWTR4_ACCMOD                   ,0x30000000         @<ACCMOD[1:0] bits (Access mode) */
.equ  FSMC_BWTR4_ACCMOD_0                 ,0x10000000         @<Bit 0 */
.equ  FSMC_BWTR4_ACCMOD_1                 ,0x20000000         @<Bit 1 */

@*****************  Bit definition for FSMC_PCR2 register  *******************/
.equ  FSMC_PCR2_PWAITEN                   ,0x00000002         @<Wait feature enable bit */
.equ  FSMC_PCR2_PBKEN                     ,0x00000004         @<PC Card/NAND Flash memory bank enable bit */
.equ  FSMC_PCR2_PTYP                      ,0x00000008         @<Memory type */

.equ  FSMC_PCR2_PWID                      ,0x00000030         @<PWID[1:0] bits (NAND Flash databus width) */
.equ  FSMC_PCR2_PWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_PCR2_PWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_PCR2_ECCEN                     ,0x00000040         @<ECC computation logic enable bit */

.equ  FSMC_PCR2_TCLR                      ,0x00001E00         @<TCLR[3:0] bits (CLE to RE delay) */
.equ  FSMC_PCR2_TCLR_0                    ,0x00000200         @<Bit 0 */
.equ  FSMC_PCR2_TCLR_1                    ,0x00000400         @<Bit 1 */
.equ  FSMC_PCR2_TCLR_2                    ,0x00000800         @<Bit 2 */
.equ  FSMC_PCR2_TCLR_3                    ,0x00001000         @<Bit 3 */

.equ  FSMC_PCR2_TAR                       ,0x0001E000         @<TAR[3:0] bits (ALE to RE delay) */
.equ  FSMC_PCR2_TAR_0                     ,0x00002000         @<Bit 0 */
.equ  FSMC_PCR2_TAR_1                     ,0x00004000         @<Bit 1 */
.equ  FSMC_PCR2_TAR_2                     ,0x00008000         @<Bit 2 */
.equ  FSMC_PCR2_TAR_3                     ,0x00010000         @<Bit 3 */

.equ  FSMC_PCR2_ECCPS                     ,0x000E0000         @<ECCPS[1:0] bits (ECC page size) */
.equ  FSMC_PCR2_ECCPS_0                   ,0x00020000         @<Bit 0 */
.equ  FSMC_PCR2_ECCPS_1                   ,0x00040000         @<Bit 1 */
.equ  FSMC_PCR2_ECCPS_2                   ,0x00080000         @<Bit 2 */

@*****************  Bit definition for FSMC_PCR3 register  *******************/
.equ  FSMC_PCR3_PWAITEN                   ,0x00000002         @<Wait feature enable bit */
.equ  FSMC_PCR3_PBKEN                     ,0x00000004         @<PC Card/NAND Flash memory bank enable bit */
.equ  FSMC_PCR3_PTYP                      ,0x00000008         @<Memory type */

.equ  FSMC_PCR3_PWID                      ,0x00000030         @<PWID[1:0] bits (NAND Flash databus width) */
.equ  FSMC_PCR3_PWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_PCR3_PWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_PCR3_ECCEN                     ,0x00000040         @<ECC computation logic enable bit */

.equ  FSMC_PCR3_TCLR                      ,0x00001E00         @<TCLR[3:0] bits (CLE to RE delay) */
.equ  FSMC_PCR3_TCLR_0                    ,0x00000200         @<Bit 0 */
.equ  FSMC_PCR3_TCLR_1                    ,0x00000400         @<Bit 1 */
.equ  FSMC_PCR3_TCLR_2                    ,0x00000800         @<Bit 2 */
.equ  FSMC_PCR3_TCLR_3                    ,0x00001000         @<Bit 3 */

.equ  FSMC_PCR3_TAR                       ,0x0001E000         @<TAR[3:0] bits (ALE to RE delay) */
.equ  FSMC_PCR3_TAR_0                     ,0x00002000         @<Bit 0 */
.equ  FSMC_PCR3_TAR_1                     ,0x00004000         @<Bit 1 */
.equ  FSMC_PCR3_TAR_2                     ,0x00008000         @<Bit 2 */
.equ  FSMC_PCR3_TAR_3                     ,0x00010000         @<Bit 3 */

.equ  FSMC_PCR3_ECCPS                     ,0x000E0000         @<ECCPS[2:0] bits (ECC page size) */
.equ  FSMC_PCR3_ECCPS_0                   ,0x00020000         @<Bit 0 */
.equ  FSMC_PCR3_ECCPS_1                   ,0x00040000         @<Bit 1 */
.equ  FSMC_PCR3_ECCPS_2                   ,0x00080000         @<Bit 2 */

@*****************  Bit definition for FSMC_PCR4 register  *******************/
.equ  FSMC_PCR4_PWAITEN                   ,0x00000002         @<Wait feature enable bit */
.equ  FSMC_PCR4_PBKEN                     ,0x00000004         @<PC Card/NAND Flash memory bank enable bit */
.equ  FSMC_PCR4_PTYP                      ,0x00000008         @<Memory type */

.equ  FSMC_PCR4_PWID                      ,0x00000030         @<PWID[1:0] bits (NAND Flash databus width) */
.equ  FSMC_PCR4_PWID_0                    ,0x00000010         @<Bit 0 */
.equ  FSMC_PCR4_PWID_1                    ,0x00000020         @<Bit 1 */

.equ  FSMC_PCR4_ECCEN                     ,0x00000040         @<ECC computation logic enable bit */

.equ  FSMC_PCR4_TCLR                      ,0x00001E00         @<TCLR[3:0] bits (CLE to RE delay) */
.equ  FSMC_PCR4_TCLR_0                    ,0x00000200         @<Bit 0 */
.equ  FSMC_PCR4_TCLR_1                    ,0x00000400         @<Bit 1 */
.equ  FSMC_PCR4_TCLR_2                    ,0x00000800         @<Bit 2 */
.equ  FSMC_PCR4_TCLR_3                    ,0x00001000         @<Bit 3 */

.equ  FSMC_PCR4_TAR                       ,0x0001E000         @<TAR[3:0] bits (ALE to RE delay) */
.equ  FSMC_PCR4_TAR_0                     ,0x00002000         @<Bit 0 */
.equ  FSMC_PCR4_TAR_1                     ,0x00004000         @<Bit 1 */
.equ  FSMC_PCR4_TAR_2                     ,0x00008000         @<Bit 2 */
.equ  FSMC_PCR4_TAR_3                     ,0x00010000         @<Bit 3 */

.equ  FSMC_PCR4_ECCPS                     ,0x000E0000         @<ECCPS[2:0] bits (ECC page size) */
.equ  FSMC_PCR4_ECCPS_0                   ,0x00020000         @<Bit 0 */
.equ  FSMC_PCR4_ECCPS_1                   ,0x00040000         @<Bit 1 */
.equ  FSMC_PCR4_ECCPS_2                   ,0x00080000         @<Bit 2 */

@******************  Bit definition for FSMC_SR2 register  *******************/
.equ  FSMC_SR2_IRS                        ,0x01               @<Interrupt Rising Edge status */
.equ  FSMC_SR2_ILS                        ,0x02               @<Interrupt Level status */
.equ  FSMC_SR2_IFS                        ,0x04               @<Interrupt Falling Edge status */
.equ  FSMC_SR2_IREN                       ,0x08               @<Interrupt Rising Edge detection Enable bit */
.equ  FSMC_SR2_ILEN                       ,0x10               @<Interrupt Level detection Enable bit */
.equ  FSMC_SR2_IFEN                       ,0x20               @<Interrupt Falling Edge detection Enable bit */
.equ  FSMC_SR2_FEMPT                      ,0x40               @<FIFO empty */

@******************  Bit definition for FSMC_SR3 register  *******************/
.equ  FSMC_SR3_IRS                        ,0x01               @<Interrupt Rising Edge status */
.equ  FSMC_SR3_ILS                        ,0x02               @<Interrupt Level status */
.equ  FSMC_SR3_IFS                        ,0x04               @<Interrupt Falling Edge status */
.equ  FSMC_SR3_IREN                       ,0x08               @<Interrupt Rising Edge detection Enable bit */
.equ  FSMC_SR3_ILEN                       ,0x10               @<Interrupt Level detection Enable bit */
.equ  FSMC_SR3_IFEN                       ,0x20               @<Interrupt Falling Edge detection Enable bit */
.equ  FSMC_SR3_FEMPT                      ,0x40               @<FIFO empty */

@******************  Bit definition for FSMC_SR4 register  *******************/
.equ  FSMC_SR4_IRS                        ,0x01               @<Interrupt Rising Edge status */
.equ  FSMC_SR4_ILS                        ,0x02               @<Interrupt Level status */
.equ  FSMC_SR4_IFS                        ,0x04               @<Interrupt Falling Edge status */
.equ  FSMC_SR4_IREN                       ,0x08               @<Interrupt Rising Edge detection Enable bit */
.equ  FSMC_SR4_ILEN                       ,0x10               @<Interrupt Level detection Enable bit */
.equ  FSMC_SR4_IFEN                       ,0x20               @<Interrupt Falling Edge detection Enable bit */
.equ  FSMC_SR4_FEMPT                      ,0x40               @<FIFO empty */

@*****************  Bit definition for FSMC_PMEM2 register  ******************/
.equ  FSMC_PMEM2_MEMSET2                  ,0x000000FF         @<MEMSET2[7:0] bits (Common memory 2 setup time) */
.equ  FSMC_PMEM2_MEMSET2_0                ,0x00000001         @<Bit 0 */
.equ  FSMC_PMEM2_MEMSET2_1                ,0x00000002         @<Bit 1 */
.equ  FSMC_PMEM2_MEMSET2_2                ,0x00000004         @<Bit 2 */
.equ  FSMC_PMEM2_MEMSET2_3                ,0x00000008         @<Bit 3 */
.equ  FSMC_PMEM2_MEMSET2_4                ,0x00000010         @<Bit 4 */
.equ  FSMC_PMEM2_MEMSET2_5                ,0x00000020         @<Bit 5 */
.equ  FSMC_PMEM2_MEMSET2_6                ,0x00000040         @<Bit 6 */
.equ  FSMC_PMEM2_MEMSET2_7                ,0x00000080         @<Bit 7 */

.equ  FSMC_PMEM2_MEMWAIT2                 ,0x0000FF00         @<MEMWAIT2[7:0] bits (Common memory 2 wait time) */
.equ  FSMC_PMEM2_MEMWAIT2_0               ,0x00000100         @<Bit 0 */
.equ  FSMC_PMEM2_MEMWAIT2_1               ,0x00000200         @<Bit 1 */
.equ  FSMC_PMEM2_MEMWAIT2_2               ,0x00000400         @<Bit 2 */
.equ  FSMC_PMEM2_MEMWAIT2_3               ,0x00000800         @<Bit 3 */
.equ  FSMC_PMEM2_MEMWAIT2_4               ,0x00001000         @<Bit 4 */
.equ  FSMC_PMEM2_MEMWAIT2_5               ,0x00002000         @<Bit 5 */
.equ  FSMC_PMEM2_MEMWAIT2_6               ,0x00004000         @<Bit 6 */
.equ  FSMC_PMEM2_MEMWAIT2_7               ,0x00008000         @<Bit 7 */

.equ  FSMC_PMEM2_MEMHOLD2                 ,0x00FF0000         @<MEMHOLD2[7:0] bits (Common memory 2 hold time) */
.equ  FSMC_PMEM2_MEMHOLD2_0               ,0x00010000         @<Bit 0 */
.equ  FSMC_PMEM2_MEMHOLD2_1               ,0x00020000         @<Bit 1 */
.equ  FSMC_PMEM2_MEMHOLD2_2               ,0x00040000         @<Bit 2 */
.equ  FSMC_PMEM2_MEMHOLD2_3               ,0x00080000         @<Bit 3 */
.equ  FSMC_PMEM2_MEMHOLD2_4               ,0x00100000         @<Bit 4 */
.equ  FSMC_PMEM2_MEMHOLD2_5               ,0x00200000         @<Bit 5 */
.equ  FSMC_PMEM2_MEMHOLD2_6               ,0x00400000         @<Bit 6 */
.equ  FSMC_PMEM2_MEMHOLD2_7               ,0x00800000         @<Bit 7 */

.equ  FSMC_PMEM2_MEMHIZ2                  ,0xFF000000         @<MEMHIZ2[7:0] bits (Common memory 2 databus HiZ time) */
.equ  FSMC_PMEM2_MEMHIZ2_0                ,0x01000000         @<Bit 0 */
.equ  FSMC_PMEM2_MEMHIZ2_1                ,0x02000000         @<Bit 1 */
.equ  FSMC_PMEM2_MEMHIZ2_2                ,0x04000000         @<Bit 2 */
.equ  FSMC_PMEM2_MEMHIZ2_3                ,0x08000000         @<Bit 3 */
.equ  FSMC_PMEM2_MEMHIZ2_4                ,0x10000000         @<Bit 4 */
.equ  FSMC_PMEM2_MEMHIZ2_5                ,0x20000000         @<Bit 5 */
.equ  FSMC_PMEM2_MEMHIZ2_6                ,0x40000000         @<Bit 6 */
.equ  FSMC_PMEM2_MEMHIZ2_7                ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_PMEM3 register  ******************/
.equ  FSMC_PMEM3_MEMSET3                  ,0x000000FF         @<MEMSET3[7:0] bits (Common memory 3 setup time) */
.equ  FSMC_PMEM3_MEMSET3_0                ,0x00000001         @<Bit 0 */
.equ  FSMC_PMEM3_MEMSET3_1                ,0x00000002         @<Bit 1 */
.equ  FSMC_PMEM3_MEMSET3_2                ,0x00000004         @<Bit 2 */
.equ  FSMC_PMEM3_MEMSET3_3                ,0x00000008         @<Bit 3 */
.equ  FSMC_PMEM3_MEMSET3_4                ,0x00000010         @<Bit 4 */
.equ  FSMC_PMEM3_MEMSET3_5                ,0x00000020         @<Bit 5 */
.equ  FSMC_PMEM3_MEMSET3_6                ,0x00000040         @<Bit 6 */
.equ  FSMC_PMEM3_MEMSET3_7                ,0x00000080         @<Bit 7 */

.equ  FSMC_PMEM3_MEMWAIT3                 ,0x0000FF00         @<MEMWAIT3[7:0] bits (Common memory 3 wait time) */
.equ  FSMC_PMEM3_MEMWAIT3_0               ,0x00000100         @<Bit 0 */
.equ  FSMC_PMEM3_MEMWAIT3_1               ,0x00000200         @<Bit 1 */
.equ  FSMC_PMEM3_MEMWAIT3_2               ,0x00000400         @<Bit 2 */
.equ  FSMC_PMEM3_MEMWAIT3_3               ,0x00000800         @<Bit 3 */
.equ  FSMC_PMEM3_MEMWAIT3_4               ,0x00001000         @<Bit 4 */
.equ  FSMC_PMEM3_MEMWAIT3_5               ,0x00002000         @<Bit 5 */
.equ  FSMC_PMEM3_MEMWAIT3_6               ,0x00004000         @<Bit 6 */
.equ  FSMC_PMEM3_MEMWAIT3_7               ,0x00008000         @<Bit 7 */

.equ  FSMC_PMEM3_MEMHOLD3                 ,0x00FF0000         @<MEMHOLD3[7:0] bits (Common memory 3 hold time) */
.equ  FSMC_PMEM3_MEMHOLD3_0               ,0x00010000         @<Bit 0 */
.equ  FSMC_PMEM3_MEMHOLD3_1               ,0x00020000         @<Bit 1 */
.equ  FSMC_PMEM3_MEMHOLD3_2               ,0x00040000         @<Bit 2 */
.equ  FSMC_PMEM3_MEMHOLD3_3               ,0x00080000         @<Bit 3 */
.equ  FSMC_PMEM3_MEMHOLD3_4               ,0x00100000         @<Bit 4 */
.equ  FSMC_PMEM3_MEMHOLD3_5               ,0x00200000         @<Bit 5 */
.equ  FSMC_PMEM3_MEMHOLD3_6               ,0x00400000         @<Bit 6 */
.equ  FSMC_PMEM3_MEMHOLD3_7               ,0x00800000         @<Bit 7 */

.equ  FSMC_PMEM3_MEMHIZ3                  ,0xFF000000         @<MEMHIZ3[7:0] bits (Common memory 3 databus HiZ time) */
.equ  FSMC_PMEM3_MEMHIZ3_0                ,0x01000000         @<Bit 0 */
.equ  FSMC_PMEM3_MEMHIZ3_1                ,0x02000000         @<Bit 1 */
.equ  FSMC_PMEM3_MEMHIZ3_2                ,0x04000000         @<Bit 2 */
.equ  FSMC_PMEM3_MEMHIZ3_3                ,0x08000000         @<Bit 3 */
.equ  FSMC_PMEM3_MEMHIZ3_4                ,0x10000000         @<Bit 4 */
.equ  FSMC_PMEM3_MEMHIZ3_5                ,0x20000000         @<Bit 5 */
.equ  FSMC_PMEM3_MEMHIZ3_6                ,0x40000000         @<Bit 6 */
.equ  FSMC_PMEM3_MEMHIZ3_7                ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_PMEM4 register  ******************/
.equ  FSMC_PMEM4_MEMSET4                  ,0x000000FF         @<MEMSET4[7:0] bits (Common memory 4 setup time) */
.equ  FSMC_PMEM4_MEMSET4_0                ,0x00000001         @<Bit 0 */
.equ  FSMC_PMEM4_MEMSET4_1                ,0x00000002         @<Bit 1 */
.equ  FSMC_PMEM4_MEMSET4_2                ,0x00000004         @<Bit 2 */
.equ  FSMC_PMEM4_MEMSET4_3                ,0x00000008         @<Bit 3 */
.equ  FSMC_PMEM4_MEMSET4_4                ,0x00000010         @<Bit 4 */
.equ  FSMC_PMEM4_MEMSET4_5                ,0x00000020         @<Bit 5 */
.equ  FSMC_PMEM4_MEMSET4_6                ,0x00000040         @<Bit 6 */
.equ  FSMC_PMEM4_MEMSET4_7                ,0x00000080         @<Bit 7 */

.equ  FSMC_PMEM4_MEMWAIT4                 ,0x0000FF00         @<MEMWAIT4[7:0] bits (Common memory 4 wait time) */
.equ  FSMC_PMEM4_MEMWAIT4_0               ,0x00000100         @<Bit 0 */
.equ  FSMC_PMEM4_MEMWAIT4_1               ,0x00000200         @<Bit 1 */
.equ  FSMC_PMEM4_MEMWAIT4_2               ,0x00000400         @<Bit 2 */
.equ  FSMC_PMEM4_MEMWAIT4_3               ,0x00000800         @<Bit 3 */
.equ  FSMC_PMEM4_MEMWAIT4_4               ,0x00001000         @<Bit 4 */
.equ  FSMC_PMEM4_MEMWAIT4_5               ,0x00002000         @<Bit 5 */
.equ  FSMC_PMEM4_MEMWAIT4_6               ,0x00004000         @<Bit 6 */
.equ  FSMC_PMEM4_MEMWAIT4_7               ,0x00008000         @<Bit 7 */

.equ  FSMC_PMEM4_MEMHOLD4                 ,0x00FF0000         @<MEMHOLD4[7:0] bits (Common memory 4 hold time) */
.equ  FSMC_PMEM4_MEMHOLD4_0               ,0x00010000         @<Bit 0 */
.equ  FSMC_PMEM4_MEMHOLD4_1               ,0x00020000         @<Bit 1 */
.equ  FSMC_PMEM4_MEMHOLD4_2               ,0x00040000         @<Bit 2 */
.equ  FSMC_PMEM4_MEMHOLD4_3               ,0x00080000         @<Bit 3 */
.equ  FSMC_PMEM4_MEMHOLD4_4               ,0x00100000         @<Bit 4 */
.equ  FSMC_PMEM4_MEMHOLD4_5               ,0x00200000         @<Bit 5 */
.equ  FSMC_PMEM4_MEMHOLD4_6               ,0x00400000         @<Bit 6 */
.equ  FSMC_PMEM4_MEMHOLD4_7               ,0x00800000         @<Bit 7 */

.equ  FSMC_PMEM4_MEMHIZ4                  ,0xFF000000         @<MEMHIZ4[7:0] bits (Common memory 4 databus HiZ time) */
.equ  FSMC_PMEM4_MEMHIZ4_0                ,0x01000000         @<Bit 0 */
.equ  FSMC_PMEM4_MEMHIZ4_1                ,0x02000000         @<Bit 1 */
.equ  FSMC_PMEM4_MEMHIZ4_2                ,0x04000000         @<Bit 2 */
.equ  FSMC_PMEM4_MEMHIZ4_3                ,0x08000000         @<Bit 3 */
.equ  FSMC_PMEM4_MEMHIZ4_4                ,0x10000000         @<Bit 4 */
.equ  FSMC_PMEM4_MEMHIZ4_5                ,0x20000000         @<Bit 5 */
.equ  FSMC_PMEM4_MEMHIZ4_6                ,0x40000000         @<Bit 6 */
.equ  FSMC_PMEM4_MEMHIZ4_7                ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_PATT2 register  ******************/
.equ  FSMC_PATT2_ATTSET2                  ,0x000000FF         @<ATTSET2[7:0] bits (Attribute memory 2 setup time) */
.equ  FSMC_PATT2_ATTSET2_0                ,0x00000001         @<Bit 0 */
.equ  FSMC_PATT2_ATTSET2_1                ,0x00000002         @<Bit 1 */
.equ  FSMC_PATT2_ATTSET2_2                ,0x00000004         @<Bit 2 */
.equ  FSMC_PATT2_ATTSET2_3                ,0x00000008         @<Bit 3 */
.equ  FSMC_PATT2_ATTSET2_4                ,0x00000010         @<Bit 4 */
.equ  FSMC_PATT2_ATTSET2_5                ,0x00000020         @<Bit 5 */
.equ  FSMC_PATT2_ATTSET2_6                ,0x00000040         @<Bit 6 */
.equ  FSMC_PATT2_ATTSET2_7                ,0x00000080         @<Bit 7 */

.equ  FSMC_PATT2_ATTWAIT2                 ,0x0000FF00         @<ATTWAIT2[7:0] bits (Attribute memory 2 wait time) */
.equ  FSMC_PATT2_ATTWAIT2_0               ,0x00000100         @<Bit 0 */
.equ  FSMC_PATT2_ATTWAIT2_1               ,0x00000200         @<Bit 1 */
.equ  FSMC_PATT2_ATTWAIT2_2               ,0x00000400         @<Bit 2 */
.equ  FSMC_PATT2_ATTWAIT2_3               ,0x00000800         @<Bit 3 */
.equ  FSMC_PATT2_ATTWAIT2_4               ,0x00001000         @<Bit 4 */
.equ  FSMC_PATT2_ATTWAIT2_5               ,0x00002000         @<Bit 5 */
.equ  FSMC_PATT2_ATTWAIT2_6               ,0x00004000         @<Bit 6 */
.equ  FSMC_PATT2_ATTWAIT2_7               ,0x00008000         @<Bit 7 */

.equ  FSMC_PATT2_ATTHOLD2                 ,0x00FF0000         @<ATTHOLD2[7:0] bits (Attribute memory 2 hold time) */
.equ  FSMC_PATT2_ATTHOLD2_0               ,0x00010000         @<Bit 0 */
.equ  FSMC_PATT2_ATTHOLD2_1               ,0x00020000         @<Bit 1 */
.equ  FSMC_PATT2_ATTHOLD2_2               ,0x00040000         @<Bit 2 */
.equ  FSMC_PATT2_ATTHOLD2_3               ,0x00080000         @<Bit 3 */
.equ  FSMC_PATT2_ATTHOLD2_4               ,0x00100000         @<Bit 4 */
.equ  FSMC_PATT2_ATTHOLD2_5               ,0x00200000         @<Bit 5 */
.equ  FSMC_PATT2_ATTHOLD2_6               ,0x00400000         @<Bit 6 */
.equ  FSMC_PATT2_ATTHOLD2_7               ,0x00800000         @<Bit 7 */

.equ  FSMC_PATT2_ATTHIZ2                  ,0xFF000000         @<ATTHIZ2[7:0] bits (Attribute memory 2 databus HiZ time) */
.equ  FSMC_PATT2_ATTHIZ2_0                ,0x01000000         @<Bit 0 */
.equ  FSMC_PATT2_ATTHIZ2_1                ,0x02000000         @<Bit 1 */
.equ  FSMC_PATT2_ATTHIZ2_2                ,0x04000000         @<Bit 2 */
.equ  FSMC_PATT2_ATTHIZ2_3                ,0x08000000         @<Bit 3 */
.equ  FSMC_PATT2_ATTHIZ2_4                ,0x10000000         @<Bit 4 */
.equ  FSMC_PATT2_ATTHIZ2_5                ,0x20000000         @<Bit 5 */
.equ  FSMC_PATT2_ATTHIZ2_6                ,0x40000000         @<Bit 6 */
.equ  FSMC_PATT2_ATTHIZ2_7                ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_PATT3 register  ******************/
.equ  FSMC_PATT3_ATTSET3                  ,0x000000FF         @<ATTSET3[7:0] bits (Attribute memory 3 setup time) */
.equ  FSMC_PATT3_ATTSET3_0                ,0x00000001         @<Bit 0 */
.equ  FSMC_PATT3_ATTSET3_1                ,0x00000002         @<Bit 1 */
.equ  FSMC_PATT3_ATTSET3_2                ,0x00000004         @<Bit 2 */
.equ  FSMC_PATT3_ATTSET3_3                ,0x00000008         @<Bit 3 */
.equ  FSMC_PATT3_ATTSET3_4                ,0x00000010         @<Bit 4 */
.equ  FSMC_PATT3_ATTSET3_5                ,0x00000020         @<Bit 5 */
.equ  FSMC_PATT3_ATTSET3_6                ,0x00000040         @<Bit 6 */
.equ  FSMC_PATT3_ATTSET3_7                ,0x00000080         @<Bit 7 */

.equ  FSMC_PATT3_ATTWAIT3                 ,0x0000FF00         @<ATTWAIT3[7:0] bits (Attribute memory 3 wait time) */
.equ  FSMC_PATT3_ATTWAIT3_0               ,0x00000100         @<Bit 0 */
.equ  FSMC_PATT3_ATTWAIT3_1               ,0x00000200         @<Bit 1 */
.equ  FSMC_PATT3_ATTWAIT3_2               ,0x00000400         @<Bit 2 */
.equ  FSMC_PATT3_ATTWAIT3_3               ,0x00000800         @<Bit 3 */
.equ  FSMC_PATT3_ATTWAIT3_4               ,0x00001000         @<Bit 4 */
.equ  FSMC_PATT3_ATTWAIT3_5               ,0x00002000         @<Bit 5 */
.equ  FSMC_PATT3_ATTWAIT3_6               ,0x00004000         @<Bit 6 */
.equ  FSMC_PATT3_ATTWAIT3_7               ,0x00008000         @<Bit 7 */

.equ  FSMC_PATT3_ATTHOLD3                 ,0x00FF0000         @<ATTHOLD3[7:0] bits (Attribute memory 3 hold time) */
.equ  FSMC_PATT3_ATTHOLD3_0               ,0x00010000         @<Bit 0 */
.equ  FSMC_PATT3_ATTHOLD3_1               ,0x00020000         @<Bit 1 */
.equ  FSMC_PATT3_ATTHOLD3_2               ,0x00040000         @<Bit 2 */
.equ  FSMC_PATT3_ATTHOLD3_3               ,0x00080000         @<Bit 3 */
.equ  FSMC_PATT3_ATTHOLD3_4               ,0x00100000         @<Bit 4 */
.equ  FSMC_PATT3_ATTHOLD3_5               ,0x00200000         @<Bit 5 */
.equ  FSMC_PATT3_ATTHOLD3_6               ,0x00400000         @<Bit 6 */
.equ  FSMC_PATT3_ATTHOLD3_7               ,0x00800000         @<Bit 7 */

.equ  FSMC_PATT3_ATTHIZ3                  ,0xFF000000         @<ATTHIZ3[7:0] bits (Attribute memory 3 databus HiZ time) */
.equ  FSMC_PATT3_ATTHIZ3_0                ,0x01000000         @<Bit 0 */
.equ  FSMC_PATT3_ATTHIZ3_1                ,0x02000000         @<Bit 1 */
.equ  FSMC_PATT3_ATTHIZ3_2                ,0x04000000         @<Bit 2 */
.equ  FSMC_PATT3_ATTHIZ3_3                ,0x08000000         @<Bit 3 */
.equ  FSMC_PATT3_ATTHIZ3_4                ,0x10000000         @<Bit 4 */
.equ  FSMC_PATT3_ATTHIZ3_5                ,0x20000000         @<Bit 5 */
.equ  FSMC_PATT3_ATTHIZ3_6                ,0x40000000         @<Bit 6 */
.equ  FSMC_PATT3_ATTHIZ3_7                ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_PATT4 register  ******************/
.equ  FSMC_PATT4_ATTSET4                  ,0x000000FF         @<ATTSET4[7:0] bits (Attribute memory 4 setup time) */
.equ  FSMC_PATT4_ATTSET4_0                ,0x00000001         @<Bit 0 */
.equ  FSMC_PATT4_ATTSET4_1                ,0x00000002         @<Bit 1 */
.equ  FSMC_PATT4_ATTSET4_2                ,0x00000004         @<Bit 2 */
.equ  FSMC_PATT4_ATTSET4_3                ,0x00000008         @<Bit 3 */
.equ  FSMC_PATT4_ATTSET4_4                ,0x00000010         @<Bit 4 */
.equ  FSMC_PATT4_ATTSET4_5                ,0x00000020         @<Bit 5 */
.equ  FSMC_PATT4_ATTSET4_6                ,0x00000040         @<Bit 6 */
.equ  FSMC_PATT4_ATTSET4_7                ,0x00000080         @<Bit 7 */

.equ  FSMC_PATT4_ATTWAIT4                 ,0x0000FF00         @<ATTWAIT4[7:0] bits (Attribute memory 4 wait time) */
.equ  FSMC_PATT4_ATTWAIT4_0               ,0x00000100         @<Bit 0 */
.equ  FSMC_PATT4_ATTWAIT4_1               ,0x00000200         @<Bit 1 */
.equ  FSMC_PATT4_ATTWAIT4_2               ,0x00000400         @<Bit 2 */
.equ  FSMC_PATT4_ATTWAIT4_3               ,0x00000800         @<Bit 3 */
.equ  FSMC_PATT4_ATTWAIT4_4               ,0x00001000         @<Bit 4 */
.equ  FSMC_PATT4_ATTWAIT4_5               ,0x00002000         @<Bit 5 */
.equ  FSMC_PATT4_ATTWAIT4_6               ,0x00004000         @<Bit 6 */
.equ  FSMC_PATT4_ATTWAIT4_7               ,0x00008000         @<Bit 7 */

.equ  FSMC_PATT4_ATTHOLD4                 ,0x00FF0000         @<ATTHOLD4[7:0] bits (Attribute memory 4 hold time) */
.equ  FSMC_PATT4_ATTHOLD4_0               ,0x00010000         @<Bit 0 */
.equ  FSMC_PATT4_ATTHOLD4_1               ,0x00020000         @<Bit 1 */
.equ  FSMC_PATT4_ATTHOLD4_2               ,0x00040000         @<Bit 2 */
.equ  FSMC_PATT4_ATTHOLD4_3               ,0x00080000         @<Bit 3 */
.equ  FSMC_PATT4_ATTHOLD4_4               ,0x00100000         @<Bit 4 */
.equ  FSMC_PATT4_ATTHOLD4_5               ,0x00200000         @<Bit 5 */
.equ  FSMC_PATT4_ATTHOLD4_6               ,0x00400000         @<Bit 6 */
.equ  FSMC_PATT4_ATTHOLD4_7               ,0x00800000         @<Bit 7 */

.equ  FSMC_PATT4_ATTHIZ4                  ,0xFF000000         @<ATTHIZ4[7:0] bits (Attribute memory 4 databus HiZ time) */
.equ  FSMC_PATT4_ATTHIZ4_0                ,0x01000000         @<Bit 0 */
.equ  FSMC_PATT4_ATTHIZ4_1                ,0x02000000         @<Bit 1 */
.equ  FSMC_PATT4_ATTHIZ4_2                ,0x04000000         @<Bit 2 */
.equ  FSMC_PATT4_ATTHIZ4_3                ,0x08000000         @<Bit 3 */
.equ  FSMC_PATT4_ATTHIZ4_4                ,0x10000000         @<Bit 4 */
.equ  FSMC_PATT4_ATTHIZ4_5                ,0x20000000         @<Bit 5 */
.equ  FSMC_PATT4_ATTHIZ4_6                ,0x40000000         @<Bit 6 */
.equ  FSMC_PATT4_ATTHIZ4_7                ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_PIO4 register  *******************/
.equ  FSMC_PIO4_IOSET4                    ,0x000000FF         @<IOSET4[7:0] bits (I/O 4 setup time) */
.equ  FSMC_PIO4_IOSET4_0                  ,0x00000001         @<Bit 0 */
.equ  FSMC_PIO4_IOSET4_1                  ,0x00000002         @<Bit 1 */
.equ  FSMC_PIO4_IOSET4_2                  ,0x00000004         @<Bit 2 */
.equ  FSMC_PIO4_IOSET4_3                  ,0x00000008         @<Bit 3 */
.equ  FSMC_PIO4_IOSET4_4                  ,0x00000010         @<Bit 4 */
.equ  FSMC_PIO4_IOSET4_5                  ,0x00000020         @<Bit 5 */
.equ  FSMC_PIO4_IOSET4_6                  ,0x00000040         @<Bit 6 */
.equ  FSMC_PIO4_IOSET4_7                  ,0x00000080         @<Bit 7 */

.equ  FSMC_PIO4_IOWAIT4                   ,0x0000FF00         @<IOWAIT4[7:0] bits (I/O 4 wait time) */
.equ  FSMC_PIO4_IOWAIT4_0                 ,0x00000100         @<Bit 0 */
.equ  FSMC_PIO4_IOWAIT4_1                 ,0x00000200         @<Bit 1 */
.equ  FSMC_PIO4_IOWAIT4_2                 ,0x00000400         @<Bit 2 */
.equ  FSMC_PIO4_IOWAIT4_3                 ,0x00000800         @<Bit 3 */
.equ  FSMC_PIO4_IOWAIT4_4                 ,0x00001000         @<Bit 4 */
.equ  FSMC_PIO4_IOWAIT4_5                 ,0x00002000         @<Bit 5 */
.equ  FSMC_PIO4_IOWAIT4_6                 ,0x00004000         @<Bit 6 */
.equ  FSMC_PIO4_IOWAIT4_7                 ,0x00008000         @<Bit 7 */

.equ  FSMC_PIO4_IOHOLD4                   ,0x00FF0000         @<IOHOLD4[7:0] bits (I/O 4 hold time) */
.equ  FSMC_PIO4_IOHOLD4_0                 ,0x00010000         @<Bit 0 */
.equ  FSMC_PIO4_IOHOLD4_1                 ,0x00020000         @<Bit 1 */
.equ  FSMC_PIO4_IOHOLD4_2                 ,0x00040000         @<Bit 2 */
.equ  FSMC_PIO4_IOHOLD4_3                 ,0x00080000         @<Bit 3 */
.equ  FSMC_PIO4_IOHOLD4_4                 ,0x00100000         @<Bit 4 */
.equ  FSMC_PIO4_IOHOLD4_5                 ,0x00200000         @<Bit 5 */
.equ  FSMC_PIO4_IOHOLD4_6                 ,0x00400000         @<Bit 6 */
.equ  FSMC_PIO4_IOHOLD4_7                 ,0x00800000         @<Bit 7 */

.equ  FSMC_PIO4_IOHIZ4                    ,0xFF000000         @<IOHIZ4[7:0] bits (I/O 4 databus HiZ time) */
.equ  FSMC_PIO4_IOHIZ4_0                  ,0x01000000         @<Bit 0 */
.equ  FSMC_PIO4_IOHIZ4_1                  ,0x02000000         @<Bit 1 */
.equ  FSMC_PIO4_IOHIZ4_2                  ,0x04000000         @<Bit 2 */
.equ  FSMC_PIO4_IOHIZ4_3                  ,0x08000000         @<Bit 3 */
.equ  FSMC_PIO4_IOHIZ4_4                  ,0x10000000         @<Bit 4 */
.equ  FSMC_PIO4_IOHIZ4_5                  ,0x20000000         @<Bit 5 */
.equ  FSMC_PIO4_IOHIZ4_6                  ,0x40000000         @<Bit 6 */
.equ  FSMC_PIO4_IOHIZ4_7                  ,0x80000000         @<Bit 7 */

@*****************  Bit definition for FSMC_ECCR2 register  ******************/
.equ  FSMC_ECCR2_ECC2                     ,0xFFFFFFFF         @<ECC result */

@*****************  Bit definition for FSMC_ECCR3 register  ******************/
.equ  FSMC_ECCR3_ECC3                     ,0xFFFFFFFF         @<ECC result */

@******************************************************************************/
@*                                                                            */
@*                            General Purpose I/O                             */
@*                                                                            */
@******************************************************************************/
.equ GPIO_MODER				  ,0x00
@*****************  Bits definition for GPIO_MODER register  *****************/
.equ GPIO_MODER_MODER_INPUT		          ,0x00000000
.equ GPIO_MODER_MODER_GENERAL_OUT         ,0x00000001
.equ GPIO_MODER_MODER_ALT_MODE            ,0x00000002
.equ GPIO_MODER_MODER_ANALOG_MODE         ,0x00000003

.equ GPIO_MODER_MODER0                    ,0x00000003
.equ GPIO_MODER_MODER0_0                  ,0x00000001
.equ GPIO_MODER_MODER0_1                  ,0x00000002

.equ GPIO_MODER_MODER1                    ,0x0000000C
.equ GPIO_MODER_MODER1_0                  ,0x00000004
.equ GPIO_MODER_MODER1_1                  ,0x00000008

.equ GPIO_MODER_MODER2                    ,0x00000030
.equ GPIO_MODER_MODER2_0                  ,0x00000010
.equ GPIO_MODER_MODER2_1                  ,0x00000020

.equ GPIO_MODER_MODER3                    ,0x000000C0
.equ GPIO_MODER_MODER3_0                  ,0x00000040
.equ GPIO_MODER_MODER3_1                  ,0x00000080

.equ GPIO_MODER_MODER4                    ,0x00000300
.equ GPIO_MODER_MODER4_0                  ,0x00000100
.equ GPIO_MODER_MODER4_1                  ,0x00000200

.equ GPIO_MODER_MODER5                    ,0x00000C00
.equ GPIO_MODER_MODER5_0                  ,0x00000400
.equ GPIO_MODER_MODER5_1                  ,0x00000800

.equ GPIO_MODER_MODER6                    ,0x00003000
.equ GPIO_MODER_MODER6_0                  ,0x00001000
.equ GPIO_MODER_MODER6_1                  ,0x00002000

.equ GPIO_MODER_MODER7                    ,0x0000C000
.equ GPIO_MODER_MODER7_0                  ,0x00004000
.equ GPIO_MODER_MODER7_1                  ,0x00008000

.equ GPIO_MODER_MODER8                    ,0x00030000
.equ GPIO_MODER_MODER8_0                  ,0x00010000
.equ GPIO_MODER_MODER8_1                  ,0x00020000

.equ GPIO_MODER_MODER9                    ,0x000C0000
.equ GPIO_MODER_MODER9_0                  ,0x00040000
.equ GPIO_MODER_MODER9_1                  ,0x00080000

.equ GPIO_MODER_MODER10                   ,0x00300000
.equ GPIO_MODER_MODER10_0                 ,0x00100000
.equ GPIO_MODER_MODER10_1                 ,0x00200000

.equ GPIO_MODER_MODER11                   ,0x00C00000
.equ GPIO_MODER_MODER11_0                 ,0x00400000
.equ GPIO_MODER_MODER11_1                 ,0x00800000

.equ GPIO_MODER_MODER12                   ,0x03000000
.equ GPIO_MODER_MODER12_0                 ,0x01000000
.equ GPIO_MODER_MODER12_1                 ,0x02000000

.equ GPIO_MODER_MODER13                   ,0x0C000000
.equ GPIO_MODER_MODER13_0                 ,0x04000000
.equ GPIO_MODER_MODER13_1                 ,0x08000000

.equ GPIO_MODER_MODER14                   ,0x30000000
.equ GPIO_MODER_MODER14_0                 ,0x10000000
.equ GPIO_MODER_MODER14_1                 ,0x20000000

.equ GPIO_MODER_MODER15                   ,0xC0000000
.equ GPIO_MODER_MODER15_0                 ,0x40000000
.equ GPIO_MODER_MODER15_1                 ,0x80000000

.equ GPIO_OTYPER			  ,0x04
@*****************  Bits definition for GPIO_OTYPER register  ****************/
.equ GPIO_OTYPER_OT_0                     ,0x00000001
.equ GPIO_OTYPER_OT_1                     ,0x00000002
.equ GPIO_OTYPER_OT_2                     ,0x00000004
.equ GPIO_OTYPER_OT_3                     ,0x00000008
.equ GPIO_OTYPER_OT_4                     ,0x00000010
.equ GPIO_OTYPER_OT_5                     ,0x00000020
.equ GPIO_OTYPER_OT_6                     ,0x00000040
.equ GPIO_OTYPER_OT_7                     ,0x00000080
.equ GPIO_OTYPER_OT_8                     ,0x00000100
.equ GPIO_OTYPER_OT_9                     ,0x00000200
.equ GPIO_OTYPER_OT_10                    ,0x00000400
.equ GPIO_OTYPER_OT_11                    ,0x00000800
.equ GPIO_OTYPER_OT_12                    ,0x00001000
.equ GPIO_OTYPER_OT_13                    ,0x00002000
.equ GPIO_OTYPER_OT_14                    ,0x00004000
.equ GPIO_OTYPER_OT_15                    ,0x00008000

.equ GPIO_OSPEEDR                         ,0x08
@*****************  Bits definition for GPIO_OSPEEDR register  ***************/
.equ GPIO_OSPEEDER_LS		              ,0x00000000  @ Low speed
.equ GPIO_OSPEEDER_MD		              ,0x00000001  @ Medium speed
.equ GPIO_OSPEEDER_HS		              ,0x00000002  @ High speed
.equ GPIO_OSPEEDER_VH		              ,0x00000003  @ Very high speed
 
.equ GPIO_OSPEEDER_OSPEEDR0               ,0x00000003
.equ GPIO_OSPEEDER_OSPEEDR0_0             ,0x00000001
.equ GPIO_OSPEEDER_OSPEEDR0_1             ,0x00000002

.equ GPIO_OSPEEDER_OSPEEDR1               ,0x0000000C
.equ GPIO_OSPEEDER_OSPEEDR1_0             ,0x00000004
.equ GPIO_OSPEEDER_OSPEEDR1_1             ,0x00000008

.equ GPIO_OSPEEDER_OSPEEDR2               ,0x00000030
.equ GPIO_OSPEEDER_OSPEEDR2_0             ,0x00000010
.equ GPIO_OSPEEDER_OSPEEDR2_1             ,0x00000020

.equ GPIO_OSPEEDER_OSPEEDR3               ,0x000000C0
.equ GPIO_OSPEEDER_OSPEEDR3_0             ,0x00000040
.equ GPIO_OSPEEDER_OSPEEDR3_1             ,0x00000080

.equ GPIO_OSPEEDER_OSPEEDR4               ,0x00000300
.equ GPIO_OSPEEDER_OSPEEDR4_0             ,0x00000100
.equ GPIO_OSPEEDER_OSPEEDR4_1             ,0x00000200

.equ GPIO_OSPEEDER_OSPEEDR5               ,0x00000C00
.equ GPIO_OSPEEDER_OSPEEDR5_0             ,0x00000400
.equ GPIO_OSPEEDER_OSPEEDR5_1             ,0x00000800

.equ GPIO_OSPEEDER_OSPEEDR6               ,0x00003000
.equ GPIO_OSPEEDER_OSPEEDR6_0             ,0x00001000
.equ GPIO_OSPEEDER_OSPEEDR6_1             ,0x00002000

.equ GPIO_OSPEEDER_OSPEEDR7               ,0x0000C000
.equ GPIO_OSPEEDER_OSPEEDR7_0             ,0x00004000
.equ GPIO_OSPEEDER_OSPEEDR7_1             ,0x00008000

.equ GPIO_OSPEEDER_OSPEEDR8               ,0x00030000
.equ GPIO_OSPEEDER_OSPEEDR8_0             ,0x00010000
.equ GPIO_OSPEEDER_OSPEEDR8_1             ,0x00020000

.equ GPIO_OSPEEDER_OSPEEDR9               ,0x000C0000
.equ GPIO_OSPEEDER_OSPEEDR9_0             ,0x00040000
.equ GPIO_OSPEEDER_OSPEEDR9_1             ,0x00080000

.equ GPIO_OSPEEDER_OSPEEDR10              ,0x00300000
.equ GPIO_OSPEEDER_OSPEEDR10_0            ,0x00100000
.equ GPIO_OSPEEDER_OSPEEDR10_1            ,0x00200000

.equ GPIO_OSPEEDER_OSPEEDR11              ,0x00C00000
.equ GPIO_OSPEEDER_OSPEEDR11_0            ,0x00400000
.equ GPIO_OSPEEDER_OSPEEDR11_1            ,0x00800000

.equ GPIO_OSPEEDER_OSPEEDR12              ,0x03000000
.equ GPIO_OSPEEDER_OSPEEDR12_0            ,0x01000000
.equ GPIO_OSPEEDER_OSPEEDR12_1            ,0x02000000

.equ GPIO_OSPEEDER_OSPEEDR13              ,0x0C000000
.equ GPIO_OSPEEDER_OSPEEDR13_0            ,0x04000000
.equ GPIO_OSPEEDER_OSPEEDR13_1            ,0x08000000

.equ GPIO_OSPEEDER_OSPEEDR14              ,0x30000000
.equ GPIO_OSPEEDER_OSPEEDR14_0            ,0x10000000
.equ GPIO_OSPEEDER_OSPEEDR14_1            ,0x20000000

.equ GPIO_OSPEEDER_OSPEEDR15              ,0xC0000000
.equ GPIO_OSPEEDER_OSPEEDR15_0            ,0x40000000
.equ GPIO_OSPEEDER_OSPEEDR15_1            ,0x80000000

.equ GPIO_PUPDR                           ,0x0C
@*****************  Bits definition for GPIO_PUPDR register  *****************/
.equ GPIO_PUPDR_PUPDR0                    ,0x00000003
.equ GPIO_PUPDR_PUPDR0_0                  ,0x00000001
.equ GPIO_PUPDR_PUPDR0_1                  ,0x00000002

.equ GPIO_PUPDR_PUPDR1                    ,0x0000000C
.equ GPIO_PUPDR_PUPDR1_0                  ,0x00000004
.equ GPIO_PUPDR_PUPDR1_1                  ,0x00000008

.equ GPIO_PUPDR_PUPDR2                    ,0x00000030
.equ GPIO_PUPDR_PUPDR2_0                  ,0x00000010
.equ GPIO_PUPDR_PUPDR2_1                  ,0x00000020

.equ GPIO_PUPDR_PUPDR3                    ,0x000000C0
.equ GPIO_PUPDR_PUPDR3_0                  ,0x00000040
.equ GPIO_PUPDR_PUPDR3_1                  ,0x00000080

.equ GPIO_PUPDR_PUPDR4                    ,0x00000300
.equ GPIO_PUPDR_PUPDR4_0                  ,0x00000100
.equ GPIO_PUPDR_PUPDR4_1                  ,0x00000200

.equ GPIO_PUPDR_PUPDR5                    ,0x00000C00
.equ GPIO_PUPDR_PUPDR5_0                  ,0x00000400
.equ GPIO_PUPDR_PUPDR5_1                  ,0x00000800

.equ GPIO_PUPDR_PUPDR6                    ,0x00003000
.equ GPIO_PUPDR_PUPDR6_0                  ,0x00001000
.equ GPIO_PUPDR_PUPDR6_1                  ,0x00002000

.equ GPIO_PUPDR_PUPDR7                    ,0x0000C000
.equ GPIO_PUPDR_PUPDR7_0                  ,0x00004000
.equ GPIO_PUPDR_PUPDR7_1                  ,0x00008000

.equ GPIO_PUPDR_PUPDR8                    ,0x00030000
.equ GPIO_PUPDR_PUPDR8_0                  ,0x00010000
.equ GPIO_PUPDR_PUPDR8_1                  ,0x00020000

.equ GPIO_PUPDR_PUPDR9                    ,0x000C0000
.equ GPIO_PUPDR_PUPDR9_0                  ,0x00040000
.equ GPIO_PUPDR_PUPDR9_1                  ,0x00080000

.equ GPIO_PUPDR_PUPDR10                   ,0x00300000
.equ GPIO_PUPDR_PUPDR10_0                 ,0x00100000
.equ GPIO_PUPDR_PUPDR10_1                 ,0x00200000

.equ GPIO_PUPDR_PUPDR11                   ,0x00C00000
.equ GPIO_PUPDR_PUPDR11_0                 ,0x00400000
.equ GPIO_PUPDR_PUPDR11_1                 ,0x00800000

.equ GPIO_PUPDR_PUPDR12                   ,0x03000000
.equ GPIO_PUPDR_PUPDR12_0                 ,0x01000000
.equ GPIO_PUPDR_PUPDR12_1                 ,0x02000000

.equ GPIO_PUPDR_PUPDR13                   ,0x0C000000
.equ GPIO_PUPDR_PUPDR13_0                 ,0x04000000
.equ GPIO_PUPDR_PUPDR13_1                 ,0x08000000

.equ GPIO_PUPDR_PUPDR14                   ,0x30000000
.equ GPIO_PUPDR_PUPDR14_0                 ,0x10000000
.equ GPIO_PUPDR_PUPDR14_1                 ,0x20000000

.equ GPIO_PUPDR_PUPDR15                   ,0xC0000000
.equ GPIO_PUPDR_PUPDR15_0                 ,0x40000000
.equ GPIO_PUPDR_PUPDR15_1                 ,0x80000000

.equ GPIO_IDR			          ,0x10
@*****************  Bits definition for GPIO_IDR register  *******************/
.equ GPIO_IDR_IDR_0                       ,0x00000001
.equ GPIO_IDR_IDR_1                       ,0x00000002
.equ GPIO_IDR_IDR_2                       ,0x00000004
.equ GPIO_IDR_IDR_3                       ,0x00000008
.equ GPIO_IDR_IDR_4                       ,0x00000010
.equ GPIO_IDR_IDR_5                       ,0x00000020
.equ GPIO_IDR_IDR_6                       ,0x00000040
.equ GPIO_IDR_IDR_7                       ,0x00000080
.equ GPIO_IDR_IDR_8                       ,0x00000100
.equ GPIO_IDR_IDR_9                       ,0x00000200
.equ GPIO_IDR_IDR_10                      ,0x00000400
.equ GPIO_IDR_IDR_11                      ,0x00000800
.equ GPIO_IDR_IDR_12                      ,0x00001000
.equ GPIO_IDR_IDR_13                      ,0x00002000
.equ GPIO_IDR_IDR_14                      ,0x00004000
.equ GPIO_IDR_IDR_15                      ,0x00008000
@ Old GPIO_IDR register bits definition, maintained for legacy purpose */
.equ GPIO_OTYPER_IDR_0                    ,GPIO_IDR_IDR_0
.equ GPIO_OTYPER_IDR_1                    ,GPIO_IDR_IDR_1
.equ GPIO_OTYPER_IDR_2                    ,GPIO_IDR_IDR_2
.equ GPIO_OTYPER_IDR_3                    ,GPIO_IDR_IDR_3
.equ GPIO_OTYPER_IDR_4                    ,GPIO_IDR_IDR_4
.equ GPIO_OTYPER_IDR_5                    ,GPIO_IDR_IDR_5
.equ GPIO_OTYPER_IDR_6                    ,GPIO_IDR_IDR_6
.equ GPIO_OTYPER_IDR_7                    ,GPIO_IDR_IDR_7
.equ GPIO_OTYPER_IDR_8                    ,GPIO_IDR_IDR_8
.equ GPIO_OTYPER_IDR_9                    ,GPIO_IDR_IDR_9
.equ GPIO_OTYPER_IDR_10                   ,GPIO_IDR_IDR_10
.equ GPIO_OTYPER_IDR_11                   ,GPIO_IDR_IDR_11
.equ GPIO_OTYPER_IDR_12                   ,GPIO_IDR_IDR_12
.equ GPIO_OTYPER_IDR_13                   ,GPIO_IDR_IDR_13
.equ GPIO_OTYPER_IDR_14                   ,GPIO_IDR_IDR_14
.equ GPIO_OTYPER_IDR_15                   ,GPIO_IDR_IDR_15

.equ GPIO_ODR                             ,0x14                            
@*****************  Bits definition for GPIO_ODR register  *******************/
.equ GPIO_ODR_ODR_0                       ,0x00000001
.equ GPIO_ODR_ODR_1                       ,0x00000002
.equ GPIO_ODR_ODR_2                       ,0x00000004
.equ GPIO_ODR_ODR_3                       ,0x00000008
.equ GPIO_ODR_ODR_4                       ,0x00000010
.equ GPIO_ODR_ODR_5                       ,0x00000020
.equ GPIO_ODR_ODR_6                       ,0x00000040
.equ GPIO_ODR_ODR_7                       ,0x00000080
.equ GPIO_ODR_ODR_8                       ,0x00000100
.equ GPIO_ODR_ODR_9                       ,0x00000200
.equ GPIO_ODR_ODR_10                      ,0x00000400
.equ GPIO_ODR_ODR_11                      ,0x00000800
.equ GPIO_ODR_ODR_12                      ,0x00001000
.equ GPIO_ODR_ODR_13                      ,0x00002000
.equ GPIO_ODR_ODR_14                      ,0x00004000
.equ GPIO_ODR_ODR_15                      ,0x00008000

@ Old GPIO_ODR register bits definition, maintained for legacy purpose */
.equ GPIO_OTYPER_ODR_0                    ,GPIO_ODR_ODR_0
.equ GPIO_OTYPER_ODR_1                    ,GPIO_ODR_ODR_1
.equ GPIO_OTYPER_ODR_2                    ,GPIO_ODR_ODR_2
.equ GPIO_OTYPER_ODR_3                    ,GPIO_ODR_ODR_3
.equ GPIO_OTYPER_ODR_4                    ,GPIO_ODR_ODR_4
.equ GPIO_OTYPER_ODR_5                    ,GPIO_ODR_ODR_5
.equ GPIO_OTYPER_ODR_6                    ,GPIO_ODR_ODR_6
.equ GPIO_OTYPER_ODR_7                    ,GPIO_ODR_ODR_7
.equ GPIO_OTYPER_ODR_8                    ,GPIO_ODR_ODR_8
.equ GPIO_OTYPER_ODR_9                    ,GPIO_ODR_ODR_9
.equ GPIO_OTYPER_ODR_10                   ,GPIO_ODR_ODR_10
.equ GPIO_OTYPER_ODR_11                   ,GPIO_ODR_ODR_11
.equ GPIO_OTYPER_ODR_12                   ,GPIO_ODR_ODR_12
.equ GPIO_OTYPER_ODR_13                   ,GPIO_ODR_ODR_13
.equ GPIO_OTYPER_ODR_14                   ,GPIO_ODR_ODR_14
.equ GPIO_OTYPER_ODR_15                   ,GPIO_ODR_ODR_15

.equ GPIO_BSRR                            ,0x18
@*****************  Bits definition for GPIO_BSRR register  ******************/
.equ GPIO_BSRR_BS_0                       ,0x00000001
.equ GPIO_BSRR_BS_1                       ,0x00000002
.equ GPIO_BSRR_BS_2                       ,0x00000004
.equ GPIO_BSRR_BS_3                       ,0x00000008
.equ GPIO_BSRR_BS_4                       ,0x00000010
.equ GPIO_BSRR_BS_5                       ,0x00000020
.equ GPIO_BSRR_BS_6                       ,0x00000040
.equ GPIO_BSRR_BS_7                       ,0x00000080
.equ GPIO_BSRR_BS_8                       ,0x00000100
.equ GPIO_BSRR_BS_9                       ,0x00000200
.equ GPIO_BSRR_BS_10                      ,0x00000400
.equ GPIO_BSRR_BS_11                      ,0x00000800
.equ GPIO_BSRR_BS_12                      ,0x00001000
.equ GPIO_BSRR_BS_13                      ,0x00002000
.equ GPIO_BSRR_BS_14                      ,0x00004000
.equ GPIO_BSRR_BS_15                      ,0x00008000
.equ GPIO_BSRR_BR_0                       ,0x00010000
.equ GPIO_BSRR_BR_1                       ,0x00020000
.equ GPIO_BSRR_BR_2                       ,0x00040000
.equ GPIO_BSRR_BR_3                       ,0x00080000
.equ GPIO_BSRR_BR_4                       ,0x00100000
.equ GPIO_BSRR_BR_5                       ,0x00200000
.equ GPIO_BSRR_BR_6                       ,0x00400000
.equ GPIO_BSRR_BR_7                       ,0x00800000
.equ GPIO_BSRR_BR_8                       ,0x01000000
.equ GPIO_BSRR_BR_9                       ,0x02000000
.equ GPIO_BSRR_BR_10                      ,0x04000000
.equ GPIO_BSRR_BR_11                      ,0x08000000
.equ GPIO_BSRR_BR_12                      ,0x10000000
.equ GPIO_BSRR_BR_13                      ,0x20000000
.equ GPIO_BSRR_BR_14                      ,0x40000000
.equ GPIO_BSRR_BR_15                      ,0x80000000

.equ GPIO_LCKR				  ,0x1C

.equ GPIO_AFRL				  ,0x20  @ регистр указания альтернативных функций
.equ GPIO_AFRH				  ,0x24  @ регистр указания альтернативных функций
@*****************  Bits definition for GPIO_AFRx register  ********************/
.equ AFRx_MSK                         ,0x0F

.equ AFRx_AF0                         ,0x00
.equ AFRx_AF1                         ,0x01
.equ AFRx_AF2                         ,0x02
.equ AFRx_AF3                         ,0x03
.equ AFRx_AF4                         ,0x04
.equ AFRx_AF5                         ,0x05
.equ AFRx_AF6                         ,0x06
.equ AFRx_AF7                         ,0x07
.equ AFRx_AF8                         ,0x08
.equ AFRx_AF9                         ,0x09
.equ AFRx_AF10                        ,0x0A
.equ AFRx_AF11                        ,0x0B
.equ AFRx_AF12                        ,0x0C
.equ AFRx_AF13                        ,0x0D
.equ AFRx_AF14                        ,0x0E
.equ AFRx_AF15                        ,0x0F

@******************************************************************************/
@*                                                                            */
@*                                    HASH                                    */
@*                                                                            */
@******************************************************************************/
@*****************  Bits definition for HASH_CR register  ********************/
.equ HASH_CR_INIT                         ,0x00000004
.equ HASH_CR_DMAE                         ,0x00000008
.equ HASH_CR_DATATYPE                     ,0x00000030
.equ HASH_CR_DATATYPE_0                   ,0x00000010
.equ HASH_CR_DATATYPE_1                   ,0x00000020
.equ HASH_CR_MODE                         ,0x00000040
.equ HASH_CR_ALGO                         ,0x00000080
.equ HASH_CR_NBW                          ,0x00000F00
.equ HASH_CR_NBW_0                        ,0x00000100
.equ HASH_CR_NBW_1                        ,0x00000200
.equ HASH_CR_NBW_2                        ,0x00000400
.equ HASH_CR_NBW_3                        ,0x00000800
.equ HASH_CR_DINNE                        ,0x00001000
.equ HASH_CR_LKEY                         ,0x00010000

@*****************  Bits definition for HASH_STR register  *******************/
.equ HASH_STR_NBW                         ,0x0000001F
.equ HASH_STR_NBW_0                       ,0x00000001
.equ HASH_STR_NBW_1                       ,0x00000002
.equ HASH_STR_NBW_2                       ,0x00000004
.equ HASH_STR_NBW_3                       ,0x00000008
.equ HASH_STR_NBW_4                       ,0x00000010
.equ HASH_STR_DCAL                        ,0x00000100

@*****************  Bits definition for HASH_IMR register  *******************/
.equ HASH_IMR_DINIM                       ,0x00000001
.equ HASH_IMR_DCIM                        ,0x00000002

@*****************  Bits definition for HASH_SR register  ********************/
.equ HASH_SR_DINIS                        ,0x00000001
.equ HASH_SR_DCIS                         ,0x00000002
.equ HASH_SR_DMAS                         ,0x00000004
.equ HASH_SR_BUSY                         ,0x00000008

@******************************************************************************/
@*                                                                            */
@*                      Inter-integrated Circuit Interface                    */
@*                                                                            */
@******************************************************************************/
@******************  Bit definition for I2C_CR1 register  ********************/
.equ  I2C_CR1_PE                          ,0x0001            @<Peripheral Enable */
.equ  I2C_CR1_SMBUS                       ,0x0002            @<SMBus Mode */
.equ  I2C_CR1_SMBTYPE                     ,0x0008            @<SMBus Type */
.equ  I2C_CR1_ENARP                       ,0x0010            @<ARP Enable */
.equ  I2C_CR1_ENPEC                       ,0x0020            @<PEC Enable */
.equ  I2C_CR1_ENGC                        ,0x0040            @<General Call Enable */
.equ  I2C_CR1_NOSTRETCH                   ,0x0080            @<Clock Stretching Disable (Slave mode) */
.equ  I2C_CR1_START                       ,0x0100            @<Start Generation */
.equ  I2C_CR1_STOP                        ,0x0200            @<Stop Generation */
.equ  I2C_CR1_ACK                         ,0x0400            @<Acknowledge Enable */
.equ  I2C_CR1_POS                         ,0x0800            @<Acknowledge/PEC Position (for data reception) */
.equ  I2C_CR1_PEC                         ,0x1000            @<Packet Error Checking */
.equ  I2C_CR1_ALERT                       ,0x2000            @<SMBus Alert */
.equ  I2C_CR1_SWRST                       ,0x8000            @<Software Reset */

@******************  Bit definition for I2C_CR2 register  ********************/
.equ  I2C_CR2_FREQ                        ,0x003F            @<FREQ[5:0] bits (Peripheral Clock Frequency) */
.equ  I2C_CR2_FREQ_0                      ,0x0001            @<Bit 0 */
.equ  I2C_CR2_FREQ_1                      ,0x0002            @<Bit 1 */
.equ  I2C_CR2_FREQ_2                      ,0x0004            @<Bit 2 */
.equ  I2C_CR2_FREQ_3                      ,0x0008            @<Bit 3 */
.equ  I2C_CR2_FREQ_4                      ,0x0010            @<Bit 4 */
.equ  I2C_CR2_FREQ_5                      ,0x0020            @<Bit 5 */

.equ  I2C_CR2_ITERREN                     ,0x0100            @<Error Interrupt Enable */
.equ  I2C_CR2_ITEVTEN                     ,0x0200            @<Event Interrupt Enable */
.equ  I2C_CR2_ITBUFEN                     ,0x0400            @<Buffer Interrupt Enable */
.equ  I2C_CR2_DMAEN                       ,0x0800            @<DMA Requests Enable */
.equ  I2C_CR2_LAST                        ,0x1000            @<DMA Last Transfer */

@******************  Bit definition for I2C_OAR1 register  *******************/
.equ  I2C_OAR1_ADD1_7                     ,0x00FE            @<Interface Address */
.equ  I2C_OAR1_ADD8_9                     ,0x0300            @<Interface Address */

.equ  I2C_OAR1_ADD0                       ,0x0001            @<Bit 0 */
.equ  I2C_OAR1_ADD1                       ,0x0002            @<Bit 1 */
.equ  I2C_OAR1_ADD2                       ,0x0004            @<Bit 2 */
.equ  I2C_OAR1_ADD3                       ,0x0008            @<Bit 3 */
.equ  I2C_OAR1_ADD4                       ,0x0010            @<Bit 4 */
.equ  I2C_OAR1_ADD5                       ,0x0020            @<Bit 5 */
.equ  I2C_OAR1_ADD6                       ,0x0040            @<Bit 6 */
.equ  I2C_OAR1_ADD7                       ,0x0080            @<Bit 7 */
.equ  I2C_OAR1_ADD8                       ,0x0100            @<Bit 8 */
.equ  I2C_OAR1_ADD9                       ,0x0200            @<Bit 9 */

.equ  I2C_OAR1_ADDMODE                    ,0x8000            @<Addressing Mode (Slave mode) */

@******************  Bit definition for I2C_OAR2 register  *******************/
.equ  I2C_OAR2_ENDUAL                     ,0x01               @<Dual addressing mode enable */
.equ  I2C_OAR2_ADD2                       ,0xFE               @<Interface address */

@*******************  Bit definition for I2C_DR register  ********************/
.equ  I2C_DR_DR                           ,0xFF               @<8-bit Data Register */

@******************  Bit definition for I2C_SR1 register  ********************/
.equ  I2C_SR1_SB                          ,0x0001            @<Start Bit (Master mode) */
.equ  I2C_SR1_ADDR                        ,0x0002            @<Address sent (master mode)/matched (slave mode) */
.equ  I2C_SR1_BTF                         ,0x0004            @<Byte Transfer Finished */
.equ  I2C_SR1_ADD10                       ,0x0008            @<10-bit header sent (Master mode) */
.equ  I2C_SR1_STOPF                       ,0x0010            @<Stop detection (Slave mode) */
.equ  I2C_SR1_RXNE                        ,0x0040            @<Data Register not Empty (receivers) */
.equ  I2C_SR1_TXE                         ,0x0080            @<Data Register Empty (transmitters) */
.equ  I2C_SR1_BERR                        ,0x0100            @<Bus Error */
.equ  I2C_SR1_ARLO                        ,0x0200            @<Arbitration Lost (master mode) */
.equ  I2C_SR1_AF                          ,0x0400            @<Acknowledge Failure */
.equ  I2C_SR1_OVR                         ,0x0800            @<Overrun/Underrun */
.equ  I2C_SR1_PECERR                      ,0x1000            @<PEC Error in reception */
.equ  I2C_SR1_TIMEOUT                     ,0x4000            @<Timeout or Tlow Error */
.equ  I2C_SR1_SMBALERT                    ,0x8000            @<SMBus Alert */

@******************  Bit definition for I2C_SR2 register  ********************/
.equ  I2C_SR2_MSL                         ,0x0001            @<Master/Slave */
.equ  I2C_SR2_BUSY                        ,0x0002            @<Bus Busy */
.equ  I2C_SR2_TRA                         ,0x0004            @<Transmitter/Receiver */
.equ  I2C_SR2_GENCALL                     ,0x0010            @<General Call Address (Slave mode) */
.equ  I2C_SR2_SMBDEFAULT                  ,0x0020            @<SMBus Device Default Address (Slave mode) */
.equ  I2C_SR2_SMBHOST                     ,0x0040            @<SMBus Host Header (Slave mode) */
.equ  I2C_SR2_DUALF                       ,0x0080            @<Dual Flag (Slave mode) */
.equ  I2C_SR2_PEC                         ,0xFF00            @<Packet Error Checking Register */

@******************  Bit definition for I2C_CCR register  ********************/
.equ  I2C_CCR_CCR                         ,0x0FFF            @<Clock Control Register in Fast/Standard mode (Master mode) */
.equ  I2C_CCR_DUTY                        ,0x4000            @<Fast Mode Duty Cycle */
.equ  I2C_CCR_FS                          ,0x8000            @<I2C Master Mode Selection */

@*****************  Bit definition for I2C_TRISE register  *******************/
.equ  I2C_TRISE_TRISE                     ,0x3F               @<Maximum Rise Time in Fast/Standard mode (Master mode) */

@******************************************************************************/
@*                                                                            */
@*                           Independent WATCHDOG                             */
@*                                                                            */
@******************************************************************************/
@******************  Bit definition for IWDG_KR register  ********************/
.equ  IWDG_KR_KEY                         ,0xFFFF            @<Key value (write only, read 0000h) */

@******************  Bit definition for IWDG_PR register  ********************/
.equ  IWDG_PR_PR                          ,0x07               @<PR[2:0] (Prescaler divider) */
.equ  IWDG_PR_PR_0                        ,0x01               @<Bit 0 */
.equ  IWDG_PR_PR_1                        ,0x02               @<Bit 1 */
.equ  IWDG_PR_PR_2                        ,0x04               @<Bit 2 */

@******************  Bit definition for IWDG_RLR register  *******************/
.equ  IWDG_RLR_RL                         ,0x0FFF            @<Watchdog counter reload value */

@******************  Bit definition for IWDG_SR register  ********************/
.equ  IWDG_SR_PVU                         ,0x01               @<Watchdog prescaler value update */
.equ  IWDG_SR_RVU                         ,0x02               @<Watchdog counter reload value update */

@******************************************************************************/
@*                                                                            */
@*                             Power Control                                  */
@*                                                                            */
@******************************************************************************/
.equ  PWR_CR				  ,0x00000000
@*******************  Bit definition for PWR_CR register  ********************/
.equ  PWR_CR_LPDS                         ,0x0001     @< Low-Power Deepsleep */
.equ  PWR_CR_PDDS                         ,0x0002     @< Power Down Deepsleep */
.equ  PWR_CR_CWUF                         ,0x0004     @< Clear Wakeup Flag */
.equ  PWR_CR_CSBF                         ,0x0008     @< Clear Standby Flag */
.equ  PWR_CR_PVDE                         ,0x0010     @< Power Voltage Detector Enable */

.equ  PWR_CR_PLS                          ,0x00E0     @< PLS[2:0] bits (PVD Level Selection) */
.equ  PWR_CR_PLS_0                        ,0x0020     @< Bit 0 */
.equ  PWR_CR_PLS_1                        ,0x0040     @< Bit 1 */
.equ  PWR_CR_PLS_2                        ,0x0080     @< Bit 2 */


@< PVD level configuration */
.equ  PWR_CR_PLS_LEV0                     ,0x0000     @< PVD level 0 */
.equ  PWR_CR_PLS_LEV1                     ,0x0020     @< PVD level 1 */
.equ  PWR_CR_PLS_LEV2                     ,0x0040     @< PVD level 2 */
.equ  PWR_CR_PLS_LEV3                     ,0x0060     @< PVD level 3 */
.equ  PWR_CR_PLS_LEV4                     ,0x0080     @< PVD level 4 */
.equ  PWR_CR_PLS_LEV5                     ,0x00A0     @< PVD level 5 */
.equ  PWR_CR_PLS_LEV6                     ,0x00C0     @< PVD level 6 */
.equ  PWR_CR_PLS_LEV7                     ,0x00E0     @< PVD level 7 */

.equ  PWR_CR_DBP                          ,0x0100     @< Disable Backup Domain write protection */
.equ  PWR_CR_FPDS                         ,0x0200     @< Flash power down in Stop mode */
.equ  PWR_CR_VOS                          ,0x4000     @< Regulator voltage scaling output selection */
.equ  PWR_CR_VOS_N                        ,14         @< Regulator voltage scaling output selection */

@ Legacy define */
.equ  PWR_CR_PMODE                        ,PWR_CR_VOS

.equ  PWR_CSR                             ,0x04
@******************  Bit definition for PWR_CSR register  ********************/
.equ  PWR_CSR_WUF                         ,0x0001     @< Wakeup Flag */
.equ  PWR_CSR_SBF                         ,0x0002     @< Standby Flag */
.equ  PWR_CSR_PVDO                        ,0x0004     @< PVD Output */
.equ  PWR_CSR_BRR                         ,0x0008     @< Backup regulator ready */
.equ  PWR_CSR_EWUP                        ,0x0100     @< Enable WKUP pin */
.equ  PWR_CSR_BRE                         ,0x0200     @< Backup regulator enable */
.equ  PWR_CSR_VOSRDY                      ,0x4000     @< Regulator voltage scaling output selection ready */
@ Legacy define */
.equ  PWR_CSR_REGRDY                      ,PWR_CSR_VOSRDY

@******************************************************************************/
@*                                                                            */
@*                         Reset and Clock Control                            */
@*                                                                            */
@******************************************************************************/
.equ  RCC_CR				  ,0x00000000
@*******************  Bit definition for RCC_CR register  ********************/
.equ  RCC_CR_HSION                        ,0x00000001
.equ  RCC_CR_HSIRDY                       ,0x00000002

.equ  RCC_CR_HSITRIM                      ,0x000000F8
.equ  RCC_CR_HSITRIM_0                    ,0x00000008 @<Bit 0 */
.equ  RCC_CR_HSITRIM_1                    ,0x00000010 @<Bit 1 */
.equ  RCC_CR_HSITRIM_2                    ,0x00000020 @<Bit 2 */
.equ  RCC_CR_HSITRIM_3                    ,0x00000040 @<Bit 3 */
.equ  RCC_CR_HSITRIM_4                    ,0x00000080 @<Bit 4 */

.equ  RCC_CR_HSICAL                       ,0x0000FF00
.equ  RCC_CR_HSICAL_0                     ,0x00000100 @<Bit 0 */
.equ  RCC_CR_HSICAL_1                     ,0x00000200 @<Bit 1 */
.equ  RCC_CR_HSICAL_2                     ,0x00000400 @<Bit 2 */
.equ  RCC_CR_HSICAL_3                     ,0x00000800 @<Bit 3 */
.equ  RCC_CR_HSICAL_4                     ,0x00001000 @<Bit 4 */
.equ  RCC_CR_HSICAL_5                     ,0x00002000 @<Bit 5 */
.equ  RCC_CR_HSICAL_6                     ,0x00004000 @<Bit 6 */
.equ  RCC_CR_HSICAL_7                     ,0x00008000 @<Bit 7 */

.equ  RCC_CR_HSEON                        ,0x00010000 @ включение HSE
.equ  RCC_CR_HSEON_N                      ,16

.equ  RCC_CR_HSERDY                       ,0x00020000 @ флаг готовности HSE
.equ  RCC_CR_HSERDY_N                     ,17

.equ  RCC_CR_HSEBYP                       ,0x00040000
.equ  RCC_CR_CSSON                        ,0x00080000
.equ  RCC_CR_PLLON                        ,0x01000000
.equ  RCC_CR_PLLON_N                      ,24

.equ  RCC_CR_PLLRDY                       ,0x02000000
.equ  RCC_CR_PLLRDY_N                     ,25

.equ  RCC_CR_PLLI2SON                     ,0x04000000
.equ  RCC_CR_PLLI2SRDY                    ,0x08000000

.equ  RCC_PLLCFGR			  ,0x04
@*******************  Bit definition for RCC_PLLCFGR register  ***************/
.equ  RCC_PLLCFGR_PLLM                    ,0x0000003F
.equ  RCC_PLLCFGR_PLLM_0                  ,0x00000001
.equ  RCC_PLLCFGR_PLLM_1                  ,0x00000002
.equ  RCC_PLLCFGR_PLLM_2                  ,0x00000004
.equ  RCC_PLLCFGR_PLLM_3                  ,0x00000008
.equ  RCC_PLLCFGR_PLLM_4                  ,0x00000010
.equ  RCC_PLLCFGR_PLLM_5                  ,0x00000020

.equ  RCC_PLLCFGR_PLLN                     ,0x00007FC0
.equ  RCC_PLLCFGR_PLLN_0                   ,0x00000040
.equ  RCC_PLLCFGR_PLLN_1                   ,0x00000080
.equ  RCC_PLLCFGR_PLLN_2                   ,0x00000100
.equ  RCC_PLLCFGR_PLLN_3                   ,0x00000200
.equ  RCC_PLLCFGR_PLLN_4                   ,0x00000400
.equ  RCC_PLLCFGR_PLLN_5                   ,0x00000800
.equ  RCC_PLLCFGR_PLLN_6                   ,0x00001000
.equ  RCC_PLLCFGR_PLLN_7                   ,0x00002000
.equ  RCC_PLLCFGR_PLLN_8                   ,0x00004000

.equ  RCC_PLLCFGR_PLLP                    ,0x00030000
.equ  RCC_PLLCFGR_PLLP_0                  ,0x00010000
.equ  RCC_PLLCFGR_PLLP_1                  ,0x00020000

.equ  RCC_PLLCFGR_PLLSRC                  ,0x00400000
.equ  RCC_PLLCFGR_PLLSRC_HSE              ,0x00400000
.equ  RCC_PLLCFGR_PLLSRC_HSI              ,0x00000000

.equ  RCC_PLLCFGR_PLLQ                    ,0x0F000000
.equ  RCC_PLLCFGR_PLLQ_0                  ,0x01000000
.equ  RCC_PLLCFGR_PLLQ_1                  ,0x02000000
.equ  RCC_PLLCFGR_PLLQ_2                  ,0x04000000
.equ  RCC_PLLCFGR_PLLQ_3                  ,0x08000000

.equ  RCC_CFGR				  ,0x08
@*******************  Bit definition for RCC_CFGR register  ******************/
@< SW configuration */
.equ  RCC_CFGR_SW                         ,0x00000003         @< SW[1:0] bits (System clock Switch) */
.equ  RCC_CFGR_SW_0                       ,0x00000001         @< Bit 0 */
.equ  RCC_CFGR_SW_1                       ,0x00000002         @< Bit 1 */

.equ  RCC_CFGR_SW_HSI                     ,0x00000000         @< HSI selected as system clock */
.equ  RCC_CFGR_SW_HSE                     ,0x00000001         @< HSE selected as system clock */
.equ  RCC_CFGR_SW_PLL                     ,0x00000002         @< PLL selected as system clock */

@< SWS configuration */
.equ  RCC_CFGR_SWS                        ,0x0000000C         @< SWS[1:0] bits (System Clock Switch Status) */
.equ  RCC_CFGR_SWS_0                      ,0x00000004         @< Bit 0 */
.equ  RCC_CFGR_SWS_1                      ,0x00000008         @< Bit 1 */

.equ  RCC_CFGR_SWS_HSI                    ,0x00000000         @< HSI oscillator used as system clock */
.equ  RCC_CFGR_SWS_HSE                    ,0x00000004         @< HSE oscillator used as system clock */

.equ  RCC_CFGR_SWS_PLL                    ,0x00000008         @< PLL used as system clock */
.equ  RCC_CFGR_SWS_PLL_N                  ,3         @< PLL used as system clock */


@< HPRE configuration */
.equ  RCC_CFGR_HPRE                       ,0x000000F0         @< HPRE[3:0] bits (AHB prescaler) */
.equ  RCC_CFGR_HPRE_0                     ,0x00000010         @< Bit 0 */
.equ  RCC_CFGR_HPRE_1                     ,0x00000020         @< Bit 1 */
.equ  RCC_CFGR_HPRE_2                     ,0x00000040         @< Bit 2 */
.equ  RCC_CFGR_HPRE_3                     ,0x00000080         @< Bit 3 */

.equ  RCC_CFGR_HPRE_DIV1                  ,0x00000000         @< SYSCLK not divided */
.equ  RCC_CFGR_HPRE_DIV2                  ,0x00000080         @< SYSCLK divided by 2 */
.equ  RCC_CFGR_HPRE_DIV4                  ,0x00000090         @< SYSCLK divided by 4 */
.equ  RCC_CFGR_HPRE_DIV8                  ,0x000000A0         @< SYSCLK divided by 8 */
.equ  RCC_CFGR_HPRE_DIV16                 ,0x000000B0         @< SYSCLK divided by 16 */
.equ  RCC_CFGR_HPRE_DIV64                 ,0x000000C0         @< SYSCLK divided by 64 */
.equ  RCC_CFGR_HPRE_DIV128                ,0x000000D0         @< SYSCLK divided by 128 */
.equ  RCC_CFGR_HPRE_DIV256                ,0x000000E0         @< SYSCLK divided by 256 */
.equ  RCC_CFGR_HPRE_DIV512                ,0x000000F0         @< SYSCLK divided by 512 */

@< PPRE1 configuration */
.equ  RCC_CFGR_PPRE1                      ,0x00001C00         @< PRE1[2:0] bits (APB1 prescaler) */
.equ  RCC_CFGR_PPRE1_0                    ,0x00000400         @< Bit 0 */
.equ  RCC_CFGR_PPRE1_1                    ,0x00000800         @< Bit 1 */
.equ  RCC_CFGR_PPRE1_2                    ,0x00001000         @< Bit 2 */

.equ  RCC_CFGR_PPRE1_DIV1                 ,0x00000000         @< HCLK not divided */
.equ  RCC_CFGR_PPRE1_DIV2                 ,0x00001000         @< HCLK divided by 2 */
.equ  RCC_CFGR_PPRE1_DIV4                 ,0x00001400         @< HCLK divided by 4 */
.equ  RCC_CFGR_PPRE1_DIV8                 ,0x00001800         @< HCLK divided by 8 */
.equ  RCC_CFGR_PPRE1_DIV16                ,0x00001C00         @< HCLK divided by 16 */

@< PPRE2 configuration */
.equ  RCC_CFGR_PPRE2                      ,0x0000E000         @< PRE2[2:0] bits (APB2 prescaler) */
.equ  RCC_CFGR_PPRE2_0                    ,0x00002000         @< Bit 0 */
.equ  RCC_CFGR_PPRE2_1                    ,0x00004000         @< Bit 1 */

.equ  RCC_CFGR_PPRE2_2                    ,0x00008000         @ Делитель = 2
.equ  RCC_CFGR_PPRE2_2_N                  ,15                 @ Делитель = 2


.equ  RCC_CFGR_PPRE2_DIV1                 ,0x00000000         @< HCLK not divided */
.equ  RCC_CFGR_PPRE2_DIV2                 ,0x00008000         @< HCLK divided by 2 */
.equ  RCC_CFGR_PPRE2_DIV2_N               ,15 		          @< HCLK divided by 2 */

.equ  RCC_CFGR_PPRE2_DIV4                 ,0x0000A000         @< HCLK divided by 4 */
.equ  RCC_CFGR_PPRE2_DIV8                 ,0x0000C000         @< HCLK divided by 8 */
.equ  RCC_CFGR_PPRE2_DIV16                ,0x0000E000         @< HCLK divided by 16 */

@< RTCPRE configuration */
.equ  RCC_CFGR_RTCPRE                     ,0x001F0000
.equ  RCC_CFGR_RTCPRE_0                   ,0x00010000
.equ  RCC_CFGR_RTCPRE_1                   ,0x00020000
.equ  RCC_CFGR_RTCPRE_2                   ,0x00040000
.equ  RCC_CFGR_RTCPRE_3                   ,0x00080000
.equ  RCC_CFGR_RTCPRE_4                   ,0x00100000

@< MCO1 configuration */
.equ  RCC_CFGR_MCO1                       ,0x00600000
.equ  RCC_CFGR_MCO1_0                     ,0x00200000
.equ  RCC_CFGR_MCO1_1                     ,0x00400000

.equ  RCC_CFGR_I2SSRC                     ,0x00800000

.equ  RCC_CFGR_MCO1PRE                    ,0x07000000
.equ  RCC_CFGR_MCO1PRE_0                  ,0x01000000
.equ  RCC_CFGR_MCO1PRE_1                  ,0x02000000
.equ  RCC_CFGR_MCO1PRE_2                  ,0x04000000

.equ  RCC_CFGR_MCO2PRE                    ,0x38000000
.equ  RCC_CFGR_MCO2PRE_0                  ,0x08000000
.equ  RCC_CFGR_MCO2PRE_1                  ,0x10000000
.equ  RCC_CFGR_MCO2PRE_2                  ,0x20000000

.equ  RCC_CFGR_MCO2                       ,0xC0000000
.equ  RCC_CFGR_MCO2_0                     ,0x40000000
.equ  RCC_CFGR_MCO2_1                     ,0x80000000

.equ  RCC_CIR                             ,0x0C
@*******************  Bit definition for RCC_CIR register  *******************/
.equ  RCC_CIR_LSIRDYF                     ,0x00000001
.equ  RCC_CIR_LSERDYF                     ,0x00000002
.equ  RCC_CIR_HSIRDYF                     ,0x00000004
.equ  RCC_CIR_HSERDYF                     ,0x00000008
.equ  RCC_CIR_PLLRDYF                     ,0x00000010
.equ  RCC_CIR_PLLI2SRDYF                  ,0x00000020
.equ  RCC_CIR_CSSF                        ,0x00000080
.equ  RCC_CIR_LSIRDYIE                    ,0x00000100
.equ  RCC_CIR_LSERDYIE                    ,0x00000200
.equ  RCC_CIR_HSIRDYIE                    ,0x00000400
.equ  RCC_CIR_HSERDYIE                    ,0x00000800
.equ  RCC_CIR_PLLRDYIE                    ,0x00001000
.equ  RCC_CIR_PLLI2SRDYIE                 ,0x00002000
.equ  RCC_CIR_LSIRDYC                     ,0x00010000
.equ  RCC_CIR_LSERDYC                     ,0x00020000
.equ  RCC_CIR_HSIRDYC                     ,0x00040000
.equ  RCC_CIR_HSERDYC                     ,0x00080000
.equ  RCC_CIR_PLLRDYC                     ,0x00100000
.equ  RCC_CIR_PLLI2SRDYC                  ,0x00200000
.equ  RCC_CIR_CSSC                        ,0x00800000

.equ  RCC_AHB1RSTR			  ,0x10
@*******************  Bit definition for RCC_AHB1RSTR register  **************/
.equ  RCC_AHB1RSTR_GPIOARST               ,0x00000001
.equ  RCC_AHB1RSTR_GPIOBRST               ,0x00000002
.equ  RCC_AHB1RSTR_GPIOCRST               ,0x00000004
.equ  RCC_AHB1RSTR_GPIODRST               ,0x00000008
.equ  RCC_AHB1RSTR_GPIOERST               ,0x00000010
.equ  RCC_AHB1RSTR_GPIOFRST               ,0x00000020
.equ  RCC_AHB1RSTR_GPIOGRST               ,0x00000040
.equ  RCC_AHB1RSTR_GPIOHRST               ,0x00000080
.equ  RCC_AHB1RSTR_GPIOIRST               ,0x00000100
.equ  RCC_AHB1RSTR_CRCRST                 ,0x00001000
.equ  RCC_AHB1RSTR_DMA1RST                ,0x00200000
.equ  RCC_AHB1RSTR_DMA2RST                ,0x00400000
.equ  RCC_AHB1RSTR_ETHMACRST              ,0x02000000
.equ  RCC_AHB1RSTR_OTGHRST                ,0x10000000

.equ  RCC_AHB2RSTR			  ,0x14
@*******************  Bit definition for RCC_AHB2RSTR register  **************/
.equ  RCC_AHB2RSTR_DCMIRST                ,0x00000001
.equ  RCC_AHB2RSTR_CRYPRST                ,0x00000010
.equ  RCC_AHB2RSTR_HSAHRST                ,0x00000020
.equ  RCC_AHB2RSTR_RNGRST                 ,0x00000040
.equ  RCC_AHB2RSTR_OTGFSRST               ,0x00000080

.equ  RCC_AHB3RSTR			  ,0x18
@*******************  Bit definition for RCC_AHB3RSTR register  **************/
.equ  RCC_AHB3RSTR_FSMCRST                ,0x00000001

.equ  RCC_APB1RSTR			  ,0x20
@*******************  Bit definition for RCC_APB1RSTR register  **************/
.equ  RCC_APB1RSTR_TIM2RST                ,0x00000001
.equ  RCC_APB1RSTR_TIM3RST                ,0x00000002
.equ  RCC_APB1RSTR_TIM4RST                ,0x00000004
.equ  RCC_APB1RSTR_TIM5RST                ,0x00000008
.equ  RCC_APB1RSTR_TIM6RST                ,0x00000010
.equ  RCC_APB1RSTR_TIM7RST                ,0x00000020
.equ  RCC_APB1RSTR_TIM12RST               ,0x00000040
.equ  RCC_APB1RSTR_TIM13RST               ,0x00000080
.equ  RCC_APB1RSTR_TIM14RST               ,0x00000100
.equ  RCC_APB1RSTR_WWDGEN                 ,0x00000800
.equ  RCC_APB1RSTR_SPI2RST                ,0x00008000
.equ  RCC_APB1RSTR_SPI3RST                ,0x00010000
.equ  RCC_APB1RSTR_USART2RST              ,0x00020000
.equ  RCC_APB1RSTR_USART3RST              ,0x00040000
.equ  RCC_APB1RSTR_UART4RST               ,0x00080000
.equ  RCC_APB1RSTR_UART5RST               ,0x00100000
.equ  RCC_APB1RSTR_I2C1RST                ,0x00200000
.equ  RCC_APB1RSTR_I2C2RST                ,0x00400000
.equ  RCC_APB1RSTR_I2C3RST                ,0x00800000
.equ  RCC_APB1RSTR_CAN1RST                ,0x02000000
.equ  RCC_APB1RSTR_CAN2RST                ,0x04000000
.equ  RCC_APB1RSTR_PWRRST                 ,0x10000000
.equ  RCC_APB1RSTR_DACRST                 ,0x20000000

.equ  RCC_APB2RSTR                        ,0x24
@*******************  Bit definition for RCC_APB2RSTR register  **************/
.equ  RCC_APB2RSTR_TIM1RST                ,0x00000001
.equ  RCC_APB2RSTR_TIM8RST                ,0x00000002
.equ  RCC_APB2RSTR_USART1RST              ,0x00000010
.equ  RCC_APB2RSTR_USART6RST              ,0x00000020
.equ  RCC_APB2RSTR_ADCRST                 ,0x00000100
.equ  RCC_APB2RSTR_SDIORST                ,0x00000800
.equ  RCC_APB2RSTR_SPI1RST                ,0x00001000
.equ  RCC_APB2RSTR_SYSCFGRST              ,0x00004000
.equ  RCC_APB2RSTR_TIM9RST                ,0x00010000
.equ  RCC_APB2RSTR_TIM10RST               ,0x00020000
.equ  RCC_APB2RSTR_TIM11RST               ,0x00040000
@ Old SPI1RST bit definition, maintained for legacy purpose */
.equ  RCC_APB2RSTR_SPI1                   ,RCC_APB2RSTR_SPI1RST

.equ  RCC_AHB1ENR			  ,0x30
@*******************  Bit definition for RCC_AHB1ENR register  ***************/
.equ  RCC_AHB1ENR_GPIOAEN                 ,0x00000001
.equ  RCC_AHB1ENR_GPIOAEN_N               ,0x00

.equ  RCC_AHB1ENR_GPIOBEN                 ,0x00000002
.equ  RCC_AHB1ENR_GPIOBEN_N               ,0x01

.equ  RCC_AHB1ENR_GPIOCEN                 ,0x00000004
.equ  RCC_AHB1ENR_GPIOCEN_N               ,0x02

.equ  RCC_AHB1ENR_GPIODEN                 ,0x00000008
.equ  RCC_AHB1ENR_GPIODEN_N               ,0x03

.equ  RCC_AHB1ENR_GPIOEEN                 ,0x00000010
.equ  RCC_AHB1ENR_GPIOEEN_N               ,0x04

.equ  RCC_AHB1ENR_GPIOFEN                 ,0x00000020
.equ  RCC_AHB1ENR_GPIOFEN_N               ,0x05

.equ  RCC_AHB1ENR_GPIOGEN                 ,0x00000040
.equ  RCC_AHB1ENR_GPIOGEN_N               ,0x06

.equ  RCC_AHB1ENR_GPIOHEN                 ,0x00000080
.equ  RCC_AHB1ENR_GPIOHEN_N               ,0x07

.equ  RCC_AHB1ENR_GPIOIEN                 ,0x00000100
.equ  RCC_AHB1ENR_GPIOIEN_N               ,0x08

.equ  RCC_AHB1ENR_CRCEN                   ,0x00001000
.equ  RCC_AHB1ENR_CRCEN_N                 ,12

.equ  RCC_AHB1ENR_BKPSRAMEN               ,0x00040000
.equ  RCC_AHB1ENR_BKPSRAMEN_N             ,18

.equ  RCC_AHB1ENR_CCMDATARAMEN            ,0x00100000
.equ  RCC_AHB1ENR_CCMDATARAMEN_N          ,20

.equ  RCC_AHB1ENR_DMA1EN                  ,0x00200000
.equ  RCC_AHB1ENR_DMA1EN_N                ,21

.equ  RCC_AHB1ENR_DMA2EN                  ,0x00400000
.equ  RCC_AHB1ENR_DMA2EN_N                ,22

.equ  RCC_AHB1ENR_ETHMACEN                ,0x02000000
.equ  RCC_AHB1ENR_ETHMACEN_N              ,25

.equ  RCC_AHB1ENR_ETHMACTXEN              ,0x04000000
.equ  RCC_AHB1ENR_ETHMACTXEN_N            ,26

.equ  RCC_AHB1ENR_ETHMACRXEN              ,0x08000000
.equ  RCC_AHB1ENR_ETHMACRXEN_N            ,27

.equ  RCC_AHB1ENR_ETHMACPTPEN             ,0x10000000
.equ  RCC_AHB1ENR_ETHMACPTPEN_N           ,28

.equ  RCC_AHB1ENR_OTGHSEN                 ,0x20000000
.equ  RCC_AHB1ENR_OTGHSEN_N               ,29

.equ  RCC_AHB1ENR_OTGHSULPIEN             ,0x40000000
.equ  RCC_AHB1ENR_OTGHSULPIEN_N           ,30


.equ  RCC_AHB2ENR			  ,0x34
@*******************  Bit definition for RCC_AHB2ENR register  ***************/
.equ  RCC_AHB2ENR_DCMIEN                  ,0x00000001
.equ  RCC_AHB2ENR_CRYPEN                  ,0x00000010
.equ  RCC_AHB2ENR_HASHEN                  ,0x00000020
.equ  RCC_AHB2ENR_RNGEN                   ,0x00000040
.equ  RCC_AHB2ENR_OTGFSEN                 ,0x00000080

.equ  RCC_AHB3ENR			  ,0x38
@*******************  Bit definition for RCC_AHB3ENR register  ***************/
.equ  RCC_AHB3ENR_FSMCEN                  ,0x00000001

.equ  RCC_APB1ENR			  ,0x40
@*******************  Bit definition for RCC_APB1ENR register  ***************/
.equ  RCC_APB1ENR_TIM2EN                  ,0x00000001
.equ  RCC_APB1ENR_TIM3EN                  ,0x00000002
.equ  RCC_APB1ENR_TIM4EN                  ,0x00000004
.equ  RCC_APB1ENR_TIM5EN                  ,0x00000008
.equ  RCC_APB1ENR_TIM6EN                  ,0x00000010
.equ  RCC_APB1ENR_TIM7EN                  ,0x00000020
.equ  RCC_APB1ENR_TIM12EN                 ,0x00000040
.equ  RCC_APB1ENR_TIM13EN                 ,0x00000080
.equ  RCC_APB1ENR_TIM14EN                 ,0x00000100
.equ  RCC_APB1ENR_WWDGEN                  ,0x00000800

.equ  RCC_APB1ENR_SPI2EN                  ,0x00004000
.equ  RCC_APB1ENR_SPI2EN_N                ,14

.equ  RCC_APB1ENR_SPI3EN                  ,0x00008000
.equ  RCC_APB1ENR_USART2EN                ,0x00020000
.equ  RCC_APB1ENR_USART3EN                ,0x00040000
.equ  RCC_APB1ENR_UART4EN                 ,0x00080000
.equ  RCC_APB1ENR_UART5EN                 ,0x00100000
.equ  RCC_APB1ENR_I2C1EN                  ,0x00200000
.equ  RCC_APB1ENR_I2C2EN                  ,0x00400000
.equ  RCC_APB1ENR_I2C3EN                  ,0x00800000
.equ  RCC_APB1ENR_CAN1EN                  ,0x02000000
.equ  RCC_APB1ENR_CAN2EN                  ,0x04000000

.equ  RCC_APB1ENR_PWREN                   ,0x10000000
.equ  RCC_APB1ENR_PWREN_N                 ,28

.equ  RCC_APB1ENR_DACEN                   ,0x20000000

@*******************  Bit definition for RCC_APB2ENR register  ***************/
.equ  RCC_APB2ENR_TIM1EN                  ,0x00000001
.equ  RCC_APB2ENR_TIM8EN                  ,0x00000002
.equ  RCC_APB2ENR_USART1EN                ,0x00000010
.equ  RCC_APB2ENR_USART6EN                ,0x00000020
.equ  RCC_APB2ENR_ADC1EN                  ,0x00000100
.equ  RCC_APB2ENR_ADC2EN                  ,0x00000200
.equ  RCC_APB2ENR_ADC3EN                  ,0x00000400
.equ  RCC_APB2ENR_SDIOEN                  ,0x00000800
.equ  RCC_APB2ENR_SPI1EN                  ,0x00001000
.equ  RCC_APB2ENR_SYSCFGEN                ,0x00004000
.equ  RCC_APB2ENR_TIM11EN                 ,0x00040000
.equ  RCC_APB2ENR_TIM10EN                 ,0x00020000
.equ  RCC_APB2ENR_TIM9EN                  ,0x00010000

.equ  RCC_AHB1LPENR			  ,0x50
@*******************  Bit definition for RCC_AHB1LPENR register  *************/
.equ  RCC_AHB1LPENR_GPIOALPEN             ,0x00000001
.equ  RCC_AHB1LPENR_GPIOBLPEN             ,0x00000002
.equ  RCC_AHB1LPENR_GPIOCLPEN             ,0x00000004
.equ  RCC_AHB1LPENR_GPIODLPEN             ,0x00000008
.equ  RCC_AHB1LPENR_GPIOELPEN             ,0x00000010
.equ  RCC_AHB1LPENR_GPIOFLPEN             ,0x00000020
.equ  RCC_AHB1LPENR_GPIOGLPEN             ,0x00000040
.equ  RCC_AHB1LPENR_GPIOHLPEN             ,0x00000080
.equ  RCC_AHB1LPENR_GPIOILPEN             ,0x00000100
.equ  RCC_AHB1LPENR_CRCLPEN               ,0x00001000
.equ  RCC_AHB1LPENR_FLITFLPEN             ,0x00008000
.equ  RCC_AHB1LPENR_SRAM1LPEN             ,0x00010000
.equ  RCC_AHB1LPENR_SRAM2LPEN             ,0x00020000
.equ  RCC_AHB1LPENR_BKPSRAMLPEN           ,0x00040000
.equ  RCC_AHB1LPENR_DMA1LPEN              ,0x00200000
.equ  RCC_AHB1LPENR_DMA2LPEN              ,0x00400000
.equ  RCC_AHB1LPENR_ETHMACLPEN            ,0x02000000
.equ  RCC_AHB1LPENR_ETHMACTXLPEN          ,0x04000000
.equ  RCC_AHB1LPENR_ETHMACRXLPEN          ,0x08000000
.equ  RCC_AHB1LPENR_ETHMACPTPLPEN         ,0x10000000
.equ  RCC_AHB1LPENR_OTGHSLPEN             ,0x20000000
.equ  RCC_AHB1LPENR_OTGHSULPILPEN         ,0x40000000

.equ  RCC_AHB2LPENR			  ,0x54
@*******************  Bit definition for RCC_AHB2LPENR register  *************/
.equ  RCC_AHB2LPENR_DCMILPEN              ,0x00000001
.equ  RCC_AHB2LPENR_CRYPLPEN              ,0x00000010
.equ  RCC_AHB2LPENR_HASHLPEN              ,0x00000020
.equ  RCC_AHB2LPENR_RNGLPEN               ,0x00000040
.equ  RCC_AHB2LPENR_OTGFSLPEN             ,0x00000080

.equ  RCC_AHB3LPENR			  ,0x58
@*******************  Bit definition for RCC_AHB3LPENR register  *************/
.equ  RCC_AHB3LPENR_FSMCLPEN              ,0x00000001

.equ  RCC_APB1LPENR			  ,0x60
@*******************  Bit definition for RCC_APB1LPENR register  *************/
.equ  RCC_APB1LPENR_TIM2LPEN              ,0x00000001
.equ  RCC_APB1LPENR_TIM3LPEN              ,0x00000002
.equ  RCC_APB1LPENR_TIM4LPEN              ,0x00000004
.equ  RCC_APB1LPENR_TIM5LPEN              ,0x00000008
.equ  RCC_APB1LPENR_TIM6LPEN              ,0x00000010
.equ  RCC_APB1LPENR_TIM7LPEN              ,0x00000020
.equ  RCC_APB1LPENR_TIM12LPEN             ,0x00000040
.equ  RCC_APB1LPENR_TIM13LPEN             ,0x00000080
.equ  RCC_APB1LPENR_TIM14LPEN             ,0x00000100
.equ  RCC_APB1LPENR_WWDGLPEN              ,0x00000800
.equ  RCC_APB1LPENR_SPI2LPEN              ,0x00004000
.equ  RCC_APB1LPENR_SPI3LPEN              ,0x00008000
.equ  RCC_APB1LPENR_USART2LPEN            ,0x00020000
.equ  RCC_APB1LPENR_USART3LPEN            ,0x00040000
.equ  RCC_APB1LPENR_UART4LPEN             ,0x00080000
.equ  RCC_APB1LPENR_UART5LPEN             ,0x00100000
.equ  RCC_APB1LPENR_I2C1LPEN              ,0x00200000
.equ  RCC_APB1LPENR_I2C2LPEN              ,0x00400000
.equ  RCC_APB1LPENR_I2C3LPEN              ,0x00800000
.equ  RCC_APB1LPENR_CAN1LPEN              ,0x02000000
.equ  RCC_APB1LPENR_CAN2LPEN              ,0x04000000
.equ  RCC_APB1LPENR_PWRLPEN               ,0x10000000
.equ  RCC_APB1LPENR_DACLPEN               ,0x20000000

.equ  RCC_APB2LPENR			  ,0x64
@*******************  Bit definition for RCC_APB2LPENR register  *************/
.equ  RCC_APB2LPENR_TIM1LPEN              ,0x00000001
.equ  RCC_APB2LPENR_TIM8LPEN              ,0x00000002
.equ  RCC_APB2LPENR_USART1LPEN            ,0x00000010
.equ  RCC_APB2LPENR_USART6LPEN            ,0x00000020
.equ  RCC_APB2LPENR_ADC1LPEN              ,0x00000100
.equ  RCC_APB2LPENR_ADC2PEN               ,0x00000200
.equ  RCC_APB2LPENR_ADC3LPEN              ,0x00000400
.equ  RCC_APB2LPENR_SDIOLPEN              ,0x00000800
.equ  RCC_APB2LPENR_SPI1LPEN              ,0x00001000
.equ  RCC_APB2LPENR_SYSCFGLPEN            ,0x00004000
.equ  RCC_APB2LPENR_TIM9LPEN              ,0x00010000
.equ  RCC_APB2LPENR_TIM10LPEN             ,0x00020000
.equ  RCC_APB2LPENR_TIM11LPEN             ,0x00040000

.equ  RCC_BDCR				  ,0x70
@*******************  Bit definition for RCC_BDCR register  ******************/
.equ  RCC_BDCR_LSEON                      ,0x00000001
.equ  RCC_BDCR_LSERDY                     ,0x00000002
.equ  RCC_BDCR_LSEBYP                     ,0x00000004

.equ  RCC_BDCR_RTCSEL                    ,0x00000300
.equ  RCC_BDCR_RTCSEL_0                  ,0x00000100
.equ  RCC_BDCR_RTCSEL_1                  ,0x00000200

.equ  RCC_BDCR_RTCEN                      ,0x00008000
.equ  RCC_BDCR_BDRST                      ,0x00010000

.equ  RCC_CSR				  ,0x74
@*******************  Bit definition for RCC_CSR register  *******************/
.equ  RCC_CSR_LSION                       ,0x00000001
.equ  RCC_CSR_LSIRDY                      ,0x00000002
.equ  RCC_CSR_RMVF                        ,0x01000000
.equ  RCC_CSR_BORRSTF                     ,0x02000000
.equ  RCC_CSR_PADRSTF                     ,0x04000000
.equ  RCC_CSR_PORRSTF                     ,0x08000000
.equ  RCC_CSR_SFTRSTF                     ,0x10000000
.equ  RCC_CSR_WDGRSTF                     ,0x20000000
.equ  RCC_CSR_WWDGRSTF                    ,0x40000000
.equ  RCC_CSR_LPWRRSTF                    ,0x80000000

.equ  RCC_SSCGR				  ,0x80
@*******************  Bit definition for RCC_SSCGR register  *****************/
.equ  RCC_SSCGR_MODPER                    ,0x00001FFF
.equ  RCC_SSCGR_INCSTEP                   ,0x0FFFE000
.equ  RCC_SSCGR_SPREADSEL                 ,0x40000000
.equ  RCC_SSCGR_SSCGEN                    ,0x80000000

.equ  RCC_PLLI2SCFGR			  ,0x84
@*******************  Bit definition for RCC_PLLI2SCFGR register  ************/
.equ  RCC_PLLI2SCFGR_PLLI2SN              ,0x00007FC0
.equ  RCC_PLLI2SCFGR_PLLI2SR              ,0x70000000

@******************************************************************************/
@*                                                                            */
@*                                    RNG                                     */
@*                                                                            */
@******************************************************************************/
@*******************  Bits definition for RNG_CR register  *******************/
.equ RNG_CR_RNGEN                         ,0x00000004
.equ RNG_CR_IE                            ,0x00000008

@*******************  Bits definition for RNG_SR register  *******************/
.equ RNG_SR_DRDY                          ,0x00000001
.equ RNG_SR_CECS                          ,0x00000002
.equ RNG_SR_SECS                          ,0x00000004
.equ RNG_SR_CEIS                          ,0x00000020
.equ RNG_SR_SEIS                          ,0x00000040

@******************************************************************************/
@*                                                                            */
@*                           Real-Time Clock (RTC)                            */
@*                                                                            */
@******************************************************************************/
@*******************  Bits definition for RTC_TR register  *******************/
.equ RTC_TR_PM                            ,0x00400000
.equ RTC_TR_HT                            ,0x00300000
.equ RTC_TR_HT_0                          ,0x00100000
.equ RTC_TR_HT_1                          ,0x00200000
.equ RTC_TR_HU                            ,0x000F0000
.equ RTC_TR_HU_0                          ,0x00010000
.equ RTC_TR_HU_1                          ,0x00020000
.equ RTC_TR_HU_2                          ,0x00040000
.equ RTC_TR_HU_3                          ,0x00080000
.equ RTC_TR_MNT                           ,0x00007000
.equ RTC_TR_MNT_0                         ,0x00001000
.equ RTC_TR_MNT_1                         ,0x00002000
.equ RTC_TR_MNT_2                         ,0x00004000
.equ RTC_TR_MNU                           ,0x00000F00
.equ RTC_TR_MNU_0                         ,0x00000100
.equ RTC_TR_MNU_1                         ,0x00000200
.equ RTC_TR_MNU_2                         ,0x00000400
.equ RTC_TR_MNU_3                         ,0x00000800
.equ RTC_TR_ST                            ,0x00000070
.equ RTC_TR_ST_0                          ,0x00000010
.equ RTC_TR_ST_1                          ,0x00000020
.equ RTC_TR_ST_2                          ,0x00000040
.equ RTC_TR_SU                            ,0x0000000F
.equ RTC_TR_SU_0                          ,0x00000001
.equ RTC_TR_SU_1                          ,0x00000002
.equ RTC_TR_SU_2                          ,0x00000004
.equ RTC_TR_SU_3                          ,0x00000008

@*******************  Bits definition for RTC_DR register  *******************/
.equ RTC_DR_YT                            ,0x00F00000
.equ RTC_DR_YT_0                          ,0x00100000
.equ RTC_DR_YT_1                          ,0x00200000
.equ RTC_DR_YT_2                          ,0x00400000
.equ RTC_DR_YT_3                          ,0x00800000
.equ RTC_DR_YU                            ,0x000F0000
.equ RTC_DR_YU_0                          ,0x00010000
.equ RTC_DR_YU_1                          ,0x00020000
.equ RTC_DR_YU_2                          ,0x00040000
.equ RTC_DR_YU_3                          ,0x00080000
.equ RTC_DR_WDU                           ,0x0000E000
.equ RTC_DR_WDU_0                         ,0x00002000
.equ RTC_DR_WDU_1                         ,0x00004000
.equ RTC_DR_WDU_2                         ,0x00008000
.equ RTC_DR_MT                            ,0x00001000
.equ RTC_DR_MU                            ,0x00000F00
.equ RTC_DR_MU_0                          ,0x00000100
.equ RTC_DR_MU_1                          ,0x00000200
.equ RTC_DR_MU_2                          ,0x00000400
.equ RTC_DR_MU_3                          ,0x00000800
.equ RTC_DR_DT                            ,0x00000030
.equ RTC_DR_DT_0                          ,0x00000010
.equ RTC_DR_DT_1                          ,0x00000020
.equ RTC_DR_DU                            ,0x0000000F
.equ RTC_DR_DU_0                          ,0x00000001
.equ RTC_DR_DU_1                          ,0x00000002
.equ RTC_DR_DU_2                          ,0x00000004
.equ RTC_DR_DU_3                          ,0x00000008

@*******************  Bits definition for RTC_CR register  *******************/
.equ RTC_CR_COE                           ,0x00800000
.equ RTC_CR_OSEL                          ,0x00600000
.equ RTC_CR_OSEL_0                        ,0x00200000
.equ RTC_CR_OSEL_1                        ,0x00400000
.equ RTC_CR_POL                           ,0x00100000
.equ RTC_CR_COSEL                         ,0x00080000
.equ RTC_CR_BCK                           ,0x00040000
.equ RTC_CR_SUB1H                         ,0x00020000
.equ RTC_CR_ADD1H                         ,0x00010000
.equ RTC_CR_TSIE                          ,0x00008000
.equ RTC_CR_WUTIE                         ,0x00004000
.equ RTC_CR_ALRBIE                        ,0x00002000
.equ RTC_CR_ALRAIE                        ,0x00001000
.equ RTC_CR_TSE                           ,0x00000800
.equ RTC_CR_WUTE                          ,0x00000400
.equ RTC_CR_ALRBE                         ,0x00000200
.equ RTC_CR_ALRAE                         ,0x00000100
.equ RTC_CR_DCE                           ,0x00000080
.equ RTC_CR_FMT                           ,0x00000040
.equ RTC_CR_BYPSHAD                       ,0x00000020
.equ RTC_CR_REFCKON                       ,0x00000010
.equ RTC_CR_TSEDGE                        ,0x00000008
.equ RTC_CR_WUCKSEL                       ,0x00000007
.equ RTC_CR_WUCKSEL_0                     ,0x00000001
.equ RTC_CR_WUCKSEL_1                     ,0x00000002
.equ RTC_CR_WUCKSEL_2                     ,0x00000004

@*******************  Bits definition for RTC_ISR register  ******************/
.equ RTC_ISR_RECALPF                      ,0x00010000
.equ RTC_ISR_TAMP1F                       ,0x00002000
.equ RTC_ISR_TSOVF                        ,0x00001000
.equ RTC_ISR_TSF                          ,0x00000800
.equ RTC_ISR_WUTF                         ,0x00000400
.equ RTC_ISR_ALRBF                        ,0x00000200
.equ RTC_ISR_ALRAF                        ,0x00000100
.equ RTC_ISR_INIT                         ,0x00000080
.equ RTC_ISR_INITF                        ,0x00000040
.equ RTC_ISR_RSF                          ,0x00000020
.equ RTC_ISR_INITS                        ,0x00000010
.equ RTC_ISR_SHPF                         ,0x00000008
.equ RTC_ISR_WUTWF                        ,0x00000004
.equ RTC_ISR_ALRBWF                       ,0x00000002
.equ RTC_ISR_ALRAWF                       ,0x00000001

@*******************  Bits definition for RTC_PRER register  *****************/
.equ RTC_PRER_PREDIV_A                    ,0x007F0000
.equ RTC_PRER_PREDIV_S                    ,0x00001FFF

@*******************  Bits definition for RTC_WUTR register  *****************/
.equ RTC_WUTR_WUT                         ,0x0000FFFF

@*******************  Bits definition for RTC_CALIBR register  ***************/
.equ RTC_CALIBR_DCS                       ,0x00000080
.equ RTC_CALIBR_DC                        ,0x0000001F

@*******************  Bits definition for RTC_ALRMAR register  ***************/
.equ RTC_ALRMAR_MSK4                      ,0x80000000
.equ RTC_ALRMAR_WDSEL                     ,0x40000000
.equ RTC_ALRMAR_DT                        ,0x30000000
.equ RTC_ALRMAR_DT_0                      ,0x10000000
.equ RTC_ALRMAR_DT_1                      ,0x20000000
.equ RTC_ALRMAR_DU                        ,0x0F000000
.equ RTC_ALRMAR_DU_0                      ,0x01000000
.equ RTC_ALRMAR_DU_1                      ,0x02000000
.equ RTC_ALRMAR_DU_2                      ,0x04000000
.equ RTC_ALRMAR_DU_3                      ,0x08000000
.equ RTC_ALRMAR_MSK3                      ,0x00800000
.equ RTC_ALRMAR_PM                        ,0x00400000
.equ RTC_ALRMAR_HT                        ,0x00300000
.equ RTC_ALRMAR_HT_0                      ,0x00100000
.equ RTC_ALRMAR_HT_1                      ,0x00200000
.equ RTC_ALRMAR_HU                        ,0x000F0000
.equ RTC_ALRMAR_HU_0                      ,0x00010000
.equ RTC_ALRMAR_HU_1                      ,0x00020000
.equ RTC_ALRMAR_HU_2                      ,0x00040000
.equ RTC_ALRMAR_HU_3                      ,0x00080000
.equ RTC_ALRMAR_MSK2                      ,0x00008000
.equ RTC_ALRMAR_MNT                       ,0x00007000
.equ RTC_ALRMAR_MNT_0                     ,0x00001000
.equ RTC_ALRMAR_MNT_1                     ,0x00002000
.equ RTC_ALRMAR_MNT_2                     ,0x00004000
.equ RTC_ALRMAR_MNU                       ,0x00000F00
.equ RTC_ALRMAR_MNU_0                     ,0x00000100
.equ RTC_ALRMAR_MNU_1                     ,0x00000200
.equ RTC_ALRMAR_MNU_2                     ,0x00000400
.equ RTC_ALRMAR_MNU_3                     ,0x00000800
.equ RTC_ALRMAR_MSK1                      ,0x00000080
.equ RTC_ALRMAR_ST                        ,0x00000070
.equ RTC_ALRMAR_ST_0                      ,0x00000010
.equ RTC_ALRMAR_ST_1                      ,0x00000020
.equ RTC_ALRMAR_ST_2                      ,0x00000040
.equ RTC_ALRMAR_SU                        ,0x0000000F
.equ RTC_ALRMAR_SU_0                      ,0x00000001
.equ RTC_ALRMAR_SU_1                      ,0x00000002
.equ RTC_ALRMAR_SU_2                      ,0x00000004
.equ RTC_ALRMAR_SU_3                      ,0x00000008

@*******************  Bits definition for RTC_ALRMBR register  ***************/
.equ RTC_ALRMBR_MSK4                      ,0x80000000
.equ RTC_ALRMBR_WDSEL                     ,0x40000000
.equ RTC_ALRMBR_DT                        ,0x30000000
.equ RTC_ALRMBR_DT_0                      ,0x10000000
.equ RTC_ALRMBR_DT_1                      ,0x20000000
.equ RTC_ALRMBR_DU                        ,0x0F000000
.equ RTC_ALRMBR_DU_0                      ,0x01000000
.equ RTC_ALRMBR_DU_1                      ,0x02000000
.equ RTC_ALRMBR_DU_2                      ,0x04000000
.equ RTC_ALRMBR_DU_3                      ,0x08000000
.equ RTC_ALRMBR_MSK3                      ,0x00800000
.equ RTC_ALRMBR_PM                        ,0x00400000
.equ RTC_ALRMBR_HT                        ,0x00300000
.equ RTC_ALRMBR_HT_0                      ,0x00100000
.equ RTC_ALRMBR_HT_1                      ,0x00200000
.equ RTC_ALRMBR_HU                        ,0x000F0000
.equ RTC_ALRMBR_HU_0                      ,0x00010000
.equ RTC_ALRMBR_HU_1                      ,0x00020000
.equ RTC_ALRMBR_HU_2                      ,0x00040000
.equ RTC_ALRMBR_HU_3                      ,0x00080000
.equ RTC_ALRMBR_MSK2                      ,0x00008000
.equ RTC_ALRMBR_MNT                       ,0x00007000
.equ RTC_ALRMBR_MNT_0                     ,0x00001000
.equ RTC_ALRMBR_MNT_1                     ,0x00002000
.equ RTC_ALRMBR_MNT_2                     ,0x00004000
.equ RTC_ALRMBR_MNU                       ,0x00000F00
.equ RTC_ALRMBR_MNU_0                     ,0x00000100
.equ RTC_ALRMBR_MNU_1                     ,0x00000200
.equ RTC_ALRMBR_MNU_2                     ,0x00000400
.equ RTC_ALRMBR_MNU_3                     ,0x00000800
.equ RTC_ALRMBR_MSK1                      ,0x00000080
.equ RTC_ALRMBR_ST                        ,0x00000070
.equ RTC_ALRMBR_ST_0                      ,0x00000010
.equ RTC_ALRMBR_ST_1                      ,0x00000020
.equ RTC_ALRMBR_ST_2                      ,0x00000040
.equ RTC_ALRMBR_SU                        ,0x0000000F
.equ RTC_ALRMBR_SU_0                      ,0x00000001
.equ RTC_ALRMBR_SU_1                      ,0x00000002
.equ RTC_ALRMBR_SU_2                      ,0x00000004
.equ RTC_ALRMBR_SU_3                      ,0x00000008

@*******************  Bits definition for RTC_WPR register  ******************/
.equ RTC_WPR_KEY                          ,0x000000FF

@*******************  Bits definition for RTC_SSR register  ******************/
.equ RTC_SSR_SS                           ,0x0000FFFF

@*******************  Bits definition for RTC_SHIFTR register  ***************/
.equ RTC_SHIFTR_SUBFS                     ,0x00007FFF
.equ RTC_SHIFTR_ADD1S                     ,0x80000000

@*******************  Bits definition for RTC_TSTR register  *****************/
.equ RTC_TSTR_PM                          ,0x00400000
.equ RTC_TSTR_HT                          ,0x00300000
.equ RTC_TSTR_HT_0                        ,0x00100000
.equ RTC_TSTR_HT_1                        ,0x00200000
.equ RTC_TSTR_HU                          ,0x000F0000
.equ RTC_TSTR_HU_0                        ,0x00010000
.equ RTC_TSTR_HU_1                        ,0x00020000
.equ RTC_TSTR_HU_2                        ,0x00040000
.equ RTC_TSTR_HU_3                        ,0x00080000
.equ RTC_TSTR_MNT                         ,0x00007000
.equ RTC_TSTR_MNT_0                       ,0x00001000
.equ RTC_TSTR_MNT_1                       ,0x00002000
.equ RTC_TSTR_MNT_2                       ,0x00004000
.equ RTC_TSTR_MNU                         ,0x00000F00
.equ RTC_TSTR_MNU_0                       ,0x00000100
.equ RTC_TSTR_MNU_1                       ,0x00000200
.equ RTC_TSTR_MNU_2                       ,0x00000400
.equ RTC_TSTR_MNU_3                       ,0x00000800
.equ RTC_TSTR_ST                          ,0x00000070
.equ RTC_TSTR_ST_0                        ,0x00000010
.equ RTC_TSTR_ST_1                        ,0x00000020
.equ RTC_TSTR_ST_2                        ,0x00000040
.equ RTC_TSTR_SU                          ,0x0000000F
.equ RTC_TSTR_SU_0                        ,0x00000001
.equ RTC_TSTR_SU_1                        ,0x00000002
.equ RTC_TSTR_SU_2                        ,0x00000004
.equ RTC_TSTR_SU_3                        ,0x00000008

@*******************  Bits definition for RTC_TSDR register  *****************/
.equ RTC_TSDR_WDU                         ,0x0000E000
.equ RTC_TSDR_WDU_0                       ,0x00002000
.equ RTC_TSDR_WDU_1                       ,0x00004000
.equ RTC_TSDR_WDU_2                       ,0x00008000
.equ RTC_TSDR_MT                          ,0x00001000
.equ RTC_TSDR_MU                          ,0x00000F00
.equ RTC_TSDR_MU_0                        ,0x00000100
.equ RTC_TSDR_MU_1                        ,0x00000200
.equ RTC_TSDR_MU_2                        ,0x00000400
.equ RTC_TSDR_MU_3                        ,0x00000800
.equ RTC_TSDR_DT                          ,0x00000030
.equ RTC_TSDR_DT_0                        ,0x00000010
.equ RTC_TSDR_DT_1                        ,0x00000020
.equ RTC_TSDR_DU                          ,0x0000000F
.equ RTC_TSDR_DU_0                        ,0x00000001
.equ RTC_TSDR_DU_1                        ,0x00000002
.equ RTC_TSDR_DU_2                        ,0x00000004
.equ RTC_TSDR_DU_3                        ,0x00000008

@*******************  Bits definition for RTC_TSSSR register  ****************/
.equ RTC_TSSSR_SS                         ,0x0000FFFF

@*******************  Bits definition for RTC_CAL register  *****************/
.equ RTC_CALR_CALP                        ,0x00008000
.equ RTC_CALR_CALW8                       ,0x00004000
.equ RTC_CALR_CALW16                      ,0x00002000
.equ RTC_CALR_CALM                        ,0x000001FF
.equ RTC_CALR_CALM_0                      ,0x00000001
.equ RTC_CALR_CALM_1                      ,0x00000002
.equ RTC_CALR_CALM_2                      ,0x00000004
.equ RTC_CALR_CALM_3                      ,0x00000008
.equ RTC_CALR_CALM_4                      ,0x00000010
.equ RTC_CALR_CALM_5                      ,0x00000020
.equ RTC_CALR_CALM_6                      ,0x00000040
.equ RTC_CALR_CALM_7                      ,0x00000080
.equ RTC_CALR_CALM_8                      ,0x00000100

@*******************  Bits definition for RTC_TAFCR register  ****************/
.equ RTC_TAFCR_ALARMOUTTYPE               ,0x00040000
.equ RTC_TAFCR_TSINSEL                    ,0x00020000
.equ RTC_TAFCR_TAMPINSEL                  ,0x00010000
.equ RTC_TAFCR_TAMPPUDIS                  ,0x00008000
.equ RTC_TAFCR_TAMPPRCH                   ,0x00006000
.equ RTC_TAFCR_TAMPPRCH_0                 ,0x00002000
.equ RTC_TAFCR_TAMPPRCH_1                 ,0x00004000
.equ RTC_TAFCR_TAMPFLT                    ,0x00001800
.equ RTC_TAFCR_TAMPFLT_0                  ,0x00000800
.equ RTC_TAFCR_TAMPFLT_1                  ,0x00001000
.equ RTC_TAFCR_TAMPFREQ                   ,0x00000700
.equ RTC_TAFCR_TAMPFREQ_0                 ,0x00000100
.equ RTC_TAFCR_TAMPFREQ_1                 ,0x00000200
.equ RTC_TAFCR_TAMPFREQ_2                 ,0x00000400
.equ RTC_TAFCR_TAMPTS                     ,0x00000080
.equ RTC_TAFCR_TAMPIE                     ,0x00000004
.equ RTC_TAFCR_TAMP1TRG                   ,0x00000002
.equ RTC_TAFCR_TAMP1E                     ,0x00000001

@*******************  Bits definition for RTC_ALRMASSR register  *************/
.equ RTC_ALRMASSR_MASKSS                  ,0x0F000000
.equ RTC_ALRMASSR_MASKSS_0                ,0x01000000
.equ RTC_ALRMASSR_MASKSS_1                ,0x02000000
.equ RTC_ALRMASSR_MASKSS_2                ,0x04000000
.equ RTC_ALRMASSR_MASKSS_3                ,0x08000000
.equ RTC_ALRMASSR_SS                      ,0x00007FFF

@*******************  Bits definition for RTC_ALRMBSSR register  *************/
.equ RTC_ALRMBSSR_MASKSS                  ,0x0F000000
.equ RTC_ALRMBSSR_MASKSS_0                ,0x01000000
.equ RTC_ALRMBSSR_MASKSS_1                ,0x02000000
.equ RTC_ALRMBSSR_MASKSS_2                ,0x04000000
.equ RTC_ALRMBSSR_MASKSS_3                ,0x08000000
.equ RTC_ALRMBSSR_SS                      ,0x00007FFF

@*******************  Bits definition for RTC_BKP0R register  ****************/
.equ RTC_BKP0R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP1R register  ****************/
.equ RTC_BKP1R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP2R register  ****************/
.equ RTC_BKP2R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP3R register  ****************/
.equ RTC_BKP3R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP4R register  ****************/
.equ RTC_BKP4R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP5R register  ****************/
.equ RTC_BKP5R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP6R register  ****************/
.equ RTC_BKP6R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP7R register  ****************/
.equ RTC_BKP7R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP8R register  ****************/
.equ RTC_BKP8R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP9R register  ****************/
.equ RTC_BKP9R                            ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP10R register  ***************/
.equ RTC_BKP10R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP11R register  ***************/
.equ RTC_BKP11R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP12R register  ***************/
.equ RTC_BKP12R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP13R register  ***************/
.equ RTC_BKP13R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP14R register  ***************/
.equ RTC_BKP14R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP15R register  ***************/
.equ RTC_BKP15R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP16R register  ***************/
.equ RTC_BKP16R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP17R register  ***************/
.equ RTC_BKP17R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP18R register  ***************/
.equ RTC_BKP18R                           ,0xFFFFFFFF

@*******************  Bits definition for RTC_BKP19R register  ***************/
.equ RTC_BKP19R                           ,0xFFFFFFFF

@******************************************************************************/
@*                                                                            */
@*                          SD host Interface                                 */
@*                                                                            */
@******************************************************************************/
@*****************  Bit definition for SDIO_POWER register  ******************/
.equ  SDIO_POWER_PWRCTRL                  ,0x03               @<PWRCTRL[1:0] bits (Power supply control bits) */
.equ  SDIO_POWER_PWRCTRL_0                ,0x01               @<Bit 0 */
.equ  SDIO_POWER_PWRCTRL_1                ,0x02               @<Bit 1 */

@*****************  Bit definition for SDIO_CLKCR register  ******************/
.equ  SDIO_CLKCR_CLKDIV                   ,0x00FF            @<Clock divide factor */
.equ  SDIO_CLKCR_CLKEN                    ,0x0100            @<Clock enable bit */
.equ  SDIO_CLKCR_PWRSAV                   ,0x0200            @<Power saving configuration bit */
.equ  SDIO_CLKCR_BYPASS                   ,0x0400            @<Clock divider bypass enable bit */

.equ  SDIO_CLKCR_WIDBUS                   ,0x1800            @<WIDBUS[1:0] bits (Wide bus mode enable bit) */
.equ  SDIO_CLKCR_WIDBUS_0                 ,0x0800            @<Bit 0 */
.equ  SDIO_CLKCR_WIDBUS_1                 ,0x1000            @<Bit 1 */

.equ  SDIO_CLKCR_NEGEDGE                  ,0x2000            @<SDIO_CK dephasing selection bit */
.equ  SDIO_CLKCR_HWFC_EN                  ,0x4000            @<HW Flow Control enable */

@******************  Bit definition for SDIO_ARG register  *******************/
.equ  SDIO_ARG_CMDARG                     ,0xFFFFFFFF            @<Command argument */

@******************  Bit definition for SDIO_CMD register  *******************/
.equ  SDIO_CMD_CMDINDEX                   ,0x003F            @<Command Index */

.equ  SDIO_CMD_WAITRESP                   ,0x00C0            @<WAITRESP[1:0] bits (Wait for response bits) */
.equ  SDIO_CMD_WAITRESP_0                 ,0x0040            @< Bit 0 */
.equ  SDIO_CMD_WAITRESP_1                 ,0x0080            @< Bit 1 */

.equ  SDIO_CMD_WAITINT                    ,0x0100            @<CPSM Waits for Interrupt Request */
.equ  SDIO_CMD_WAITPEND                   ,0x0200            @<CPSM Waits for ends of data transfer (CmdPend internal signal) */
.equ  SDIO_CMD_CPSMEN                     ,0x0400            @<Command path state machine (CPSM) Enable bit */
.equ  SDIO_CMD_SDIOSUSPEND                ,0x0800            @<SD I/O suspend command */
.equ  SDIO_CMD_ENCMDCOMPL                 ,0x1000            @<Enable CMD completion */
.equ  SDIO_CMD_NIEN                       ,0x2000            @<Not Interrupt Enable */
.equ  SDIO_CMD_CEATACMD                   ,0x4000            @<CE-ATA command */

@****************  Bit definition for SDIO_RESPCMD register  *****************/
.equ  SDIO_RESPCMD_RESPCMD                ,0x3F               @<Response command index */

@*****************  Bit definition for SDIO_RESP0 register  ******************/
.equ  SDIO_RESP0_CARDSTATUS0              ,0xFFFFFFFF         @<Card Status */

@*****************  Bit definition for SDIO_RESP1 register  ******************/
.equ  SDIO_RESP1_CARDSTATUS1              ,0xFFFFFFFF         @<Card Status */

@*****************  Bit definition for SDIO_RESP2 register  ******************/
.equ  SDIO_RESP2_CARDSTATUS2              ,0xFFFFFFFF         @<Card Status */

@*****************  Bit definition for SDIO_RESP3 register  ******************/
.equ  SDIO_RESP3_CARDSTATUS3              ,0xFFFFFFFF         @<Card Status */

@*****************  Bit definition for SDIO_RESP4 register  ******************/
.equ  SDIO_RESP4_CARDSTATUS4              ,0xFFFFFFFF         @<Card Status */

@*****************  Bit definition for SDIO_DTIMER register  *****************/
.equ  SDIO_DTIMER_DATATIME                ,0xFFFFFFFF         @<Data timeout period. */

@*****************  Bit definition for SDIO_DLEN register  *******************/
.equ  SDIO_DLEN_DATALENGTH                ,0x01FFFFFF         @<Data length value */

@*****************  Bit definition for SDIO_DCTRL register  ******************/
.equ  SDIO_DCTRL_DTEN                     ,0x0001            @<Data transfer enabled bit */
.equ  SDIO_DCTRL_DTDIR                    ,0x0002            @<Data transfer direction selection */
.equ  SDIO_DCTRL_DTMODE                   ,0x0004            @<Data transfer mode selection */
.equ  SDIO_DCTRL_DMAEN                    ,0x0008            @<DMA enabled bit */

.equ  SDIO_DCTRL_DBLOCKSIZE               ,0x00F0            @<DBLOCKSIZE[3:0] bits (Data block size) */
.equ  SDIO_DCTRL_DBLOCKSIZE_0             ,0x0010            @<Bit 0 */
.equ  SDIO_DCTRL_DBLOCKSIZE_1             ,0x0020            @<Bit 1 */
.equ  SDIO_DCTRL_DBLOCKSIZE_2             ,0x0040            @<Bit 2 */
.equ  SDIO_DCTRL_DBLOCKSIZE_3             ,0x0080            @<Bit 3 */

.equ  SDIO_DCTRL_RWSTART                  ,0x0100            @<Read wait start */
.equ  SDIO_DCTRL_RWSTOP                   ,0x0200            @<Read wait stop */
.equ  SDIO_DCTRL_RWMOD                    ,0x0400            @<Read wait mode */
.equ  SDIO_DCTRL_SDIOEN                   ,0x0800            @<SD I/O enable functions */

@*****************  Bit definition for SDIO_DCOUNT register  *****************/
.equ  SDIO_DCOUNT_DATACOUNT               ,0x01FFFFFF         @<Data count value */

@*****************  Bit definition for SDIO_STA register  ********************/
.equ  SDIO_STA_CCRCFAIL                   ,0x00000001         @<Command response received (CRC check failed) */
.equ  SDIO_STA_DCRCFAIL                   ,0x00000002         @<Data block sent/received (CRC check failed) */
.equ  SDIO_STA_CTIMEOUT                   ,0x00000004         @<Command response timeout */
.equ  SDIO_STA_DTIMEOUT                   ,0x00000008         @<Data timeout */
.equ  SDIO_STA_TXUNDERR                   ,0x00000010         @<Transmit FIFO underrun error */
.equ  SDIO_STA_RXOVERR                    ,0x00000020         @<Received FIFO overrun error */
.equ  SDIO_STA_CMDREND                    ,0x00000040         @<Command response received (CRC check passed) */
.equ  SDIO_STA_CMDSENT                    ,0x00000080         @<Command sent (no response required) */
.equ  SDIO_STA_DATAEND                    ,0x00000100         @<Data end (data counter, SDIDCOUNT, is zero) */
.equ  SDIO_STA_STBITERR                   ,0x00000200         @<Start bit not detected on all data signals in wide bus mode */
.equ  SDIO_STA_DBCKEND                    ,0x00000400         @<Data block sent/received (CRC check passed) */
.equ  SDIO_STA_CMDACT                     ,0x00000800         @<Command transfer in progress */
.equ  SDIO_STA_TXACT                      ,0x00001000         @<Data transmit in progress */
.equ  SDIO_STA_RXACT                      ,0x00002000         @<Data receive in progress */
.equ  SDIO_STA_TXFIFOHE                   ,0x00004000         @<Transmit FIFO Half Empty: at least 8 words can be written into the FIFO */
.equ  SDIO_STA_RXFIFOHF                   ,0x00008000         @<Receive FIFO Half Full: there are at least 8 words in the FIFO */
.equ  SDIO_STA_TXFIFOF                    ,0x00010000         @<Transmit FIFO full */
.equ  SDIO_STA_RXFIFOF                    ,0x00020000         @<Receive FIFO full */
.equ  SDIO_STA_TXFIFOE                    ,0x00040000         @<Transmit FIFO empty */
.equ  SDIO_STA_RXFIFOE                    ,0x00080000         @<Receive FIFO empty */
.equ  SDIO_STA_TXDAVL                     ,0x00100000         @<Data available in transmit FIFO */
.equ  SDIO_STA_RXDAVL                     ,0x00200000         @<Data available in receive FIFO */
.equ  SDIO_STA_SDIOIT                     ,0x00400000         @<SDIO interrupt received */
.equ  SDIO_STA_CEATAEND                   ,0x00800000         @<CE-ATA command completion signal received for CMD61 */

@******************  Bit definition for SDIO_ICR register  *******************/
.equ  SDIO_ICR_CCRCFAILC                  ,0x00000001         @<CCRCFAIL flag clear bit */
.equ  SDIO_ICR_DCRCFAILC                  ,0x00000002         @<DCRCFAIL flag clear bit */
.equ  SDIO_ICR_CTIMEOUTC                  ,0x00000004         @<CTIMEOUT flag clear bit */
.equ  SDIO_ICR_DTIMEOUTC                  ,0x00000008         @<DTIMEOUT flag clear bit */
.equ  SDIO_ICR_TXUNDERRC                  ,0x00000010         @<TXUNDERR flag clear bit */
.equ  SDIO_ICR_RXOVERRC                   ,0x00000020         @<RXOVERR flag clear bit */
.equ  SDIO_ICR_CMDRENDC                   ,0x00000040         @<CMDREND flag clear bit */
.equ  SDIO_ICR_CMDSENTC                   ,0x00000080         @<CMDSENT flag clear bit */
.equ  SDIO_ICR_DATAENDC                   ,0x00000100         @<DATAEND flag clear bit */
.equ  SDIO_ICR_STBITERRC                  ,0x00000200         @<STBITERR flag clear bit */
.equ  SDIO_ICR_DBCKENDC                   ,0x00000400         @<DBCKEND flag clear bit */
.equ  SDIO_ICR_SDIOITC                    ,0x00400000         @<SDIOIT flag clear bit */
.equ  SDIO_ICR_CEATAENDC                  ,0x00800000         @<CEATAEND flag clear bit */

@*****************  Bit definition for SDIO_MASK register  *******************/
.equ  SDIO_MASK_CCRCFAILIE                ,0x00000001         @<Command CRC Fail Interrupt Enable */
.equ  SDIO_MASK_DCRCFAILIE                ,0x00000002         @<Data CRC Fail Interrupt Enable */
.equ  SDIO_MASK_CTIMEOUTIE                ,0x00000004         @<Command TimeOut Interrupt Enable */
.equ  SDIO_MASK_DTIMEOUTIE                ,0x00000008         @<Data TimeOut Interrupt Enable */
.equ  SDIO_MASK_TXUNDERRIE                ,0x00000010         @<Tx FIFO UnderRun Error Interrupt Enable */
.equ  SDIO_MASK_RXOVERRIE                 ,0x00000020         @<Rx FIFO OverRun Error Interrupt Enable */
.equ  SDIO_MASK_CMDRENDIE                 ,0x00000040         @<Command Response Received Interrupt Enable */
.equ  SDIO_MASK_CMDSENTIE                 ,0x00000080         @<Command Sent Interrupt Enable */
.equ  SDIO_MASK_DATAENDIE                 ,0x00000100         @<Data End Interrupt Enable */
.equ  SDIO_MASK_STBITERRIE                ,0x00000200         @<Start Bit Error Interrupt Enable */
.equ  SDIO_MASK_DBCKENDIE                 ,0x00000400         @<Data Block End Interrupt Enable */
.equ  SDIO_MASK_CMDACTIE                  ,0x00000800         @<CCommand Acting Interrupt Enable */
.equ  SDIO_MASK_TXACTIE                   ,0x00001000         @<Data Transmit Acting Interrupt Enable */
.equ  SDIO_MASK_RXACTIE                   ,0x00002000         @<Data receive acting interrupt enabled */
.equ  SDIO_MASK_TXFIFOHEIE                ,0x00004000         @<Tx FIFO Half Empty interrupt Enable */
.equ  SDIO_MASK_RXFIFOHFIE                ,0x00008000         @<Rx FIFO Half Full interrupt Enable */
.equ  SDIO_MASK_TXFIFOFIE                 ,0x00010000         @<Tx FIFO Full interrupt Enable */
.equ  SDIO_MASK_RXFIFOFIE                 ,0x00020000         @<Rx FIFO Full interrupt Enable */
.equ  SDIO_MASK_TXFIFOEIE                 ,0x00040000         @<Tx FIFO Empty interrupt Enable */
.equ  SDIO_MASK_RXFIFOEIE                 ,0x00080000         @<Rx FIFO Empty interrupt Enable */
.equ  SDIO_MASK_TXDAVLIE                  ,0x00100000         @<Data available in Tx FIFO interrupt Enable */
.equ  SDIO_MASK_RXDAVLIE                  ,0x00200000         @<Data available in Rx FIFO interrupt Enable */
.equ  SDIO_MASK_SDIOITIE                  ,0x00400000         @<SDIO Mode Interrupt Received interrupt Enable */
.equ  SDIO_MASK_CEATAENDIE                ,0x00800000         @<CE-ATA command completion signal received Interrupt Enable */

@****************  Bit definition for SDIO_FIFOCNT register  *****************/
.equ  SDIO_FIFOCNT_FIFOCOUNT              ,0x00FFFFFF         @<Remaining number of words to be written to or read from the FIFO */

@*****************  Bit definition for SDIO_FIFO register  *******************/
.equ  SDIO_FIFO_FIFODATA                  ,0xFFFFFFFF         @<Receive and transmit FIFO data */

@*****************************************************************************/
@                                                                            */
@                        Serial Peripheral Interface                         */
@                                                                            */
@*****************************************************************************/
.equ SPI_CR1							  ,0x00
@******************  Bit definition for SPI_CR1 register  ********************/
.equ  SPI_CR1_CPHA                        ,0x0001             @<Clock Phase */
.equ  SPI_CR1_CPOL                        ,0x0002             @<Clock Polarity */
.equ  SPI_CR1_MSTR                        ,0x0004             @<Master Selection */

.equ  SPI_CR1_BR                          ,0x0038             @<BR[2:0] bits (Baud Rate Control) */
.equ  SPI_CR1_BR_0                        ,0x0008             @ SPI_BaudRatePrescaler_4
.equ  SPI_BaudRatePrescaler_4             ,0x0008             @ 

.equ  SPI_CR1_BR_1                        ,0x0010             @ SPI_BaudRatePrescaler_8
.equ  SPI_CR1_BR_2                        ,0x0020             @ SPI_BaudRatePrescaler_32

.equ  SPI_CR1_SPE                         ,0x0040             @<SPI Enable */
.equ  SPI_CR1_SPE_N                       ,6                  @<SPI Enable */

.equ  SPI_CR1_LSBFIRST                    ,0x0080             @<Frame Format */
.equ  SPI_CR1_SSI                         ,0x0100             @<Internal slave select */
.equ  SPI_CR1_SSM                         ,0x0200             @<Software slave management */
.equ  SPI_CR1_RXONLY                      ,0x0400             @<Receive only */
.equ  SPI_CR1_DFF                         ,0x0800             @<Data Frame Format */
.equ  SPI_CR1_CRCNEXT                     ,0x1000             @<Transmit CRC next */
.equ  SPI_CR1_CRCEN                       ,0x2000             @<Hardware CRC calculation enable */
.equ  SPI_CR1_BIDIOE                      ,0x4000             @<Output enable in bidirectional mode */
.equ  SPI_CR1_BIDIMODE                    ,0x8000             @<Bidirectional data mode enable */

.equ SPI_CR2							  ,0x04
@******************  Bit definition for SPI_CR2 register  ********************/
.equ  SPI_CR2_RXDMAEN                     ,0x01               @<Rx Buffer DMA Enable */
.equ  SPI_CR2_TXDMAEN                     ,0x02               @<Tx Buffer DMA Enable */
.equ  SPI_CR2_SSOE                        ,0x04               @<SS Output Enable */
.equ  SPI_CR2_ERRIE                       ,0x20               @<Error Interrupt Enable */
.equ  SPI_CR2_RXNEIE                      ,0x40               @<RX buffer Not Empty Interrupt Enable */
.equ  SPI_CR2_TXEIE                       ,0x80               @<Tx buffer Empty Interrupt Enable */

.equ  SPI_SR							  ,0x08
@*******************  Bit definition for SPI_SR register  ********************/
.equ  SPI_SR_RXNE                         ,0x01               @<Receive buffer Not Empty */

.equ  SPI_SR_TXE                          ,0x02               @<Transmit buffer Empty */
.equ  SPI_SR_TXE_N                        ,1                  @<Transmit buffer Empty */

.equ  SPI_SR_CHSIDE                       ,0x04               @<Channel side */
.equ  SPI_SR_UDR                          ,0x08               @<Underrun flag */
.equ  SPI_SR_CRCERR                       ,0x10               @<CRC Error flag */
.equ  SPI_SR_MODF                         ,0x20               @<Mode fault */
.equ  SPI_SR_OVR                          ,0x40               @<Overrun flag */

.equ  SPI_SR_BSY                          ,0x80               @<Busy flag */
.equ  SPI_SR_BSY_N                        ,7               @<Busy flag */


.equ  SPI_DR							  ,0X0C
@*******************  Bit definition for SPI_DR register  ********************/
.equ  SPI_DR_DR                           ,0xFFFF             @<Data Register */

@******************  Bit definition for SPI_CRCPR register  ******************/
.equ  SPI_CRCPR_CRCPOLY                   ,0xFFFF             @<CRC polynomial register */

@*****************  Bit definition for SPI_RXCRCR register  ******************/
.equ  SPI_RXCRCR_RXCRC                    ,0xFFFF             @<Rx CRC Register */

@*****************  Bit definition for SPI_TXCRCR register  ******************/
.equ  SPI_TXCRCR_TXCRC                    ,0xFFFF             @<Tx CRC Register */

.equ SPI_I2SCFGR						  ,0x1C
@*****************  Bit definition for SPI_I2SCFGR register  *****************/
.equ  SPI_I2SCFGR_CHLEN                   ,0x0001             @<Channel length (number of bits per audio channel) */

.equ  SPI_I2SCFGR_DATLEN                  ,0x0006             @<DATLEN[1:0] bits (Data length to be transferred) */
.equ  SPI_I2SCFGR_DATLEN_0                ,0x0002             @<Bit 0 */
.equ  SPI_I2SCFGR_DATLEN_1                ,0x0004             @<Bit 1 */

.equ  SPI_I2SCFGR_CKPOL                   ,0x0008             @<steady state clock polarity */

.equ  SPI_I2SCFGR_I2SSTD                  ,0x0030             @<I2SSTD[1:0] bits (I2S standard selection) */
.equ  SPI_I2SCFGR_I2SSTD_0                ,0x0010             @<Bit 0 */
.equ  SPI_I2SCFGR_I2SSTD_1                ,0x0020             @<Bit 1 */

.equ  SPI_I2SCFGR_PCMSYNC                 ,0x0080             @<PCM frame synchronization */

.equ  SPI_I2SCFGR_I2SCFG                  ,0x0300             @<I2SCFG[1:0] bits (I2S configuration mode) */
.equ  SPI_I2SCFGR_I2SCFG_0                ,0x0100             @<Bit 0 */
.equ  SPI_I2SCFGR_I2SCFG_1                ,0x0200             @<Bit 1 */

.equ  SPI_I2SCFGR_I2SE                    ,0x0400             @<I2S Enable */
.equ  SPI_I2SCFGR_I2SMOD                  ,0x0800             @<I2S mode selection */
.equ  SPI_I2SCFGR_I2SMOD_N                ,11             @<I2S mode selection */

@*****************  Bit definition for SPI_I2SPR register  *******************/
.equ  SPI_I2SPR_I2SDIV                    ,0x00FF             @<I2S Linear prescaler */
.equ  SPI_I2SPR_ODD                       ,0x0100             @<Odd factor for the prescaler */
.equ  SPI_I2SPR_MCKOE                     ,0x0200             @<Master Clock Output Enable */

@*****************************************************************************/
@                                                                            */
@                                 SYSCFG                                     */
@                                                                            */
@*****************************************************************************/
@*****************  Bit definition for SYSCFG_MEMRMP register  ***************/  
.equ SYSCFG_MEMRMP_MEM_MODE          ,0x00000003  @<SYSCFG_Memory Remap Config */
.equ SYSCFG_MEMRMP_MEM_MODE_0        ,0x00000001 
.equ SYSCFG_MEMRMP_MEM_MODE_1        ,0x00000002 

@*****************  Bit definition for SYSCFG_PMC register  ******************/
.equ SYSCFG_PMC_MII_RMII_SEL         ,0x00800000  @<Ethernet PHY interface selection */
@ Old MII_RMII_SEL bit definition, maintained for legacy purpose */
.equ SYSCFG_PMC_MII_RMII             ,SYSCFG_PMC_MII_RMII_SEL

@****************  Bit definition for SYSCFG_EXTICR1 register  ***************/
.equ SYSCFG_EXTICR1_EXTI0            ,0x000F  @<EXTI 0 configuration */
.equ SYSCFG_EXTICR1_EXTI1            ,0x00F0  @<EXTI 1 configuration */
.equ SYSCFG_EXTICR1_EXTI2            ,0x0F00  @<EXTI 2 configuration */
.equ SYSCFG_EXTICR1_EXTI3            ,0xF000  @<EXTI 3 configuration */
@* 
@* @brief   EXTI0 configuration  
@* 
.equ SYSCFG_EXTICR1_EXTI0_PA         ,0x0000  @<PA[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PB         ,0x0001  @<PB[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PC         ,0x0002  @<PC[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PD         ,0x0003  @<PD[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PE         ,0x0004  @<PE[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PF         ,0x0005  @<PF[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PG         ,0x0006  @<PG[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PH         ,0x0007  @<PH[0] pin */
.equ SYSCFG_EXTICR1_EXTI0_PI         ,0x0008  @<PI[0] pin */
@* 
@* @brief   EXTI1 configuration  
@* 
.equ SYSCFG_EXTICR1_EXTI1_PA         ,0x0000  @<PA[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PB         ,0x0010  @<PB[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PC         ,0x0020  @<PC[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PD         ,0x0030  @<PD[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PE         ,0x0040  @<PE[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PF         ,0x0050  @<PF[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PG         ,0x0060  @<PG[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PH         ,0x0070  @<PH[1] pin */
.equ SYSCFG_EXTICR1_EXTI1_PI         ,0x0080  @<PI[1] pin */
@* 
@* @brief   EXTI2 configuration  
@* 
.equ SYSCFG_EXTICR1_EXTI2_PA         ,0x0000  @<PA[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PB         ,0x0100  @<PB[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PC         ,0x0200  @<PC[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PD         ,0x0300  @<PD[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PE         ,0x0400  @<PE[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PF         ,0x0500  @<PF[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PG         ,0x0600  @<PG[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PH         ,0x0700  @<PH[2] pin */
.equ SYSCFG_EXTICR1_EXTI2_PI         ,0x0800  @<PI[2] pin */
@* 
@* @brief   EXTI3 configuration  
@* 
.equ SYSCFG_EXTICR1_EXTI3_PA         ,0x0000  @<PA[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PB         ,0x1000  @<PB[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PC         ,0x2000  @<PC[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PD         ,0x3000  @<PD[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PE         ,0x4000  @<PE[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PF         ,0x5000  @<PF[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PG         ,0x6000  @<PG[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PH         ,0x7000  @<PH[3] pin */
.equ SYSCFG_EXTICR1_EXTI3_PI         ,0x8000  @<PI[3] pin */
                                             
@****************  Bit definition for SYSCFG_EXTICR2 register  ***************/
.equ SYSCFG_EXTICR2_EXTI4            ,0x000F  @<EXTI 4 configuration */
.equ SYSCFG_EXTICR2_EXTI5            ,0x00F0  @<EXTI 5 configuration */
.equ SYSCFG_EXTICR2_EXTI6            ,0x0F00  @<EXTI 6 configuration */
.equ SYSCFG_EXTICR2_EXTI7            ,0xF000  @<EXTI 7 configuration */
@*                                           
@* @brief   EXTI4 configuration  
@* 
.equ SYSCFG_EXTICR2_EXTI4_PA         ,0x0000  @<PA[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PB         ,0x0001  @<PB[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PC         ,0x0002  @<PC[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PD         ,0x0003  @<PD[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PE         ,0x0004  @<PE[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PF         ,0x0005  @<PF[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PG         ,0x0006  @<PG[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PH         ,0x0007  @<PH[4] pin */
.equ SYSCFG_EXTICR2_EXTI4_PI         ,0x0008  @<PI[4] pin */
@* 
@* @brief   EXTI5 configuration  
@* 
.equ SYSCFG_EXTICR2_EXTI5_PA         ,0x0000  @<PA[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PB         ,0x0010  @<PB[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PC         ,0x0020  @<PC[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PD         ,0x0030  @<PD[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PE         ,0x0040  @<PE[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PF         ,0x0050  @<PF[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PG         ,0x0060  @<PG[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PH         ,0x0070  @<PH[5] pin */
.equ SYSCFG_EXTICR2_EXTI5_PI         ,0x0080  @<PI[5] pin */
@* 
@* @brief   EXTI6 configuration  
@* 
.equ SYSCFG_EXTICR2_EXTI6_PA         ,0x0000  @<PA[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PB         ,0x0100  @<PB[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PC         ,0x0200  @<PC[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PD         ,0x0300  @<PD[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PE         ,0x0400  @<PE[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PF         ,0x0500  @<PF[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PG         ,0x0600  @<PG[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PH         ,0x0700  @<PH[6] pin */
.equ SYSCFG_EXTICR2_EXTI6_PI         ,0x0800  @<PI[6] pin */
@* 
@* @brief   EXTI7 configuration  
@* 
.equ SYSCFG_EXTICR2_EXTI7_PA         ,0x0000  @<PA[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PB         ,0x1000  @<PB[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PC         ,0x2000  @<PC[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PD         ,0x3000  @<PD[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PE         ,0x4000  @<PE[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PF         ,0x5000  @<PF[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PG         ,0x6000  @<PG[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PH         ,0x7000  @<PH[7] pin */
.equ SYSCFG_EXTICR2_EXTI7_PI         ,0x8000  @<PI[7] pin */

@****************  Bit definition for SYSCFG_EXTICR3 register  ***************/
.equ SYSCFG_EXTICR3_EXTI8            ,0x000F  @<EXTI 8 configuration */
.equ SYSCFG_EXTICR3_EXTI9            ,0x00F0  @<EXTI 9 configuration */
.equ SYSCFG_EXTICR3_EXTI10           ,0x0F00  @<EXTI 10 configuration */
.equ SYSCFG_EXTICR3_EXTI11           ,0xF000  @<EXTI 11 configuration */
                                             
@* 
@* @brief   EXTI8 configuration  
@* 
.equ SYSCFG_EXTICR3_EXTI8_PA         ,0x0000  @<PA[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PB         ,0x0001  @<PB[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PC         ,0x0002  @<PC[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PD         ,0x0003  @<PD[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PE         ,0x0004  @<PE[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PF         ,0x0005  @<PF[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PG         ,0x0006  @<PG[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PH         ,0x0007  @<PH[8] pin */
.equ SYSCFG_EXTICR3_EXTI8_PI         ,0x0008  @<PI[8] pin */
@* 
@* @brief   EXTI9 configuration  
@* 
.equ SYSCFG_EXTICR3_EXTI9_PA         ,0x0000  @<PA[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PB         ,0x0010  @<PB[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PC         ,0x0020  @<PC[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PD         ,0x0030  @<PD[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PE         ,0x0040  @<PE[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PF         ,0x0050  @<PF[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PG         ,0x0060  @<PG[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PH         ,0x0070  @<PH[9] pin */
.equ SYSCFG_EXTICR3_EXTI9_PI         ,0x0080  @<PI[9] pin */
@* 
@* @brief   EXTI10 configuration  
@* 
.equ SYSCFG_EXTICR3_EXTI10_PA        ,0x0000  @<PA[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PB        ,0x0100  @<PB[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PC        ,0x0200  @<PC[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PD        ,0x0300  @<PD[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PE        ,0x0400  @<PE[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PF        ,0x0500  @<PF[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PG        ,0x0600  @<PG[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PH        ,0x0700  @<PH[10] pin */
.equ SYSCFG_EXTICR3_EXTI10_PI        ,0x0800  @<PI[10] pin */
@* 
@* @brief   EXTI11 configuration  
@* 
.equ SYSCFG_EXTICR3_EXTI11_PA        ,0x0000  @<PA[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PB        ,0x1000  @<PB[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PC        ,0x2000  @<PC[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PD        ,0x3000  @<PD[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PE        ,0x4000  @<PE[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PF        ,0x5000  @<PF[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PG        ,0x6000  @<PG[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PH        ,0x7000  @<PH[11] pin */
.equ SYSCFG_EXTICR3_EXTI11_PI        ,0x8000  @<PI[11] pin */

@****************  Bit definition for SYSCFG_EXTICR4 register  ***************/
.equ SYSCFG_EXTICR4_EXTI12           ,0x000F  @<EXTI 12 configuration */
.equ SYSCFG_EXTICR4_EXTI13           ,0x00F0  @<EXTI 13 configuration */
.equ SYSCFG_EXTICR4_EXTI14           ,0x0F00  @<EXTI 14 configuration */
.equ SYSCFG_EXTICR4_EXTI15           ,0xF000  @<EXTI 15 configuration */
@* 
@* @brief   EXTI12 configuration  
@* 
.equ SYSCFG_EXTICR4_EXTI12_PA        ,0x0000  @<PA[12] pin */
.equ SYSCFG_EXTICR4_EXTI12_PB        ,0x0001  @<PB[12] pin */
.equ SYSCFG_EXTICR4_EXTI12_PC        ,0x0002  @<PC[12] pin */
.equ SYSCFG_EXTICR4_EXTI12_PD        ,0x0003  @<PD[12] pin */
.equ SYSCFG_EXTICR4_EXTI12_PE        ,0x0004  @<PE[12] pin */
.equ SYSCFG_EXTICR4_EXTI12_PF        ,0x0005  @<PF[12] pin */
.equ SYSCFG_EXTICR4_EXTI12_PG        ,0x0006  @<PG[12] pin */
.equ SYSCFG_EXTICR3_EXTI12_PH        ,0x0007  @<PH[12] pin */
@* 
@* @brief   EXTI13 configuration  
@* 
.equ SYSCFG_EXTICR4_EXTI13_PA        ,0x0000  @<PA[13] pin */
.equ SYSCFG_EXTICR4_EXTI13_PB        ,0x0010  @<PB[13] pin */
.equ SYSCFG_EXTICR4_EXTI13_PC        ,0x0020  @<PC[13] pin */
.equ SYSCFG_EXTICR4_EXTI13_PD        ,0x0030  @<PD[13] pin */
.equ SYSCFG_EXTICR4_EXTI13_PE        ,0x0040  @<PE[13] pin */
.equ SYSCFG_EXTICR4_EXTI13_PF        ,0x0050  @<PF[13] pin */
.equ SYSCFG_EXTICR4_EXTI13_PG        ,0x0060  @<PG[13] pin */
.equ SYSCFG_EXTICR3_EXTI13_PH        ,0x0070  @<PH[13] pin */
@* 
@* @brief   EXTI14 configuration  
@* 
.equ SYSCFG_EXTICR4_EXTI14_PA        ,0x0000  @<PA[14] pin */
.equ SYSCFG_EXTICR4_EXTI14_PB        ,0x0100  @<PB[14] pin */
.equ SYSCFG_EXTICR4_EXTI14_PC        ,0x0200  @<PC[14] pin */
.equ SYSCFG_EXTICR4_EXTI14_PD        ,0x0300  @<PD[14] pin */
.equ SYSCFG_EXTICR4_EXTI14_PE        ,0x0400  @<PE[14] pin */
.equ SYSCFG_EXTICR4_EXTI14_PF        ,0x0500  @<PF[14] pin */
.equ SYSCFG_EXTICR4_EXTI14_PG        ,0x0600  @<PG[14] pin */
.equ SYSCFG_EXTICR3_EXTI14_PH        ,0x0700  @<PH[14] pin */
@* 
@* brief   EXTI15 configuration  
@* 
.equ SYSCFG_EXTICR4_EXTI15_PA        ,0x0000  @<PA[15] pin */
.equ SYSCFG_EXTICR4_EXTI15_PB        ,0x1000  @<PB[15] pin */
.equ SYSCFG_EXTICR4_EXTI15_PC        ,0x2000  @<PC[15] pin */
.equ SYSCFG_EXTICR4_EXTI15_PD        ,0x3000  @<PD[15] pin */
.equ SYSCFG_EXTICR4_EXTI15_PE        ,0x4000  @<PE[15] pin */
.equ SYSCFG_EXTICR4_EXTI15_PF        ,0x5000  @<PF[15] pin */
.equ SYSCFG_EXTICR4_EXTI15_PG        ,0x6000  @<PG[15] pin */
.equ SYSCFG_EXTICR3_EXTI15_PH        ,0x7000  @<PH[15] pin */

@*****************  Bit definition for SYSCFG_CMPCR register  ****************/  
.equ SYSCFG_CMPCR_CMP_PD             ,0x00000001  @<Compensation cell ready flag */
.equ SYSCFG_CMPCR_READY              ,0x00000100  @<Compensation cell power-down */

@******************************************************************************/
@*                                                                            */
@*                                    TIM                                     */
@*                                                                            */
@******************************************************************************/
@******************  Bit definition for TIM_CR1 register  ********************/
.equ  TIM_CR1_CEN                         ,0x0001             @<Counter enable */
.equ  TIM_CR1_UDIS                        ,0x0002             @<Update disable */
.equ  TIM_CR1_URS                         ,0x0004             @<Update request source */
.equ  TIM_CR1_OPM                         ,0x0008             @<One pulse mode */
.equ  TIM_CR1_DIR                         ,0x0010             @<Direction */

.equ  TIM_CR1_CMS                         ,0x0060             @<CMS[1:0] bits (Center-aligned mode selection) */
.equ  TIM_CR1_CMS_0                       ,0x0020             @<Bit 0 */
.equ  TIM_CR1_CMS_1                       ,0x0040             @<Bit 1 */

.equ  TIM_CR1_ARPE                        ,0x0080             @<Auto-reload preload enable */

.equ  TIM_CR1_CKD                         ,0x0300             @<CKD[1:0] bits (clock division) */
.equ  TIM_CR1_CKD_0                       ,0x0100             @<Bit 0 */
.equ  TIM_CR1_CKD_1                       ,0x0200             @<Bit 1 */

@******************  Bit definition for TIM_CR2 register  ********************/
.equ  TIM_CR2_CCPC                        ,0x0001             @<Capture/Compare Preloaded Control */
.equ  TIM_CR2_CCUS                        ,0x0004             @<Capture/Compare Control Update Selection */
.equ  TIM_CR2_CCDS                        ,0x0008             @<Capture/Compare DMA Selection */

.equ  TIM_CR2_MMS                         ,0x0070             @<MMS[2:0] bits (Master Mode Selection) */
.equ  TIM_CR2_MMS_0                       ,0x0010             @<Bit 0 */
.equ  TIM_CR2_MMS_1                       ,0x0020             @<Bit 1 */
.equ  TIM_CR2_MMS_2                       ,0x0040             @<Bit 2 */

.equ  TIM_CR2_TI1S                        ,0x0080             @<TI1 Selection */
.equ  TIM_CR2_OIS1                        ,0x0100             @<Output Idle state 1 (OC1 output) */
.equ  TIM_CR2_OIS1N                       ,0x0200             @<Output Idle state 1 (OC1N output) */
.equ  TIM_CR2_OIS2                        ,0x0400             @<Output Idle state 2 (OC2 output) */
.equ  TIM_CR2_OIS2N                       ,0x0800             @<Output Idle state 2 (OC2N output) */
.equ  TIM_CR2_OIS3                        ,0x1000             @<Output Idle state 3 (OC3 output) */
.equ  TIM_CR2_OIS3N                       ,0x2000             @<Output Idle state 3 (OC3N output) */
.equ  TIM_CR2_OIS4                        ,0x4000             @<Output Idle state 4 (OC4 output) */

@******************  Bit definition for TIM_SMCR register  *******************/
.equ  TIM_SMCR_SMS                        ,0x0007             @<SMS[2:0] bits (Slave mode selection) */
.equ  TIM_SMCR_SMS_0                      ,0x0001             @<Bit 0 */
.equ  TIM_SMCR_SMS_1                      ,0x0002             @<Bit 1 */
.equ  TIM_SMCR_SMS_2                      ,0x0004             @<Bit 2 */

.equ  TIM_SMCR_TS                         ,0x0070             @<TS[2:0] bits (Trigger selection) */
.equ  TIM_SMCR_TS_0                       ,0x0010             @<Bit 0 */
.equ  TIM_SMCR_TS_1                       ,0x0020             @<Bit 1 */
.equ  TIM_SMCR_TS_2                       ,0x0040             @<Bit 2 */

.equ  TIM_SMCR_MSM                        ,0x0080             @<Master/slave mode */

.equ  TIM_SMCR_ETF                        ,0x0F00             @<ETF[3:0] bits (External trigger filter) */
.equ  TIM_SMCR_ETF_0                      ,0x0100             @<Bit 0 */
.equ  TIM_SMCR_ETF_1                      ,0x0200             @<Bit 1 */
.equ  TIM_SMCR_ETF_2                      ,0x0400             @<Bit 2 */
.equ  TIM_SMCR_ETF_3                      ,0x0800             @<Bit 3 */

.equ  TIM_SMCR_ETPS                       ,0x3000             @<ETPS[1:0] bits (External trigger prescaler) */
.equ  TIM_SMCR_ETPS_0                     ,0x1000             @<Bit 0 */
.equ  TIM_SMCR_ETPS_1                     ,0x2000             @<Bit 1 */

.equ  TIM_SMCR_ECE                        ,0x4000             @<External clock enable */
.equ  TIM_SMCR_ETP                        ,0x8000             @<External trigger polarity */

@******************  Bit definition for TIM_DIER register  *******************/
.equ  TIM_DIER_UIE                        ,0x0001             @<Update interrupt enable */
.equ  TIM_DIER_CC1IE                      ,0x0002             @<Capture/Compare 1 interrupt enable */
.equ  TIM_DIER_CC2IE                      ,0x0004             @<Capture/Compare 2 interrupt enable */
.equ  TIM_DIER_CC3IE                      ,0x0008             @<Capture/Compare 3 interrupt enable */
.equ  TIM_DIER_CC4IE                      ,0x0010             @<Capture/Compare 4 interrupt enable */
.equ  TIM_DIER_COMIE                      ,0x0020             @<COM interrupt enable */
.equ  TIM_DIER_TIE                        ,0x0040             @<Trigger interrupt enable */
.equ  TIM_DIER_BIE                        ,0x0080             @<Break interrupt enable */
.equ  TIM_DIER_UDE                        ,0x0100             @<Update DMA request enable */
.equ  TIM_DIER_CC1DE                      ,0x0200             @<Capture/Compare 1 DMA request enable */
.equ  TIM_DIER_CC2DE                      ,0x0400             @<Capture/Compare 2 DMA request enable */
.equ  TIM_DIER_CC3DE                      ,0x0800             @<Capture/Compare 3 DMA request enable */
.equ  TIM_DIER_CC4DE                      ,0x1000             @<Capture/Compare 4 DMA request enable */
.equ  TIM_DIER_COMDE                      ,0x2000             @<COM DMA request enable */
.equ  TIM_DIER_TDE                        ,0x4000             @<Trigger DMA request enable */

@*******************  Bit definition for TIM_SR register  ********************/
.equ  TIM_SR_UIF                          ,0x0001             @<Update interrupt Flag */
.equ  TIM_SR_CC1IF                        ,0x0002             @<Capture/Compare 1 interrupt Flag */
.equ  TIM_SR_CC2IF                        ,0x0004             @<Capture/Compare 2 interrupt Flag */
.equ  TIM_SR_CC3IF                        ,0x0008             @<Capture/Compare 3 interrupt Flag */
.equ  TIM_SR_CC4IF                        ,0x0010             @<Capture/Compare 4 interrupt Flag */
.equ  TIM_SR_COMIF                        ,0x0020             @<COM interrupt Flag */
.equ  TIM_SR_TIF                          ,0x0040             @<Trigger interrupt Flag */
.equ  TIM_SR_BIF                          ,0x0080             @<Break interrupt Flag */
.equ  TIM_SR_CC1OF                        ,0x0200             @<Capture/Compare 1 Overcapture Flag */
.equ  TIM_SR_CC2OF                        ,0x0400             @<Capture/Compare 2 Overcapture Flag */
.equ  TIM_SR_CC3OF                        ,0x0800             @<Capture/Compare 3 Overcapture Flag */
.equ  TIM_SR_CC4OF                        ,0x1000             @<Capture/Compare 4 Overcapture Flag */

@******************  Bit definition for TIM_EGR register  ********************/
.equ  TIM_EGR_UG                          ,0x01                @<Update Generation */
.equ  TIM_EGR_CC1G                        ,0x02                @<Capture/Compare 1 Generation */
.equ  TIM_EGR_CC2G                        ,0x04                @<Capture/Compare 2 Generation */
.equ  TIM_EGR_CC3G                        ,0x08                @<Capture/Compare 3 Generation */
.equ  TIM_EGR_CC4G                        ,0x10                @<Capture/Compare 4 Generation */
.equ  TIM_EGR_COMG                        ,0x20                @<Capture/Compare Control Update Generation */
.equ  TIM_EGR_TG                          ,0x40                @<Trigger Generation */
.equ  TIM_EGR_BG                          ,0x80                @<Break Generation */

@*****************  Bit definition for TIM_CCMR1 register  *******************/
.equ  TIM_CCMR1_CC1S                      ,0x0003             @<CC1S[1:0] bits (Capture/Compare 1 Selection) */
.equ  TIM_CCMR1_CC1S_0                    ,0x0001             @<Bit 0 */
.equ  TIM_CCMR1_CC1S_1                    ,0x0002             @<Bit 1 */

.equ  TIM_CCMR1_OC1FE                     ,0x0004             @<Output Compare 1 Fast enable */
.equ  TIM_CCMR1_OC1PE                     ,0x0008             @<Output Compare 1 Preload enable */

.equ  TIM_CCMR1_OC1M                      ,0x0070             @<OC1M[2:0] bits (Output Compare 1 Mode) */
.equ  TIM_CCMR1_OC1M_0                    ,0x0010             @<Bit 0 */
.equ  TIM_CCMR1_OC1M_1                    ,0x0020             @<Bit 1 */
.equ  TIM_CCMR1_OC1M_2                    ,0x0040             @<Bit 2 */

.equ  TIM_CCMR1_OC1CE                     ,0x0080             @<Output Compare 1Clear Enable */

.equ  TIM_CCMR1_CC2S                      ,0x0300             @<CC2S[1:0] bits (Capture/Compare 2 Selection) */
.equ  TIM_CCMR1_CC2S_0                    ,0x0100             @<Bit 0 */
.equ  TIM_CCMR1_CC2S_1                    ,0x0200             @<Bit 1 */

.equ  TIM_CCMR1_OC2FE                     ,0x0400             @<Output Compare 2 Fast enable */
.equ  TIM_CCMR1_OC2PE                     ,0x0800             @<Output Compare 2 Preload enable */

.equ  TIM_CCMR1_OC2M                      ,0x7000             @<OC2M[2:0] bits (Output Compare 2 Mode) */
.equ  TIM_CCMR1_OC2M_0                    ,0x1000             @<Bit 0 */
.equ  TIM_CCMR1_OC2M_1                    ,0x2000             @<Bit 1 */
.equ  TIM_CCMR1_OC2M_2                    ,0x4000             @<Bit 2 */

.equ  TIM_CCMR1_OC2CE                     ,0x8000             @<Output Compare 2 Clear Enable */

@----------------------------------------------------------------------------*/

.equ  TIM_CCMR1_IC1PSC                    ,0x000C             @<IC1PSC[1:0] bits (Input Capture 1 Prescaler) */
.equ  TIM_CCMR1_IC1PSC_0                  ,0x0004             @<Bit 0 */
.equ  TIM_CCMR1_IC1PSC_1                  ,0x0008             @<Bit 1 */

.equ  TIM_CCMR1_IC1F                      ,0x00F0             @<IC1F[3:0] bits (Input Capture 1 Filter) */
.equ  TIM_CCMR1_IC1F_0                    ,0x0010             @<Bit 0 */
.equ  TIM_CCMR1_IC1F_1                    ,0x0020             @<Bit 1 */
.equ  TIM_CCMR1_IC1F_2                    ,0x0040             @<Bit 2 */
.equ  TIM_CCMR1_IC1F_3                    ,0x0080             @<Bit 3 */

.equ  TIM_CCMR1_IC2PSC                    ,0x0C00             @<IC2PSC[1:0] bits (Input Capture 2 Prescaler) */
.equ  TIM_CCMR1_IC2PSC_0                  ,0x0400             @<Bit 0 */
.equ  TIM_CCMR1_IC2PSC_1                  ,0x0800             @<Bit 1 */

.equ  TIM_CCMR1_IC2F                      ,0xF000             @<IC2F[3:0] bits (Input Capture 2 Filter) */
.equ  TIM_CCMR1_IC2F_0                    ,0x1000             @<Bit 0 */
.equ  TIM_CCMR1_IC2F_1                    ,0x2000             @<Bit 1 */
.equ  TIM_CCMR1_IC2F_2                    ,0x4000             @<Bit 2 */
.equ  TIM_CCMR1_IC2F_3                    ,0x8000             @<Bit 3 */

@*****************  Bit definition for TIM_CCMR2 register  *******************/
.equ  TIM_CCMR2_CC3S                      ,0x0003             @<CC3S[1:0] bits (Capture/Compare 3 Selection) */
.equ  TIM_CCMR2_CC3S_0                    ,0x0001             @<Bit 0 */
.equ  TIM_CCMR2_CC3S_1                    ,0x0002             @<Bit 1 */

.equ  TIM_CCMR2_OC3FE                     ,0x0004             @<Output Compare 3 Fast enable */
.equ  TIM_CCMR2_OC3PE                     ,0x0008             @<Output Compare 3 Preload enable */

.equ  TIM_CCMR2_OC3M                      ,0x0070             @<OC3M[2:0] bits (Output Compare 3 Mode) */
.equ  TIM_CCMR2_OC3M_0                    ,0x0010             @<Bit 0 */
.equ  TIM_CCMR2_OC3M_1                    ,0x0020             @<Bit 1 */
.equ  TIM_CCMR2_OC3M_2                    ,0x0040             @<Bit 2 */

.equ  TIM_CCMR2_OC3CE                     ,0x0080             @<Output Compare 3 Clear Enable */

.equ  TIM_CCMR2_CC4S                      ,0x0300             @<CC4S[1:0] bits (Capture/Compare 4 Selection) */
.equ  TIM_CCMR2_CC4S_0                    ,0x0100             @<Bit 0 */
.equ  TIM_CCMR2_CC4S_1                    ,0x0200             @<Bit 1 */

.equ  TIM_CCMR2_OC4FE                     ,0x0400             @<Output Compare 4 Fast enable */
.equ  TIM_CCMR2_OC4PE                     ,0x0800             @<Output Compare 4 Preload enable */

.equ  TIM_CCMR2_OC4M                      ,0x7000             @<OC4M[2:0] bits (Output Compare 4 Mode) */
.equ  TIM_CCMR2_OC4M_0                    ,0x1000             @<Bit 0 */
.equ  TIM_CCMR2_OC4M_1                    ,0x2000             @<Bit 1 */
.equ  TIM_CCMR2_OC4M_2                    ,0x4000             @<Bit 2 */

.equ  TIM_CCMR2_OC4CE                     ,0x8000             @<Output Compare 4 Clear Enable */

@----------------------------------------------------------------------------*/

.equ  TIM_CCMR2_IC3PSC                    ,0x000C             @<IC3PSC[1:0] bits (Input Capture 3 Prescaler) */
.equ  TIM_CCMR2_IC3PSC_0                  ,0x0004             @<Bit 0 */
.equ  TIM_CCMR2_IC3PSC_1                  ,0x0008             @<Bit 1 */

.equ  TIM_CCMR2_IC3F                      ,0x00F0             @<IC3F[3:0] bits (Input Capture 3 Filter) */
.equ  TIM_CCMR2_IC3F_0                    ,0x0010             @<Bit 0 */
.equ  TIM_CCMR2_IC3F_1                    ,0x0020             @<Bit 1 */
.equ  TIM_CCMR2_IC3F_2                    ,0x0040             @<Bit 2 */
.equ  TIM_CCMR2_IC3F_3                    ,0x0080             @<Bit 3 */

.equ  TIM_CCMR2_IC4PSC                    ,0x0C00             @<IC4PSC[1:0] bits (Input Capture 4 Prescaler) */
.equ  TIM_CCMR2_IC4PSC_0                  ,0x0400             @<Bit 0 */
.equ  TIM_CCMR2_IC4PSC_1                  ,0x0800             @<Bit 1 */

.equ  TIM_CCMR2_IC4F                      ,0xF000             @<IC4F[3:0] bits (Input Capture 4 Filter) */
.equ  TIM_CCMR2_IC4F_0                    ,0x1000             @<Bit 0 */
.equ  TIM_CCMR2_IC4F_1                    ,0x2000             @<Bit 1 */
.equ  TIM_CCMR2_IC4F_2                    ,0x4000             @<Bit 2 */
.equ  TIM_CCMR2_IC4F_3                    ,0x8000             @<Bit 3 */

@******************  Bit definition for TIM_CCER register  *******************/
.equ  TIM_CCER_CC1E                       ,0x0001             @<Capture/Compare 1 output enable */
.equ  TIM_CCER_CC1P                       ,0x0002             @<Capture/Compare 1 output Polarity */
.equ  TIM_CCER_CC1NE                      ,0x0004             @<Capture/Compare 1 Complementary output enable */
.equ  TIM_CCER_CC1NP                      ,0x0008             @<Capture/Compare 1 Complementary output Polarity */
.equ  TIM_CCER_CC2E                       ,0x0010             @<Capture/Compare 2 output enable */
.equ  TIM_CCER_CC2P                       ,0x0020             @<Capture/Compare 2 output Polarity */
.equ  TIM_CCER_CC2NE                      ,0x0040             @<Capture/Compare 2 Complementary output enable */
.equ  TIM_CCER_CC2NP                      ,0x0080             @<Capture/Compare 2 Complementary output Polarity */
.equ  TIM_CCER_CC3E                       ,0x0100             @<Capture/Compare 3 output enable */
.equ  TIM_CCER_CC3P                       ,0x0200             @<Capture/Compare 3 output Polarity */
.equ  TIM_CCER_CC3NE                      ,0x0400             @<Capture/Compare 3 Complementary output enable */
.equ  TIM_CCER_CC3NP                      ,0x0800             @<Capture/Compare 3 Complementary output Polarity */
.equ  TIM_CCER_CC4E                       ,0x1000             @<Capture/Compare 4 output enable */
.equ  TIM_CCER_CC4P                       ,0x2000             @<Capture/Compare 4 output Polarity */
.equ  TIM_CCER_CC4NP                      ,0x8000             @<Capture/Compare 4 Complementary output Polarity */

@******************  Bit definition for TIM_CNT register  ********************/
.equ  TIM_CNT_CNT                         ,0xFFFF             @<Counter Value */

@******************  Bit definition for TIM_PSC register  ********************/
.equ  TIM_PSC_PSC                         ,0xFFFF             @<Prescaler Value */

@******************  Bit definition for TIM_ARR register  ********************/
.equ  TIM_ARR_ARR                         ,0xFFFF             @<actual auto-reload Value */

@******************  Bit definition for TIM_RCR register  ********************/
.equ  TIM_RCR_REP                         ,0xFF                @<Repetition Counter Value */

@******************  Bit definition for TIM_CCR1 register  *******************/
.equ  TIM_CCR1_CCR1                       ,0xFFFF             @<Capture/Compare 1 Value */

@******************  Bit definition for TIM_CCR2 register  *******************/
.equ  TIM_CCR2_CCR2                       ,0xFFFF             @<Capture/Compare 2 Value */

@******************  Bit definition for TIM_CCR3 register  *******************/
.equ  TIM_CCR3_CCR3                       ,0xFFFF             @<Capture/Compare 3 Value */

@******************  Bit definition for TIM_CCR4 register  *******************/
.equ  TIM_CCR4_CCR4                       ,0xFFFF             @<Capture/Compare 4 Value */

@******************  Bit definition for TIM_BDTR register  *******************/
.equ  TIM_BDTR_DTG                        ,0x00FF             @<DTG[0:7] bits (Dead-Time Generator set-up) */
.equ  TIM_BDTR_DTG_0                      ,0x0001             @<Bit 0 */
.equ  TIM_BDTR_DTG_1                      ,0x0002             @<Bit 1 */
.equ  TIM_BDTR_DTG_2                      ,0x0004             @<Bit 2 */
.equ  TIM_BDTR_DTG_3                      ,0x0008             @<Bit 3 */
.equ  TIM_BDTR_DTG_4                      ,0x0010             @<Bit 4 */
.equ  TIM_BDTR_DTG_5                      ,0x0020             @<Bit 5 */
.equ  TIM_BDTR_DTG_6                      ,0x0040             @<Bit 6 */
.equ  TIM_BDTR_DTG_7                      ,0x0080             @<Bit 7 */

.equ  TIM_BDTR_LOCK                       ,0x0300             @<LOCK[1:0] bits (Lock Configuration) */
.equ  TIM_BDTR_LOCK_0                     ,0x0100             @<Bit 0 */
.equ  TIM_BDTR_LOCK_1                     ,0x0200             @<Bit 1 */

.equ  TIM_BDTR_OSSI                       ,0x0400             @<Off-State Selection for Idle mode */
.equ  TIM_BDTR_OSSR                       ,0x0800             @<Off-State Selection for Run mode */
.equ  TIM_BDTR_BKE                        ,0x1000             @<Break enable */
.equ  TIM_BDTR_BKP                        ,0x2000             @<Break Polarity */
.equ  TIM_BDTR_AOE                        ,0x4000             @<Automatic Output enable */
.equ  TIM_BDTR_MOE                        ,0x8000             @<Main Output enable */

@******************  Bit definition for TIM_DCR register  ********************/
.equ  TIM_DCR_DBA                         ,0x001F             @<DBA[4:0] bits (DMA Base Address) */
.equ  TIM_DCR_DBA_0                       ,0x0001             @<Bit 0 */
.equ  TIM_DCR_DBA_1                       ,0x0002             @<Bit 1 */
.equ  TIM_DCR_DBA_2                       ,0x0004             @<Bit 2 */
.equ  TIM_DCR_DBA_3                       ,0x0008             @<Bit 3 */
.equ  TIM_DCR_DBA_4                       ,0x0010             @<Bit 4 */

.equ  TIM_DCR_DBL                         ,0x1F00             @<DBL[4:0] bits (DMA Burst Length) */
.equ  TIM_DCR_DBL_0                       ,0x0100             @<Bit 0 */
.equ  TIM_DCR_DBL_1                       ,0x0200             @<Bit 1 */
.equ  TIM_DCR_DBL_2                       ,0x0400             @<Bit 2 */
.equ  TIM_DCR_DBL_3                       ,0x0800             @<Bit 3 */
.equ  TIM_DCR_DBL_4                       ,0x1000             @<Bit 4 */

@******************  Bit definition for TIM_DMAR register  *******************/
.equ  TIM_DMAR_DMAB                       ,0xFFFF             @<DMA register for burst accesses */

@******************  Bit definition for TIM_OR register  *********************/
.equ TIM_OR_TI4_RMP                       ,0x00C0             @<TI4_RMP[1:0] bits (TIM5 Input 4 remap) */
.equ TIM_OR_TI4_RMP_0                     ,0x0040             @<Bit 0 */
.equ TIM_OR_TI4_RMP_1                     ,0x0080             @<Bit 1 */
.equ TIM_OR_ITR1_RMP                      ,0x0C00             @<ITR1_RMP[1:0] bits (TIM2 Internal trigger 1 remap) */
.equ TIM_OR_ITR1_RMP_0                    ,0x0400             @<Bit 0 */
.equ TIM_OR_ITR1_RMP_1                    ,0x0800             @<Bit 1 */


@******************************************************************************/
@*                                                                            */
@*         Universal Synchronous Asynchronous Receiver Transmitter            */
@*                                                                            */
@******************************************************************************/
@******************  Bit definition for USART_SR register  *******************/
.equ  USART_SR_PE                         ,0x0001             @<Parity Error */
.equ  USART_SR_FE                         ,0x0002             @<Framing Error */
.equ  USART_SR_NE                         ,0x0004             @<Noise Error Flag */
.equ  USART_SR_ORE                        ,0x0008             @<OverRun Error */
.equ  USART_SR_IDLE                       ,0x0010             @<IDLE line detected */
.equ  USART_SR_RXNE                       ,0x0020             @<Read Data Register Not Empty */
.equ  USART_SR_TC                         ,0x0040             @<Transmission Complete */
.equ  USART_SR_TXE                        ,0x0080             @<Transmit Data Register Empty */
.equ  USART_SR_LBD                        ,0x0100             @<LIN Break Detection Flag */
.equ  USART_SR_CTS                        ,0x0200             @<CTS Flag */

@******************  Bit definition for USART_DR register  *******************/
.equ  USART_DR_DR                         ,0x01FF             @<Data value */

@*****************  Bit definition for USART_BRR register  *******************/
.equ  USART_BRR_DIV_Fraction              ,0x000F             @<Fraction of USARTDIV */
.equ  USART_BRR_DIV_Mantissa              ,0xFFF0             @<Mantissa of USARTDIV */

@*****************  Bit definition for USART_CR1 register  *******************/
.equ  USART_CR1_SBK                       ,0x0001             @<Send Break */
.equ  USART_CR1_RWU                       ,0x0002             @<Receiver wakeup */
.equ  USART_CR1_RE                        ,0x0004             @<Receiver Enable */
.equ  USART_CR1_TE                        ,0x0008             @<Transmitter Enable */
.equ  USART_CR1_IDLEIE                    ,0x0010             @<IDLE Interrupt Enable */
.equ  USART_CR1_RXNEIE                    ,0x0020             @<RXNE Interrupt Enable */
.equ  USART_CR1_TCIE                      ,0x0040             @<Transmission Complete Interrupt Enable */
.equ  USART_CR1_TXEIE                     ,0x0080             @<PE Interrupt Enable */
.equ  USART_CR1_PEIE                      ,0x0100             @<PE Interrupt Enable */
.equ  USART_CR1_PS                        ,0x0200             @<Parity Selection */
.equ  USART_CR1_PCE                       ,0x0400             @<Parity Control Enable */
.equ  USART_CR1_WAKE                      ,0x0800             @<Wakeup method */
.equ  USART_CR1_M                         ,0x1000             @<Word length */
.equ  USART_CR1_UE                        ,0x2000             @<USART Enable */
.equ  USART_CR1_OVER8                     ,0x8000             @<USART Oversampling by 8 enable */

@*****************  Bit definition for USART_CR2 register  *******************/
.equ  USART_CR2_ADD                       ,0x000F             @<Address of the USART node */
.equ  USART_CR2_LBDL                      ,0x0020             @<LIN Break Detection Length */
.equ  USART_CR2_LBDIE                     ,0x0040             @<LIN Break Detection Interrupt Enable */
.equ  USART_CR2_LBCL                      ,0x0100             @<Last Bit Clock pulse */
.equ  USART_CR2_CPHA                      ,0x0200             @<Clock Phase */
.equ  USART_CR2_CPOL                      ,0x0400             @<Clock Polarity */
.equ  USART_CR2_CLKEN                     ,0x0800             @<Clock Enable */

.equ  USART_CR2_STOP                      ,0x3000             @<STOP[1:0] bits (STOP bits) */
.equ  USART_CR2_STOP_0                    ,0x1000             @<Bit 0 */
.equ  USART_CR2_STOP_1                    ,0x2000             @<Bit 1 */

.equ  USART_CR2_LINEN                     ,0x4000             @<LIN mode enable */

@*****************  Bit definition for USART_CR3 register  *******************/
.equ  USART_CR3_EIE                       ,0x0001             @<Error Interrupt Enable */
.equ  USART_CR3_IREN                      ,0x0002             @<IrDA mode Enable */
.equ  USART_CR3_IRLP                      ,0x0004             @<IrDA Low-Power */
.equ  USART_CR3_HDSEL                     ,0x0008             @<Half-Duplex Selection */
.equ  USART_CR3_NACK                      ,0x0010             @<Smartcard NACK enable */
.equ  USART_CR3_SCEN                      ,0x0020             @<Smartcard mode enable */
.equ  USART_CR3_DMAR                      ,0x0040             @<DMA Enable Receiver */
.equ  USART_CR3_DMAT                      ,0x0080             @<DMA Enable Transmitter */
.equ  USART_CR3_RTSE                      ,0x0100             @<RTS Enable */
.equ  USART_CR3_CTSE                      ,0x0200             @<CTS Enable */
.equ  USART_CR3_CTSIE                     ,0x0400             @<CTS Interrupt Enable */
.equ  USART_CR3_ONEBIT                    ,0x0800             @<USART One bit method enable */

@*****************  Bit definition for USART_GTPR register  ******************/
.equ  USART_GTPR_PSC                      ,0x00FF             @<PSC[7:0] bits (Prescaler value) */
.equ  USART_GTPR_PSC_0                    ,0x0001             @<Bit 0 */
.equ  USART_GTPR_PSC_1                    ,0x0002             @<Bit 1 */
.equ  USART_GTPR_PSC_2                    ,0x0004             @<Bit 2 */
.equ  USART_GTPR_PSC_3                    ,0x0008             @<Bit 3 */
.equ  USART_GTPR_PSC_4                    ,0x0010             @<Bit 4 */
.equ  USART_GTPR_PSC_5                    ,0x0020             @<Bit 5 */
.equ  USART_GTPR_PSC_6                    ,0x0040             @<Bit 6 */
.equ  USART_GTPR_PSC_7                    ,0x0080             @<Bit 7 */

.equ  USART_GTPR_GT                       ,0xFF00             @<Guard time value */

@******************************************************************************/
@*                                                                            */
@*                            Window WATCHDOG                                 */
@*                                                                            */
@******************************************************************************/
@******************  Bit definition for WWDG_CR register  ********************/
.equ  WWDG_CR_T                           ,0x7F                @<T[6:0] bits (7-Bit counter (MSB to LSB)) */
.equ  WWDG_CR_T0                          ,0x01                @<Bit 0 */
.equ  WWDG_CR_T1                          ,0x02                @<Bit 1 */
.equ  WWDG_CR_T2                          ,0x04                @<Bit 2 */
.equ  WWDG_CR_T3                          ,0x08                @<Bit 3 */
.equ  WWDG_CR_T4                          ,0x10                @<Bit 4 */
.equ  WWDG_CR_T5                          ,0x20                @<Bit 5 */
.equ  WWDG_CR_T6                          ,0x40                @<Bit 6 */

.equ  WWDG_CR_WDGA                        ,0x80                @<Activation bit */

@******************  Bit definition for WWDG_CFR register  *******************/
.equ  WWDG_CFR_W                          ,0x007F             @<W[6:0] bits (7-bit window value) */
.equ  WWDG_CFR_W0                         ,0x0001             @<Bit 0 */
.equ  WWDG_CFR_W1                         ,0x0002             @<Bit 1 */
.equ  WWDG_CFR_W2                         ,0x0004             @<Bit 2 */
.equ  WWDG_CFR_W3                         ,0x0008             @<Bit 3 */
.equ  WWDG_CFR_W4                         ,0x0010             @<Bit 4 */
.equ  WWDG_CFR_W5                         ,0x0020             @<Bit 5 */
.equ  WWDG_CFR_W6                         ,0x0040             @<Bit 6 */

.equ  WWDG_CFR_WDGTB                      ,0x0180             @<WDGTB[1:0] bits (Timer Base) */
.equ  WWDG_CFR_WDGTB0                     ,0x0080             @<Bit 0 */
.equ  WWDG_CFR_WDGTB1                     ,0x0100             @<Bit 1 */

.equ  WWDG_CFR_EWI                        ,0x0200             @<Early Wakeup Interrupt */

@******************  Bit definition for WWDG_SR register  ********************/
.equ  WWDG_SR_EWIF                        ,0x01               @<Early Wakeup Interrupt Flag */


@******************************************************************************/
@*                                                                            */
@*                                DBG                                         */
@*                                                                            */
@******************************************************************************/
@*******************  Bit definition for DBGMCU_IDCODE register  *************/
.equ  DBGMCU_IDCODE_DEV_ID                ,0x00000FFF
.equ  DBGMCU_IDCODE_REV_ID                ,0xFFFF0000

@*******************  Bit definition for DBGMCU_CR register  *****************/
.equ  DBGMCU_CR_DBG_SLEEP                 ,0x00000001
.equ  DBGMCU_CR_DBG_STOP                  ,0x00000002
.equ  DBGMCU_CR_DBG_STANDBY               ,0x00000004
.equ  DBGMCU_CR_TRACE_IOEN                ,0x00000020

.equ  DBGMCU_CR_TRACE_MODE                ,0x000000C0
.equ  DBGMCU_CR_TRACE_MODE_0              ,0x00000040   @<Bit 0 */
.equ  DBGMCU_CR_TRACE_MODE_1              ,0x00000080   @<Bit 1 */

@*******************  Bit definition for DBGMCU_APB1_FZ register  ************/
.equ  DBGMCU_APB1_FZ_DBG_TIM2_STOP            ,0x00000001
.equ  DBGMCU_APB1_FZ_DBG_TIM3_STOP            ,0x00000002
.equ  DBGMCU_APB1_FZ_DBG_TIM4_STOP            ,0x00000004
.equ  DBGMCU_APB1_FZ_DBG_TIM5_STOP            ,0x00000008
.equ  DBGMCU_APB1_FZ_DBG_TIM6_STOP            ,0x00000010
.equ  DBGMCU_APB1_FZ_DBG_TIM7_STOP            ,0x00000020
.equ  DBGMCU_APB1_FZ_DBG_TIM12_STOP           ,0x00000040
.equ  DBGMCU_APB1_FZ_DBG_TIM13_STOP           ,0x00000080
.equ  DBGMCU_APB1_FZ_DBG_TIM14_STOP           ,0x00000100
.equ  DBGMCU_APB1_FZ_DBG_RTC_STOP             ,0x00000400
.equ  DBGMCU_APB1_FZ_DBG_WWDG_STOP            ,0x00000800
.equ  DBGMCU_APB1_FZ_DBG_IWDG_STOP            ,0x00001000
.equ  DBGMCU_APB1_FZ_DBG_I2C1_SMBUS_TIMEOUT   ,0x00200000
.equ  DBGMCU_APB1_FZ_DBG_I2C2_SMBUS_TIMEOUT   ,0x00400000
.equ  DBGMCU_APB1_FZ_DBG_I2C3_SMBUS_TIMEOUT   ,0x00800000
.equ  DBGMCU_APB1_FZ_DBG_CAN1_STOP            ,0x02000000
.equ  DBGMCU_APB1_FZ_DBG_CAN2_STOP            ,0x04000000

@ Old IWDGSTOP bit definition, maintained for legacy purpose */
.equ  DBGMCU_APB1_FZ_DBG_IWDEG_STOP           ,DBGMCU_APB1_FZ_DBG_IWDG_STOP

@*******************  Bit definition for DBGMCU_APB2_FZ register  ************/
.equ  DBGMCU_APB1_FZ_DBG_TIM1_STOP        ,0x00000001
.equ  DBGMCU_APB1_FZ_DBG_TIM8_STOP        ,0x00000002
.equ  DBGMCU_APB1_FZ_DBG_TIM9_STOP        ,0x00010000
.equ  DBGMCU_APB1_FZ_DBG_TIM10_STOP       ,0x00020000
.equ  DBGMCU_APB1_FZ_DBG_TIM11_STOP       ,0x00040000

@******************************************************************************/
@*                                                                            */
@*                Ethernet MAC Registers bits definitions                     */
@*                                                                            */
@******************************************************************************/
@ Bit definition for Ethernet MAC Control Register register */
.equ ETH_MACCR_WD              ,0x00800000       @ Watchdog disable */
.equ ETH_MACCR_JD              ,0x00400000       @ Jabber disable */
.equ ETH_MACCR_IFG             ,0x000E0000       @ Inter-frame gap */
.equ ETH_MACCR_IFG_96Bit       ,0x00000000       @ Minimum IFG between frames during transmission is 96Bit */
.equ ETH_MACCR_IFG_88Bit     ,0x00020000       @ Minimum IFG between frames during transmission is 88Bit */
.equ ETH_MACCR_IFG_80Bit     ,0x00040000       @ Minimum IFG between frames during transmission is 80Bit */
.equ ETH_MACCR_IFG_72Bit     ,0x00060000       @ Minimum IFG between frames during transmission is 72Bit */
.equ ETH_MACCR_IFG_64Bit     ,0x00080000       @ Minimum IFG between frames during transmission is 64Bit */        
.equ ETH_MACCR_IFG_56Bit     ,0x000A0000       @ Minimum IFG between frames during transmission is 56Bit */
.equ ETH_MACCR_IFG_48Bit     ,0x000C0000       @ Minimum IFG between frames during transmission is 48Bit */
.equ ETH_MACCR_IFG_40Bit     ,0x000E0000       @ Minimum IFG between frames during transmission is 40Bit */              
.equ ETH_MACCR_CSD     ,0x00010000       @ Carrier sense disable (during transmission) */
.equ ETH_MACCR_FES     ,0x00004000       @ Fast ethernet speed */
.equ ETH_MACCR_ROD     ,0x00002000       @ Receive own disable */
.equ ETH_MACCR_LM      ,0x00001000       @ loopback mode */
.equ ETH_MACCR_DM      ,0x00000800       @ Duplex mode */
.equ ETH_MACCR_IPCO    ,0x00000400       @ IP Checksum offload */
.equ ETH_MACCR_RD      ,0x00000200       @ Retry disable */
.equ ETH_MACCR_APCS    ,0x00000080       @ Automatic Pad/CRC stripping */
.equ ETH_MACCR_BL      ,0x00000060       @ Back-off limit: random integer number (r) of slot time delays before rescheduling
                                         @              a transmission attempt during retries after a collision: 0 =< r <2^k */
.equ ETH_MACCR_BL_10    ,0x00000000       @ k = min (n, 10) */
.equ ETH_MACCR_BL_8     ,0x00000020       @ k = min (n, 8) */
.equ ETH_MACCR_BL_4     ,0x00000040       @ k = min (n, 4) */
.equ ETH_MACCR_BL_1     ,0x00000060       @ k = min (n, 1) */ 
.equ ETH_MACCR_DC      ,0x00000010       @ Defferal check */
.equ ETH_MACCR_TE      ,0x00000008       @ Transmitter enable */
.equ ETH_MACCR_RE      ,0x00000004       @ Receiver enable */

@ Bit definition for Ethernet MAC Frame Filter Register */
.equ ETH_MACFFR_RA     ,0x80000000       @ Receive all */ 
.equ ETH_MACFFR_HPF    ,0x00000400       @ Hash or perfect filter */ 
.equ ETH_MACFFR_SAF    ,0x00000200       @ Source address filter enable */ 
.equ ETH_MACFFR_SAIF   ,0x00000100       @ SA inverse filtering */ 
.equ ETH_MACFFR_PCF    ,0x000000C0       @ Pass control frames: 3 cases */
.equ ETH_MACFFR_PCF_BlockAll                ,0x00000040       @ MAC filters all control frames from reaching the application */
.equ ETH_MACFFR_PCF_ForwardAll              ,0x00000080       @ MAC forwards all control frames to application even if they fail the Address Filter */
.equ ETH_MACFFR_PCF_ForwardPassedAddrFilter ,0x000000C0       @ MAC forwards control frames that pass the Address Filter. */ 
.equ ETH_MACFFR_BFD    ,0x00000020       @ Broadcast frame disable */ 
.equ ETH_MACFFR_PAM    ,0x00000010       @ Pass all mutlicast */ 
.equ ETH_MACFFR_DAIF   ,0x00000008       @ DA Inverse filtering */ 
.equ ETH_MACFFR_HM     ,0x00000004       @ Hash multicast */ 
.equ ETH_MACFFR_HU     ,0x00000002       @ Hash unicast */
.equ ETH_MACFFR_PM     ,0x00000001       @ Promiscuous mode */

@ Bit definition for Ethernet MAC Hash Table High Register */
.equ ETH_MACHTHR_HTH   ,0xFFFFFFFF       @ Hash table high */

@ Bit definition for Ethernet MAC Hash Table Low Register */
.equ ETH_MACHTLR_HTL   ,0xFFFFFFFF       @ Hash table low */

@ Bit definition for Ethernet MAC MII Address Register */
.equ ETH_MACMIIAR_PA   ,0x0000F800       @ Physical layer address */ 
.equ ETH_MACMIIAR_MR   ,0x000007C0       @ MII register in the selected PHY */ 
.equ ETH_MACMIIAR_CR   ,0x0000001C       @ CR clock range: 6 cases */ 
.equ ETH_MACMIIAR_CR_Div42   ,0x00000000       @ HCLK:60-100 MHz; MDC clock= HCLK/42 */
.equ ETH_MACMIIAR_CR_Div62   ,0x00000004       @ HCLK:100-150 MHz; MDC clock= HCLK/62 */
.equ ETH_MACMIIAR_CR_Div16   ,0x00000008       @ HCLK:20-35 MHz; MDC clock= HCLK/16 */
.equ ETH_MACMIIAR_CR_Div26   ,0x0000000C       @ HCLK:35-60 MHz; MDC clock= HCLK/26 */
.equ ETH_MACMIIAR_CR_Div102  ,0x00000010       @ HCLK:150-168 MHz; MDC clock= HCLK/102 */  
.equ ETH_MACMIIAR_MW   ,0x00000002       @ MII write */ 
.equ ETH_MACMIIAR_MB   ,0x00000001       @ MII busy */ 
  
@ Bit definition for Ethernet MAC MII Data Register */
.equ ETH_MACMIIDR_MD   ,0x0000FFFF       @ MII data: read/write data from/to PHY */

@ Bit definition for Ethernet MAC Flow Control Register */
.equ ETH_MACFCR_PT     ,0xFFFF0000       @ Pause time */
.equ ETH_MACFCR_ZQPD   ,0x00000080       @ Zero-quanta pause disable */
.equ ETH_MACFCR_PLT    ,0x00000030       @ Pause low threshold: 4 cases */
.equ ETH_MACFCR_PLT_Minus4   ,0x00000000       @ Pause time minus 4 slot times */
.equ ETH_MACFCR_PLT_Minus28  ,0x00000010       @ Pause time minus 28 slot times */
.equ ETH_MACFCR_PLT_Minus144 ,0x00000020       @ Pause time minus 144 slot times */
.equ ETH_MACFCR_PLT_Minus256 ,0x00000030       @ Pause time minus 256 slot times */      
.equ ETH_MACFCR_UPFD   ,0x00000008       @ Unicast pause frame detect */
.equ ETH_MACFCR_RFCE   ,0x00000004       @ Receive flow control enable */
.equ ETH_MACFCR_TFCE   ,0x00000002       @ Transmit flow control enable */
.equ ETH_MACFCR_FCBBPA ,0x00000001       @ Flow control busy/backpressure activate */

@ Bit definition for Ethernet MAC VLAN Tag Register */
.equ ETH_MACVLANTR_VLANTC ,0x00010000       @ 12-bit VLAN tag comparison */
.equ ETH_MACVLANTR_VLANTI ,0x0000FFFF       @ VLAN tag identifier (for receive frames) */

@ Bit definition for Ethernet MAC Remote Wake-UpFrame Filter Register */ 
.equ ETH_MACRWUFFR_D   ,0xFFFFFFFF       @ Wake-up frame filter register data */
@ Eight sequential Writes to this address (offset 0x28) will write all Wake-UpFrame Filter Registers.
@ Eight sequential Reads from this address (offset 0x28) will read all Wake-UpFrame Filter Registers. */
@ Wake-UpFrame Filter Reg0 : Filter 0 Byte Mask
@ Wake-UpFrame Filter Reg1 : Filter 1 Byte Mask
@ Wake-UpFrame Filter Reg2 : Filter 2 Byte Mask
@ Wake-UpFrame Filter Reg3 : Filter 3 Byte Mask
@ Wake-UpFrame Filter Reg4 : RSVD - Filter3 Command - RSVD - Filter2 Command - 
@                            RSVD - Filter1 Command - RSVD - Filter0 Command
@ Wake-UpFrame Filter Re5 : Filter3 Offset - Filter2 Offset - Filter1 Offset - Filter0 Offset
@ Wake-UpFrame Filter Re6 : Filter1 CRC16 - Filter0 CRC16
@ Wake-UpFrame Filter Re7 : Filter3 CRC16 - Filter2 CRC16 */

@ Bit definition for Ethernet MAC PMT Control and Status Register */ 
.equ ETH_MACPMTCSR_WFFRPR ,0x80000000       @ Wake-Up Frame Filter Register Pointer Reset */
.equ ETH_MACPMTCSR_GU     ,0x00000200       @ Global Unicast */
.equ ETH_MACPMTCSR_WFR    ,0x00000040       @ Wake-Up Frame Received */
.equ ETH_MACPMTCSR_MPR    ,0x00000020       @ Magic Packet Received */
.equ ETH_MACPMTCSR_WFE    ,0x00000004       @ Wake-Up Frame Enable */
.equ ETH_MACPMTCSR_MPE    ,0x00000002       @ Magic Packet Enable */
.equ ETH_MACPMTCSR_PD     ,0x00000001       @ Power Down */

@ Bit definition for Ethernet MAC Status Register */
.equ ETH_MACSR_TSTS      ,0x00000200       @ Time stamp trigger status */
.equ ETH_MACSR_MMCTS     ,0x00000040       @ MMC transmit status */
.equ ETH_MACSR_MMMCRS    ,0x00000020       @ MMC receive status */
.equ ETH_MACSR_MMCS      ,0x00000010       @ MMC status */
.equ ETH_MACSR_PMTS      ,0x00000008       @ PMT status */

@ Bit definition for Ethernet MAC Interrupt Mask Register */
.equ ETH_MACIMR_TSTIM     ,0x00000200       @ Time stamp trigger interrupt mask */
.equ ETH_MACIMR_PMTIM     ,0x00000008       @ PMT interrupt mask */

@ Bit definition for Ethernet MAC Address0 High Register */
.equ ETH_MACA0HR_MACA0H   ,0x0000FFFF       @ MAC address0 high */

@ Bit definition for Ethernet MAC Address0 Low Register */
.equ ETH_MACA0LR_MACA0L   ,0xFFFFFFFF       @ MAC address0 low */

@ Bit definition for Ethernet MAC Address1 High Register */
.equ ETH_MACA1HR_AE       ,0x80000000       @ Address enable */
.equ ETH_MACA1HR_SA       ,0x40000000       @ Source address */
.equ ETH_MACA1HR_MBC      ,0x3F000000       @ Mask byte control: bits to mask for comparison of the MAC Address bytes */
.equ ETH_MACA1HR_MBC_HBits15_8    ,0x20000000       @ Mask MAC Address high reg bits [15:8] */
.equ ETH_MACA1HR_MBC_HBits7_0     ,0x10000000       @ Mask MAC Address high reg bits [7:0] */
.equ ETH_MACA1HR_MBC_LBits31_24   ,0x08000000       @ Mask MAC Address low reg bits [31:24] */
.equ ETH_MACA1HR_MBC_LBits23_16   ,0x04000000       @ Mask MAC Address low reg bits [23:16] */
.equ ETH_MACA1HR_MBC_LBits15_8    ,0x02000000       @ Mask MAC Address low reg bits [15:8] */
.equ ETH_MACA1HR_MBC_LBits7_0     ,0x01000000       @ Mask MAC Address low reg bits [7:0] */ 
.equ ETH_MACA1HR_MACA1H   ,0x0000FFFF       @ MAC address1 high */

@ Bit definition for Ethernet MAC Address1 Low Register */
.equ ETH_MACA1LR_MACA1L   ,0xFFFFFFFF       @ MAC address1 low */

@ Bit definition for Ethernet MAC Address2 High Register */
.equ ETH_MACA2HR_AE       ,0x80000000       @ Address enable */
.equ ETH_MACA2HR_SA       ,0x40000000       @ Source address */
.equ ETH_MACA2HR_MBC      ,0x3F000000       @ Mask byte control */
.equ ETH_MACA2HR_MBC_HBits15_8    ,0x20000000       @ Mask MAC Address high reg bits [15:8] */
.equ ETH_MACA2HR_MBC_HBits7_0     ,0x10000000       @ Mask MAC Address high reg bits [7:0] */
.equ ETH_MACA2HR_MBC_LBits31_24   ,0x08000000       @ Mask MAC Address low reg bits [31:24] */
.equ ETH_MACA2HR_MBC_LBits23_16   ,0x04000000       @ Mask MAC Address low reg bits [23:16] */
.equ ETH_MACA2HR_MBC_LBits15_8    ,0x02000000       @ Mask MAC Address low reg bits [15:8] */
.equ ETH_MACA2HR_MBC_LBits7_0     ,0x01000000       @ Mask MAC Address low reg bits [70] */
.equ ETH_MACA2HR_MACA2H   ,0x0000FFFF       @ MAC address1 high */

@ Bit definition for Ethernet MAC Address2 Low Register */
.equ ETH_MACA2LR_MACA2L   ,0xFFFFFFFF       @ MAC address2 low */

@ Bit definition for Ethernet MAC Address3 High Register */
.equ ETH_MACA3HR_AE       ,0x80000000       @ Address enable */
.equ ETH_MACA3HR_SA       ,0x40000000       @ Source address */
.equ ETH_MACA3HR_MBC      ,0x3F000000       @ Mask byte control */
.equ ETH_MACA3HR_MBC_HBits15_8    ,0x20000000       @ Mask MAC Address high reg bits [15:8] */
.equ ETH_MACA3HR_MBC_HBits7_0     ,0x10000000       @ Mask MAC Address high reg bits [7:0] */
.equ ETH_MACA3HR_MBC_LBits31_24   ,0x08000000       @ Mask MAC Address low reg bits [31:24] */
.equ ETH_MACA3HR_MBC_LBits23_16   ,0x04000000       @ Mask MAC Address low reg bits [23:16] */
.equ ETH_MACA3HR_MBC_LBits15_8    ,0x02000000       @ Mask MAC Address low reg bits [15:8] */
.equ ETH_MACA3HR_MBC_LBits7_0     ,0x01000000       @ Mask MAC Address low reg bits [70] */
.equ ETH_MACA3HR_MACA3H   ,0x0000FFFF       @ MAC address3 high */

@ Bit definition for Ethernet MAC Address3 Low Register */
.equ ETH_MACA3LR_MACA3L   ,0xFFFFFFFF       @ MAC address3 low */

@******************************************************************************/
@*                Ethernet MMC Registers bits definition                      */
@******************************************************************************/

@ Bit definition for Ethernet MMC Contol Register */
.equ ETH_MMCCR_MCFHP      ,0x00000020       @ MMC counter Full-Half preset */
.equ ETH_MMCCR_MCP        ,0x00000010       @ MMC counter preset */
.equ ETH_MMCCR_MCF        ,0x00000008       @ MMC Counter Freeze */
.equ ETH_MMCCR_ROR        ,0x00000004       @ Reset on Read */
.equ ETH_MMCCR_CSR        ,0x00000002       @ Counter Stop Rollover */
.equ ETH_MMCCR_CR         ,0x00000001       @ Counters Reset */

@ Bit definition for Ethernet MMC Receive Interrupt Register */
.equ ETH_MMCRIR_RGUFS     ,0x00020000       @ Set when Rx good unicast frames counter reaches half the maximum value */
.equ ETH_MMCRIR_RFAES     ,0x00000040       @ Set when Rx alignment error counter reaches half the maximum value */
.equ ETH_MMCRIR_RFCES     ,0x00000020       @ Set when Rx crc error counter reaches half the maximum value */

@ Bit definition for Ethernet MMC Transmit Interrupt Register */
.equ ETH_MMCTIR_TGFS      ,0x00200000       @ Set when Tx good frame count counter reaches half the maximum value */
.equ ETH_MMCTIR_TGFMSCS   ,0x00008000       @ Set when Tx good multi col counter reaches half the maximum value */
.equ ETH_MMCTIR_TGFSCS    ,0x00004000       @ Set when Tx good single col counter reaches half the maximum value */

@ Bit definition for Ethernet MMC Receive Interrupt Mask Register */
.equ ETH_MMCRIMR_RGUFM    ,0x00020000       @ Mask the interrupt when Rx good unicast frames counter reaches half the maximum value */
.equ ETH_MMCRIMR_RFAEM    ,0x00000040       @ Mask the interrupt when when Rx alignment error counter reaches half the maximum value */
.equ ETH_MMCRIMR_RFCEM    ,0x00000020       @ Mask the interrupt when Rx crc error counter reaches half the maximum value */

@ Bit definition for Ethernet MMC Transmit Interrupt Mask Register */
.equ ETH_MMCTIMR_TGFM     ,0x00200000       @ Mask the interrupt when Tx good frame count counter reaches half the maximum value */
.equ ETH_MMCTIMR_TGFMSCM  ,0x00008000       @ Mask the interrupt when Tx good multi col counter reaches half the maximum value */
.equ ETH_MMCTIMR_TGFSCM   ,0x00004000       @ Mask the interrupt when Tx good single col counter reaches half the maximum value */

@ Bit definition for Ethernet MMC Transmitted Good Frames after Single Collision Counter Register */
.equ ETH_MMCTGFSCCR_TGFSCC     ,0xFFFFFFFF       @ Number of successfully transmitted frames after a single collision in Half-duplex mode. */

@ Bit definition for Ethernet MMC Transmitted Good Frames after More than a Single Collision Counter Register */
.equ ETH_MMCTGFMSCCR_TGFMSCC   ,0xFFFFFFFF       @ Number of successfully transmitted frames after more than a single collision in Half-duplex mode. */

@ Bit definition for Ethernet MMC Transmitted Good Frames Counter Register */
.equ ETH_MMCTGFCR_TGFC    ,0xFFFFFFFF       @ Number of good frames transmitted. */

@ Bit definition for Ethernet MMC Received Frames with CRC Error Counter Register */
.equ ETH_MMCRFCECR_RFCEC  ,0xFFFFFFFF       @ Number of frames received with CRC error. */

@ Bit definition for Ethernet MMC Received Frames with Alignement Error Counter Register */
.equ ETH_MMCRFAECR_RFAEC  ,0xFFFFFFFF       @ Number of frames received with alignment (dribble) error */

@ Bit definition for Ethernet MMC Received Good Unicast Frames Counter Register */
.equ ETH_MMCRGUFCR_RGUFC  ,0xFFFFFFFF       @ Number of good unicast frames received. */

@******************************************************************************/
@*               Ethernet PTP Registers bits definition                       */
@******************************************************************************/

@ Bit definition for Ethernet PTP Time Stamp Contol Register */
.equ ETH_PTPTSCR_TSCNT       ,0x00030000       @ Time stamp clock node type */
.equ ETH_PTPTSSR_TSSMRME     ,0x00008000       @ Time stamp snapshot for message relevant to master enable */
.equ ETH_PTPTSSR_TSSEME      ,0x00004000       @ Time stamp snapshot for event message enable */
.equ ETH_PTPTSSR_TSSIPV4FE   ,0x00002000       @ Time stamp snapshot for IPv4 frames enable */
.equ ETH_PTPTSSR_TSSIPV6FE   ,0x00001000       @ Time stamp snapshot for IPv6 frames enable */
.equ ETH_PTPTSSR_TSSPTPOEFE  ,0x00000800       @ Time stamp snapshot for PTP over ethernet frames enable */
.equ ETH_PTPTSSR_TSPTPPSV2E  ,0x00000400       @ Time stamp PTP packet snooping for version2 format enable */
.equ ETH_PTPTSSR_TSSSR       ,0x00000200       @ Time stamp Sub-seconds rollover */
.equ ETH_PTPTSSR_TSSARFE     ,0x00000100       @ Time stamp snapshot for all received frames enable */

.equ ETH_PTPTSCR_TSARU    ,0x00000020       @ Addend register update */
.equ ETH_PTPTSCR_TSITE    ,0x00000010       @ Time stamp interrupt trigger enable */
.equ ETH_PTPTSCR_TSSTU    ,0x00000008       @ Time stamp update */
.equ ETH_PTPTSCR_TSSTI    ,0x00000004       @ Time stamp initialize */
.equ ETH_PTPTSCR_TSFCU    ,0x00000002       @ Time stamp fine or coarse update */
.equ ETH_PTPTSCR_TSE      ,0x00000001       @ Time stamp enable */

@ Bit definition for Ethernet PTP Sub-Second Increment Register */
.equ ETH_PTPSSIR_STSSI    ,0x000000FF       @ System time Sub-second increment value */

@ Bit definition for Ethernet PTP Time Stamp High Register */
.equ ETH_PTPTSHR_STS      ,0xFFFFFFFF       @ System Time second */

@ Bit definition for Ethernet PTP Time Stamp Low Register */
.equ ETH_PTPTSLR_STPNS    ,0x80000000       @ System Time Positive or negative time */
.equ ETH_PTPTSLR_STSS     ,0x7FFFFFFF       @ System Time sub-seconds */

@ Bit definition for Ethernet PTP Time Stamp High Update Register */
.equ ETH_PTPTSHUR_TSUS    ,0xFFFFFFFF       @ Time stamp update seconds */

@ Bit definition for Ethernet PTP Time Stamp Low Update Register */
.equ ETH_PTPTSLUR_TSUPNS  ,0x80000000       @ Time stamp update Positive or negative time */
.equ ETH_PTPTSLUR_TSUSS   ,0x7FFFFFFF       @ Time stamp update sub-seconds */

@ Bit definition for Ethernet PTP Time Stamp Addend Register */
.equ ETH_PTPTSAR_TSA      ,0xFFFFFFFF       @ Time stamp addend */

@ Bit definition for Ethernet PTP Target Time High Register */
.equ ETH_PTPTTHR_TTSH     ,0xFFFFFFFF       @ Target time stamp high */

@ Bit definition for Ethernet PTP Target Time Low Register */
.equ ETH_PTPTTLR_TTSL     ,0xFFFFFFFF       @ Target time stamp low */

@ Bit definition for Ethernet PTP Time Stamp Status Register */
.equ ETH_PTPTSSR_TSTTR    ,0x00000020       @ Time stamp target time reached */
.equ ETH_PTPTSSR_TSSO     ,0x00000010       @ Time stamp seconds overflow */

@*****************************************************************************/
@                 Ethernet DMA Registers bits definition                     */
@*****************************************************************************/

@ Bit definition for Ethernet DMA Bus Mode Register */
.equ ETH_DMABMR_AAB       ,0x02000000       @ Address-Aligned beats */
.equ ETH_DMABMR_FPM        ,0x01000000       @ 4xPBL mode */
.equ ETH_DMABMR_USP       ,0x00800000       @ Use separate PBL */
.equ ETH_DMABMR_RDP       ,0x007E0000       @ RxDMA PBL */
.equ ETH_DMABMR_RDP_1Beat    ,0x00020000       @ maximum number of beats to be transferred in one RxDMA transaction is 1 */
.equ ETH_DMABMR_RDP_2Beat    ,0x00040000       @ maximum number of beats to be transferred in one RxDMA transaction is 2 */
.equ ETH_DMABMR_RDP_4Beat    ,0x00080000       @ maximum number of beats to be transferred in one RxDMA transaction is 4 */
.equ ETH_DMABMR_RDP_8Beat    ,0x00100000       @ maximum number of beats to be transferred in one RxDMA transaction is 8 */
.equ ETH_DMABMR_RDP_16Beat   ,0x00200000       @ maximum number of beats to be transferred in one RxDMA transaction is 16 */
.equ ETH_DMABMR_RDP_32Beat   ,0x00400000       @ maximum number of beats to be transferred in one RxDMA transaction is 32 */                
.equ ETH_DMABMR_RDP_4xPBL_4Beat   ,0x01020000       @ maximum number of beats to be transferred in one RxDMA transaction is 4 */
.equ ETH_DMABMR_RDP_4xPBL_8Beat   ,0x01040000       @ maximum number of beats to be transferred in one RxDMA transaction is 8 */
.equ ETH_DMABMR_RDP_4xPBL_16Beat  ,0x01080000       @ maximum number of beats to be transferred in one RxDMA transaction is 16 */
.equ ETH_DMABMR_RDP_4xPBL_32Beat  ,0x01100000       @ maximum number of beats to be transferred in one RxDMA transaction is 32 */
.equ ETH_DMABMR_RDP_4xPBL_64Beat  ,0x01200000       @ maximum number of beats to be transferred in one RxDMA transaction is 64 */
.equ ETH_DMABMR_RDP_4xPBL_128Beat ,0x01400000       @ maximum number of beats to be transferred in one RxDMA transaction is 128 */  
.equ ETH_DMABMR_FB        ,0x00010000       @ Fixed Burst */
.equ ETH_DMABMR_RTPR      ,0x0000C000       @ Rx Tx priority ratio */
.equ ETH_DMABMR_RTPR_1_1     ,0x00000000       @ Rx Tx priority ratio */
.equ ETH_DMABMR_RTPR_2_1     ,0x00004000       @ Rx Tx priority ratio */
.equ ETH_DMABMR_RTPR_3_1     ,0x00008000       @ Rx Tx priority ratio */
.equ ETH_DMABMR_RTPR_4_1     ,0x0000C000       @ Rx Tx priority ratio */  
.equ ETH_DMABMR_PBL    ,0x00003F00       @ Programmable burst length */
.equ ETH_DMABMR_PBL_1Beat    ,0x00000100       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 1 */
.equ ETH_DMABMR_PBL_2Beat    ,0x00000200       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 2 */
.equ ETH_DMABMR_PBL_4Beat    ,0x00000400       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 4 */
.equ ETH_DMABMR_PBL_8Beat    ,0x00000800       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 8 */
.equ ETH_DMABMR_PBL_16Beat   ,0x00001000       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 16 */
.equ ETH_DMABMR_PBL_32Beat   ,0x00002000       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 32 */                
.equ ETH_DMABMR_PBL_4xPBL_4Beat   ,0x01000100       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 4 */
.equ ETH_DMABMR_PBL_4xPBL_8Beat   ,0x01000200       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 8 */
.equ ETH_DMABMR_PBL_4xPBL_16Beat  ,0x01000400       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 16 */
.equ ETH_DMABMR_PBL_4xPBL_32Beat  ,0x01000800       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 32 */
.equ ETH_DMABMR_PBL_4xPBL_64Beat  ,0x01001000       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 64 */
.equ ETH_DMABMR_PBL_4xPBL_128Beat ,0x01002000       @ maximum number of beats to be transferred in one TxDMA (or both) transaction is 128 */
.equ ETH_DMABMR_EDE       ,0x00000080       @ Enhanced Descriptor Enable */
.equ ETH_DMABMR_DSL       ,0x0000007C       @ Descriptor Skip Length */
.equ ETH_DMABMR_DA        ,0x00000002       @ DMA arbitration scheme */
.equ ETH_DMABMR_SR        ,0x00000001       @ Software reset */

@ Bit definition for Ethernet DMA Transmit Poll Demand Register */
.equ ETH_DMATPDR_TPD      ,0xFFFFFFFF       @ Transmit poll demand */

@ Bit definition for Ethernet DMA Receive Poll Demand Register */
.equ ETH_DMARPDR_RPD      ,0xFFFFFFFF       @ Receive poll demand  */

@ Bit definition for Ethernet DMA Receive Descriptor List Address Register */
.equ ETH_DMARDLAR_SRL     ,0xFFFFFFFF       @ Start of receive list */

@ Bit definition for Ethernet DMA Transmit Descriptor List Address Register */
.equ ETH_DMATDLAR_STL     ,0xFFFFFFFF       @ Start of transmit list */

@ Bit definition for Ethernet DMA Status Register */
.equ ETH_DMASR_TSTS       ,0x20000000       @ Time-stamp trigger status */
.equ ETH_DMASR_PMTS       ,0x10000000       @ PMT status */
.equ ETH_DMASR_MMCS       ,0x08000000       @ MMC status */
.equ ETH_DMASR_EBS        ,0x03800000       @ Error bits status */

@ combination with EBS[2:0] for GetFlagStatus function */
.equ ETH_DMASR_EBS_DescAccess      ,0x02000000       @ Error bits 0-data buffer, 1-desc. access */
.equ ETH_DMASR_EBS_ReadTransf      ,0x01000000       @ Error bits 0-write trnsf, 1-read transfr */
.equ ETH_DMASR_EBS_DataTransfTx    ,0x00800000       @ Error bits 0-Rx DMA, 1-Tx DMA */
.equ ETH_DMASR_TPS         ,0x00700000       @ Transmit process state */
.equ ETH_DMASR_TPS_Stopped         ,0x00000000       @ Stopped - Reset or Stop Tx Command issued  */
.equ ETH_DMASR_TPS_Fetching        ,0x00100000       @ Running - fetching the Tx descriptor */
.equ ETH_DMASR_TPS_Waiting         ,0x00200000       @ Running - waiting for status */
.equ ETH_DMASR_TPS_Reading         ,0x00300000       @ Running - reading the data from host memory */
.equ ETH_DMASR_TPS_Suspended       ,0x00600000       @ Suspended - Tx Descriptor unavailabe */
.equ ETH_DMASR_TPS_Closing         ,0x00700000       @ Running - closing Rx descriptor */
.equ ETH_DMASR_RPS         ,0x000E0000       @ Receive process state */
.equ ETH_DMASR_RPS_Stopped         ,0x00000000       @ Stopped - Reset or Stop Rx Command issued */
.equ ETH_DMASR_RPS_Fetching        ,0x00020000       @ Running - fetching the Rx descriptor */
.equ ETH_DMASR_RPS_Waiting         ,0x00060000       @ Running - waiting for packet */
.equ ETH_DMASR_RPS_Suspended       ,0x00080000       @ Suspended - Rx Descriptor unavailable */
.equ ETH_DMASR_RPS_Closing         ,0x000A0000       @ Running - closing descriptor */
.equ ETH_DMASR_RPS_Queuing         ,0x000E0000       @ Running - queuing the recieve frame into host memory */
.equ ETH_DMASR_NIS        ,0x00010000       @ Normal interrupt summary */
.equ ETH_DMASR_AIS        ,0x00008000       @ Abnormal interrupt summary */
.equ ETH_DMASR_ERS        ,0x00004000       @ Early receive status */
.equ ETH_DMASR_FBES       ,0x00002000       @ Fatal bus error status */
.equ ETH_DMASR_ETS        ,0x00000400       @ Early transmit status */
.equ ETH_DMASR_RWTS       ,0x00000200       @ Receive watchdog timeout status */
.equ ETH_DMASR_RPSS       ,0x00000100       @ Receive process stopped status */
.equ ETH_DMASR_RBUS       ,0x00000080       @ Receive buffer unavailable status */
.equ ETH_DMASR_RS         ,0x00000040       @ Receive status */
.equ ETH_DMASR_TUS        ,0x00000020       @ Transmit underflow status */
.equ ETH_DMASR_ROS        ,0x00000010       @ Receive overflow status */
.equ ETH_DMASR_TJTS       ,0x00000008       @ Transmit jabber timeout status */
.equ ETH_DMASR_TBUS       ,0x00000004       @ Transmit buffer unavailable status */
.equ ETH_DMASR_TPSS       ,0x00000002       @ Transmit process stopped status */
.equ ETH_DMASR_TS         ,0x00000001       @ Transmit status */

@ Bit definition for Ethernet DMA Operation Mode Register */
.equ ETH_DMAOMR_DTCEFD    ,0x04000000       @ Disable Dropping of TCP/IP checksum error frames */
.equ ETH_DMAOMR_RSF       ,0x02000000       @ Receive store and forward */
.equ ETH_DMAOMR_DFRF      ,0x01000000       @ Disable flushing of received frames */
.equ ETH_DMAOMR_TSF       ,0x00200000       @ Transmit store and forward */
.equ ETH_DMAOMR_FTF       ,0x00100000       @ Flush transmit FIFO */
.equ ETH_DMAOMR_TTC       ,0x0001C000       @ Transmit threshold control */
.equ ETH_DMAOMR_TTC_64Bytes       ,0x00000000       @ threshold level of the MTL Transmit FIFO is 64 Bytes */
.equ ETH_DMAOMR_TTC_128Bytes      ,0x00004000       @ threshold level of the MTL Transmit FIFO is 128 Bytes */
.equ ETH_DMAOMR_TTC_192Bytes      ,0x00008000       @ threshold level of the MTL Transmit FIFO is 192 Bytes */
.equ ETH_DMAOMR_TTC_256Bytes      ,0x0000C000       @ threshold level of the MTL Transmit FIFO is 256 Bytes */
.equ ETH_DMAOMR_TTC_40Bytes       ,0x00010000       @ threshold level of the MTL Transmit FIFO is 40 Bytes */
.equ ETH_DMAOMR_TTC_32Bytes       ,0x00014000       @ threshold level of the MTL Transmit FIFO is 32 Bytes */
.equ ETH_DMAOMR_TTC_24Bytes       ,0x00018000       @ threshold level of the MTL Transmit FIFO is 24 Bytes */
.equ ETH_DMAOMR_TTC_16Bytes       ,0x0001C000       @ threshold level of the MTL Transmit FIFO is 16 Bytes */
.equ ETH_DMAOMR_ST        ,0x00002000       @ Start/stop transmission command */
.equ ETH_DMAOMR_FEF       ,0x00000080       @ Forward error frames */
.equ ETH_DMAOMR_FUGF      ,0x00000040       @ Forward undersized good frames */
.equ ETH_DMAOMR_RTC       ,0x00000018       @ receive threshold control */
.equ ETH_DMAOMR_RTC_64Bytes       ,0x00000000       @ threshold level of the MTL Receive FIFO is 64 Bytes */
.equ ETH_DMAOMR_RTC_32Bytes       ,0x00000008       @ threshold level of the MTL Receive FIFO is 32 Bytes */
.equ ETH_DMAOMR_RTC_96Bytes       ,0x00000010       @ threshold level of the MTL Receive FIFO is 96 Bytes */
.equ ETH_DMAOMR_RTC_128Bytes      ,0x00000018       @ threshold level of the MTL Receive FIFO is 128 Bytes */
.equ ETH_DMAOMR_OSF       ,0x00000004       @ operate on second frame */
.equ ETH_DMAOMR_SR        ,0x00000002       @ Start/stop receive */

@ Bit definition for Ethernet DMA Interrupt Enable Register */
.equ ETH_DMAIER_NISE      ,0x00010000       @ Normal interrupt summary enable */
.equ ETH_DMAIER_AISE      ,0x00008000       @ Abnormal interrupt summary enable */
.equ ETH_DMAIER_ERIE      ,0x00004000       @ Early receive interrupt enable */
.equ ETH_DMAIER_FBEIE     ,0x00002000       @ Fatal bus error interrupt enable */
.equ ETH_DMAIER_ETIE      ,0x00000400       @ Early transmit interrupt enable */
.equ ETH_DMAIER_RWTIE     ,0x00000200       @ Receive watchdog timeout interrupt enable */
.equ ETH_DMAIER_RPSIE     ,0x00000100       @ Receive process stopped interrupt enable */
.equ ETH_DMAIER_RBUIE     ,0x00000080       @ Receive buffer unavailable interrupt enable */
.equ ETH_DMAIER_RIE       ,0x00000040       @ Receive interrupt enable */
.equ ETH_DMAIER_TUIE      ,0x00000020       @ Transmit Underflow interrupt enable */
.equ ETH_DMAIER_ROIE      ,0x00000010       @ Receive Overflow interrupt enable */
.equ ETH_DMAIER_TJTIE     ,0x00000008       @ Transmit jabber timeout interrupt enable */
.equ ETH_DMAIER_TBUIE     ,0x00000004       @ Transmit buffer unavailable interrupt enable */
.equ ETH_DMAIER_TPSIE     ,0x00000002       @ Transmit process stopped interrupt enable */
.equ ETH_DMAIER_TIE       ,0x00000001       @ Transmit interrupt enable */

@ Bit definition for Ethernet DMA Missed Frame and Buffer Overflow Counter Register */
.equ ETH_DMAMFBOCR_OFOC   ,0x10000000       @ Overflow bit for FIFO overflow counter */
.equ ETH_DMAMFBOCR_MFA    ,0x0FFE0000       @ Number of frames missed by the application */
.equ ETH_DMAMFBOCR_OMFC   ,0x00010000       @ Overflow bit for missed frame counter */
.equ ETH_DMAMFBOCR_MFC    ,0x0000FFFF       @ Number of frames missed by the controller */

@ Bit definition for Ethernet DMA Current Host Transmit Descriptor Register */
.equ ETH_DMACHTDR_HTDAP   ,0xFFFFFFFF       @ Host transmit descriptor address pointer */

@ Bit definition for Ethernet DMA Current Host Receive Descriptor Register */
.equ ETH_DMACHRDR_HRDAP   ,0xFFFFFFFF       @ Host receive descriptor address pointer */

@ Bit definition for Ethernet DMA Current Host Transmit Buffer Address Register */
.equ ETH_DMACHTBAR_HTBAP  ,0xFFFFFFFF       @ Host transmit buffer address pointer */

@ Bit definition for Ethernet DMA Current Host Receive Buffer Address Register */
.equ ETH_DMACHRBAR_HRBAP  ,0xFFFFFFFF       @ Host receive buffer address pointer */

@ ****************************************************************************
@ *                          SysTick timer (STK)                             *
@ ****************************************************************************
@ Внимание !! счетчик работает только если процессор не находиться в режиме
@ пониженного энергопотребления (иначе счет останавливается)
@
.equ STK_CTRL		  ,0x00		    @ Регистр статуса и управления
@ ***************** Bit definition for STK_CTRL Register *********************
.equ STK_CTRL_COUNTFLAG   ,0x00010000       @ (R) читается "1" если был перенос с момента последнего чтения
.equ STK_CTRL_CLKSOURSE   ,0x00000004       @ (RW) источник тактирования: 0: AHB/8; 1: AHB 
.equ STK_CTRL_TICKINT     ,0x00000002       @ (RW) при установке генерирует прерывание при переходе через 0
.equ STK_CTRL_ENABLE      ,0x00000001       @ (EW) включает счетчик. При установке в "1" счетчик загружает 
			@ значение из STK_LOAD и начинает обратный отсчет. При достижении "0" устанавливается
			@ COUNTFLAG и в зависимости от STK_CTRL_TICKINT генерируется прерывание, после этого 
			@ опять загружается исходное значение и начинается отсчет сначала

.equ STK_LOAD		  ,0x00000004	    @ Значение для перезагрузки счетчика 
@ ****************** Bit definition for STK_LOAD Register ********************
@ Значение для счетчика, значение диапазона 0х00000001-0x00FFFFFF.
@ Значение счетчика равное "0" не имеет смысла, так как генерация прерывания и
@ установка флага STK_CTRL_COUNTFLAG происходит при переходе с "1" на "0"
@ Если нужно чтобы флаг устанавливался каждые N (100) тактовых импульсов нужно 
@ установить значение N-1 (99)
@ Если важно только первое одиночное прерывание то для задержки на N (100) 
@ тактовых импульсов установите значение равное N (100)

.equ STK_VAL		  ,0x00000008	    @ Текущее значение счетчика 
@ ******************* Bit definition for STK_VAL Register ********************
@ Текущее значение счетчика, при чтении - значение счетчика, при записи - сброс
@ значения регистра в "0"


.equ STK_CALIB		  ,0x0000000C	    @ Регистр калибровки
@ ******************* Bit definition for STK_CALIB Register ******************
.equ STK_CALIB_NOREF_MASK ,0x80000000

.equ STK_CALIB_SKEW_MASK  ,0x40000000

.equ STK_CALIB_TENMS_MASK ,0x00FFFFFF

@ ****************************************************************************
@ *                          	   NVIC                                      *
@ ****************************************************************************
.equ NVIC_IPRx_BASE	  ,0x300	@ Базовый адрес NVIC_IPR
.equ NVIC_IPR0		  ,0x300	@ Базовый адрес NVIC_IPR0

.equ NonMaskableInt_IRQn  ,-14          @*!< 2 Non Maskable Interrupt                                          */
.equ MemoryManagement_IRQn,-12    	@/*!< 4 Cortex-M4 Memory Management Interrupt                           */
.equ BusFault_IRQn        ,-11          @/*!< 5 Cortex-M4 Bus Fault Interrupt                                   */
.equ UsageFault_IRQn      ,-10	        @/*!< 6 Cortex-M4 Usage Fault Interrupt                                 */
.equ SVCall_IRQn          ,-5           @/*!< 11 Cortex-M4 SV Call Interrupt                                    */
.equ DebugMonitor_IRQn    ,-4           @/*!< 12 Cortex-M4 Debug Monitor Interrupt                              */
.equ PendSV_IRQn          ,-2           @/*!< 14 Cortex-M4 Pend SV Interrupt                                    */
.equ SysTick_IRQn         ,-1           @/*!< 15 Cortex-M4 System Tick Interrupt                                */
@/******  STM32 specific Interrupt Numbers **********************************************************************/
.equ WWDG_IRQn            ,0     	@/*!< Window WatchDog Interrupt                                         */
.equ PVD_IRQn             ,1      	@/*!< PVD through EXTI Line detection Interrupt                         */
.equ TAMP_STAMP_IRQn      ,2      	@/*!< Tamper and TimeStamp interrupts through the EXTI line             */
.equ RTC_WKUP_IRQn        ,3      	@/*!< RTC Wakeup interrupt through the EXTI line                        */
.equ FLASH_IRQn           ,4      	@/*!< FLASH global Interrupt                                            */
.equ RCC_IRQn             ,5      	@/*!< RCC global Interrupt                                              */
.equ EXTI0_IRQn           ,6      	@/*!< EXTI Line0 Interrupt                                              */
.equ EXTI1_IRQn           ,7      	@/*!< EXTI Line1 Interrupt                                              */
.equ EXTI2_IRQn           ,8      	@/*!< EXTI Line2 Interrupt                                              */
.equ EXTI3_IRQn           ,9     	@/*!< EXTI Line3 Interrupt                                              */
.equ EXTI4_IRQn           ,10     	@/*!< EXTI Line4 Interrupt                                              */
.equ DMA1_Stream0_IRQn    ,11     	@/*!< DMA1 Stream 0 global Interrupt                                    */
.equ DMA1_Stream1_IRQn    ,12     	@/*!< DMA1 Stream 1 global Interrupt                                    */
.equ DMA1_Stream2_IRQn    ,13     	@/*!< DMA1 Stream 2 global Interrupt                                    */
.equ DMA1_Stream3_IRQn    ,14     	@/*!< DMA1 Stream 3 global Interrupt                                    */
.equ DMA1_Stream4_IRQn    ,15     	@/*!< DMA1 Stream 4 global Interrupt                                    */
.equ DMA1_Stream5_IRQn    ,16     	@/*!< DMA1 Stream 5 global Interrupt                                    */
.equ DMA1_Stream6_IRQn    ,17     	@/*!< DMA1 Stream 6 global Interrupt                                    */
.equ ADC_IRQn             ,18     	@/*!< ADC1, ADC2 and ADC3 global Interrupts                             */
.equ CAN1_TX_IRQn         ,19     	@/*!< CAN1 TX Interrupt                                                 */
.equ CAN1_RX0_IRQn        ,20     	@/*!< CAN1 RX0 Interrupt                                                */
.equ CAN1_RX1_IRQn        ,21     	@/*!< CAN1 RX1 Interrupt                                                */
.equ CAN1_SCE_IRQn        ,22     	@/*!< CAN1 SCE Interrupt                                                */
.equ EXTI9_5_IRQn         ,23     	@/*!< External Line[9:5] Interrupts                                     */
.equ TIM1_BRK_TIM9_IRQn   ,24     	@/*!< TIM1 Break interrupt and TIM9 global interrupt                    */
.equ TIM1_UP_TIM10_IRQn   ,25     	@/*!< TIM1 Update Interrupt and TIM10 global interrupt                  */
.equ TIM1_TRG_COM_TIM11_IRQn,26     	@/*!< TIM1 Trigger and Commutation Interrupt and TIM11 global interrupt */
.equ TIM1_CC_IRQn         ,27     	@/*!< TIM1 Capture Compare Interrupt                                    */
.equ TIM2_IRQn            ,28     	@/*!< TIM2 global Interrupt                                             */
.equ TIM3_IRQn            ,29     	@/*!< TIM3 global Interrupt                                             */
.equ TIM4_IRQn            ,30     	@/*!< TIM4 global Interrupt                                             */
.equ I2C1_EV_IRQn         ,31     	@/*!< I2C1 Event Interrupt                                              */
.equ I2C1_ER_IRQn         ,32     	@/*!< I2C1 Error Interrupt                                              */
.equ I2C2_EV_IRQn         ,33     	@/*!< I2C2 Event Interrupt                                              */
.equ I2C2_ER_IRQn         ,34     	@/*!< I2C2 Error Interrupt                                              */  
.equ SPI1_IRQn            ,35     	@/*!< SPI1 global Interrupt                                             */
.equ SPI2_IRQn            ,36     	@/*!< SPI2 global Interrupt                                             */
.equ USART1_IRQn          ,37     	@/*!< USART1 global Interrupt                                           */
.equ USART2_IRQn          ,38     	@/*!< USART2 global Interrupt                                           */
.equ USART3_IRQn          ,39     	@/*!< USART3 global Interrupt                                           */
.equ EXTI15_10_IRQn       ,40     	@/*!< External Line[15:10] Interrupts                                   */
.equ RTC_Alarm_IRQn       ,41     	@/*!< RTC Alarm (A and B) through EXTI Line Interrupt                   */
.equ OTG_FS_WKUP_IRQn     ,42     	@/*!< USB OTG FS Wakeup through EXTI line interrupt                     */    
.equ TIM8_BRK_TIM12_IRQn  ,43     	@/*!< TIM8 Break Interrupt and TIM12 global interrupt                   */
.equ TIM8_UP_TIM13_IRQn   ,44     	@/*!< TIM8 Update Interrupt and TIM13 global interrupt                  */
.equ TIM8_TRG_COM_TIM14_IRQn,45     	@/*!< TIM8 Trigger and Commutation Interrupt and TIM14 global interrupt */
.equ TIM8_CC_IRQn         ,46     	@/*!< TIM8 Capture Compare Interrupt                                    */
.equ DMA1_Stream7_IRQn    ,47     	@/*!< DMA1 Stream7 Interrupt                                            */
.equ FSMC_IRQn            ,48     	@/*!< FSMC global Interrupt                                             */
.equ SDIO_IRQn            ,49     	@/*!< SDIO global Interrupt                                             */
.equ TIM5_IRQn            ,50     	@/*!< TIM5 global Interrupt                                             */
.equ SPI3_IRQn            ,51    	@/*!< SPI3 global Interrupt                                             */
.equ UART4_IRQn           ,52     	@/*!< UART4 global Interrupt                                            */
.equ UART5_IRQn           ,53     	@/*!< UART5 global Interrupt                                            */
.equ TIM6_DAC_IRQn        ,54     	@/*!< TIM6 global and DAC1&2 underrun error  interrupts                 */
.equ TIM7_IRQn            ,55     	@/*!< TIM7 global interrupt                                             */
.equ DMA2_Stream0_IRQn    ,56     	@/*!< DMA2 Stream 0 global Interrupt                                    */
.equ DMA2_Stream1_IRQn    ,57     	@/*!< DMA2 Stream 1 global Interrupt                                    */
.equ DMA2_Stream2_IRQn    ,58     	@/*!< DMA2 Stream 2 global Interrupt                                    */
.equ DMA2_Stream3_IRQn    ,59     	@/*!< DMA2 Stream 3 global Interrupt                                    */
.equ DMA2_Stream4_IRQn    ,60     	@/*!< DMA2 Stream 4 global Interrupt                                    */
.equ ETH_IRQn             ,61     	@/*!< Ethernet global Interrupt                                         */
.equ ETH_WKUP_IRQn        ,62     	@/*!< Ethernet Wakeup through EXTI line Interrupt                       */
.equ CAN2_TX_IRQn         ,63     	@/*!< CAN2 TX Interrupt                                                 */
.equ CAN2_RX0_IRQn        ,64     	@/*!< CAN2 RX0 Interrupt                                                */
.equ CAN2_RX1_IRQn        ,65     	@/*!< CAN2 RX1 Interrupt                                                */
.equ CAN2_SCE_IRQn        ,66     	@/*!< CAN2 SCE Interrupt                                                */
.equ OTG_FS_IRQn          ,67     	@/*!< USB OTG FS global Interrupt                                       */
.equ DMA2_Stream5_IRQn    ,68     	@/*!< DMA2 Stream 5 global interrupt                                    */
.equ DMA2_Stream6_IRQn    ,69     	@/*!< DMA2 Stream 6 global interrupt                                    */
.equ DMA2_Stream7_IRQn    ,70     	@/*!< DMA2 Stream 7 global interrupt                                    */
.equ USART6_IRQn          ,71     	@/*!< USART6 global interrupt                                           */ 
.equ I2C3_EV_IRQn         ,72     	@/*!< I2C3 event interrupt                                              */
.equ I2C3_ER_IRQn         ,73     	@/*!< I2C3 error interrupt                                              */
.equ OTG_HS_EP1_OUT_IRQn  ,74     	@/*!< USB OTG HS End Point 1 Out global interrupt                       */
.equ OTG_HS_EP1_IN_IRQn   ,75     	@/*!< USB OTG HS End Point 1 In global interrupt                        */
.equ OTG_HS_WKUP_IRQn     ,76     	@/*!< USB OTG HS Wakeup through EXTI interrupt                          */
.equ OTG_HS_IRQn          ,77     	@/*!< USB OTG HS global interrupt                                       */
.equ DCMI_IRQn            ,78     	@/*!< DCMI global interrupt                                             */
.equ CRYP_IRQn            ,79     	@/*!< CRYP crypto global interrupt                                      */
.equ HASH_RNG_IRQn        ,80      	@/*!< Hash and Rng global interrupt                                     */
.equ FPU_IRQn             ,81      	@/*!< FPU global interrupt                                              */

@ ****************************************************************************
@ *                         System control block (SCB)                       *
@ ****************************************************************************
.equ ACTLR		  ,0xE000E008	@ Auxiliary control register
					@ ВНИМАНИЕ ! адрес определен полностью !
@ ******************* Bit definition for ACTLR Register **********************
.equ ACTRL_DISOOFP        ,0x00000020   @ Отключение инструкций с плавающей точкой
.equ ACTRL_DISFPCA        ,0x00000010   @ Отключение автообновления CONTROL.FPCA
.equ ACTRL_DISFOLD        ,0x00000004   @ Отключение сворачивания IT инструкций
.equ ACTRL_DISDEFWBUF     ,0x00000002   @ Отключение буфера на запись в память (?)
.equ ACTRL_DISMCYCINT     ,0x00000001   @ Отключение прерывания многоцикличных инструкций

@ базовый адрес SCB_BASE = 0xE000ED00 
.equ CPUID		  ,0x00		@ CPUID base register

.equ ICSR		  ,0x04   	@ Interrupt control and state register
@ ******************* Bit definition for ICSR Register ***********************
.equ ICSR_NMIPENDSET      ,0x80000000   @ NMI set-pending bit
.equ ICSR_PENDSVSET       ,0x10000000   @ PendSV set-pending bit
.equ ICSR_PENDSVCLR       ,0x08000000   @ PendSV clear-pending bit. This bit is write-only. On a read, value is unknown
.equ ICSR_PENDSTSET       ,0x04000000   @ SysTick exception set-pending bit
.equ ICSR_PENDSTCLR       ,0x02000000   @ SysTick exception clear-pending bit. Write-only. On a read, value is unknown
.equ ICSR_ISRPENDING      ,0x00400000   @ Interrupt pending flag, excluding NMI and Faults
.equ ICSR_VECTPENDING_MASK,0x0007F000   @ Pending vector. Indicates the exception number of the highest priority pending enabled exception
.equ ICSR_RETTOBASE       ,0x00000800   @ Return to base level. Indicates whether there are preempted active exceptions
.equ ICSR_VECTACTIVE      ,0x000001FF   @ Active vector. Contains the active exception number

.equ VTOR		  ,0x08         @ Vector table offset register

.equ AIRCR		  ,0x0C         @ Application interrupt and reset control register

.equ SCR		  ,0x10		@ System control register (SCR)

.equ CCR		  ,0x14         @ Configuration and control register (CCR)

.equ SHPR1        ,0x18         @ System handler priority registers (SHPRx)

.equ SHPR2        ,0x1C         @ System handler priority registers (SHPRx)

.equ SHPR3        ,0x20         @ System handler priority registers (SHPRx)

.equ SHCRS        ,0x24         @ System handler control and state register (SHCSR)

.equ CFSR		  ,0x28         @ Configurable fault status register (CFSR; UFSR+BFSR+MMFSR)

.equ MMSR		  ,0x28         @ MemManage Fault Status Register

.equ BFSR		  ,0x29         @ BusFault Status Register

.equ UFSR         ,0x2A         @ UsageFault Status Register

.equ HFSR         ,0x2C         @ Hard fault status register (HFSR)

.equ MMAR         ,0x34         @ Memory management fault address register (MMFAR)

.equ BFAR		  ,0x38         @ Bus fault address register (BFAR)

.equ AFSR         ,0x3C         @ Auxiliary fault status register (AFSR) 
