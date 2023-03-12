stm8/
    extern main
    #include "mapping.inc"

    segment 'rom'
reset.l
    ; initialize SP
    ldw X,#$03ff
    ldw SP,X
    jp main
    jra reset

    interrupt NonHandledInterrupt
NonHandledInterrupt.l
    iret    

    segment 'vectit'
    dc.l {$82000000+reset}                  ; reset
    dc.l {$82000000+NonHandledInterrupt}    ; trap
    dc.l {$82000000+NonHandledInterrupt}    ; irq0
    dc.l {$82000000+NonHandledInterrupt}    ; irq1
    dc.l {$82000000+NonHandledInterrupt}    ; irq2
    dc.l {$82000000+NonHandledInterrupt}    ; irq3
    dc.l {$82000000+NonHandledInterrupt}    ; irq4
    dc.l {$82000000+NonHandledInterrupt}    ; irq5
    dc.l {$82000000+NonHandledInterrupt}    ; irq6
    dc.l {$82000000+NonHandledInterrupt}    ; irq7
    dc.l {$82000000+NonHandledInterrupt}    ; irq8
    dc.l {$82000000+NonHandledInterrupt}    ; irq9
    dc.l {$82000000+NonHandledInterrupt}    ; irq10
    dc.l {$82000000+NonHandledInterrupt}    ; irq11
    dc.l {$82000000+NonHandledInterrupt}    ; irq12
    dc.l {$82000000+NonHandledInterrupt}    ; irq13
    dc.l {$82000000+NonHandledInterrupt}    ; irq14
    dc.l {$82000000+NonHandledInterrupt}    ; irq15
    dc.l {$82000000+NonHandledInterrupt}    ; irq16
    dc.l {$82000000+NonHandledInterrupt}    ; irq17
    dc.l {$82000000+NonHandledInterrupt}    ; irq18
    dc.l {$82000000+NonHandledInterrupt}    ; irq19
    dc.l {$82000000+NonHandledInterrupt}    ; irq20
    dc.l {$82000000+NonHandledInterrupt}    ; irq21
    dc.l {$82000000+NonHandledInterrupt}    ; irq22
    dc.l {$82000000+NonHandledInterrupt}    ; irq23
    dc.l {$82000000+NonHandledInterrupt}    ; irq24
    dc.l {$82000000+NonHandledInterrupt}    ; irq25
    dc.l {$82000000+NonHandledInterrupt}    ; irq26
    dc.l {$82000000+NonHandledInterrupt}    ; irq27
    dc.l {$82000000+NonHandledInterrupt}    ; irq28
    dc.l {$82000000+NonHandledInterrupt}    ; irq29

		END
