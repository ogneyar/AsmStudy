@; MDR32F9Q2I

@; BOOT ROM 2K 0x0000_0000

.equ FLASH_BASE           ,0x08000000  @; FLASH(up to 128 KB) base address in the alias region

@; EXTERNAL BUS 256M 0x10000000  @;

.equ SRAM_BASE            ,0x20000000  @; SRAM(32 KB) base address in the alias region

@; BIT BAND REGION 32M 0x22000000  @;
@; EXTERNAL BUS 0x30000000  @;

.equ PERIPH_BASE          ,0x40000000  @; Peripheral base address in the alias region

@; BIT BAND REGION 0x42000000  @;
@; EXTERNAL BUS 0x50000000  @;

@; EXTERNAL BUS 1 G 0x60000000  @;

@; EXTERNAL BUS 1 G 0xA0000000  @;

@; SYSTEM 512 M 0xE0000000  @;


@; --------------------------------------------
@; Периферия
.equ MDR_CAN1                   ,0x40000000  @; 
.equ MDR_CAN2                   ,0x40008000  @; 
.equ MDR_USB                    ,0x40010000  @; 
.equ MDR_EEPROM_CNTRL           ,0x40018000  @; 
.equ MDR_RST_CLK                ,0x40020000  @; 
.equ MDR_DMA                    ,0x40028000  @; 
.equ MDR_UART1                  ,0x40030000  @; 
.equ MDR_UART2                  ,0x40038000  @; 
.equ MDR_SPI1                   ,0x40040000  @; 
.equ MDR_I2C1                   ,0x40050000  @; 
.equ MDR_POWER                  ,0x40058000  @; 
.equ MDR_WWDT                   ,0x40060000  @; 
.equ MDR_IWDT                   ,0x40068000  @; 
.equ MDR_TIMER1                 ,0x40070000  @; 
.equ MDR_TIMER2                 ,0x40078000  @; 
.equ MDR_TIMER3                 ,0x40080000  @; 
.equ MDR_ADC                    ,0x40088000  @; 
.equ MDR_DAC                    ,0x40090000  @; 
.equ MDR_COMP                   ,0x40098000  @; 
.equ MDR_SPI2                   ,0x400a0000  @; 
.equ MDR_PORTA                  ,0x400a8000  @; 
.equ MDR_PORTB                  ,0x400b0000  @; 
.equ MDR_PORTC                  ,0x400b8000  @; 
.equ MDR_PORTD                  ,0x400c0000  @; 
.equ MDR_PORTE                  ,0x400c8000  @; 
.equ MDR_BKP                    ,0x400d8000  @; 
.equ MDR_PORTF                  ,0x400e8000  @; 
.equ MDR_EXT_BUS_CNTRL          ,0x400f0000  @; 



@; 14.1 Описание регистров блока контроллера тактовой частоты (MDR_RST_CLK)
.equ MDR_RST_CLK_CLOCK_STATUS   ,(MDR_RST_CLK + 0x00)
.equ MDR_RST_CLK_PLL_CONTROL    ,(MDR_RST_CLK + 0x04)
.equ MDR_RST_CLK_HS_CONTROL     ,(MDR_RST_CLK + 0x08)
.equ MDR_RST_CLK_CPU_CLOCK      ,(MDR_RST_CLK + 0x0c)
.equ MDR_RST_CLK_USB_CLOCK      ,(MDR_RST_CLK + 0x10)
.equ MDR_RST_CLK_ADC_MCO_CLOCK  ,(MDR_RST_CLK + 0x14)
.equ MDR_RST_CLK_RTC_CLOCK      ,(MDR_RST_CLK + 0x18)
.equ MDR_RST_CLK_PER_CLOCK      ,(MDR_RST_CLK + 0x1c)
.equ MDR_RST_CLK_CAN_CLOCK      ,(MDR_RST_CLK + 0x20)
.equ MDR_RST_CLK_TIM_CLOCK      ,(MDR_RST_CLK + 0x24)
.equ MDR_RST_CLK_UART_CLOCK     ,(MDR_RST_CLK + 0x28)
.equ MDR_RST_CLK_SSP_CLOCK      ,(MDR_RST_CLK + 0x2c)


