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
chiBuffer dword 120 dup (001b0061h)
coordBufSize dword 00500002h
coordBufCoord dd 0
; srctWriteRect dd 0Ah

SMALL_RECT struct
   dw Left
   dw Top
   dw Right
   dw Bottom
SMALL_RECT ends
 
.code

main proc
    LOCAL msg:MSG
    ; LOCAL srctWriteRect:SMALL_RECT

    invoke FreeConsole
    invoke AllocConsole
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout, eax 
    
    ; invoke CreateConsoleScreenBuffer, (GENERIC_READ | GENERIC_WRITE), (FILE_SHARE_READ | FILE_SHARE_WRITE), NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    ; invoke CreateConsoleScreenBuffer, 0C0000000h, 03h, NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    ; mov hNewScreenBuffer, eax 
    ; invoke SetConsoleActiveScreenBuffer, hNewScreenBuffer
    ; invoke WriteConsoleOutput, hNewScreenBuffer, chiBuffer, coordBufSize, coordBufCoord, &srctWriteRect

    ; invoke SetConsoleMode, eax, ENABLE_PROCESSED_OUTPUT
    invoke WriteConsole, stdout, ADDR msgtw, SIZEOF msgtw;, ADDR cWritten, NULL

    invoke Sleep, 3000
    invoke SetConsoleActiveScreenBuffer, stdout
    invoke FreeConsole
    invoke ExitProcess, NULL
main endp

end
