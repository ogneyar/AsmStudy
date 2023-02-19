
#ifndef _TN104DEF_INC_
#define _TN104DEF_INC_


#pragma partinc 0

; ; ***** SPECIFY DEVICE ***************************************************
.device ATtiny104
#pragma AVRPART ADMIN PART_NAME ATtiny104
.equ	SIGNATURE_000	= 0x1e
.equ	SIGNATURE_001	= 0x90
.equ	SIGNATURE_002	= 0x0B

#pragma AVRPART CORE CORE_VERSION V2
#pragma AVRPART CORE NEW_INSTRUCTIONS lpm rd,z+


; ***** I/O REGISTER DEFINITIONS *****************************************
; NOTE:
; Definitions marked "MEMORY MAPPED"are extended I/O ports
; and cannot be used with IN/OUT instructions

.equ	SREG	= 0x5f
.equ	SPL		= 0x3d
.equ	SPH	    = 0x3e
.equ	CCP	    = 0x3c
.equ	RSTFLR	= 0x3b
.equ	SMCR	= 0x3a
.equ	OSCCAL	= 0x39
.equ	CLKMSR	= 0x37
.equ	CLKPSR	= 0x36
.equ	PRR		= 0x35
.equ	VLMCSR	= 0x34
.equ	NVMCMD	= 0x33
.equ	NVMCSR	= 0x32
.equ	WDTCSR	= 0x31
.equ	GTCCR	= 0x2f
.equ	TCCR0A	= 0x2e
.equ	TCCR0B	= 0x2d
.equ	TCCR0C	= 0x2c
.equ	TIMSK0	= 0x2b
.equ	TIFR0	= 0x2a
.equ	TCNT0H	= 0x29
.equ	TCNT0L	= 0x28
.equ	OCR0AH	= 0x27
.equ	OCR0AL	= 0x26
.equ	OCR0BH	= 0x25
.equ	OCR0BL	= 0x24
.equ	ICR0H	= 0x23
.equ	ICR0L	= 0x22
.equ	ACSRA	= 0x1f
.equ	ACSRB	= 0x1e
.equ	ADCSRA	= 0x1d
.equ	ADCSRB	= 0x1c
.equ	ADMUX	= 0x1b
.equ	ADCH	= 0x1a
.equ	ADCL	= 0x19
.equ	DIDR0	= 0x17
.equ	PORTCR	= 0x16
.equ	EICRA	= 0x15
.equ	EIFR	= 0x14
.equ	EIMSK	= 0x13
.equ	PCICR	= 0x12
.equ	PCIFR	= 0x11
.equ	PCMSK1	= 0x10
.equ	PCMSK0	= 0x0f
.equ	UCSR0A	= 0x0e
.equ	UCSR0B	= 0x0d
.equ	UCSR0C	= 0x0c
.equ	UCSR0D	= 0x0b
.equ	UBBR0H	= 0x0a
.equ	UBRR0H	= 0x0a
.equ	UBBR0L	= 0x09
.equ	UBRR0L	= 0x09
.equ	UDR0	= 0x08
    .equ	UCSRA	= 0x0E ; MEMORY MAPPED
    .equ	UCSRB	= 0x0D ; MEMORY MAPPED
    .equ	UCSRC	= 0x0C ; MEMORY MAPPED
    .equ	UCSRD	= 0x0B ; MEMORY MAPPED
    .equ	UBRRH	= 0x0A ; MEMORY MAPPED
    .equ	UBRRL	= 0x09 ; MEMORY MAPPED
    .equ	UDR	    = 0x08 ; MEMORY MAPPED
.equ	PUEB	= 0x07
.equ	PORTB	= 0x06
.equ	DDRB	= 0x05
.equ	PINB	= 0x04
.equ	PUEA	= 0x03
.equ	PORTA	= 0x02
.equ	DDRA	= 0x01
.equ	PINA	= 0x00

; ***** BIT DEFINITIONS **************************************************

; ***** ADC *****************
; ADMUX - The ADC multiplexer Selection Register
.equ	MUX0	= 0 ; Analog Channel Selection Bits
.equ	MUX1	= 1 ; Analog Channel Selection Bits
.equ	MUX2	= 2 ; Analog Channel Selection Bits
.equ	REFS0	= 6 ; Analog Reference voltage Selection Bits
.equ	REFS1	= 7 ; Analog Reference voltage Selection Bits

