.386
.MODEL flat, stdcall

include E:\Program\masm32\include\kernel32.inc ; ExitProcess
includelib E:\Program\masm32\lib\kernel32.lib

STD_OUTPUT_HANDLE EQU -11

.data

consoleOutHandle dd ?
bytesWritten dd ?
message db "Hello World!!!",13,10
lmessage dd 16

.code

main PROC
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov consoleOutHandle, eax
    mov edx, offset message
    pushad
    mov eax, lmessage
    INVOKE WriteConsoleA, consoleOutHandle, edx, eax, offset bytesWritten, 0
    popad
    invoke Sleep, 3000
    INVOKE ExitProcess,0
main ENDP

end main
