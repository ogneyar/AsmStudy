
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

;=============================================================
; defines OLED SSD1306
;=============================================================
#define OLED_WIDTH              128
#define OLED_HEIGHT_32          0x02
#define OLED_HEIGHT_64          0x12
#define OLED_32                 0x1F
#define OLED_64                 0x3F

#define OLED_DISPLAY_OFF        0xAE
#define OLED_DISPLAY_ON         0xAF

#define OLED_COMMAND_MODE       0x00
#define OLED_ONE_COMMAND_MODE   0x80
#define OLED_DATA_MODE          0x40
#define OLED_ARRAY_DATA_MODE    0xC0

#define OLED_ADDRESSING_MODE    0x20
#define OLED_HORIZONTAL         0x00
#define OLED_VERTICAL           0x01

#define OLED_NORMAL_V           0xC8
#define OLED_FLIP_V             0xC0
#define OLED_NORMAL_H           0xA1
#define OLED_FLIP_H             0xA0

#define OLED_CONTRAST           0x81
#define OLED_SETCOMPINS         0xDA
#define OLED_SETVCOMDETECT      0xDB
#define OLED_CLOCKDIV           0xD5
#define OLED_SETMULTIPLEX       0xA8
#define OLED_COLUMNADDR         0x21
#define OLED_PAGEADDR           0x22
#define OLED_CHARGEPUMP         0x8D

#define OLED_NORMALDISPLAY      0xA6
#define OLED_INVERTDISPLAY      0xA7
;=============================================================


#endif  /* _DEFINES_INC_ */