; ADCL - ADC Data Register Low
.equ	ADCL0	= 0 ; ADC Data Register Low Bit 0
.equ	ADCL1	= 1 ; ADC Data Register Low Bit 1
.equ	ADCL2	= 2 ; ADC Data Register Low Bit 2
.equ	ADCL3	= 3 ; ADC Data Register Low Bit 3
.equ	ADCL4	= 4 ; ADC Data Register Low Bit 4
.equ	ADCL5	= 5 ; ADC Data Register Low Bit 5
.equ	ADCL6	= 6 ; ADC Data Register Low Bit 6
.equ	ADCL7	= 7 ; ADC Data Register Low Bit 7

; ADCH - ADC Data Register High
.equ	ADCH0	= 0 ; ADC Data Register High Bit 0
.equ	ADCH1	= 1 ; ADC Data Register High Bit 1
.equ	ADCH2	= 2 ; ADC Data Register High Bit 2
.equ	ADCH3	= 3 ; ADC Data Register High Bit 3
.equ	ADCH4	= 4 ; ADC Data Register High Bit 4
.equ	ADCH5	= 5 ; ADC Data Register High Bit 5
.equ	ADCH6	= 6 ; ADC Data Register High Bit 6
.equ	ADCH7	= 7 ; ADC Data Register High Bit 7

; ADCSRA - The ADC Control and Status register A
.equ	ADPS0	= 0 ; ADC  Prescaler Select Bits
.equ	ADPS1	= 1 ; ADC  Prescaler Select Bits
.equ	ADPS2	= 2 ; ADC  Prescaler Select Bits
.equ	ADIE	= 3 ; ADC Interrupt Enable
.equ	ADIF	= 4 ; ADC Interrupt Flag
.equ	ADATE	= 5 ; ADC  Auto Trigger Enable
.equ	ADSC	= 6 ; ADC Start Conversion
.equ	ADEN	= 7 ; ADC Enable

; ADCSRB - The ADC Control and Status register B
.equ	ADTS0	= 0 ; ADC Auto Trigger Source bits
.equ	ADTS1	= 1 ; ADC Auto Trigger Source bits
.equ	ADTS2	= 2 ; ADC Auto Trigger Source bits
.equ	ADLAR	= 7 ; Left Adjustment for ADC Result Readout

; DIDR0 - Digital Input Disable Register
.equ	ADC0D	= 0 ; ADC0 Digital Input Disable
.equ	ADC1D	= 1 ; ADC1 Digital Input Disable
.equ	ADC2D	= 2 ; ADC2 Digital Input Disable
.equ	ADC3D	= 3 ; ADC3 Digital Input Disable
.equ	ADC4D	= 4 ; ADC4 Digital Input Disable
.equ	ADC5D	= 5 ; ADC5 Digital Input Disable
.equ	ADC6D	= 6 ; ADC6 Digital Input Disable
.equ	ADC7D	= 7 ; ADC7 Digital Input Disable


; ***** AC *****************
; ACSRA - Analog Comparator Control And Status Register A
.equ	ACIS0	= 0 ; Analog Comparator Interrupt Mode Select bits
.equ	ACIS1	= 1 ; Analog Comparator Interrupt Mode Select bits
.equ	ACIC	= 2 ; Analog Comparator Input Capture  Enable
.equ	ACIE	= 3 ; Analog Comparator Interrupt Enable
.equ	ACI	= 4 ; Analog Comparator Interrupt Flag
.equ	ACO	= 5 ; Analog Compare Output
.equ	ACBG	= 6 ; Analog Comparator Bandgap enable
.equ	ACD	= 7 ; Analog Comparator Disable

; ACSRB - Analog Comparator Control And Status Register B
.equ	ACPMUX	= 0 ; Analog Comparator positive input selection bit
.equ	ACOE	= 1 ; Analog Comparator Output Enable

; DIDR0 - 
.equ	AIN0D	= 0 ; AIN0 Digital Input Disable
.equ	AIN1D	= 1 ; AIN1 Digital Input Disable


; ***** CPU *****************
; CCP - Configuration Change Protection
.equ	CCP0	= 0 ; CCP signature
.equ	CCP1	= 1 ; CCP signature
.equ	CCP2	= 2 ; CCP signature
.equ	CCP3	= 3 ; CCP signature
.equ	CCP4	= 4 ; CCP signature
.equ	CCP5	= 5 ; CCP signature
.equ	CCP6	= 6 ; CCP signature
.equ	CCP7	= 7 ; CCP signature

; SP - Stack Pointer 
.equ	SPH0	= 0 ; Stack Pointer  High Bit 8
.equ	SPH1	= 1 ; Stack Pointer  High Bit 9
.equ	SPH2	= 2 ; Stack Pointer  High Bit 10
.equ	SPH3	= 3 ; Stack Pointer  High Bit 11
.equ	SPH4	= 4 ; Stack Pointer  High Bit 12
.equ	SPH5	= 5 ; Stack Pointer  High Bit 13
.equ	SPH6	= 6 ; Stack Pointer  High Bit 14
.equ	SPH7	= 7 ; Stack Pointer  High Bit 15

.equ	SPL0	= 0 ; Stack Pointer  Low Bit 0
.equ	SPL1	= 1 ; Stack Pointer  Low Bit 1
.equ	SPL2	= 2 ; Stack Pointer  Low Bit 2
.equ	SPL3	= 3 ; Stack Pointer  Low Bit 3
.equ	SPL4	= 4 ; Stack Pointer  Low Bit 4
.equ	SPL5	= 5 ; Stack Pointer  Low Bit 5
.equ	SPL6	= 6 ; Stack Pointer  Low Bit 6
.equ	SPL7	= 7 ; Stack Pointer  Low Bit 7

; SREG - Status Register
.equ	SREG_C	= 0 ; Carry Flag
.equ	SREG_Z	= 1 ; Zero Flag
.equ	SREG_N	= 2 ; Negative Flag
.equ	SREG_V	= 3 ; Two's Complement Overflow Flag
.equ	SREG_S	= 4 ; Sign Bit
.equ	SREG_H	= 5 ; Half Carry Flag
.equ	SREG_T	= 6 ; Bit Copy Storage
.equ	SREG_I	= 7 ; Global Interrupt Enable

; CLKMSR - Clock Main Settings Register
.equ	CLKMS0	= 0 ; Clock Main Select Bits
.equ	CLKMS1	= 1 ; Clock Main Select Bits

; CLKPSR - Clock Prescale Register
.equ	CLKPS0	= 0 ; Clock Prescaler Select Bits
.equ	CLKPS1	= 1 ; Clock Prescaler Select Bits
.equ	CLKPS2	= 2 ; Clock Prescaler Select Bits
.equ	CLKPS3	= 3 ; Clock Prescaler Select Bits

; OSCCAL - Oscillator Calibration Value
.equ	OSCCAL0	= 0 ; Oscillator Calibration Value Bit 0
.equ	OSCCAL1	= 1 ; Oscillator Calibration Value Bit 1
.equ	OSCCAL2	= 2 ; Oscillator Calibration Value Bit 2
.equ	OSCCAL3	= 3 ; Oscillator Calibration Value Bit 3
.equ	OSCCAL4	= 4 ; Oscillator Calibration Value Bit 4
.equ	OSCCAL5	= 5 ; Oscillator Calibration Value Bit 5
.equ	OSCCAL6	= 6 ; Oscillator Calibration Value Bit 6
.equ	OSCCAL7	= 7 ; Oscillator Calibration Value Bit 7

; SMCR - Sleep Mode Control Register
.equ	SE	= 0 ; Sleep Enable
.equ	SM0	= 1 ; Sleep Mode Select Bits
.equ	SM1	= 2 ; Sleep Mode Select Bits
.equ	SM2	= 3 ; Sleep Mode Select Bits

; PRR - Power Reduction Register
.equ	PRTIM0	= 0 ; Power Reduction Timer/Counter0
.equ	PRADC	= 1 ; Power Reduction ADC
.equ	PRUSART	= 2 ; Power Reduction USART

; VLMCSR - Vcc Level Monitoring Control and Status Register
.equ	VLM0	= 0 ; Trigger Level of Voltage Level Monitor bits
.equ	VLM1	= 1 ; Trigger Level of Voltage Level Monitor bits
.equ	VLM2	= 2 ; Trigger Level of Voltage Level Monitor bits
.equ	VLMIE	= 6 ; VLM Interrupt Enable
.equ	VLMF	= 7 ; VLM Flag

; RSTFLR - Reset Flag Register
.equ	PORF	= 0 ; Power-on Reset Flag
.equ	EXTRF	= 1 ; External Reset Flag
.equ	WDRF	= 3 ; Watchdog Reset Flag

; NVMCSR - Non-Volatile Memory Control and Status Register
.equ	NVMBSY	= 7 ; Non-Volatile Memory Busy

; NVMCMD - Non-Volatile Memory Command
.equ	NVMCMD0	= 0 ; Non-Volatile Memory Command Bit 0
.equ	NVMCMD1	= 1 ; Non-Volatile Memory Command Bit 1
.equ	NVMCMD2	= 2 ; Non-Volatile Memory Command Bit 2
.equ	NVMCMD3	= 3 ; Non-Volatile Memory Command Bit 3
.equ	NVMCMD4	= 4 ; Non-Volatile Memory Command Bit 4
.equ	NVMCMD5	= 5 ; Non-Volatile Memory Command Bit 5


; ***** PORTA *****************
; PORTCR - Port Control Register
.equ	BBMA	= 0 ; Break-Before-Make Mode Enable for PORTA
                                 
; PORTA - Data Register, Port A
.equ	PORTA0	= 0	; 
.equ	PA0	= 0	; For compatibility
.equ	PORTA1	= 1	; 
.equ	PA1	= 1	; For compatibility
.equ	PORTA2	= 2	; 
.equ	PA2	= 2	; For compatibility
.equ	PORTA3	= 3	; 
.equ	PA3	= 3	; For compatibility
.equ	PORTA4	= 4	; 
.equ	PA4	= 4	; For compatibility
.equ	PORTA5	= 5	; 
.equ	PA5	= 5	; For compatibility
.equ	PORTA6	= 6	; 
.equ	PA6	= 6	; For compatibility
.equ	PORTA7	= 7	; 
.equ	PA7	= 7	; For compatibility

; DDRA - Data Direction Register, Port A
.equ	DDA0	= 0	; 
.equ	DDA1	= 1	; 
.equ	DDA2	= 2	; 
.equ	DDA3	= 3	; 
.equ	DDA4	= 4	; 
.equ	DDA5	= 5	; 
.equ	DDA6	= 6	; 
.equ	DDA7	= 7	; 

; PINA - Input Pins, Port A
.equ	PINA0	= 0	; 
.equ	PINA1	= 1	; 
.equ	PINA2	= 2	; 
.equ	PINA3	= 3	; 
.equ	PINA4	= 4	; 
.equ	PINA5	= 5	; 
.equ	PINA6	= 6	; 
.equ	PINA7	= 7	; 

; PUEA - Pull Up Enable, Port A
.equ	PUEA0	= 0	; 
.equ	PUEA1	= 1	; 
.equ	PUEA2	= 2	; 
.equ	PUEA3	= 3	; 
.equ	PUEA4	= 4	; 
.equ	PUEA5	= 5	; 
.equ	PUEA6	= 6	; 
.equ	PUEA7	= 7	; 


; ***** PORTB ************************
; PORTB - Data Register, Port B
.equ	PORTB0	= 0	; 
.equ	PB0	= 0	; For compatibility
.equ	PORTB1	= 1	; 
.equ	PB1	= 1	; For compatibility
.equ	PORTB2	= 2	; 
.equ	PB2	= 2	; For compatibility
.equ	PORTB3	= 3	; 
.equ	PB3	= 3	; For compatibility

; DDRB - Data Direction Register, Port B
.equ	DDB0	= 0	; 
.equ	DDB1	= 1	; 
.equ	DDB2	= 2	; 
.equ	DDB3	= 3	; 

; PINB - Input Pins, Port B
.equ	PINB0	= 0	; 
.equ	PINB1	= 1	; 
.equ	PINB2	= 2	; 
.equ	PINB3	= 3	; 

; PUEB - Pull Up Enable, Port B
.equ	PUEB0	= 0	; 
.equ	PUEB1	= 1	; 
.equ	PUEB2	= 2	; 
.equ	PUEB3	= 3	; 



; ***** EXINT *****************
; EICRA - External Interrupt Control Register A
.equ	ISC00	= 0 ; Interrupt Sense Control 0 Bit 0
.equ	ISC01	= 1 ; Interrupt Sense Control 0 Bit 1

; EIMSK - External Interrupt Mask register
.equ	INT0	= 0 ; External Interrupt Request 0 Enable

; EIFR - External Interrupt Flag register
.equ	INTF0	= 0 ; External Interrupt Flag 0

; PCICR - Pin Change Interrupt Control Register
.equ	PCIE0	= 0 ; Pin Change Interrupt Enable 0
.equ	PCIE1	= 1 ; Pin Change Interrupt Enable 1

; PCIFR - Pin Change Interrupt Flag Register
.equ	PCIF0	= 0 ; Pin Change Interrupt Flag 0
.equ	PCIF1	= 1 ; Pin Change Interrupt Flag 1

; PCMSK1 - Pin Change Mask Register 1
.equ	PCINT8	= 0 ; Pin Change Enable Mask 1 Bit 0
.equ	PCINT9	= 1 ; Pin Change Enable Mask 1 Bit 1
.equ	PCINT10	= 2 ; Pin Change Enable Mask 1 Bit 2
.equ	PCINT11	= 3 ; Pin Change Enable Mask 1 Bit 3

