
.model small ;large

.code
;.8086
.486
    start:
        mov ax, DGROUP
        mov ds, ax
        ; ----------------
        mov eax, 00000900h
        mov edx, offset hello
        int 21h
        ; ----------------
        mov ax, 4c00h
        int 21h

.data
    hello db 'Hello, World!$'

.stack 100h

end start