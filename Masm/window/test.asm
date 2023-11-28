.386p
.model flat, stdcall
ifdef MASM
    ; MASM
    extern ExitProcess@4:near
    extern MessageBoxA@16:near
    includelib E:\Program\masm32\lib\kernel32.lib
    includelib E:\Program\masm32\lib\user32.lib
else
    ; TASM
    extern ExitProcess:near
    extern MessageBoxA:near
    includelib E:\Program\tasm32\lib\import32.lib
    ExitProcess@4 = ExitProcess
    MessageBoxA@16 = MessageBoxA
endif
;-----------------------------------------------------------
_data segment dword public use32 'data'
    titleWindow db 'Title',0
    messageWindow db 'Test program',0
_data ends

_text segment dword public use32 'code'
start:
    push 03
    push offset titleWindow
    push offset messageWindow
    push 0
    call MessageBoxA@16
    ;-----------------------------------
    push 0
    call ExitProcess@4
_text ends
end start