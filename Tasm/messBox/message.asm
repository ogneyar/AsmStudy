; .386P
; плоская модель
; .MODEL FLAT, STDCALL


.8086
; .386
.model small;flat;


; includelib kernel32.lib
;    extrn __imp__GetModuleHandleA@4:dword
;    extrn __imp__ExitProcess@4:dword
; ExitProcess     equ __imp__ExitProcess@4
; GetModuleHandle equ __imp__GetModuleHandleA@4

; includelib IMPORT32.LIB
; includelib user32.lib
include user32.inc
; include WINDOWS.INC
extrn MessageBoxA:PROC
; EXTERN MessageBoxA
.code
   
    start:
        mov ax, DGROUP
        mov ds, ax
        push 0105h
        push offset wTitle   
        push offset Message
        push ax
        call MessageBoxA
        ; call ExitProcess
    ; ret 
    
; wTitle  db 'Iczelion Tutorial #2:MessageBox',0
; Message db 'Win32 Assembly with tasm is Great!',0
; ends

.data
    wTitle  db 'Iczelion Tutorial #2:MessageBox',0
    Message db 'Win32 Assembly with tasm is Great!',0

.stack 100h

end start
