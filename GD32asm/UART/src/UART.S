
.equ RCU_APB2EN, 0x40021018
.equ RCU_APB2EN_AFEN, (1<<0)
.equ RCU_APB2EN_PAEN, (1<<2)
.equ RCU_APB2EN_PBEN, (1<<3)
.equ RCU_APB2EN_PCEN, (1<<4)
.equ RCU_APB2EN_USART0EN, (1<<14)
.equ GPIOA_BASE, 0x40010800
.equ GPIOB_BASE, 0x40010C00
.equ GPIOC_BASE, 0x40011000
.equ GPIOA_CTL0, (GPIOA_BASE + 0x00)
.equ GPIOA_CTL1, (GPIOA_BASE + 0x04)
.equ GPIOA_OCTL, (GPIOA_BASE + 0x0C)
.equ GPIOB_CTL0, (GPIOB_BASE + 0x00)
.equ GPIOB_CTL1, (GPIOB_BASE + 0x04)
.equ GPIOB_OCTL, (GPIOB_BASE + 0x0C)
.equ GPIOC_CTL0, (GPIOC_BASE + 0x00)
.equ GPIOC_CTL1, (GPIOC_BASE + 0x04)
.equ GPIOC_OCTL, (GPIOC_BASE + 0x0C)

.equ GPIO_MASK,		0b1111
.equ GPIO_HIZ,		0b0100
.equ GPIO_PP50,		0b0011
.equ GPIO_APP50,	0b1011

.equ USART0_BASE, 0x40013800
.equ USART_STAT_OFFSET, 0x00
.equ USART_DATA_OFFSET, 0x04
.equ USART_BAUD_OFFSET, 0x08
.equ USART_CTL0_OFFSET, 0x0C

.equ USART_CTL0_REN, (1<<2)
.equ USART_CTL0_TEN, (1<<3)
.equ USART_STAT_RBNE,(1<<5)
.equ USART_STAT_TBE, (1<<7)
.equ USART_CTL0_UEN, (1<<13)
//#GPIOA
.equ UART0_TX, 9
.equ UART0_RX, 10
.equ GLED, 1
.equ BLED, 2
//#GPIOB
.equ SBTN, 0
.equ RBTN, 1
//#GPIOC
.equ RLED, 13

.equ delay, 500000

.macro push val
    addi sp, sp, -4
    sw \val, 0(sp)
.endm

.macro pop val
    lw \val, 0(sp)
    addi sp, sp, 4
.endm

.text
.global _start
_start:
    // указатель стека на конец оперативки
    la sp, _stack_end // 0x20008000
// копирование оперативной памяти (copy data section)
    la a0, _data_load
    la a1, _data_start
    la a2, _data_end
    bgeu a1, a2, copy_data_end
copy_data_loop:
    lw t0, (a0)
    sw t0, (a1)
    addi a0, a0, 4
    addi a1, a1, 4
    bltu a1, a2, copy_data_loop
copy_data_end:
# Clear [bss] section
    la a0, _bss_start
    la a1, _bss_end
    bgeu a0, a1, clear_bss_end
clear_bss_loop:
    sw zero, (a0)
    addi a0, a0, 4
    bltu a0, a1, clear_bss_loop
clear_bss_end:
  
  
    // включение тактирования порта А, B, C, альтернативных функций и USART 
    la t0, RCU_APB2EN
    lw	t1, 0(t0)
        la  t2, RCU_APB2EN_PAEN | RCU_APB2EN_PBEN | RCU_APB2EN_PCEN | RCU_APB2EN_AFEN | RCU_APB2EN_USART0EN
        or	t1, t1, t2
    sw	t1, 0(t0)

    // GLED и BLED на выход
    la a5, GPIOA_CTL0
    lw	a4, 0(a5)
        la  a6, ~(GPIO_MASK << (GLED*4) | GPIO_MASK << (BLED*4))
        and a3, a4, a6
        la  a4, (GPIO_PP50 << (GLED*4) | GPIO_PP50 << (BLED*4))
        or  a4, a4, a3
    sw	a4, 0(a5)

    // RLED на выход
    la a5, GPIOC_CTL1
    lw	a4, 0(a5)
        la  a6, ~(GPIO_MASK << ((RLED-8)*4))
        and a3, a4, a6
        la  a4, (GPIO_PP50 << ((RLED-8)*4))
        or    a4, a4, a3
    sw	a4, 0(a5)
  
    // включаем USART порты 
    la t0, GPIOA_CTL1
    lw	t1, 0(t0)
        la  t2, ~(GPIO_MASK << ((UART0_RX-8)*4) | GPIO_MASK << ((UART0_TX-8)*4))
        and t3, t1, t2
        la  t1, (GPIO_HIZ << ((UART0_RX-8)*4) | GPIO_APP50 << ((UART0_TX-8)*4))
        or    t1, t1, t3
    sw	t1, 0(t0)
  
    la t0, USART0_BASE
        li t1, 8000000 / 9600
    sw t1, USART_BAUD_OFFSET(t0)
        li t1, USART_CTL0_UEN | USART_CTL0_REN | USART_CTL0_TEN
    sw t1, USART_CTL0_OFFSET(t0)
    
    // вывод данных в serial порт
    la t0, USART0_BASE
        li t1, 'H'
    sb t1, USART_DATA_OFFSET(t0)

    call uart_wait

    la t0, USART0_BASE
        li t1, 'e'
    sb t1, USART_DATA_OFFSET(t0)

    call uart_wait

    la t0, USART0_BASE
        li t1, 'l'
    sb t1, USART_DATA_OFFSET(t0)

    call uart_wait

    la t0, USART0_BASE
        li t1, 'l'
    sb t1, USART_DATA_OFFSET(t0)

    call uart_wait

    la t0, USART0_BASE
        li t1, 'o'
    sb t1, USART_DATA_OFFSET(t0)
    
    // xor green led
    la t0, GPIOA_OCTL
    lw	t1, 0(t0)
        xori    t1, t1, (1<<GLED)
    sw	t1, 0(t0)
  
MAIN_LOOP:
  la t0, GPIOA_OCTL
  lw	t1, 0(t0)
    xori	t1, t1, (1<<GLED) | (1<<BLED)
  sw	t1, 0(t0)
  
  li a0, delay
  call sleep
  
  j MAIN_LOOP
  

// подпрограмма задержки
sleep:
    push ra // Адрес возврата
    push s0

    mv s0, a0
sleep_loop:
    addi  s0, s0, -1
        bnez s0, sleep_loop

    pop s0
    pop ra
ret


uart_wait:
  la t0, USART0_BASE
  lh t2, USART_STAT_OFFSET(t0)
  andi t2, t2, USART_STAT_TBE
    beqz t2, uart_wait
ret
