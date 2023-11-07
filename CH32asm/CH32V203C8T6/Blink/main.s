.align 1
.equ PERIPH_BASE,       (0x40000000)

.equ APB2PERIPH_BASE,   (PERIPH_BASE + 0x10000)
.equ AHBPERIPH_BASE,    (PERIPH_BASE + 0x20000)

.equ GPIOB_BASE,        (APB2PERIPH_BASE + 0x0C00)
.equ RCC_BASE,          (AHBPERIPH_BASE + 0x1000) 

.equ RCC_APB2PCENR,     (RCC_BASE + 0x18) # 0x40021018

.equ RCC_APB2PCENR_IOPBEN, (1 << 3) # 0x00000008

.equ GPIOB_CFGLR,       (GPIOB_BASE + 0x00)
.equ GPIOB_OUTDR,       (GPIOB_BASE + 0x0c)
.equ GPIOB_BSHR,        (GPIOB_BASE + 0x10)
.equ GPIOB_BCR,         (GPIOB_BASE + 0x14)

.equ GPIO_MASK,     0b1111
.equ GPIO_PP_50MHz, 0b0011  # Speed_50MHz

.equ LED1, 3 # PB3 - red
.equ LED2, 4 # PB4 - green
.equ LED3, 5 # PB5 - blue

.equ delay, 0x00100000

.section .text
.global _start

_start:
    # RCC_APB2PCENR |= RCC_APB2PCENR_IOPBEN
    li t0, RCC_APB2PCENR
    lw t1, 0(t0)
    ori	t1, t1, RCC_APB2PCENR_IOPBEN
    sw t1, 0(t0)
    
    # GPIOB_CFGLR = (GPIOB_CFGLR & (0b1111<<LED*4)) | 0b0011 << (LED*4)
    li t0, GPIOB_CFGLR
    lw t1, 0(t0)
    li t2, ~(GPIO_MASK << (LED1*4)) & ~(GPIO_MASK << (LED2*4)) & ~(GPIO_MASK << (LED3*4))
    and t1, t1, t2
    li t2, (GPIO_PP_50MHz << (LED1*4)) | (GPIO_PP_50MHz << (LED2*4)) | (GPIO_PP_50MHz << (LED3*4))
    or t1, t1, t2
    sw t1, 0(t0)

loop_main:
    # GPIOB_OUTDR ^= (1 << LED1) | (1 << LED3)
    li t0, GPIOB_OUTDR
    lw t1, 0(t0)
    xori t1, t1, (1 << LED1) | (1 << LED3)
    sw t1, 0(t0)    
    
    li a0, delay
    jal sleep

    # GPIOB_OUTDR ^= (1 << LED2)
    li t0, GPIOB_OUTDR
    lw t1, 0(t0)
    xori t1, t1, (1 << LED2)
    sw t1, 0(t0)  

    j loop_main

halt: j halt

sleep:
    addi  a0, a0, -1
    bnez a0, sleep

    ret
