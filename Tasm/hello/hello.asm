; .model large

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
        mov ah, 09h ; 09h (or 09) - output
        mov dx, offset hello ; say Hello, World!
        int 21h ; interrupt

        mov ah, 4ch ; exit
        int 21h ; interrupt

        ret ; return
        
    start endp ; end procedure
    
code ends ; end code segment

end start ; end program