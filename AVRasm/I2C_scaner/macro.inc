
#ifndef _MACRO_INC_
#define _MACRO_INC_


.macro uout
   .if @0<0x40
       out @0,@1
   .else
       sts @0,@1
   .endif
.endm
.macro uin
   .if @1<0x40
       in @0,@1
   .else
       lds @0,@1
   .endif
.endm

.macro SETstr
    LDI 	ZL, LOW(@0*2)   
	LDI 	ZH, HIGH(@0*2)
.endm

; .macro SETdel
;     LDI 	XL, LOW(@0)   
; 	LDI 	XH, HIGH(@0)
; .endm


#endif  /* _MACRO_INC_ */
