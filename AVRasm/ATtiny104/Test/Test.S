
;

#include <avr/io.h>

main:
    ldi r16,0b00100000
  ; Set PA5 to an output
    out DDRA,r16
  ; Set PA5 HIGH
    out PORTA,r16
loop:
  ; Loop forever
    rjmp loop