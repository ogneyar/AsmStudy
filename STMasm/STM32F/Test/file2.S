
      EXPORT myApplication
       
RCC      EQU 0x40021000
Port_C     EQU 0x40011000
 
       
      AREA mySection3, CODE, READONLY
       
myApplication
      ; enable the APB2 clock
      
      MOV r0, #0x10
      LDR r1, =RCC
      STR r0, [r1, #0x18]


      ; configure the GPIO C for output

      MOV r0, #0x200000
      LDR r1, =Port_C
      STR r0, [r1, #0x04]


      ; set the builtin LED on/off
      
      MOV r0, #0x2000
      STR r0, [r1, #0x0C]


      B .

      ALIGN

      END
