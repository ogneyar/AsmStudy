
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

@ External Interrupts
@	.word	int_vect_terminator+1	@ Window Watchdog interrupt 
@	.word	int_vect_terminator+1	@ PVD through EXTI line detection interrupt
@	.word	int_vect_terminator+1	@ Tamper and TimeStamp interrupts through the EXTI line
@	.word	int_vect_terminator+1	@ RTC Wakeup interrupt through the EXTI line
@	.word	int_vect_terminator+1	@ Flash global interrupt
@	.word	int_vect_terminator+1	@ RCC global interrupt
@	.word	int_vect_terminator+1	@ EXTI Line0 interrupt
@	.word	int_vect_terminator+1	@ EXTI Line1 interrupt
@	.word	int_vect_terminator+1	@ EXTI Line2 interrupt
@	.word	int_vect_terminator+1	@ EXTI Line3 interrupt
@	.word	int_vect_terminator+1	@ EXTI Line4 interrupt
@	.word	int_vect_terminator+1	@ DMA1 Stream0 global interrupt  
@	.word	int_vect_terminator+1	@ DMA1 Stream1 global interrupt 
@	.word	int_vect_terminator+1	@ DMA1 Stream2 global interrupt 
@	.word	int_vect_terminator+1	@ DMA1 Stream3 global interrupt 
@	.word	int_vect_terminator+1	@ DMA1 Stream4 global interrupt 
@	.word	int_vect_terminator+1	@ DMA1 Stream5 global interrupt 
@	.word	int_vect_terminator+1	@ DMA1 Stream6 global interrupt 
@	.word	int_vect_terminator+1	@ ADC1, ADC2 and ADC3 global interrupts
@	.word	int_vect_terminator+1	@ CAN1 TX interrupts 
@	.word	int_vect_terminator+1	@ CAN1 RX0 interrupts 
@	.word	int_vect_terminator+1	@ CAN1 RX1 interrupt 
@	.word	int_vect_terminator+1	@ CAN1 SCE interrupt 
@	.word	int_vect_terminator+1	@ EXTI Line[9:5] interrupts 
@	.word	int_vect_terminator+1	@ TIM1 Break interrupt and TIM9 global interrupt
@	.word	int_vect_terminator+1	@ TIM1 Update interrupt and TIM10 global interrupt
@	.word	int_vect_terminator+1	@ TIM1 Trigger and Commutation interrupts and TIM11 global interrupt
@	.word	int_vect_terminator+1	@ TIM1 Capture Compare interrupt 
@	.word	int_vect_terminator+1	@ TIM2 global interrupt 
@	.word	int_vect_terminator+1	@ TIM3 global interrupt 
@	.word	int_vect_terminator+1	@ TIM4 global interrupt 
@	.word	int_vect_terminator+1	@ I2C1 event interrupt
@	.word	int_vect_terminator+1	@ I2C1 error interrupt
@	.word	int_vect_terminator+1	@ I2C2 event interrupt
@	.word	int_vect_terminator+1	@ I2C2 error interrupt
@	.word	int_vect_terminator+1	@ SPI1 global interrupt
@	.word	int_vect_terminator+1	@ SPI2 global interrupt
@	.word	int_vect_terminator+1	@ USART1 global interrupt
@	.word	int_vect_terminator+1	@ USART2 global interrupt
@	.word	int_vect_terminator+1	@ USART3 global interrupt
@	.word	int_vect_terminator+1	@ EXTI Line[15:10] interrupts
@	.word	int_vect_terminator+1	@ RTC Alarms (A and B) through EXTI line interrupt
@	.word	int_vect_terminator+1	@ USB On-The-Go FS Wakeup through EXTI line interrupt
@	.word	int_vect_terminator+1	@ TIM8 Break interrupt and TIM12 global interrupt
@	.word	int_vect_terminator+1	@ TIM8 Update interrupt and TIM13 global interrupt
@	.word	int_vect_terminator+1	@ TIM8 Trigger and Commutation interrupts and TIM14 global interrupt
@	.word	int_vect_terminator+1	@ TIM8 Capture Compare interrupt 
@	.word	int_vect_terminator+1	@ DMA1 Stream7 global interrupt  
@	.word	int_vect_terminator+1	@ FSMC global interrupt
@	.word	int_vect_terminator+1	@ SDIO global interrupt
@	.word	int_vect_terminator+1	@ TIM5 global interrupt
@	.word	int_vect_terminator+1	@ SPI3 global interrupt
@	.word	int_vect_terminator+1	@ UART4 global interrupt
@	.word	int_vect_terminator+1	@ UART5 global interrupt
@	.word	int_vect_terminator+1	@ TIM6 global interrupt, DAC1 and DAC2 underrun error interrupts
@	.word	int_vect_terminator+1	@ TIM7 global interrupt
@	.word	int_vect_terminator+1	@ DMA2 Stream0 global interrupt  
@	.word	int_vect_terminator+1	@ DMA2 Stream1 global interrupt 
@	.word	int_vect_terminator+1	@ DMA2 Stream2 global interrupt 
@	.word	int_vect_terminator+1	@ DMA2 Stream3 global interrupt 
@	.word	int_vect_terminator+1	@ DMA2 Stream4 global interrupt 
@	.word	int_vect_terminator+1	@ Ethernet global interrupt 
@	.word	int_vect_terminator+1	@ Ethernet Wakeup through EXTI line interrupt
@	.word	int_vect_terminator+1	@ CAN2 TX interrupts
@	.word	int_vect_terminator+1	@ CAN2 RX0 interrupts
@	.word	int_vect_terminator+1	@ CAN2 RX1 interrupt
@	.word	int_vect_terminator+1	@ CAN2 SCE interrupt
@	.word	int_vect_terminator+1	@ USB On The Go FS global interrupt
@	.word	int_vect_terminator+1	@ DMA2 Stream5 global interrupt  
@	.word	int_vect_terminator+1	@ DMA2 Stream6 global interrupt  
@	.word	int_vect_terminator+1	@ DMA2 Stream7 global interrupt  
@	.word	int_vect_terminator+1	@ USART6 global interrupt 
@	.word	int_vect_terminator+1	@ I2C3 event interrupt
@	.word	int_vect_terminator+1	@ I2C3 error interrupt
@	.word	int_vect_terminator+1	@ USB On The Go HS End Point 1 Out global interrupt 
@	.word	int_vect_terminator+1	@ USB On The Go HS End Point 1 In global interrupt 
@	.word	int_vect_terminator+1	@ USB On The Go HS Wakeup through EXTI interrupt 
@	.word	int_vect_terminator+1	@ USB On The Go HS global interrupt 
@	.word	int_vect_terminator+1	@ DCMI global interrupt 
@	.word	int_vect_terminator+1	@ CRYP crypto global interrupt 
@	.word	int_vect_terminator+1	@ Hash and Rng global interrupt  
@	.word	int_vect_terminator+1	@ FPU global interrupt


.section .asmcode
@ Заглушка для любых необрабатываемых прерываний
int_vect_terminator:	
		B	int_vect_terminator
