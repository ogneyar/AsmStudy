
.equ RCU_APB2EN, 0x40021018
.equ RCU_APB2EN_PAEN, (1<<2)
.equ GPIOA_CTL0, 0x40010800
.equ GPIO_MASK, 0b1111
.equ GPIO_PP_50MHz, 0b0011
.equ GPIOA_OCTL, 0x4001080C

.equ GLED, 1  // PA1
.equ BLED, 2  // PA2

.equ delay, 300000

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

    // включение тактирования порта А
    la a5, RCU_APB2EN
    lw	a4, 0(a5)
        ori	a4, a4, RCU_APB2EN_PAEN
    sw	a4, 0(a5)

    // PA0 и PA1 на выход
    la a5, GPIOA_CTL0
    lw	a4, 0(a5)
        la  a6, ~((GPIO_MASK << (GLED*4)) | (GPIO_MASK << (BLED*4)))
        and a3, a4, a6
        la  a4, ((GPIO_PP_50MHz << (GLED*4)) | (GPIO_PP_50MHz << (BLED*4)))
        or    a4, a4, a3
    sw	a4, 0(a5)  
  
MAIN_LOOP:
    la s0, GPIOA_OCTL
    lh s1, 0(s0)
    la s2, ~(1<<GLED | 1<<BLED)

    la s3, led_arr
    la s4, led_arr_end
led_loop:
    lh t0, 0(s3)
    and s1, s1, s2
    or s1, s1, t0
        sh s1, 0(s0)

    la a0, delay
    call sleep

    addi s3, s3, 2
    bltu s3, s4, led_loop

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


; .text // запись массива во flash память
.data // запись массива в оперативную память
led_arr:
    .short (0<<GLED | 0<<BLED)
    .short (0<<GLED | 1<<BLED)
    .short (1<<GLED | 0<<BLED)
    .short (1<<GLED | 1<<BLED)
led_arr_end:
