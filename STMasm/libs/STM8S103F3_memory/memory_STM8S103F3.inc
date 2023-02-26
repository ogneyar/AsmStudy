
; STM8S103F3 memory map

; 1024 bytes / 1 kbytes of SRAM
$0000  xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx    
  .
$01F0  xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx
; STACK START
$01FF  xx
$0200  xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx    
  .
$03F0  xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx      ; $03FF RAM END

; 15360 reserved bytes ($90 is prefix to opcode for STM8)
$0400  90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90  
  .
$3FF0  90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90      ; $3FFF

; 640 bytes nonvolatile EEPROM
$4000  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      
  .
$4270  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $427F EEPROM END

; 1408 reserved bytes ($71 is illegal opcode for STM8)
$4280  71 71 71 71 71 71 71 71 71 71 71 71 71 71 71 71  
  . 
$47F0  71 71 71 71 71 71 71 71 71 71 71 71 71 71 71 71      ; $47FF 

; OPTION bytes area
$4800  00  OPT0           ; ROP - Read-out protection 
$4801  00  OPT1           ; UBC - User boot code 
$4802  FF  NOPT1          ; NUBC
$4803  00  OPT2           ; AFR - Alternate function remapping
$4804  FF  NOPT2          ; NAFR
$4805  00  OPT3           ; Misc. option
$4806  FF  NOPT3          ; 
$4807  00  OPT4           ; Clock option
$4808  FF  NOPT4          ; 
$4809  00  OPT5           ; HSE clock startup
$480A  FF  NOPT5          ;
; Reserved area (53 bytes nonvolatile EEPROM available for writing / reading)
$480B  00 00 00 00 00  
$4810  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
$4820  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  
$4830  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $483F OPTION END 

; 20 reserved bytes different for different STM8S103F3  
$4840  0C F3             ; complementary pair
$4842  12 ED             ; complementary pair
$4844  0C F3             ; complementary pair
$4846  DD 22             ; complementary pair
$4848  7A 85             ; complementary pair
$484A  49 B6             ; complementary pair
$484C  01 FE             ; complementary pair
$484E  10 EF             ; complementary pair  
$4850  01 FE             ; complementary pair
$4852  0C F3             ; complementary pair 
; 12 reserved bytes the same for the different STM8S103F3
$4854  00 00 00 00 00 00 00 00 00 00 00 00                  ; $485F      ?
; 5 reserved bytes different for different STM8S103F3 
$4860  66 00 1F 68 00                                       ; $4864      ?
      (5D 00 1F 62 00)
      (5C 00 1F 5F 00)
; 12 bytes Unique ID different for different STM8S103F3 
$4865  00 (00) (00)      ; U_ID[7:0]    X co-ordinate on the wafer
$4866  2A (16) (2B)      ; U_ID[15:8]   X co-ordinate on the wafer
$4867  00 (00) (00)      ; U_ID[23:16]  Y co-ordinate on the wafer
$4868  08 (0F) (28)      ; U_ID[31:24]  Y co-ordinate on the wafer
$4869  11 (01) (11)      ; U_ID[39:32]  Wafer number
$486A  47 (47) (47)      ; U_ID[47:40]  Lot number
$486B  36 (36) (36)      ; U_ID[55:48]  Lot number
$486C  34 (34) (34)      ; U_ID[63:56]  Lot number
$486D  37 (32) (37)      ; U_ID[71:64]  Lot number
$486E  34 (34) (34)      ; U_ID[79:72]  Lot number
$486F  31 (31) (31)      ; U_ID[87:80]  Lot number
$4870  31 (35) (31)      ; U_ID[95:88]  Lot number 
; 15 reserved bytes the same for the different STM8S103F3
$4871  1F 00 00 1F 00 00 00 00 00 00 00 00 00 00 00         ; $487F

; 1916 reserved bytes ($90 is prefix to opcode for STM8)
$4880  90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
  .