@; 14.1.8 MDR_RST_CLK->PER_CLOCK
.equ PER_CLOCK_PCLK_EN_CAN1_Pos         ,0
.equ PER_CLOCK_PCLK_EN_CAN1             ,(1 << PER_CLOCK_PCLK_EN_CAN1_Pos)
.equ PER_CLOCK_PCLK_EN_CAN2_Pos         ,1
.equ PER_CLOCK_PCLK_EN_CAN2             ,(1 << PER_CLOCK_PCLK_EN_CAN2_Pos)
.equ PER_CLOCK_PCLK_EN_USB_Pos          ,2
.equ PER_CLOCK_PCLK_EN_USB              ,(1 << PER_CLOCK_PCLK_EN_USB_Pos)
.equ PER_CLOCK_PCLK_EN_EEPROM_CNTRL_Pos ,3
.equ PER_CLOCK_PCLK_EN_EEPROM_CNTRL     ,(1 << PER_CLOCK_PCLK_EN_EEPROM_CNTRL_Pos)
.equ PER_CLOCK_PCLK_EN_RST_CLK_Pos      ,4
.equ PER_CLOCK_PCLK_EN_RST_CLK          ,(1 << PER_CLOCK_PCLK_EN_RST_CLK_Pos)
.equ PER_CLOCK_PCLK_EN_DMA_Pos          ,5
.equ PER_CLOCK_PCLK_EN_DMA              ,(1 << PER_CLOCK_PCLK_EN_DMA_Pos)
.equ PER_CLOCK_PCLK_EN_UART1_Pos        ,6
.equ PER_CLOCK_PCLK_EN_UART1            ,(1 << PER_CLOCK_PCLK_EN_UART1_Pos)
.equ PER_CLOCK_PCLK_EN_UART2_Pos        ,7
.equ PER_CLOCK_PCLK_EN_UART2            ,(1 << PER_CLOCK_PCLK_EN_UART2_Pos)
.equ PER_CLOCK_PCLK_EN_SPI1_Pos         ,8
.equ PER_CLOCK_PCLK_EN_SPI1             ,(1 << PER_CLOCK_PCLK_EN_SPI1_Pos)
.equ PER_CLOCK_PCLK_EN_I2C1_Pos         ,10
.equ PER_CLOCK_PCLK_EN_I2C1             ,(1 << PER_CLOCK_PCLK_EN_I2C1_Pos)
.equ PER_CLOCK_PCLK_EN_POWER_Pos        ,11
.equ PER_CLOCK_PCLK_EN_POWER            ,(1 << PER_CLOCK_PCLK_EN_POWER_Pos)
.equ PER_CLOCK_PCLK_EN_WWDT_Pos         ,12
.equ PER_CLOCK_PCLK_EN_WWDT             ,(1 << PER_CLOCK_PCLK_EN_WWDT_Pos)
.equ PER_CLOCK_PCLK_EN_IWDT_Pos         ,13
.equ PER_CLOCK_PCLK_EN_IWDT             ,(1 << PER_CLOCK_PCLK_EN_IWDT_Pos)
.equ PER_CLOCK_PCLK_EN_TIMER1_Pos       ,14
.equ PER_CLOCK_PCLK_EN_TIMER1           ,(1 << PER_CLOCK_PCLK_EN_TIMER1_Pos)
.equ PER_CLOCK_PCLK_EN_TIMER2_Pos       ,15
.equ PER_CLOCK_PCLK_EN_TIMER2           ,(1 << PER_CLOCK_PCLK_EN_TIMER2_Pos)
.equ PER_CLOCK_PCLK_EN_TIMER3_Pos       ,16
.equ PER_CLOCK_PCLK_EN_TIMER3           ,(1 << PER_CLOCK_PCLK_EN_TIMER3_Pos)
.equ PER_CLOCK_PCLK_EN_ADC_Pos          ,17
.equ PER_CLOCK_PCLK_EN_ADC              ,(1 << PER_CLOCK_PCLK_EN_ADC_Pos)
.equ PER_CLOCK_PCLK_EN_DAC_Pos          ,18
.equ PER_CLOCK_PCLK_EN_DAC              ,(1 << PER_CLOCK_PCLK_EN_DAC_Pos)
.equ PER_CLOCK_PCLK_EN_COMP_Pos         ,19
.equ PER_CLOCK_PCLK_EN_COMP             ,(1 << PER_CLOCK_PCLK_EN_COMP_Pos)
.equ PER_CLOCK_PCLK_EN_SPI2_Pos         ,20
.equ PER_CLOCK_PCLK_EN_SPI2             ,(1 << PER_CLOCK_PCLK_EN_SPI2_Pos)
.equ PER_CLOCK_PCLK_EN_PORTA_Pos        ,21
.equ PER_CLOCK_PCLK_EN_PORTA            ,(1 << PER_CLOCK_PCLK_EN_PORTA_Pos)
.equ PER_CLOCK_PCLK_EN_PORTB_Pos        ,22
.equ PER_CLOCK_PCLK_EN_PORTB            ,(1 << PER_CLOCK_PCLK_EN_PORTB_Pos)
.equ PER_CLOCK_PCLK_EN_PORTC_Pos        ,23
.equ PER_CLOCK_PCLK_EN_PORTC            ,(1 << PER_CLOCK_PCLK_EN_PORTC_Pos)
.equ PER_CLOCK_PCLK_EN_PORTD_Pos        ,24
.equ PER_CLOCK_PCLK_EN_PORTD            ,(1 << PER_CLOCK_PCLK_EN_PORTD_Pos)
.equ PER_CLOCK_PCLK_EN_PORTE_Pos        ,25
.equ PER_CLOCK_PCLK_EN_PORTE            ,(1 << PER_CLOCK_PCLK_EN_PORTE_Pos)
.equ PER_CLOCK_PCLK_EN_BKP_Pos          ,27
.equ PER_CLOCK_PCLK_EN_BKP              ,(1 << PER_CLOCK_PCLK_EN_BKP_Pos)
.equ PER_CLOCK_PCLK_EN_PORTF_Pos        ,29
.equ PER_CLOCK_PCLK_EN_PORTF            ,(1 << PER_CLOCK_PCLK_EN_PORTF_Pos)
.equ PER_CLOCK_PCLK_EN_EXT_BUS_CNTRL_Pos,30
.equ PER_CLOCK_PCLK_EN_EXT_BUS_CNTRL    ,(1 << PER_CLOCK_PCLK_EN_EXT_BUS_CNTRL_Pos)


