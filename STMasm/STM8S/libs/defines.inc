
    #ifdef _DEFINES_INC_
    ; nothing
    #else
    #define _DEFINES_INC_ 1
    
    MOTOROLA

    ;=============================================================
    ; defines OLED SSD1306
    ;=============================================================
    #define OLED_WIDTH              128
    #define OLED_HEIGHT_32          $02
    #define OLED_HEIGHT_64          $12
    #define OLED_32                 $1F
    #define OLED_64                 $3F

    #define OLED_DISPLAY_OFF        $AE
    #define OLED_DISPLAY_ON         $AF

    #define OLED_COMMAND_MODE       $00
    #define OLED_ONE_COMMAND_MODE   $80
    #define OLED_DATA_MODE          $40
    #define OLED_ARRAY_DATA_MODE    $C0

    #define OLED_ADDRESSING_MODE    $20
    #define OLED_HORIZONTAL         $00
    #define OLED_VERTICAL           $01

    #define OLED_NORMAL_V           $C8
    #define OLED_FLIP_V             $C0
    #define OLED_NORMAL_H           $A1
    #define OLED_FLIP_H             $A0

    #define OLED_CONTRAST           $81
    #define OLED_SETCOMPINS         $DA
    #define OLED_SETVCOMDETECT      $DB
    #define OLED_CLOCKDIV           $D5
    #define OLED_SETMULTIPLEX       $A8
    #define OLED_COLUMNADDR         $21
    #define OLED_PAGEADDR           $22
    #define OLED_CHARGEPUMP         $8D

    #define OLED_NORMALDISPLAY      $A6
    #define OLED_INVERTDISPLAY      $A7
    ;=============================================================


    #endif ; _DEFINES_INC_