; PCMSK0 - Pin Change Mask Register 0
.equ	PCINT0	= 0 ; Pin Change Enable Mask 0 Bit 0
.equ	PCINT1	= 1 ; Pin Change Enable Mask 0 Bit 1
.equ	PCINT2	= 2 ; Pin Change Enable Mask 0 Bit 2
.equ	PCINT3	= 3 ; Pin Change Enable Mask 0 Bit 3
.equ	PCINT4	= 4 ; Pin Change Enable Mask 0 Bit 4
.equ	PCINT5	= 5 ; Pin Change Enable Mask 0 Bit 5
.equ	PCINT6	= 6 ; Pin Change Enable Mask 0 Bit 6
.equ	PCINT7	= 7 ; Pin Change Enable Mask 0 Bit 7


; ***** TC0 *****************
; TCCR0A - Timer/Counter 0 Control Register A
.equ	WGM00	= 0 ; Waveform Generation Mode
.equ	WGM01	= 1 ; Waveform Generation Mode
.equ	COM0B0	= 4 ; Compare Output Mode for Channel B bits
.equ	COM0B1	= 5 ; Compare Output Mode for Channel B bits
.equ	COM0A0	= 6 ; Compare Output Mode for Channel A bits
.equ	COM0A1	= 7 ; Compare Output Mode for Channel A bits

; TCCR0B - Timer/Counter 0 Control Register B
.equ	CS00	= 0 ; Clock Select
.equ	CS01	= 1 ; Clock Select
.equ	CS02	= 2 ; Clock Select
.equ	WGM02	= 3 ; Waveform Generation Mode
.equ	WGM03	= 4 ; Waveform Generation Mode
.equ	ICES0	= 6 ; Input Capture Edge Select
.equ	ICNC0	= 7 ; Input Capture Noise Canceler

; TCCR0C - Timer/Counter 0 Control Register C
.equ	FOC0B	= 6 ; Force Output Compare for Channel B
.equ	FOC0A	= 7 ; Force Output Compare for Channel A

; TCNT0 - Timer/Counter0 
.equ	TCNT0H0	= 0 ; Timer/Counter0  High Bit 8
.equ	TCNT0H1	= 1 ; Timer/Counter0  High Bit 9
.equ	TCNT0H2	= 2 ; Timer/Counter0  High Bit 10
.equ	TCNT0H3	= 3 ; Timer/Counter0  High Bit 11
.equ	TCNT0H4	= 4 ; Timer/Counter0  High Bit 12
.equ	TCNT0H5	= 5 ; Timer/Counter0  High Bit 13
.equ	TCNT0H6	= 6 ; Timer/Counter0  High Bit 14
.equ	TCNT0H7	= 7 ; Timer/Counter0  High Bit 15

.equ	TCNT0L0	= 0 ; Timer/Counter0  Low Bit 0
.equ	TCNT0L1	= 1 ; Timer/Counter0  Low Bit 1
.equ	TCNT0L2	= 2 ; Timer/Counter0  Low Bit 2
.equ	TCNT0L3	= 3 ; Timer/Counter0  Low Bit 3
.equ	TCNT0L4	= 4 ; Timer/Counter0  Low Bit 4
.equ	TCNT0L5	= 5 ; Timer/Counter0  Low Bit 5
.equ	TCNT0L6	= 6 ; Timer/Counter0  Low Bit 6
.equ	TCNT0L7	= 7 ; Timer/Counter0  Low Bit 7

; OCR0A - Timer/Counter 0 Output Compare Register A 
.equ	OCR0AH0	= 0 ; Timer/Counter 0 Output Compare Register A  High Bit 8
.equ	OCR0AH1	= 1 ; Timer/Counter 0 Output Compare Register A  High Bit 9
.equ	OCR0AH2	= 2 ; Timer/Counter 0 Output Compare Register A  High Bit 10
.equ	OCR0AH3	= 3 ; Timer/Counter 0 Output Compare Register A  High Bit 11
.equ	OCR0AH4	= 4 ; Timer/Counter 0 Output Compare Register A  High Bit 12
.equ	OCR0AH5	= 5 ; Timer/Counter 0 Output Compare Register A  High Bit 13
.equ	OCR0AH6	= 6 ; Timer/Counter 0 Output Compare Register A  High Bit 14
.equ	OCR0AH7	= 7 ; Timer/Counter 0 Output Compare Register A  High Bit 15

