stm8/

    segment 'rom'

.delay:
	; 0x61a80 = 400000 i.e. (2*10^6 MHz)/5cycles - 1секуда
    ld a, #$03 ;  #$06 - 1000мс, #$03 - 500мс
    ldw y, #$1a80 	
loop:
    subw y, #$01 	; decrement with set carry
    sbc a,#0 		; decrement carry flag i.e. a = a - carry_flag
    jrne loop
    ret
	
    end
	