$4FE0  90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
$4FF0  90 90 90 90 90 90 90 90 90 90 90 90                  ; $4FFB
; 4 reserved bytes the same for the different STM8S103F3
$4FFC  67 67 10 03       ;   ?                              ; $4FFF 

; GPIO and periph. (HW) registers
$5000  00  PA_ODR        ; Port A data output latch register
$5001  0A  PA_IDR        ; Port A input pin value register
$5002  00  PA_DDR        ; Port A data direction register
$5003  00  PA_CR1        ; Port A control register 1
$5004  00  PA_CR2        ; Port A control register 2
$5005  00  PB_ODR        ; Port B data output latch register
$5006  00  PB_IDR        ; Port B input pin value register
$5007  20  PB_DDR        ; Port B data direction register
$5008  20  PB_CR1        ; Port B control register 1
$5009  00  PB_CR2        ; Port B control register 2
$500A  00  PC_ODR        ; Port C data output latch register
$500B  80  PC_IDR        ; Port C input pin value register
$500C  00  PC_DDR        ; Port C data direction register
$500D  00  PC_CR1        ; Port C control register 1
$500E  00  PC_CR2        ; Port C control register 2
$500F  00  PD_ODR        ; Port D data output latch register
$5010  56  PD_IDR        ; Port D input pin value register
$5011  00  PD_DDR        ; Port D data direction register
$5012  02  PD_CR1        ; Port D control register 1
$5013  00  PD_CR2        ; Port D control register 2
; Reserved area (60 bytes)
$5014  00 00 00 00 00 00 00 00 00 00 00 00
$5020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
$5030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
$5040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $504F
; Reserved area (10 bytes)
$5050  0C F3             ; complementary pair
$5052  12 ED             ; complementary pair
$5054  0C F3             ; complementary pair
$5056  DD 22             ; complementary pair
$5058  7A 85             ; complementary pair
; FLASH registers
$505A  00  FLASH_CR1     ; Flash control register 1
$505B  00  FLASH_CR2     ; Flash control register 2
$505C  FF  FLASH_NCR2    ; Flash complementary control register 2
$505D  00  FLASH_FPR     ; Flash protection register
$505E  FF  FLASH_NFPR    ; Flash complementary protection register
$505F  40  FLASH_IAPSR   ; Flash in-application programming status register
$5060  49                ; reserved
$5061  B6                ; reserved
$5062  00  FLASH_PUKR    ; Flash Program memory unprotection register
$5063  00                ; reserved
$5064  00  FLASH_DUKR    ; Data EEPROM unprotection register
$5065  00                ; reserved 
$5066  00                ; reserved 
; Reserved area (16 bytes)
$5067  00 FF             ; complementary pair
$5069  00 FF             ; complementary pair  
$506B  00 FF             ; complementary pair 
$506D  00 FF             ; complementary pair
$506F  01 FE             ; complementary pair 
$5071  10 EF             ; complementary pair
$5073  01 FE             ; complementary pair 
$5075  0C F3             ; complementary pair
; Reserved area (41 bytes)
$5077  00 00 00 00 00 00 00 00 00  
$5080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
$5090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $509F

