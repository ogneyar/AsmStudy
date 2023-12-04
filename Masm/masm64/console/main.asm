OPTION DOTNAME
; option casemap:none

include temphls.inc
include win64.inc
include kernel32.inc
includelib kernel32.lib

include print.asm


BLACK   equ 0
BLUE    equ 1
GREEN   equ 2
CYAN    equ 3
RED     equ 4
PURPLE  equ 5
YELLOW  equ 6
SYSTEM  equ 7
GREY    equ 8
BRIGHTBLUE  equ 9
BRIGHTGREEN equ 10
BRIGHTCYAN  equ 11
BRIGHTRED   equ 12
BRIGHTPURPLE equ 13
BRIGHTYELLOW equ 14
WHITE   equ 15

X equ 3
Y equ 10

.data

msgtw db 'Hello world!!!',10,13
str_title db 'My title in this console',0
stdout dd ?
cWritten dd ?
hexArr byte 25 dup (0) ; массив из 25 символов
 
.code

main proc 
LOCAL msg:MSG
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
    
    invoke Print_Byte, stdout, 62h

    invoke Sleep, 3000
    invoke ExitProcess, NULL
main endp

end
