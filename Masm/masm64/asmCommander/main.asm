include src/head.asm
include src/data.asm
include src/utils.asm
include src/panel.asm
include src/print.asm
include src/drawSymbols.asm
include src/drawLinesHorizontal.asm
include src/drawLinesVertical.asm
include src/drawTheTexts.asm

.code

main proc 

local msg:MSG
local read_buffer[buffersize]:byte
local cursor_info:CONSOLE_CURSOR_INFO

    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout_handle, eax 
    
    ; изменение размера консоли (MAXSCREENX, MAXSCREENY)
    invoke resizeConsole, stdout_handle       
    ; получение информации о screen_buffer_info
    invoke getScreenBufferInfo, stdout_handle

    ; формирование буфера консоли - screen_buffer    
    call draw

    ; установка курсора консоли в начало
    invoke SetConsoleCursorPosition, stdout_handle, 0

    ; прячем курсор ----------------------------------------
    invoke GetConsoleCursorInfo, stdout_handle, &cursor_info
    lea rdx, cursor_info
    mov bl, FALSE
    mov [ rdx + 4 ], bl ; rdx + CONSOLE_CURSOR_INFO.bVisible
    invoke SetConsoleCursorInfo, stdout_handle, &cursor_info
    ;-------------------------------------------------------

    ; ожидание ввода текста -----------------------------------------
    invoke GetStdHandle, STD_INPUT_HANDLE ; получить HANDLE для ввода
    invoke ReadConsole, eax, &read_buffer, buffersize ; вместо invoke Sleep
    ;-----------------------------------------------------------------

    invoke ExitProcess, NULL

main endp

end