@; -------------------------------------------
@; 16.1 Описание регистров портов ввода-вывода
.equ MDR_PORTx_RXTX             ,0x00
.equ MDR_PORTx_OE               ,0x04
.equ MDR_PORTx_FUNC             ,0x08
.equ MDR_PORTx_ANALOG           ,0x0c
.equ MDR_PORTx_PULL             ,0x10
.equ MDR_PORTx_PD               ,0x14
.equ MDR_PORTx_PWR              ,0x18
.equ MDR_PORTx_GFEN             ,0x1c

.equ MDR_PORTA_RXTX             ,(MDR_PORTA + MDR_PORTx_RXTX)
.equ MDR_PORTA_OE               ,(MDR_PORTA + MDR_PORTx_OE)
.equ MDR_PORTA_FUNC             ,(MDR_PORTA + MDR_PORTx_FUNC)
.equ MDR_PORTA_ANALOG           ,(MDR_PORTA + MDR_PORTx_ANALOG)
.equ MDR_PORTA_PULL             ,(MDR_PORTA + MDR_PORTx_PULL)
.equ MDR_PORTA_PD               ,(MDR_PORTA + MDR_PORTx_PD)
.equ MDR_PORTA_PWR              ,(MDR_PORTA + MDR_PORTx_PWR)

