
#ifndef _WDT_ASM_
#define _WDT_ASM_

;=================================================
WDT_Init:   
    ; Turn off global interrupt
    cli
    ; Reset Watchdog Timer
    wdr
    ; Start timed sequence
    in r16, WDTCR
    ori r16, (1 << WDCE) | (1 << WDE) | (1 << WDTIE)
    out WDTCR, r16
    ; -- Got four cycles to set the new values from here -
    ; Set new prescaler(time-out) value = 64K cycles (~0.5 s)
    ; ldi r16, (1 << WDP2) | (1 << WDP0) ; 0,5 секунды
    ldi r16, (1 << WDP2) | (1 << WDP1) | (1 << WDP0) ; 2 секунды
    ; ldi r16, (1 << WDP3) | (1 << WDP0) ; 8 секунд
    ori r16, (1 << WDE) | (1 << WDTIE) 
    out WDTCR, r16
    ; -- Finished setting new values, used 2 cycles -
    ; Turn on global interrupt
    sei
ret

WDT_off:
    ; Turn off global interrupt
    cli
    ; Reset Watchdog Timer
    wdr
    ; Clear WDRF in MCUSR
    in r16, MCUSR
    andi r16, (0xff - (1 << WDRF)) ; Watchdog Reset Flag
    out MCUSR, r16
    ; Write logical one to WDCE and WDE
    ; Keep old prescaler setting to prevent unintentional time-out
    in r16, WDTCR
    ori r16, (1 << WDCE) | (1 << WDE) | (1 << WDTIE) ; WDCE - Watchdog Change Enable
    out WDTCR, r16
    ; Turn off WDT
    ldi r16, (0<<WDE)
    out WDTCR, r16
    ; Turn on global interrupt
    sei
ret
;=================================================

#endif  /* _WDT_ASM_ */
