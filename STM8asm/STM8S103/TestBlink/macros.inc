
delay_ms MACRO ms
    #ifdef F_CPU
	; nothing
    #else
    #define F_CPU 2000000
    #endif
    ld a, #{{SEG {ms mult {F_CPU div 1000}}} div 5}
    ldw y, #{{OFFSET {ms mult {F_CPU div 1000}}} div 5}
    LOCAL loop
loop:
    subw y, #$01    ; decrement with set carry
    sbc a,#0        ; decrement carry flag i.e. a = a - carry_flag
    jrne loop
    MEND
	