.equ	OCR0AL0	= 0 ; Timer/Counter 0 Output Compare Register A  Low Bit 0
.equ	OCR0AL1	= 1 ; Timer/Counter 0 Output Compare Register A  Low Bit 1
.equ	OCR0AL2	= 2 ; Timer/Counter 0 Output Compare Register A  Low Bit 2
.equ	OCR0AL3	= 3 ; Timer/Counter 0 Output Compare Register A  Low Bit 3
.equ	OCR0AL4	= 4 ; Timer/Counter 0 Output Compare Register A  Low Bit 4
.equ	OCR0AL5	= 5 ; Timer/Counter 0 Output Compare Register A  Low Bit 5
.equ	OCR0AL6	= 6 ; Timer/Counter 0 Output Compare Register A  Low Bit 6
.equ	OCR0AL7	= 7 ; Timer/Counter 0 Output Compare Register A  Low Bit 7

; OCR0B - Timer/Counter0 Output Compare Register B 
.equ	OCR0BH0	= 0 ; Timer/Counter0 Output Compare Register B  High Bit 8
.equ	OCR0BH1	= 1 ; Timer/Counter0 Output Compare Register B  High Bit 9
.equ	OCR0BH2	= 2 ; Timer/Counter0 Output Compare Register B  High Bit 10
.equ	OCR0BH3	= 3 ; Timer/Counter0 Output Compare Register B  High Bit 11
.equ	OCR0BH4	= 4 ; Timer/Counter0 Output Compare Register B  High Bit 12
.equ	OCR0BH5	= 5 ; Timer/Counter0 Output Compare Register B  High Bit 13
.equ	OCR0BH6	= 6 ; Timer/Counter0 Output Compare Register B  High Bit 14
.equ	OCR0BH7	= 7 ; Timer/Counter0 Output Compare Register B  High Bit 15

.equ	OCR0BL0	= 0 ; Timer/Counter0 Output Compare Register B  Low Bit 0
.equ	OCR0BL1	= 1 ; Timer/Counter0 Output Compare Register B  Low Bit 1
.equ	OCR0BL2	= 2 ; Timer/Counter0 Output Compare Register B  Low Bit 2
.equ	OCR0BL3	= 3 ; Timer/Counter0 Output Compare Register B  Low Bit 3
.equ	OCR0BL4	= 4 ; Timer/Counter0 Output Compare Register B  Low Bit 4
.equ	OCR0BL5	= 5 ; Timer/Counter0 Output Compare Register B  Low Bit 5
.equ	OCR0BL6	= 6 ; Timer/Counter0 Output Compare Register B  Low Bit 6
.equ	OCR0BL7	= 7 ; Timer/Counter0 Output Compare Register B  Low Bit 7

; ICR0 - Input Capture Register  Bytes
.equ	ICR0H0	= 0 ; Input Capture Register  Bytes High Bit 8
.equ	ICR0H1	= 1 ; Input Capture Register  Bytes High Bit 9
.equ	ICR0H2	= 2 ; Input Capture Register  Bytes High Bit 10
.equ	ICR0H3	= 3 ; Input Capture Register  Bytes High Bit 11
.equ	ICR0H4	= 4 ; Input Capture Register  Bytes High Bit 12
.equ	ICR0H5	= 5 ; Input Capture Register  Bytes High Bit 13
.equ	ICR0H6	= 6 ; Input Capture Register  Bytes High Bit 14
.equ	ICR0H7	= 7 ; Input Capture Register  Bytes High Bit 15

.equ	ICR0L0	= 0 ; Input Capture Register  Bytes Low Bit 0
.equ	ICR0L1	= 1 ; Input Capture Register  Bytes Low Bit 1
.equ	ICR0L2	= 2 ; Input Capture Register  Bytes Low Bit 2
.equ	ICR0L3	= 3 ; Input Capture Register  Bytes Low Bit 3
.equ	ICR0L4	= 4 ; Input Capture Register  Bytes Low Bit 4
.equ	ICR0L5	= 5 ; Input Capture Register  Bytes Low Bit 5
.equ	ICR0L6	= 6 ; Input Capture Register  Bytes Low Bit 6
.equ	ICR0L7	= 7 ; Input Capture Register  Bytes Low Bit 7

; TIMSK0 - Timer Interrupt Mask Register 0
.equ	TOIE0	= 0 ; Overflow Interrupt Enable
.equ	OCIE0A	= 1 ; Output Compare A Match Interrupt Enable
.equ	OCIE0B	= 2 ; Output Compare B Match Interrupt Enable
.equ	ICIE0	= 5 ; Input Capture Interrupt Enable

; TIFR0 - Overflow Interrupt Enable
.equ	TOV0	= 0 ; Timer Overflow Flag
.equ	OCF0A	= 1 ; Timer Output Compare Flag 0A
.equ	OCF0B	= 2 ; Timer Output Compare Flag 0B
.equ	ICF0	= 5 ; Input Capture Flag

