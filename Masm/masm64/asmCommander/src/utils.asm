.code
;---------------------------------------------------------------------------------------------------------------
resizeConsole proc
; Параметры:
; ECX - stdout_handle
; Возврат: нет


local local_stdout:dword
local ConsoleWindow:SMALL_RECT

    push ax
    push dx
    push r8

    mov local_stdout, ecx

    invoke GetLargestConsoleWindowSize, local_stdout
    ; rax return in 31-16 bits: dwCoord.y // 15-00 bits: dwCoord.x
    lea r8, ConsoleWindow
    ; and dword ptr [ r8 + 0 ], 0 ; [r8 + SMALL_RECT.Left]
    xor dx, dx
    mov [ r8 + 0 ], dx ; [r8 + SMALL_RECT.Left]
    mov [ r8 + 2 ], dx ; [r8 + SMALL_RECT.Top]
    sub ax, MAXSCREENX
    sbb edx, edx
    and ax, dx
    add ax, MAXSCREENX-1
    mov [ r8 + 4 ], ax ; [r8 + SMALL_RECT.Right]
    shr eax, 16
    sub eax, MAXSCREENY
    sbb edx, edx
    and eax, edx
    add eax, MAXSCREENY-1
    mov [ r8 + 6 ], ax ; [r8 + SMALL_RECT.Bottom]
    invoke SetConsoleWindowInfo, local_stdout, TRUE, &ConsoleWindow
    invoke SetConsoleScreenBufferSize, local_stdout, MAXSCREENY*10000h+MAXSCREENX

    pop r8
    pop dx
    pop ax

    ret

resizeConsole endp
;---------------------------------------------------------------------------------------------------------------
getScreenBufferInfo proc
; Параметры:
; ECX - stdout_handle
; Возврат: нет

local csbi:CONSOLE_SCREEN_BUFFER_INFO

    push rbx
    push rdx

    invoke GetConsoleScreenBufferInfo, ecx, &csbi
    lea rdx, csbi                                   ; терминал  ; консоль

    mov bl, [ rdx + 0 ] ; dwSize.X                ; 11001100b ; 01111000b
    mov dwSize_X, bl
    mov bl, [ rdx + 2 ] ; dwSize.Y                ; 00001011b ; 00101001b
    mov dwSize_Y, bl
    mov bl, [ rdx + 4 ] ; dwCursorPosition.X      ; 00000000b ; 00000000b
    mov dwCursorPosition_X, bl
    mov bl, [ rdx + 6 ] ; dwCursorPosition.Y      ; 00000000b ; 00000000b
    mov dwCursorPosition_Y, bl
    mov bl, [ rdx + 8 ] ; wAttributes             ; 00001111b ; 00001111b
    mov wAttributes, bl
    mov bl, [ rdx + 10 ] ; srWindow.Left          ; 00000000b ; 00000000b
    mov srWindow_Left, bl
    mov bl, [ rdx + 12 ] ; srWindow.Top           ; 00000000b ; 00000000b
    mov srWindow_Top, bl
    mov bl, [ rdx + 14 ] ; srWindow.Right         ; 11001011b ; 01110111b
    mov srWindow_Right, bl
    mov bl, [ rdx + 16 ] ; srWindow.Bottom        ; 00001010b ; 00011101b
    mov srWindow_Bottom, bl
    mov bl, [ rdx + 18 ] ; dwMaximumWindowSize.X  ; 11001100b ; 01111000b
    mov dwMaximumWindowSize_X, bl
    mov bl, [ rdx + 20 ] ; dwMaximumWindowSize.Y  ; 00001011b ; 01000010b
    mov dwMaximumWindowSize_Y, bl

    ; invoke Print_Byte_Bin, stdout, dwMaximumWindowSize_X
    ; invoke Print_Symbol, stdout, 10

    pop rdx
    pop rbx

    ret

getScreenBufferInfo endp
;---------------------------------------------------------------------------------------------------------------
clearBuffer proc
; Параметры: нет
; Возврат: нет

    push rax
    push rcx
    push rdx

    lea rax, screen_buffer
    ; mov dx, '║'
    ; mov dx, 2551h
    mov dl, 020h ; ' ' ; 32
    ; mov dl, 0b6h ; '╢' ; 182
    ; mov dl, 0bah ; '║' ; 186
    ; mov dl, 0bbh ; '╗' ; 187
    ; mov dl, 0bch ; '╝' ; 188
    ; mov dl, 0c4h ; '─' ; 196
    ; mov dl, 0c7h ; '╟' ; 199
    ; mov dl, 0c8h ; '╚' ; 200
    ; mov dl, 0c9h ; '╔' ; 201
    ; mov dl, 0cbh ; '╦' ; 203
    ; mov dl, 0cdh ; '═' ; 205
    ; mov dl, 0d0h ; '╨' ; 208

    mov rcx, (MAXSCREENX * MAXSCREENY)

_filling_the_array:
    mov [ rax + ( rcx * sizeof byte ) - sizeof byte  ], dl
    loop _filling_the_array

    pop rdx
    pop rcx
    pop rax

    ret

clearBuffer endp
;---------------------------------------------------------------------------------------------------------------
