
    #ifdef _DELAY_ASM_
    ; nothing
    #else
    #define _DELAY_ASM_ 1

; ================================================
; подпрограмма задержки
delay:
	; 0x30d400 = 3200000 i.e. (16 MHz)/5 cycles - 1 секуда
	; 0x186a00 = 1600000 i.e. (16 MHz)/5 cycles / 2 - 0.5 секуды
	; 0x09c400 = 640000 i.e. (16 MHz)/5 cycles / 5 - 0.2 секуды
	; 0x04e200 = 320000 i.e. (16 MHz)/5 cycles / 10 - 0.1 секуды - 100ms
	; 0x007D00 = 32000 i.e. (16 MHz)/5 cycles / 10 - 0.01 секуды - 10ms
    ld 	    a, #$30 	; #$30 - 1000мс,   #$18 - 500мс,   #$09 - 200мс,   #$04 - 100мс,   #$00 - 10мс
    ldw     y, #$d400 	; #$d400 - 1000мс, #$6a00 - 500мс, #$c400 - 200мс, #$e200 - 100мс, #$7d00 - 10мс
loop_delay:
    subw    y, #$01 	; decrement with set carry
    sbc     a, #0 		; decrement carry flag i.e. a = a - carry_flag
    jrne    loop_delay
	
	ret
; ================================================

; ================================================
; подпрограмма задержки
delay_100ms:
    ld 	    a, #$04 	; #$04 - 100мс
    ldw     y, #$e200 	; #$e200 - 100мс
loop_delay_100ms:
    subw    y, #$01 	; decrement with set carry
    sbc     a, #0 		; decrement carry flag i.e. a = a - carry_flag
    jrne    loop_delay_100ms
	
	ret
; ================================================


; ================================================
; подпрограмма задержки
delay_10ms:
    ld 	    a, #$00 	; #$00 - 10мс
    ldw     y, #$7d00 	; #$7d00 - 10мс
loop_delay_10ms:
    subw    y, #$01 	; decrement with set carry
    sbc     a, #0 		; decrement carry flag i.e. a = a - carry_flag
    jrne    loop_delay_10ms
	
	ret
; ================================================

    #endif ; _DELAY_ASM_
