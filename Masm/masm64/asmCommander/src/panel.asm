
.code
;---------------------------------------------------------------------------------------------------------------
resizeConsole proc
; ECX - stdout_handle

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
; ECX - stdout_handle

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
Draw_Line proc
; ECX - stdout_handle
; EDX - message
    ; вывод текста в консоль
    ; invoke WriteConsole, stdout_handle, ADDR message, SIZEOF message;, ADDR cWritten, NULL

    ret

Draw_Line endp
;---------------------------------------------------------------------------------------------------------------
Print_Symbol proc
; ECX - stdout_handle
; DL - symbol
local symbol:byte

    mov symbol, dl

    invoke WriteConsole, ecx, ADDR symbol, SIZEOF symbol

    ret

Print_Symbol endp
;---------------------------------------------------------------------------------------------------------------
Print_Byte_Bin proc
; ECX - stdout_handle
; DL - hex
local local_stdout:dword
 
    push ax
    push bx
    push cx
    push dx

    mov bl, '0'
    mov bh, '1'

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
Print_Byte_Hex proc
; ECX - stdout
; DL - hex
 
    mov bl, '0'
    mov bh, '1'
    ; mov r9w, dx

    mov r8d, ecx
    ; mov hexArr, dl
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
    ; add rax, 1
    loop _loop
    
    mov bl, 'b'
    mov [rax], bl

    ; mov [rax], dl
    ; add rax, 1
    ; mov [rax], dl
    ; invoke WriteConsole, ecx, &hexArr, sizeof hexArr
    invoke WriteConsole, r8d, &hexArr, sizeof hexArr

    ret

Print_Byte_Hex endp
