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
coordBufSize dd 5002h
coordBufCoord dd 0
srctWriteRect dd 0Ah
 
.code

main proc 
    LOCAL msg:MSG
    LOCAL chiBuffer[160]:dword
    ; LOCAL coordBufSize:dword
    ; LOCAL coordBufCoord:dword
    ; LOCAL srctWriteRect:dd

    ; mov chiBuffer, 06162h
    ; mov coordBufSize, 5002h
    ; mov coordBufCoord, 0

    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout, eax 
    ; invoke CreateConsoleScreenBuffer, (GENERIC_READ | GENERIC_WRITE), (FILE_SHARE_READ | FILE_SHARE_WRITE), NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    invoke CreateConsoleScreenBuffer, 0C0000000h, 03h, NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    mov hNewScreenBuffer, eax 
    invoke SetConsoleActiveScreenBuffer, eax
    invoke WriteConsoleOutput, hNewScreenBuffer, chiBuffer, coordBufSize, coordBufCoord, srctWriteRect

;     invoke SetConsoleMode, eax, ENABLE_PROCESSED_OUTPUT
;     invoke WriteConsole, stdout, ADDR msgtw, SIZEOF msgtw, ADDR cWritten, NULL

    invoke Sleep, 3000
    invoke ExitProcess, NULL
main endp

end
