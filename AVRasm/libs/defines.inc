
#ifndef _DEFINES_INC_
#define _DEFINES_INC_

;=============================================================
; defines TWIRE (I2C)
;=============================================================
#define TW_STATUS_MSK		0xf8
#define TW_MAX_ADDRESS		0x80

#define TW_START            0x08
#define TW_RE_START         0x10

#define TW_MT_SLA_ACK       0x18 ; Master Transmit SLA+W Ack
#define TW_MT_SLA_NOACK     0x20 ; Master Transmit SLA+W NoAck
#define TW_MT_DATA_ACK      0x28 ; Master Transmit Data Ack
#define TW_MT_DATA_NOACK    0x30 ; Master Transmit Data NoAck

#define TW_ARBITR_LOST      0x38

#define TW_MR_SLA_ACK       0x40 ; Master Receive SLA+R Ack
#define TW_MR_SLA_NOACK     0x48 ; Master Receive SLA+R NoAck
#define TW_MR_DATA_ACK      0x50 ; Master Receive Data Ack
#define TW_MR_DATA_NOACK    0x58 ; Master Receive Data NoAck
;=============================================================


#endif  /* _DEFINES_INC_ */