$50A0  00  EXTI_CR1      ; External interrupt control register 1
$50A1  00  EXTI_CR2      ; External interrupt control register 2
; Reserved area (17 bytes)
$50A2  00 00 00 00 00 00 00 00 00 00 00 00 00 00            ; $50AF 
$50B0  00 00 00                                             ; $50B2
$50B3  00  RST_SR        ; Reset status register 1
; Reserved area (12 bytes)
$50B4  00 00 00 00 00 00 00 00 00 00 00 00                  ; $50BF 
$50C0  13  CLK_ICKR      ; Internal clock control register
$50C1  00  CLK_ECKR      ; External clock control register
$50C2  00                ; reserved 
$50C3  E1  CLK_CMSR      ; Clock master status register
$50C4  E1  CLK_SWR       ; Clock master switch register
$50C5  00  CLK_SWCR      ; Clock switch control register
$50C6  18  CLK_CKDIVR    ; Clock divider register
$50C7  FF  CLK_PCKENR1   ; Peripheral clock gating register 1
$50C8  00  CLK_CSSR      ; Clock security system register
$50C9  00  CLK_CCOR      ; Configurable clock control register
$50CA  FF  CLK_PCKENR2   ; Peripheral clock gating register 2
$50CB  00  CLK_CANCCR    ; CAN clock control register
$50CC  00  CLK_HSITRIMR  ; HSI clock calibration trimming register
$50CD  00  CLK_SWIMCCR   ; SWIM clock control register
$50CE  00                ; reserved 
$50CF  00                ; reserved 
$50D0  00                ; reserved 
$50D1  68  WWDG_CR       ; WWDG Control Register
$50D2  7F  WWDG_WR       ; WWDR Window Register
; Reserved area (13 bytes)
$50D3  00 00 00 00 00 00 00 00 00 00 00 00 00               ; $50DF 
$50E0  00  IWDG_KR       ; IWDG Key Register
$50E1  00  IWDG_PR       ; IWDG Prescaler Register
$50E2  FF  IWDG_RLR      ; IWDG Reload Register
; Reserved area (13 bytes)
$50E3  00 00 00 00 00 00 00 00 00 00 00 00 00               ; $50EF 
$50F0  00  AWU_CSR       ; AWU Control/Status Register
$50F1  3F  AWU_APR       ; AWU asynchronous prescaler buffer register
$50F2  00  AWU_TBR       ; AWU Timebase selection register
$50F3  1F  BEEP_CSR      ; BEEP Control/Status Register
; Reserved area (268 bytes)
$50F4  00 00 00 00 00 00 00 00 00 00 00 00 
$5100  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  .
$51F0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $51FF
; SPI registers
$5200  00  SPI_CR1       ; SPI Control Register 1
$5201  00  SPI_CR2       ; SPI Control Register 2
$5202  00  SPI_ICR       ; SPI Interrupt Control Register
$5203  02  SPI_SR        ; SPI Status Register
$5204  00  SPI_DR        ; SPI Data Register
$5205  07  SPI_CRCPR     ; SPI CRC Polynomial Register
$5206  00  SPI_RXCRCR    ; SPI Rx CRC Register
$5207  00  SPI_TXCRCR    ; SPI Tx CRC Register
; Reserved area (8 bytes)
$5208  00 00 00 00 00 00 00 00                              ; $520F 
; I2C registers
$5210  00  I2C_CR1       ; I2C control register 1
$5211  00  I2C_CR2       ; I2C control register 2
$5212  00  I2C_FREQR     ; I2C frequency register
$5213  00  I2C_OARL      ; I2C Own address register low
$5214  00  I2C_OARH      ; I2C Own address register high
$5215  00                ; reserved  
$5216  00  I2C_DR        ; I2C data register
$5217  00  I2C_SR1       ; I2C status register 1
$5218  00  I2C_SR2       ; I2C status register 2
$5219  02  I2C_SR3       ; I2C status register 3
$521A  00  I2C_ITR       ; I2C interrupt control register
$521B  00  I2C_CCRL      ; I2C Clock control register low
$521C  00  I2C_CCRH      ; I2C Clock control register high
$521D  02  I2C_TRISER    ; I2C TRISE register
$521E  00  I2C_PECR      ; I2C packet error checking register
; Reserved area (17 bytes)
$521F  00
$5220  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $522F 
; UART1 registers
$5230  90  UART1_SR      ; UART1 Status Register
$5231  00  UART1_DR      ; UART1 Data Register
$5232  01  UART1_BRR1    ; UART1 Baud Rate Register 1
$5233  02  UART1_BRR2    ; UART1 Baud Rate Register 2
$5234  00  UART1_CR1     ; UART1 Control Register 1
$5235  0C  UART1_CR2     ; UART1 Control Register 2
$5236  00  UART1_CR3     ; UART1 Control Register 3
$5237  00  UART1_CR4     ; UART1 Control Register 4
$5238  00  UART1_CR5     ; UART1 Control Register 5
$5239  00  UART1_GTR     ; UART1 Guard time Register
$523A  00  UART1_PSCR    ; UART1 Prescaler Register
; Reserved area (21 bytes)
$523B  00 00 00 00 00 
$5240  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ; $524F
; TIM1 registers
$5250  00  TIM1_CR1      ; TIM1 Control register 1
$5251  00  TIM1_CR2      ; TIM1 Control register 2
$5252  00  TIM1_SMCR     ; TIM1 Slave Mode Control register
$5253  00  TIM1_ETR      ; TIM1 external trigger register
$5254  00  TIM1_IER      ; TIM1 Interrupt enable register
$5255  00  TIM1_SR1      ; TIM1 Status register 1
$5256  00  TIM1_SR2      ; TIM1 Status register 2
$5257  00  TIM1_EGR      ; TIM1 Event Generation register
$5258  00  TIM1_CCMR1    ; TIM1 Capture/Compare mode register 1
$5259  00  TIM1_CCMR2    ; TIM1 Capture/Compare mode register 2
$525A  00  TIM1_CCMR3    ; TIM1 Capture/Compare mode register 3
$525B  00  TIM1_CCMR4    ; TIM1 Capture/Compare mode register 4
$525C  00  TIM1_CCER1    ; TIM1 Capture/Compare enable register 1
$525D  00  TIM1_CCER2    ; TIM1 Capture/Compare enable register 2
$525E  00  TIM1_CNTRH    ; Data bits High
$525F  00  TIM1_CNTRL    ; Data bits Low
$5260  00  TIM1_PSCRH    ; Data bits High
$5261  00  TIM1_PSCRL    ; Data bits Low
$5262  FF  TIM1_ARRH     ; Data bits High
$5263  FF  TIM1_ARRL     ; Data bits Low
$5264  00  TIM1_RCR      ; TIM1 Repetition counter register
$5265  00  TIM1_CCR1H    ; Data bits High
$5266  00  TIM1_CCR1L    ; Data bits Low
$5267  00  TIM1_CCR2H    ; Data bits High
$5268  00  TIM1_CCR2L    ; Data bits Low
$5269  00  TIM1_CCR3H    ; Data bits High
$526A  00  TIM1_CCR3L    ; Data bits Low
$526B  00  TIM1_CCR4H    ; Data bits High
$526C  00  TIM1_CCR4L    ; Data bits Low
$526D  00  TIM1_BKR      ; TIM1 Break register
$526E  00  TIM1_DTR      ; TIM1 Dead-time register
$526F  00  TIM1_OISR     ; TIM1 Output idle state register
; Reserved area (144 bytes)
$5270  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  .
$52FF  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ; $52FF
; TIM2 registers
$5300  00  TIM2_CR1      ; TIM2 Control register 1
$5301  00                ; reserved 
$5302  00                ; reserved 
$5303  00  TIM2_IER      ; TIM2 Interrupt enable register
$5304  00  TIM2_SR1      ; TIM2 Status register 1
$5305  00  TIM2_SR2      ; TIM2 Status register 2
$5306  00  TIM2_EGR      ; TIM2 Event Generation register
$5307  00  TIM2_CCMR1    ; TIM2 Capture/Compare mode register 1
$5308  00  TIM2_CCMR2    ; TIM2 Capture/Compare mode register 2
$5309  00  TIM2_CCMR3    ; TIM2 Capture/Compare mode register 3
$530A  00  TIM2_CCER1    ; TIM2 Capture/Compare enable register 1
$530B  00  TIM2_CCER2    ; TIM2 Capture/Compare enable register 2
$530C  00  TIM2_CNTRH    ; Data bits High
$530D  00  TIM2_CNTRL    ; Data bits Low
$530E  00  TIM2_PSCR     ; TIM2 Prescaler register
$530F  FF  TIM2_ARRH     ; Data bits High
$5310  FF  TIM2_ARRL     ; Data bits Low
$5311  00  TIM2_CCR1H    ; Data bits High
$5312  00  TIM2_CCR1L    ; Data bits Low
$5313  00  TIM2_CCR2H    ; Data bits High
$5314  00  TIM2_CCR2L    ; Data bits Low
$5315  00  TIM2_CCR3H    ; Data bits High
$5316  00  TIM2_CCR3L    ; Data bits Low
; Reserved area (41 bytes)
$5317  00 00 00 00 00 00 00 00 00 00 00
$5320  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
$5330  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ; $533F
; TIM4 registers
$5340  00  TIM4_CR1      ; TIM4 Control register 1
$5341  00                ; reserved 
$5342  00                ; reserved 
$5343  00  TIM4_IER      ; TIM4 Interrupt enable regist
$5344  00  TIM4_SR       ; TIM4 Status register
$5345  00  TIM4_EGR      ; TIM4 Event Generation regist
$5346  00  TIM4_CNTR     ; TIM4 Counter
$5347  00  TIM4_PSCR     ; TIM4 Prescaler register
$5348  FF  TIM4_ARR      ; TIM4 Auto-reload register
; Reserved area (153 bytes)
$5349  00 00 00 00 00 00 00
$5350  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  .  
$53D0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ; $53DF
; ADC registers
$53E0  00  ADC_DB0RH     ; Data Buffer register 0 High
$53E1  00  ADC_DB0RL     ; Data Buffer register 0 Low
$53E2  00  ADC_DB1RH     ; Data Buffer register 1 High
$53E3  00  ADC_DB1RL     ; Data Buffer register 1 Low
$53E4  00  ADC_DB2RH     ; Data Buffer register 2 High
$53E5  00  ADC_DB2RL     ; Data Buffer register 2 Low
$53E6  00  ADC_DB3RH     ; Data Buffer register 3 High
$53E7  00  ADC_DB3RL     ; Data Buffer register 3 Low
$53E8  00  ADC_DB4RH     ; Data Buffer register 4 High
$53E9  00  ADC_DB4RL     ; Data Buffer register 4 Low
$53EA  00  ADC_DB5RH     ; Data Buffer register 5 High
$53EB  00  ADC_DB5RL     ; Data Buffer register 5 Low
$53EC  00  ADC_DB6RH     ; Data Buffer register 6 High
$53ED  00  ADC_DB6RL     ; Data Buffer register 6 Low
$53EE  00  ADC_DB7RH     ; Data Buffer register 7 High
$53EF  00  ADC_DB7RL     ; Data Buffer register 7 Low
$53F0  00  ADC_DB8RH     ; Data Buffer register 8 High
$53F1  00  ADC_DB8RL     ; Data Buffer register 8 Low
$53F2  00  ADC_DB9RH     ; Data Buffer register 9 High
$53F3  00  ADC_DB9RL     ; Data Buffer register 9 Low
; Reserved area (12 bytes)
$53F4  00 00 00 00 00 00 00 00 00 00 00 00                  ; $53FF
$5400  00  ADC_CSR       ; ADC Control/Status Register
$5401  00  ADC_CR1       ; ADC Configuration Register 1
$5402  00  ADC_CR2       ; ADC Configuration Register 2
$5403  00  ADC_CR3       ; ADC Configuration Register 3
$5404  B0  ADC_DRH       ; Data bits High
$5405  01  ADC_DRL       ; Data bits Low
$5406  00  ADC_TDRH      ; Schmitt trigger disable High
$5407  00  ADC_TDRL      ; Schmitt trigger disable Low
$5408  FF  ADC_HTRH      ; High Threshold Register High
$5409  03  ADC_HTRL      ; High Threshold Register Low
$540A  00  ADC_LTRH      ; Low Threshold Register High
$540B  00  ADC_LTRL      ; Low Threshold Register Low
$540C  00  ADC_AWSRH     ; Analog Watchdog Status register High
$540D  00  ADC_AWSRL     ; Analog Watchdog Status register Low
$540E  00  ADC_AWCRH     ; Analog Watchdog Control register High
$540F  00  ADC_AWCRL     ; Analog Watchdog Control register Low  
; Reserved area (1008 bytes)
$5410  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  
  .    
