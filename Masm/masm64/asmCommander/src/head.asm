OPTION DOTNAME
; option casemap:none

include temphls.inc
include win64.inc
include kernel32.inc
includelib kernel32.lib

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

CONSOLE_CURSOR_INFO struct
   dword dwSize ; + 0
   byte bVisible ; + 4
CONSOLE_CURSOR_INFO ends


CONSOLE_SCREEN_BUFFER_INFO struct
   dword dwSize ; + 0
   dword dwCursorPosition ; + 4
   word  wAttributes ; + 8
   qword srWindow ; + 10
   dword dwMaximumWindowSize ; + 18
CONSOLE_SCREEN_BUFFER_INFO ends

SMALL_RECT struct
   word Left ; + 0
   word Top ; + 2
   word Right ; + 4
   word Bottom ; + 6
SMALL_RECT ends
