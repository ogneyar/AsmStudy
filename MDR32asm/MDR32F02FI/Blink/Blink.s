.align 2
.equ RST_CLK_HSI_FREQUENCY, 8000000
.equ MDR_RST_CLK_BASE, 0x40020000
.equ MDR_GPIO4_BASE, 0x400F0000 # MDR_PORTD

# MDR_RST_CLK_TypeDef
.equ MDR_RST_CLK_CLOCK_STATUS,  MDR_RST_CLK_BASE + 0x00 #   /*!< Frequency status register */
.equ MDR_RST_CLK_PLL_CONTROL,   MDR_RST_CLK_BASE + 0x04 #   /*!< PLL control register */
.equ MDR_RST_CLK_HS_CONTROL,    MDR_RST_CLK_BASE + 0x08 #   /*!< Hi speed oscillator control register */
.equ MDR_RST_CLK_CPU_CLOCK,     MDR_RST_CLK_BASE + 0x0C #   /*!< CPU speed control register */
.equ MDR_RST_CLK_PER1_CLOCK,    MDR_RST_CLK_BASE + 0x10 #   /*!< Peripherals(1) speed control register */
.equ MDR_RST_CLK_ADC_CLOCK,     MDR_RST_CLK_BASE + 0x14 #   /*!< Analog-to-digital control register */
.equ MDR_RST_CLK_RTC_CLOCK,     MDR_RST_CLK_BASE + 0x18 #   /*!< Real-time clock speed register */
.equ MDR_RST_CLK_PER2_CLOCK,    MDR_RST_CLK_BASE + 0x1C #   /*!< Peripherals(2) speed control register */
.equ MDR_RST_CLK_RFU,           MDR_RST_CLK_BASE + 0x20 #   /*!< ??? */
.equ MDR_RST_CLK_TIM_CLOCK,     MDR_RST_CLK_BASE + 0x24 #   /*!< Timers clock control register */
.equ MDR_RST_CLK_UART_CLOCK,    MDR_RST_CLK_BASE + 0x28 #   /*!< UARTs clock control register */
.equ MDR_RST_CLK_SSP_CLOCK,     MDR_RST_CLK_BASE + 0x2C #   /*!< SSPs clock control register */

# MDR_GPIO_TypeDef
.equ MDR_GPIO4_RXTX,     MDR_GPIO4_BASE + 0x00 #    /*!< input/output data */
.equ MDR_GPIO4_OE,       MDR_GPIO4_BASE + 0x04 #    /*!< port direction */
.equ MDR_GPIO4_FUNC,     MDR_GPIO4_BASE + 0x08 #    /*!< port function */
.equ MDR_GPIO4_ANALOG,   MDR_GPIO4_BASE + 0x0C #    /*!< analog port mode */
.equ MDR_GPIO4_PULL,     MDR_GPIO4_BASE + 0x10 #    /*!< port pull register control */
.equ MDR_GPIO4_RFU,      MDR_GPIO4_BASE + 0x14 #    /*!< RFU */
.equ MDR_GPIO4_PWR,      MDR_GPIO4_BASE + 0x18 #    /*!< port power control */
.equ MDR_GPIO4_RFU2,     MDR_GPIO4_BASE + 0x1C #    /*!< RFU2 */
.equ MDR_GPIO4_SETTX,    MDR_GPIO4_BASE + 0x20 #    /*!< bit-setup register for output ports */
.equ MDR_GPIO4_CLRTX,    MDR_GPIO4_BASE + 0x24 #    /*!< bit-clear register for output ports */
.equ MDR_GPIO4_RDTX,     MDR_GPIO4_BASE + 0x28 #    /*!< read-back register for output ports */

.equ RST_CLK_PORTD, (0x1 << 30)

.equ PORT_Pin_0, 0x01
.equ twoBitMask, 0x3
.equ PD0, 0

.equ PORT_OE_OUT, 1
.equ PORT_FUNC_PORT, 0
.equ PORT_MODE_DIGITAL, 1
.equ PORT_SPEED_SLOW_4mA, 1
.equ PORT_PULL_DOWN_OFF, 0

.section .text
.globl _start