; GTCCR - General Timer/Counter Control Register
.equ	PSR	= 0 ; Prescaler Reset
.equ	REMAP	= 1 ; Remap Bit for 14 pin part only
.equ	TSM	= 7 ; Timer Synchronization Mode


; ***** WDT *****************
; WDTCSR - Watchdog Timer Control and Status Register
.equ	WDE	= 3 ; Watch Dog Enable
.equ	WDP0	= 0 ; Watchdog Timer Prescaler Bits
.equ	WDP1	= 1 ; Watchdog Timer Prescaler Bits
.equ	WDP2	= 2 ; Watchdog Timer Prescaler Bits
.equ	WDP3	= 5 ; Watchdog Timer Prescaler Bits
.equ	WDIE	= 6 ; Watchdog Timer Interrupt Enable
.equ	WDIF	= 7 ; Watchdog Timer Interrupt Flag


; ***** FUSE *****************
; BYTE0 - 
.equ	RSTDISBL	= 0 ; Disable external reset
.equ	WDTON	= 1 ; Watch dog timer always on
.equ	CKOUT	= 2 ; Output external clock
.equ	SELFPROGEN	= 3 ; Self programming enable


; ***** LOCKBIT *****************
; LOCKBIT - 
.equ	LB1	= 0 ; Memory Lock
.equ	LB2	= 1 ; Memory Lock


; ***** USART *****************
; UDR - USART I/O Data Register
.equ	UDR0	= 0 ; USART I/O Data Register Bit 0
.equ	UDR1	= 1 ; USART I/O Data Register Bit 1
.equ	UDR2	= 2 ; USART I/O Data Register Bit 2
.equ	UDR3	= 3 ; USART I/O Data Register Bit 3
.equ	UDR4	= 4 ; USART I/O Data Register Bit 4
.equ	UDR5	= 5 ; USART I/O Data Register Bit 5
.equ	UDR6	= 6 ; USART I/O Data Register Bit 6
.equ	UDR7	= 7 ; USART I/O Data Register Bit 7

; UCSRA - USART Control and Status Register A
.equ	MPCM	= 0 ; Multi-processor Communication Mode
.equ	U2X	= 1 ; Double the USART transmission speed
.equ	UPE	= 2 ; Parity Error
.equ	DOR	= 3 ; Data overRun
.equ	FE	= 4 ; Framing Error
.equ	UDRE	= 5 ; USART Data Register Empty
.equ	TXC	= 6 ; USART Transmitt Complete
.equ	RXC	= 7 ; USART Receive Complete

; UCSRB - USART Control and Status Register B
.equ	TXB8	= 0 ; Transmit Data Bit 8
.equ	RXB8	= 1 ; Receive Data Bit 8
.equ	UCSZ2	= 2 ; Character Size
.equ	TXEN	= 3 ; Transmitter Enable
.equ	RXEN	= 4 ; Receiver Enable
.equ	UDRIE	= 5 ; USART Data register Empty Interrupt Enable
.equ	TXCIE	= 6 ; TX Complete Interrupt Enable
.equ	RXCIE	= 7 ; RX Complete Interrupt Enable

; UCSRC - USART Control and Status Register C
.equ	UCPOL	= 0 ; Clock Polarity
.equ	UCSZ0	= 1 ; Character Size
.equ	UCSZ1	= 2 ; Character Size
.equ	USBS	= 3 ; Stop Bit Select
.equ	UPM0	= 4 ; Parity Mode Bits
.equ	UPM1	= 5 ; Parity Mode Bits
.equ	UMSEL0	= 6 ; USART Mode Select
.equ	UMSEL1	= 7 ; USART Mode Select

; UCSRD - USART Control and Status Register D
.equ	SFDE	= 5 ; Start frame detection enable
.equ	RXS	= 6 ; USART RX Start Flag
.equ	RXSIE	= 7 ; USART RX Start Interrupt Enable

; UBRR - USART Baud Rate Register  Bytes
.equ	UBRRH0	= 0 ; USART Baud Rate Register  Bytes High Bit 8
.equ	UBRRH1	= 1 ; USART Baud Rate Register  Bytes High Bit 9
.equ	UBRRH2	= 2 ; USART Baud Rate Register  Bytes High Bit 10
.equ	UBRRH3	= 3 ; USART Baud Rate Register  Bytes High Bit 11

