stm8/
    MOTOROLA	
	
	WORDS		; following addresses are 16-bit length
	segment byte at 500a 'periphC'	
	
; Port C at 0x500a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.PC_ODR			DS.B 1		; Port C data output latch register
.PC_IDR			DS.B 1		; Port C input pin value register
.PC_DDR			DS.B 1		; Port C data direction register
.PC_CR1			DS.B 1		; Port C control register 1
.PC_CR2			DS.B 1		; Port C control register 2

	WORDS			; The following addresses are 16 bits long
	segment byte at 8080-9FFF 'rom'	

LED equ 3 ; led on PC3


.main
    bset PC_DDR, #LED       ; PC_DDR|=(1<<LED)
    bset PC_CR1, #LED       ; PC_CR1|=(1<<LED)
main_loop:
    bcpl PC_ODR, #LED       ; PC_ODR^=(1<<LED)	
	call delay
    jp main_loop
	
delay:
	; 0x61a80 = 400000 i.e. (2*10^6 MHz)/5cycles - 1 секуда
	; 0x30d40 = 200000 i.e. (2*10^6 MHz)/5cycles / 2 - 0.5 секуды
	; 0x13880 = 80000 i.e. (2*10^6 MHz)/5cycles / 5 - 0.2 секуды
	; 0x09c40 = 40000 i.e. (2*10^6 MHz)/5cycles / 10 - 0.1 секуды
    ld 	a, #$01 	; #$06 - 1000мс,   #$03 - 500мс,   #$01 - 200мс,   #$00 - 100мс
    ldw y, #$3880 	; #$1a80 - 1000мс, #$0d40 - 500мс, #$3880 - 200мс, #$9c40 - 100мс
loop:
    subw y, #$01 	; decrement with set carry
    sbc a,#0 		; decrement carry flag i.e. a = a - carry_flag
    jrne loop
	
	ret

    end
	
	
	