
@ Таблица прерываний для процессоров STM32F40x - F41x

.word	int_vect_terminator+1	@ NMI
.word	int_vect_terminator+1	@ Hard Fault
.word	int_vect_terminator+1	@ MPU Fault
.word	int_vect_terminator+1	@ Bus Fault
.word	int_vect_terminator+1	@ Usage Fault
.word	0			@ Reserved
.word	0			@ Reserved
.word	0			@ Reserved
.word	0			@ Reserved
.word	int_vect_terminator+1	@ SVCall
.word	int_vect_terminator+1	@ Debug Monitor
.word	0			@ Reserved
.word	int_vect_terminator+1	@ PendSV
.word	ISR_SYSTICK+1		@ SysTick

.section .text
@ Заглушка для любых необрабатываемых прерываний
int_vect_terminator:	
		B	int_vect_terminator
