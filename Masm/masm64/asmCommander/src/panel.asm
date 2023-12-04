
.code
;---------------------------------------------------------------------------------------------------------------
Draw_Line proc
; ECX - stdout
; EDX - message
    ; вывод текста в консоль
    ; invoke WriteConsole, stdout, ADDR message, SIZEOF message;, ADDR cWritten, NULL

    ret

Draw_Line endp
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
