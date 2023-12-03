include src/head.asm
include src/panel.asm

.data

; msgtw db 'Hello world!!!',10,13
msgtw db 25 dup ('-')
str_title db 'My title in this console',0
stdout dd ?
cWritten dd ?
 
.code

main proc 
LOCAL msg:MSG
local cci:CONSOLE_CURSOR_INFO
    ; invoke FreeConsole
    ; invoke AllocConsole
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout, eax 
    invoke SetConsoleMode, eax, ENABLE_PROCESSED_OUTPUT
    ; задать текстовый атрибут (цвет фона и цвет текста)
    invoke SetConsoleTextAttribute, stdout, 1bh
    ; установить курсор консоли
    invoke SetConsoleCursorPosition, stdout, Y*10000h+X
    ; задать заголовок окна консоли
    invoke SetConsoleTitle, &str_title
    ; вывод текста в консоль
    invoke WriteConsole, stdout, ADDR msgtw, SIZEOF msgtw;, ADDR cWritten, NULL
    invoke SetConsoleTextAttribute, stdout, WHITE
    ; прячем курсор----------------------------------------
    ; invoke GetConsoleCursorInfo, stdout, &cci
    ; lea edx, cci             ; lpConsoleCursorInfo
    ; ; mov [ rdx + CONSOLE_CURSOR_INFO.bVisible ], FALSE
    ; mov [ edx + 4 ], 0
    ; invoke SetConsoleCursorInfo, stdout
    ;------------------------------------------------------
    invoke Sleep, 3000
    ; invoke FreeConsole
    invoke ExitProcess, NULL
main endp

end