$57FF  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ; $57FF  HW registers END

; 1 reserved byte the same for the different STM8S103F3
$5800  00                ;   ? 

; 2047 reserved bytes ($80 is opcode of IRET for STM8)
$5801  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80  
$5810  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80  
  .  
$5FF0  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80       ; $5FFF  

; 2048 reserved bytes ($71 is illegal opcode for STM8)
; BOOT ROM START for some STM8 
$6000  71 71 71 71 71 71 71 71 71 71 71 71 71 71 71 71                          
  .
$67F0  71 71 71 71 71 71 71 71 71 71 71 71 71 71 71 71       ; $67FF  BOOT ROM END

; 5984 reserved bytes ($80 is opcode of IRET for STM8)
$6800  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80     
  .  
$7F50  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80       ; $7F5F  
  
$7F60  00  CFG_GCR       ; CFG Global configuration register
$7F61  00                ; reserved
$7F62  00                ; reserved
  .
$7F6E  00                ; reserved
$7F6F  00                ; reserved
$7F70  FF  ITC_SPR1      ; Interrupt Software priority register 1
$7F71  FF  ITC_SPR2      ; Interrupt Software priority register 2
$7F72  FF  ITC_SPR3      ; Interrupt Software priority register 3
$7F73  FF  ITC_SPR4      ; Interrupt Software priority register 4
$7F74  FF  ITC_SPR5      ; Interrupt Software priority register 5
$7F75  FF  ITC_SPR6      ; Interrupt Software priority register 6
$7F76  FF  ITC_SPR7      ; Interrupt Software priority register 7
$7F77  FF                ; reserved
$7F78  00                ; reserved
$7F79  00                ; reserved
  .
