data segment
    hello db 'Hello, World!$'
data ends

stk segment stack
    db 256 dup ('')
stk ends

code segment
    assume cs:code, ds:data, ss:stk
    start proc far
        mov ax, data
        mov ds, ax
        ; ----------------
        mov ax, 0600h  ;Запрос на очистку экрана.
        mov bh, 07     ;Нормальный атрибут (черно/белый).
        mov cx, 0000   ;Верхняя левая позиция.
        mov dx, 184FH  ;Нижняя правая позиция.
        int 10h 
        ; ----------------
        mov ah, 00001001b ; 09h, 9h or 9 - output
        mov dx, offset hello ; say Hello, World!
        int 00100001b ; or 21h - interrupt

        mov ah, 4ch ; exit
        int 21h ; interrupt

        ret; return
        
    start endp; end procedure
    
code ends; end code segment

end start; end program