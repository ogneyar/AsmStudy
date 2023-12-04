include src/head.asm
include src/panel.asm
include src/data.asm

.code

main proc 
LOCAL msg:MSG
local cci:CONSOLE_CURSOR_INFO
local csbi:CONSOLE_SCREEN_BUFFER_INFO

    ; invoke FreeConsole
    ; invoke AllocConsole
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout, eax 
    ; invoke SetConsoleMode, eax, ENABLE_PROCESSED_OUTPUT
    ; задать текстовый атрибут (цвет фона и цвет текста)
    invoke SetConsoleTextAttribute, stdout, 1bh
    ; установить курсор консоли
    invoke SetConsoleCursorPosition, stdout, Y*10000h+X
    ; задать заголовок окна консоли
    invoke SetConsoleTitle, &str_title

    ; xor rdx, rdx
    invoke Print_Symbol, stdout, 61h
    invoke Print_Symbol, stdout, 10

    ; вывод текста в консоль
    invoke WriteConsole, stdout, ADDR msgtw, SIZEOF msgtw;, ADDR cWritten, NULL
    ; задать текстовый атрибут (цвет фона и цвет текста)
    invoke SetConsoleTextAttribute, stdout, WHITE

    invoke Print_Symbol, stdout, 10
    
    ; invoke Print_Byte_Bin, stdout,62h
    ; invoke Print_Byte_Hex, stdout,62h
    
    ; lea rdx, cci
    ; mov bl, [ rdx + 4 ]
    ; invoke Print_Byte_Bin, stdout, bl
    ; invoke Print_Symbol, stdout, 10

    
    invoke GetConsoleScreenBufferInfo, stdout, &csbi
    lea rdx, csbi                                   ; терминал  ; консоль

    mov bl, [ rdx + 0 ] ; dwSize.X                ; 11001100b ; 01111000b
    mov dwSize_X, bl
    mov bl, [ rdx + 2 ] ; dwSize.Y                ; 00001011b ; 00101001b
    mov dwSize_Y, bl
    mov bl, [ rdx + 4 ] ; dwCursorPosition.X      ; 00000000b ; 00000000b
    mov dwCursorPosition_X, bl
    mov bl, [ rdx + 6 ] ; dwCursorPosition.Y      ; 00000000b ; 00000000b
    mov dwCursorPosition_Y, bl
    mov bl, [ rdx + 8 ] ; wAttributes             ; 00001111b ; 00001111b
    mov wAttributes, bl
    mov bl, [ rdx + 10 ] ; srWindow.Left          ; 00000000b ; 00000000b
    mov srWindow_Left, bl
    mov bl, [ rdx + 12 ] ; srWindow.Top           ; 00000000b ; 00000000b
    mov srWindow_Top, bl
    mov bl, [ rdx + 14 ] ; srWindow.Right         ; 11001011b ; 01110111b
    mov srWindow_Right, bl
    mov bl, [ rdx + 16 ] ; srWindow.Bottom        ; 00001010b ; 00011101b
    mov srWindow_Bottom, bl
    mov bl, [ rdx + 18 ] ; dwMaximumWindowSize.X  ; 11001100b ; 01111000b
    mov dwMaximumWindowSize_X, bl
    mov bl, [ rdx + 20 ] ; dwMaximumWindowSize.Y  ; 00001011b ; 01000010b
    mov dwMaximumWindowSize_Y, bl

    invoke Print_Byte_Bin, stdout, dwMaximumWindowSize_X
    invoke Print_Symbol, stdout, 10
    

    ; прячем курсор----------------------------------------
    invoke GetConsoleCursorInfo, stdout, &cci
    lea rdx, cci ; lpConsoleCursorInfo
    mov bl, FALSE
    mov [ rdx + 4 ], bl
    ; ; mov [ rdx + CONSOLE_CURSOR_INFO.bVisible ], FALSE
    invoke SetConsoleCursorInfo, stdout, &cci
    ;------------------------------------------------------
    invoke Sleep, 3000
    ; invoke FreeConsole
    invoke ExitProcess, NULL
main endp


end