$7F7E  00                ; reserved
$7F7F  00                ; reserved

; 128 reserved bytes ($80 is opcode of IRET for STM8)
$7F80  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 
  .
$7FF0  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80       ; $7FFF

; 8192 bytes / 8 kbytes of FLASH program memory
; 32 interrupt vectors
$8000  82 00 80 80 82 00 80 B3 82 00 80 B3 82 00 80 B3
$8010  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3   
$8020  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3   
$8030  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3   
$8040  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3   
$8050  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3   
$8060  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3   
$8070  82 00 80 B3 82 00 80 B3 82 00 80 B3 82 00 80 B3       ; $807F   INTERRUPT VECTORS END
$8080  72 1A 50 07 72 1A 50 08 A6 02 C7 52 33 A6 01 C7
$8090  52 32 72 16 52 35 72 14 52 35 72 0B 52 30 FB C6   
$80A0  52 31 AE 00 00 F6 C7 52 31 72 0F 52 30 FB 5C 26   
$80B0  F4 20 E7 80 00 00 00 00 00 00 00 00 00 00 00 00   
$80C0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
  .     
$9FF0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00       ; $9FFF   FLASH END

; 24576 reserved bytes ($80 is opcode of IRET for STM8)
$A000  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80  
  .
$FFF0  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80       ; $FFFF
; Reserved area
$010000  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80  
  .
$027FF0  80 80 80 80 80 80 80 80 80 80 80 80 80 80 80 80       ; $027FFF