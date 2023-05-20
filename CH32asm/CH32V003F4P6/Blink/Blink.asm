
.equ PERIPH_BASE,       (0x40000000)

.equ APB2PERIPH_BASE,   (PERIPH_BASE + 0x10000)
.equ AHBPERIPH_BASE,    (PERIPH_BASE + 0x20000)

.equ GPIOD_BASE,        (APB2PERIPH_BASE + 0x1400)
.equ RCC_BASE,          (AHBPERIPH_BASE + 0x1000) 

.equ RCC_APB2PCENR,     0x40021018 /*(RCC_BASE + 0x18) /* 0x40021018 */

.equ RCC_APB2PCENR_IOPDEN, (1 << 5)

.equ GPIOD_CFGLR,       0x40011400 /*(GPIOD_BASE + 0x00)*/
.equ GPIOD_OUTDR,       0x4001140C /*(GPIOD_BASE + 0x0c)*/

.equ GPIO_MASK,     0b1111
.equ GPIO_PP_50MHz, 0b0011  /* Speed_50MHz */

.equ LED, 0 /* PD0 */

.equ delay, 50000

.text
.global _start
_start:
    /* //RCC_APB2PCENR |= RCC_APB2PCENR_IOPDEN*/
    la a5, RCC_APB2PCENR
    lw	a4, 0(a5)
        ori	a4, a4, RCC_APB2PCENR_IOPDEN
    sw	a4, 0(a5)
    
    /*//GPIOD_CFGLR = (GPIOD_CFGLR & (0b1111<<LED*4)) | 0b0011 << (LED*4)*/
    la a5, GPIOD_CFGLR
    lw	a4, 0(a5)
        la  a6, ~(GPIO_MASK << (LED*4))
        and a3, a4, a6
        la  a4, (GPIO_PP_50MHz << (LED*4))
        or  a4, a4, a3
    sw	a4, 0(a5)

loop_main:
    /*//GPIOD_OUTDR ^= (1<<LED)*/
    la a5, GPIOD_OUTDR
    lw	a4, 0(a5)
        xori	a4, a4, (1<<LED)
    sw	a4, 0(a5)

    /* //sleep*/
    la a0, delay
    call sleep
    
    j loop_main


sleep:
  addi  a0, a0, -1
  bnez a0, sleep
ret


