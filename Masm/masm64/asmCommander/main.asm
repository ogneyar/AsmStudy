include src/head.asm
include src/data.asm
include src/panel.asm
include src/print.asm
include src/drawLinesHorizontal.asm

.code

main proc 
local msg:MSG
; local screen_buffer[MAXSCREENX * MAXSCREENY]:byte
local BUFF[buffersize]:byte
local cursor_info:CONSOLE_CURSOR_INFO
local left_panel:SAREA_POS
; local lpNewScreenBufferDimensions:COORD

    ; invoke FreeConsole
    ; invoke AllocConsole
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout_handle, eax 

    ; invoke SetConsoleMode, stdout_handle, ENABLE_PROCESSED_OUTPUT
    ; invoke SetConsoleDisplayMode, stdout_handle, CONSOLE_FULLSCREEN_MODE, &lpNewScreenBufferDimensions
    
    ; изменение размера консоли (MAXSCREENX, MAXSCREENY)
    invoke resizeConsole, stdout_handle
    ; изменение заголовка консоли
    invoke SetConsoleTitle, &str_title
    ; изменение текстового атрибута (цвета фона и цвета текста)
    invoke SetConsoleTextAttribute, stdout_handle, 1bh
    ; установка курсора консоли
    invoke SetConsoleCursorPosition, stdout_handle, 0
    
    ; получение информации о screen_buffer_info
    invoke getScreenBufferInfo, stdout_handle

    ; ; установка курсора консоли
    ; invoke SetConsoleCursorPosition, stdout_handle, Y*10000h+X
    ; ; задать текстовый атрибут (цвет фона и цвет текста)
    ; invoke SetConsoleTextAttribute, stdout_handle, WHITE


    ; lea rax, screen_buffer
    ; mov bl, 0cdh ; '═' ; 205
    ; mov [ rax + 256 ], bl


    ; invoke drawPanel, &screen_buffer, left_panel

    call draw

    ; установка курсора консоли в начало
    ; invoke SetConsoleCursorPosition, stdout_handle, 0

    ; invoke printByteBin, stdout_handle, dwSize_X
    ; invoke printSymbol, stdout_handle, 10

    ; invoke SetConsoleCP, CP_UTF8
    
    invoke WriteConsole, stdout_handle, ADDR screen_buffer, SIZEOF screen_buffer

    ; установка курсора консоли в начало
    invoke SetConsoleCursorPosition, stdout_handle, 0

    ; прячем курсор ----------------------------------------
    invoke GetConsoleCursorInfo, stdout_handle, &cursor_info
    lea rdx, cursor_info
    mov bl, FALSE
    mov [ rdx + 4 ], bl
    ; ; mov [ rdx + CONSOLE_CURSOR_INFO.bVisible ], FALSE
    invoke SetConsoleCursorInfo, stdout_handle, &cursor_info
    ;-------------------------------------------------------

    ; ожидание ввода текста -----------------------------------------
    invoke GetStdHandle, STD_INPUT_HANDLE ; получить HANDLE для ввода
    invoke ReadConsole, eax, &BUFF, buffersize ; вместо invoke Sleep
    ;-----------------------------------------------------------------

    ; invoke FreeConsole
    invoke ExitProcess, NULL
main endp


end