.equ	UBRRL0	= 0 ; USART Baud Rate Register  Bytes Low Bit 0
.equ	UBRRL1	= 1 ; USART Baud Rate Register  Bytes Low Bit 1
.equ	UBRRL2	= 2 ; USART Baud Rate Register  Bytes Low Bit 2
.equ	UBRRL3	= 3 ; USART Baud Rate Register  Bytes Low Bit 3
.equ	UBRRL4	= 4 ; USART Baud Rate Register  Bytes Low Bit 4
.equ	UBRRL5	= 5 ; USART Baud Rate Register  Bytes Low Bit 5
.equ	UBRRL6	= 6 ; USART Baud Rate Register  Bytes Low Bit 6
.equ	UBRRL7	= 7 ; USART Baud Rate Register  Bytes Low Bit 7



; ***** LOCKSBITS ********************************************************
.equ	LB1	= 0	; Lockbit
.equ	LB2	= 1	; Lockbit
.equ	NVLB1	= 0	; Lockbit
.equ	NVLB2	= 1	; Lockbit

; Tiny Programming Interface Identification Register
.equ	TPIIR	= 0x0F
; Tiny Programming Interface Physical Layer Control Register
.equ	TPIPCR	= 0x02
; Tiny Programming Interface Status Register
.equ	TPISR	= 0x00



; ; ***** FUSES ************************************************************
; ; LOW fuse bits
; .equ	CKSEL0	= 0	; Select Clock Source
; .equ	CKSEL1	= 1	; Select Clock Source
; .equ	SUT0	= 2	; Select start-up time
; .equ	SUT1	= 3	; Select start-up time
; .equ	CKDIV8	= 4	; Start up with system clock divided by 8
; .equ	WDTON	= 5	; Watch dog timer always on
; .equ	EESAVE	= 6	; Keep EEprom contents during chip erase
; .equ	SPIEN	= 7	; SPI programming enable

; ; HIGH fuse bits
; .equ	RSTDISBL	= 0	; Disable external reset
; .equ	BODLEVEL0	= 1	; Enable BOD and select level
; .equ	BODLEVEL1	= 2	; Enable BOD and select level
; .equ	DWEN	= 3	; DebugWire Enable
; .equ	SELFPRGEN	= 4	; Self Programming Enable



; ***** CPU REGISTER DEFINITIONS *****************************************
.def	XL	= r26
.def	XH	= r27
.def	YL	= r28
.def	YH	= r29
.def	ZL	= r30
.def	ZH	= r31


; ***** DATA MEMORY DECLARATIONS *****************************************
.equ	FLASHSTART	= 0x0000 ; Note: Word address
.equ	FLASHEND	= 0x01FF ; Note: Word address
.equ	FLASHPAGESIZE	= 0x0040 ; Note: Size in words

.equ	SRAM_START	= 0x0040
.equ	SRAM_SIZE	= 32
.equ	RAMEND	= 0x005F

.equ	XRAMEND	= 0x0000

#pragma AVRPART MEMORY PROG_FLASH 1024
#pragma AVRPART MEMORY INT_SRAM SIZE 32
#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x40


; ***** BOOTLOADER DECLARATIONS ******************************************
; No bootloader declariations
 
; ***** INTERRUPT VECTORS ************************************************
.equ	INT0addr	 = 0x0001 ; External Interrupt Request 0
.equ	PCINT0addr	 = 0x0002 ; Pin Change Interrupt Request 0
.equ	PCINT1addr	 = 0x0003 ; Pin Change Interrupt Request 1
.equ	TIM0_CAPTaddr	 = 0x0004 ; Timer/Counter0 Input Capture
.equ	TIM0_OVFaddr	 = 0x0005 ; Timer/Counter0 Overflow
.equ	TIM0_COMPAaddr	 = 0x0006 ; Timer/Counter Compare Match A
.equ	TIM0_COMPBaddr	 = 0x0007 ; Timer/Counter Compare Match B
.equ	ANA_COMPaddr	 = 0x0008 ; Analog Comparator
.equ	WDTaddr	 = 0x0009 ; Watchdog Time-out
.equ	VLMaddr	 = 0x000A ; Vcc Voltage Level Monitor
.equ	ADCaddr	 = 0x000B ; ADC Conversion complete
.equ	USART_RXSaddr	 = 0x000C ; USART RX Start
.equ	USART_RXCaddr	 = 0x000D ; USART RX Complete
.equ	USART_DREaddr	 = 0x000E ; USART Data register empty
.equ	USART_TXCaddr	 = 0x000F ; USART Tx Complete

.equ	INT_VECTORS_SIZE	= 16 ; size in words

#endif  /* _TN104DEF_INC_ */
