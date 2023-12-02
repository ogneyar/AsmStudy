include win64a.inc
BLACK   equ 0
BLUE    equ 1
GREEN   equ 2
CYAN    equ 3
RED equ 4
PURPLE  equ 5
YELLOW  equ 6
SYSTEM  equ 7
GREY    equ 8
BRIGHTBLUE equ 9
BRIGHTGREEN equ 10
BRIGHTCYAN equ 11
BRIGHTRED equ 12
BRIGHTPURPLE equ 13
BRIGHTYELLOW equ 14
WHITE   equ 15
MAXSCREENX equ 80
MAXSCREENY equ 25
buffersize equ 200
X equ 0
Y equ 10

SMALL_RECT struct
   dw Left
   dw Top
   dw Right
   dw Bottom
SMALL_RECT ends

.data
STR1 db 'Enter line of any symbols and press "Enter":',13,10
STR2 db 'Iczelion''s tutorial #38a',0
hOut dd ?

.code
main proc
    LOCAL msg:MSG
    local LENS:qword ;количество выведенных символов
    local BUFF[buffersize]:byte
    local ConsoleWindow:SMALL_RECT
 
    invoke FreeConsole ;освободить существующую консоль
    invoke AllocConsole ;создать консоль для себя
    invoke GetStdHandle, STD_OUTPUT_HANDLE ;получить handle для вывода
    mov hOut, eax
;     invoke GetLargestConsoleWindowSize, eax
; ;   rax return in 31-16 bits: dwCoord.y
; ;                 15-00 bits: dwCoord.x
;     lea r8d, ConsoleWindow
;     ; and dword ptr [r8+SMALL_RECT.Left],0
;     and dword ptr [r8+0],0
;     sub ax, MAXSCREENX
;     sbb edx, edx
;     and ax, dx
;     add ax, MAXSCREENX-1
;     ; mov [r8+SMALL_RECT.Right],ax
;     mov [r8+8],ax
;     shr eax, 16
;     sub eax, MAXSCREENY
;     sbb edx, edx
;     and eax, edx
;     add eax, MAXSCREENY-1
;     ; mov [r8+SMALL_RECT.Bottom],ax
;     mov [r8+12],ax
;     invoke SetConsoleWindowInfo, hOut, TRUE
;     invoke SetConsoleScreenBufferSize, hOut, MAXSCREENY*10000h+MAXSCREENX ;establish the new size of a window of the console
    invoke SetConsoleTitle, &STR2 ;создать заголовок окна консоли
    invoke SetConsoleCursorPosition, hOut, Y*10000h+X;установить позицию курсора
    invoke SetConsoleTextAttribute, hOut, BRIGHTGREEN ;задать цветовые атрибуты выводимого текста
    invoke WriteConsole, hOut, addr STR1, sizeof STR1, &BUFF, 0 ; вывести строку
    invoke GetStdHandle, STD_INPUT_HANDLE ; получить HANDLE для ввода
    invoke ReadConsole, eax, &BUFF, buffersize, &LENS, 0 ; ждать ввода строки
    invoke SetConsoleTextAttribute, hOut, BRIGHTCYAN ; задать цветовые атрибуты выводимого текста
    invoke WriteConsole, hOut, &BUFF, LENS ; вывести строку
    invoke Sleep, 3000 ; небольшая задержка
    invoke FreeConsole ; закрыть консоль
    invoke ExitProcess, NULL ; завершить программу
main endp

end