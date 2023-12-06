
.code 
;---------------------------------------------------------------------------------------------------------------
printSymbol proc
; Параметры:
; ECX - stdout_handle
; DL - symbol
; Возврат: нет
local symbol:byte

    mov symbol, dl

    invoke WriteConsole, ecx, ADDR symbol, SIZEOF symbol

    ret

printSymbol endp
;---------------------------------------------------------------------------------------------------------------
printByteBin proc
; Параметры:
; ECX - stdout_handle
; DL - hex
; Возврат: нет
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

printByteBin endp
;---------------------------------------------------------------------------------------------------------------