_start:
    csrr  t0, mhartid
    bnez  t0, halt

    # la    sp, __stack_top
    
    # PORT_Init
    # RST_CLK_EnablePeripheralClock(RST_CLK_PORTD, RST_CLK_Div1);
    li t0, MDR_RST_CLK_PER2_CLOCK # Load register t0 with an address PER2_CLOCK
    lw t1, 0(t0)
    li t2, RST_CLK_PORTD
    or t1, t1, t2
    sw t1, 0(t0) # store word (32bit)  

    # /* write output enable state */
    # MDR_GPIO4_OE &= ~PORT_Pin_0;
    li t0, MDR_GPIO4_OE
    lw t1, 0(t0)
    andi t1, t1, ~PORT_Pin_0
    sw t1, 0(t0)
    # MDR_GPIO4_OE |= (PORT_OE_OUT << PD0);
    li t0, MDR_GPIO4_OE
    lw t1, 0(t0)
    ori t1, t1, (PORT_OE_OUT << PD0)
    sw t1, 0(t0)

    # /* write analog / digital function */
    # MDR_GPIO4_ANALOG &= ~PORT_Pin_0;
    li t0, MDR_GPIO4_ANALOG
    lw t1, 0(t0)
    andi t1, t1, ~PORT_Pin_0
    sw t1, 0(t0)
    # MDR_GPIO4_ANALOG |= (PORT_MODE_DIGITAL << PD0);
    li t0, MDR_GPIO4_ANALOG
    lw t1, 0(t0)
    ori t1, t1, (PORT_MODE_DIGITAL << PD0)
    sw t1, 0(t0)

        # /* write pull down */
        # MDR_GPIO4_PULL &= ~PORT_Pin_0;
        li t0, MDR_GPIO4_PULL
        lw t1, 0(t0)
        andi t1, t1, ~PORT_Pin_0
        sw t1, 0(t0)
        # MDR_GPIO4_PULL |= (PORT_PULL_DOWN_OFF << PD0);
        li t0, MDR_GPIO4_PULL
        lw t1, 0(t0)
        ori t1, t1, (PORT_PULL_DOWN_OFF << PD0)
        sw t1, 0(t0)

    # /* write power/speed */
    # MDR_GPIO4_PWR &= ~twoBitMask;
    li t0, MDR_GPIO4_PWR
    lw t1, 0(t0)
    andi t1, t1, ~twoBitMask
    sw t1, 0(t0)
    # MDR_GPIO4_PWR |= (PORT_SPEED_SLOW_4mA << (PD0 * 2));
    li t0, MDR_GPIO4_PWR
    lw t1, 0(t0)
    ori t1, t1, (PORT_SPEED_SLOW_4mA << PD0)
    sw t1, 0(t0)

        # /* setup function */
        # MDR_GPIO4_FUNC &= ~twoBitMask;
        li t0, MDR_GPIO4_FUNC
        lw t1, 0(t0)
        andi t1, t1, ~twoBitMask
        sw t1, 0(t0)
        # MDR_GPIO4_FUNC |= (PORT_FUNC_PORT << (PD0 * 2));
        li t0, MDR_GPIO4_FUNC
        lw t1, 0(t0)
        ori t1, t1, (PORT_FUNC_PORT << PD0)
        sw t1, 0(t0)
    
    # PORT_SetReset(MDR_PORTD, PORT_Pin_0, SET);
    # MDR_GPIO4_SETTX = PORT_Pin_0;    
    li t0, MDR_GPIO4_SETTX
    lw t1, 0(t0)
    ori t1, t1, PORT_Pin_0
    sw t1, 0(t0)
    
    # PORT_SetReset(MDR_PORTD, PORT_Pin_0, RESET);
    # MDR_GPIO4_CLRTX = PORT_Pin_0;   
    # li t0, MDR_GPIO4_CLRTX
    # lw t1, 0(t0)
    # ori t1, t1, PORT_Pin_0
    # sw t1, 0(t0)
        

infinity_loop:
    jal   blink # call

    j infinity_loop


halt: j halt


blink:
    andi t4, t4, 0 # обнуляем счётчик t4
    li t5, 0x00100000

.blink_loop:
    # ;if (DelayCnt++ >= 0x00010000)
    bge t4, t5, .blink_run # Переход в случае больше или равно
    addi t4, t4, 1
    j .blink_loop

.blink_run:
	# ;if (((MDR_GPIO4_RXTX) & PORT_Pin_0) != 0)
    li t0, MDR_GPIO4_RXTX
    lw t1, 0(t0)
    andi t1, t1, PORT_Pin_0
    # bne t1, x0, .blink_reset # Переход в случае неравенства
    beq t1, x0, .blink_set # Переход в случае равенства
    j .blink_set

.blink_reset:
        # PORT_SetReset(LED_PORT, LED_PIN_0, RESET);
        li t0, MDR_GPIO4_CLRTX
        lw t1, 0(t0)
        ori t1, t1, PORT_Pin_0
        sw t1, 0(t0)
    # ;else
.blink_set:
        # PORT_SetReset(LED_PORT, LED_PIN_0, SET);
        li t0, MDR_GPIO4_SETTX
        lw t1, 0(t0)
        ori t1, t1, PORT_Pin_0
        sw t1, 0(t0)

    ret

