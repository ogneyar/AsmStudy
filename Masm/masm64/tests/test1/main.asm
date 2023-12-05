OPTION DOTNAME
; option casemap:none

include temphls.inc
include win64.inc
include kernel32.inc
includelib kernel32.lib

; GENERIC_READ equ 80000000h
; GENERIC_WRITE equ 40000000h
GENERIC equ 0C0000000h
; FILE_SHARE_READ equ 1
; FILE_SHARE_WRITE equ 2
FILE_SHARE equ 3
NULL equ 0
CONSOLE_TEXTMODE_BUFFER equ 1

.data

msgtw db 'Hello world!!!',10,13
std_out_handle dd ?
screen_buffer_handle dd ?
screen_buffer dword 5000 dup (001b2554h)
coordBufCoord dword 0
screen_buffer_size dword ?
; dwSize dword ?
hexArr byte 25 dup (0) ; массив из 25 символов


SMALL_RECT struct
   word Left
   word Top
   word Right
   word Bottom
SMALL_RECT ends

CONSOLE_SCREEN_BUFFER_INFO struct
   dword dwSize
   dword dwCursorPosition
   word wAttributes
   qword srWindow
   dword dwMaximumWindowSize
CONSOLE_SCREEN_BUFFER_INFO ends

COORD struct
   word X
   word Y
COORD ends


.code

main proc
    LOCAL msg:MSG
    LOCAL srWindow:SMALL_RECT
    LOCAL dwSize:COORD
    LOCAL screen_buffer_info:CONSOLE_SCREEN_BUFFER_INFO

    ; invoke FreeConsole
    ; invoke AllocConsole
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov std_out_handle, eax 
    
    invoke SetConsoleMode, std_out_handle, ENABLE_PROCESSED_OUTPUT

    ; invoke CreateConsoleScreenBuffer, (GENERIC_READ | GENERIC_WRITE), (FILE_SHARE_READ | FILE_SHARE_WRITE), NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    invoke CreateConsoleScreenBuffer, GENERIC, FILE_SHARE, NULL, CONSOLE_TEXTMODE_BUFFER, NULL    
    mov screen_buffer_handle, eax 
    invoke SetConsoleActiveScreenBuffer, screen_buffer_handle
    
    invoke GetConsoleScreenBufferInfo, screen_buffer_handle, &screen_buffer_info
    lea rdx, screen_buffer_info                   ; терминал  ; консоль

    xor rax, rax
    xor rbx, rbx
    mov bx, [ rdx + 0 ] ; dwSize.X                ; 11001100b ; 01111000b
    mov ax, [ rdx + 2 ] ; dwSize.Y                ; 00001011b ; 00101001b

    movzx rcx, ax
    shl rcx, 16
    or rcx, rbx
    mov dwSize, ecx

    add ax, bx
    mov screen_buffer_size, eax

    mov bl, [ rdx + 4 ] ; dwCursorPosition.X      ; 00000000b ; 00000000b
    mov bl, [ rdx + 6 ] ; dwCursorPosition.Y      ; 00000000b ; 00000000b
    mov bl, [ rdx + 8 ] ; wAttributes             ; 00001111b ; 00001111b

    xor rcx, rcx
    mov ax, [ rdx + 16 ] ; srWindow.Bottom        ; 00001010b ; 00011101b 
    movzx rax, ax
    shl rax, 48
    or rcx, rax
    mov ax, [ rdx + 14 ] ; srWindow.Right         ; 11001011b ; 01110111b  
    movzx rax, ax
    shl rax, 32
    or rcx, rax
    mov ax, [ rdx + 12 ] ; srWindow.Top           ; 00000000b ; 00000000b
    movzx rax, ax
    shl rax, 16
    or rcx, rax
    mov ax, [ rdx + 10 ] ; srWindow.Left          ; 00000000b ; 00000000b
    movzx rax, ax
    or rcx, rax
    mov srWindow, rcx
    
    ; invoke Print_Byte_Bin, std_out_handle, srWindow
    ; invoke Print_Symbol, std_out_handle, 10

    mov bl, [ rdx + 18 ] ; dwMaximumWindowSize.X  ; 11001100b ; 01111000b
    mov bl, [ rdx + 20 ] ; dwMaximumWindowSize.Y  ; 00001011b ; 01000010b

    invoke WriteConsoleOutput, screen_buffer_handle, screen_buffer, dwSize, NULL, &srWindow

    ; invoke SetConsoleMode, std_out_handle, ENABLE_PROCESSED_OUTPUT
    ; invoke WriteConsole, std_out_handle, ADDR msgtw, SIZEOF msgtw

    invoke Sleep, 3000
    invoke SetConsoleActiveScreenBuffer, std_out_handle
    ; invoke FreeConsole
    invoke ExitProcess, NULL
main endp


;---------------------------------------------------------------------------------------------------------------
Print_Symbol proc
; ECX - stdout
; DL - symbol
local symbol:byte

    mov symbol, dl

    invoke WriteConsole, ecx, ADDR symbol, SIZEOF symbol

    ret

Print_Symbol endp
;---------------------------------------------------------------------------------------------------------------
Print_Byte_Bin proc
; ECX - stdout
; DL - hex
local local_stdout:dword
 
    push ax
    push bx
    push cx
    push dx

    mov bl, '0'
    mov bh, '1'

    ; shr rdx, 48

    mov local_stdout, ecx
    
    lea rax, [hexArr]
    xor rcx, rcx
    mov rcx, 8

_loop:
    rol dl, 1
    jc _1
_0:   
    mov [rax], bl
    jmp _next_step
_1:
    mov [rax], bh
    
_next_step:
    inc rax
    loop _loop
    
    mov bl, 'b'
    mov [rax], bl

    invoke WriteConsole, local_stdout, &hexArr, sizeof hexArr

    pop dx
    pop cx
    pop bx
    pop ax

    ret

Print_Byte_Bin endp
;---------------------------------------------------------------------------------------------------------------


end
