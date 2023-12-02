OPTION DOTNAME
; option casemap:none

include temphls.inc
include win64.inc
include kernel32.inc
includelib kernel32.lib

; GENERIC_READ equ 80000000h
; GENERIC_WRITE equ 40000000h
; FILE_SHARE_READ equ 1
; FILE_SHARE_WRITE equ 2
; NULL equ 0
; CONSOLE_TEXTMODE_BUFFER equ 1

.data

msgtw db 'Hello world!!!',10,13
stdout dd ?
cWritten dd ?
hNewScreenBuffer dd ?
; chiBuffer dd ?
chiBuffer dword 200 dup (001b2550h)
coordBufSize dword 001E0078h
coordBufCoord dword 0
srctWriteRect qword 001D007700000000h

SMALL_RECT struct
   dw Left
   dw Top
   dw Right
   dw Bottom
SMALL_RECT ends

CONSOLE_SCREEN_BUFFER_INFO struct
   dword dwSize
   dword dwCursorPosition
   word wAttributes
   qword srWindow
   dword dwMaximumWindowSize
CONSOLE_SCREEN_BUFFER_INFO ends
 

.code

main proc
    LOCAL msg:MSG
    ; LOCAL srctWriteRect:SMALL_RECT
    ; LOCAL screen_buffer_info:CONSOLE_SCREEN_BUFFER_INFO

    ; invoke FreeConsole
    ; invoke AllocConsole
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout, eax 

    ; invoke CreateConsoleScreenBuffer, (GENERIC_READ | GENERIC_WRITE), (FILE_SHARE_READ | FILE_SHARE_WRITE), NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    invoke CreateConsoleScreenBuffer, 0C0000000h, 03h, NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    mov hNewScreenBuffer, eax 
    invoke SetConsoleActiveScreenBuffer, hNewScreenBuffer

    ; invoke GetConsoleScreenBufferInfo, stdout, &screen_buffer_info
    ; lea rbx, screen_buffer_info
    ; add rbx, 80
    ; mov srctWriteRect, rbx
    ; mov srctWriteRect, 001D007700000000h

    invoke WriteConsoleOutput, hNewScreenBuffer, chiBuffer, coordBufSize, coordBufCoord, &srctWriteRect

    ; invoke SetConsoleMode, stdout, ENABLE_PROCESSED_OUTPUT
    ; invoke WriteConsole, stdout, ADDR msgtw, SIZEOF msgtw;, ADDR cWritten, NULL

    invoke Sleep, 3000
    invoke SetConsoleActiveScreenBuffer, stdout
    ; invoke FreeConsole
    invoke ExitProcess, NULL
main endp

end
