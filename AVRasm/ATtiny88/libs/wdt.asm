
#ifndef _WDT_ASM_
#define _WDT_ASM_

#include "../libs/macro.inc"    ; подключение файла 'макросов'

;=================================================
WDT_Init:   
    push    R16
    push    R17
    mIN     R17, SREG    
    CLI ; Turn off global interrupt
    WDR ; Reset Watchdog Timer
    ; Start timed sequence
    mIN     R16, WDTCSR
    ORI     R16, (1 << WDCE) | (1 << WDE) | (1 << WDIE)
    mOUT    WDTCSR, R16
    ; -- Got four cycles to set the new values from here -
    ; Set new prescaler(time-out) value = 64K cycles (~0.5 s)
    ; ldi   R16, (1 << WDP2) | (1 << WDP0) ; 0,5 секунды
    LDI     R16, (1 << WDP2) | (1 << WDP1) | (1 << WDP0) ; 2 секунды
    ; ldi   R16, (1 << WDP3) | (1 << WDP0) ; 8 секунд
    ORI     R16, (1 << WDE) | (1 << WDIE) 
    mOUT    WDTCSR, R16
    ; -- Finished setting new values, used 2 cycles -
    ; Turn on global interrupt
    mOUT    SREG, R17 ; sei
    pop     R17
    pop     R16
ret

WDT_off:
    push    R16
    push    R17
    mIN     R17, SREG    
    CLI ; Turn off global interrupt
    WDR ; Reset Watchdog Timer
    ; Clear WDRF in MCUSR
    mIN     R16, MCUSR
    ANDI    R16, (0xff & (0 << WDRF))
    mOUT    MCUSR, R16
    ; Write logical one to WDCE and WDE
    ; Keep old prescaler setting to prevent unintentional time-out
    mIN     R16, WDTCSR
    ORI     R16, (1 << WDCE) | (1 << WDE)
    mOUT    WDTCSR, R16
    ; Turn off WDT
    LDI     R16, (0 << WDE)
    mOUT    WDTCSR, R16
    ; Turn on global interrupt
    mOUT    SREG, R17 ; sei
    pop     R17
    pop     R16
ret
;=================================================

#endif  /* _WDT_ASM_ */
