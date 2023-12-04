.code
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
Print_Byte proc
; ECX - stdout
; DL - hex
local local_stdout:dword
; local hexArr:byte 25 dup (0)
 
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

    ret

    pop dx
    pop cx
    pop bx
    pop ax

Print_Byte endp
;---------------------------------------------------------------------------------------------------------------