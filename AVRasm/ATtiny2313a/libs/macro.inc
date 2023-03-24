
#ifndef _MACRO_INC_
#define _MACRO_INC_


.macro mOUT
   .if @0<0x40
       OUT @0,@1
   .else
       STS @0,@1
   .endif
.endm
.macro mIN
   .if @1<0x40
       IN @0,@1
   .else
       LDS @0,@1
   .endif
.endm

.macro mSetZ
    LDI 	ZL, LOW(@0)   
	LDI 	ZH, HIGH(@0)
.endm

.macro mSetStr
    LDI 	ZL, LOW(@0*2)   
	LDI 	ZH, HIGH(@0*2)
.endm


#endif  /* _MACRO_INC_ */
