//
.equ RCU_APB2EN,        0x40021018
.equ RCU_APB2EN_PAEN,   (1<<2)
.equ RCU_APB2EN_PBEN,   (1<<3)
.equ RCU_APB2EN_PCEN,   (1<<4)
.equ GPIOA_CTL0,        0x40010800
.equ GPIOB_CTL0,        0x40010C00
.equ GPIOC_CTL0,        0x40011000
.equ GPIOC_CTL1,        0x40011004
.equ GPIO_MASK,         0b1111
.equ GPIO_HIZ,          0b0100
.equ GPIO_PP_50MHz,     0b0011
.equ GPIOA_OCTL,        0x4001080C
.equ GPIOB_OCTL,        0x40010C0C
.equ GPIOC_OCTL,        0x4001100C
.equ GPIOB_ISTAT,       0x40010C08

.equ RLED, 13 // PC13 = 5 in GPIOC_CTL1
.equ RLED_, 5 // ----------------------
.equ GLED, 1  // PA1
.equ BLED, 2  // PA2
.equ SBTN, 0  // PB0
.equ RBTN, 1  // PB1

.equ delay, 500000

.text
.global _start
_start:
  //RCU_APB2EN |= RCU_APB2EN_PAEN | RCU_APB2EN_PCEN
  la a5, RCU_APB2EN
  lw	a4, 0(a5)
    ori	a4, a4, RCU_APB2EN_PAEN | RCU_APB2EN_PCEN
  sw	a4, 0(a5)

  //LEDs
  //GPIOA_CTL0 = (GPIOA_CTL0 & (0b1111<<GLED*4) & (0b1111<<BLED*4)) | 0b0011 << (GLED*4) | 0b0011 << (BLED*4)
  la a5, GPIOA_CTL0
  lw	a4, 0(a5)
    la  a6, ~((GPIO_MASK << (GLED*4)) | (GPIO_MASK << (BLED*4)))
    and a3, a4, a6
    la  a4, ((GPIO_PP_50MHz << (GLED*4)) | (GPIO_PP_50MHz << (BLED*4)))
    or    a4, a4, a3
  sw	a4, 0(a5)  
  //GPIOC_CTL1 = (GPIOC_CTL1 & (0b1111<<RLED_*4)) | 0b0011 << (RLED_*4)
  la a5, GPIOC_CTL1
  lw	a4, 0(a5)
    la  a6, ~(GPIO_MASK << (RLED_*4))
    and a3, a4, a6
    la  a4, (GPIO_PP_50MHz << (RLED_*4))
    or    a4, a4, a3
  sw	a4, 0(a5)

  //Buttons
  la a5, GPIOB_CTL0
  lw	a4, 0(a5)
    la  a6, ~((GPIO_MASK << (RBTN*4)) | (GPIO_MASK << (SBTN*4)))
    and a3, a4, a6
    la  a4, ((GPIO_HIZ << (RBTN*4)) | (GPIO_HIZ << (SBTN*4)))
    or    a4, a4, a3
  sw	a4, 0(a5)
  
  la a3, 0
MAIN_LOOP:
  la a5, GPIOB_OCTL
  lw	a4, 0(a5)
    //andi	a4, a4, ~(1<<RLED | 1<<BLED | 1<<GLED)
    andi	a4, a4, ~(1<<BLED | 1<<GLED)
    or a4, a4, a6
  sw	a4, 0(a5)
  
  //GPIOC_OCTL(GPIOC) ^= (1<<RLED)
  la a5, GPIOC_OCTL
  lw	a4, 0(a5)
    la	a6, (1<<RLED)
    xor	a4, a4, a6
  sw	a4, 0(a5)
  
  //add a3, a3, (1<<RLED)
  //andi a6, a3, (1<<RLED | 1<<BLED)
  andi a6, a3, (1<<BLED)
  
  la a5, GPIOB_ISTAT
  lw a4, 0(a5)
    andi a4, a4, (1<<SBTN)
    bnez a4, SBTN_SKIP
      ori a6, a6, (1<<GLED)
SBTN_SKIP:
  
  //sleep
  la a5, delay
sleep:
  addi	a5, a5, -1
  bnez a5, sleep

  j MAIN_LOOP