.equ MDR_PORTB_RXTX             ,(MDR_PORTB + MDR_PORTx_RXTX)
.equ MDR_PORTB_OE               ,(MDR_PORTB + MDR_PORTx_OE)
.equ MDR_PORTB_FUNC             ,(MDR_PORTB + MDR_PORTx_FUNC)
.equ MDR_PORTB_ANALOG           ,(MDR_PORTB + MDR_PORTx_ANALOG)
.equ MDR_PORTB_PULL             ,(MDR_PORTB + MDR_PORTx_PULL)
.equ MDR_PORTB_PD               ,(MDR_PORTB + MDR_PORTx_PD)
.equ MDR_PORTB_PWR              ,(MDR_PORTB + MDR_PORTx_PWR)

.equ MDR_PORTC_RXTX             ,(MDR_PORTC + MDR_PORTx_RXTX)
.equ MDR_PORTC_OE               ,(MDR_PORTC + MDR_PORTx_OE)
.equ MDR_PORTC_FUNC             ,(MDR_PORTC + MDR_PORTx_FUNC)
.equ MDR_PORTC_ANALOG           ,(MDR_PORTC + MDR_PORTx_ANALOG)
.equ MDR_PORTC_PULL             ,(MDR_PORTC + MDR_PORTx_PULL)
.equ MDR_PORTC_PD               ,(MDR_PORTC + MDR_PORTx_PD)
.equ MDR_PORTC_PWR              ,(MDR_PORTC + MDR_PORTx_PWR)

.equ MDR_PORTD_RXTX             ,(MDR_PORTD + MDR_PORTx_RXTX)
.equ MDR_PORTD_OE               ,(MDR_PORTD + MDR_PORTx_OE)
.equ MDR_PORTD_FUNC             ,(MDR_PORTD + MDR_PORTx_FUNC)
.equ MDR_PORTD_ANALOG           ,(MDR_PORTD + MDR_PORTx_ANALOG)
.equ MDR_PORTD_PULL             ,(MDR_PORTD + MDR_PORTx_PULL)
.equ MDR_PORTD_PD               ,(MDR_PORTD + MDR_PORTx_PD)
.equ MDR_PORTD_PWR              ,(MDR_PORTD + MDR_PORTx_PWR)

.equ MDR_PORTE_RXTX             ,(MDR_PORTE + MDR_PORTx_RXTX)
.equ MDR_PORTE_OE               ,(MDR_PORTE + MDR_PORTx_OE)
.equ MDR_PORTE_FUNC             ,(MDR_PORTE + MDR_PORTx_FUNC)
.equ MDR_PORTE_ANALOG           ,(MDR_PORTE + MDR_PORTx_ANALOG)
.equ MDR_PORTE_PULL             ,(MDR_PORTE + MDR_PORTx_PULL)
.equ MDR_PORTE_PD               ,(MDR_PORTE + MDR_PORTx_PD)
.equ MDR_PORTE_PWR              ,(MDR_PORTE + MDR_PORTx_PWR)

.equ MDR_PORTF_RXTX             ,(MDR_PORTF + MDR_PORTx_RXTX)
.equ MDR_PORTF_OE               ,(MDR_PORTF + MDR_PORTx_OE)
.equ MDR_PORTF_FUNC             ,(MDR_PORTF + MDR_PORTx_FUNC)
.equ MDR_PORTF_ANALOG           ,(MDR_PORTF + MDR_PORTx_ANALOG)
.equ MDR_PORTF_PULL             ,(MDR_PORTF + MDR_PORTx_PULL)
.equ MDR_PORTF_PD               ,(MDR_PORTF + MDR_PORTx_PD)
.equ MDR_PORTF_PWR              ,(MDR_PORTF + MDR_PORTx_PWR)








