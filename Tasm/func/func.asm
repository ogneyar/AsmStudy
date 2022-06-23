
data segment
    endString db 'End$' ; string
    equalString db 'equal$' ; string
    notEqualString db 'NOTequal$' ; string
    lineBreak db 0Dh, 0Ah, 24h ; 0Dh = '\r', 0Ah = '\n', 24h = '$'

    intA dw 1
    intB dw 2
    intC dw 3
    intD dw 4
    intE dw 4
data ends

stk segment stack
    db 256 dup ('')
stk ends

code segment
    assume cs:code, ds:data, ss:stk
    
    start proc far
        mov ax, data
        mov ds, ax
        
        push intE; 
        push intD;
        push intC;
        push intB;
        push intA; 
        call myFunc

        ; jmp exit

      exit:
        mov ah, 09h ; output
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt
        lea dx, endString ; string 'End'
        int 21h ; interrupt
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt
        ; -------------
        mov ah, 4ch ; exit
        int 21h ; interrupt

        ret ; return
        
    start endp; end procedure


;----------------------------------------------------------------------
;Функция содержит пять параметров:
myFunc proc ; можно так описать функцию
; myFunc: ; а можно как метку, без myFunc endp в конце
    push bp
    ; Командой CALL при вызове функции, в стек поместили адрес возврата - 2 байта для процедуры типа NEAR (или 4 - для FAR), а потом еще и ВР - 2 байта (push bp - в начале нашей функции)
    mov bp,sp; Создаём стековый кадр. В bp - указатель на стековый кадр, регистр bp использовать нельзя!

    e equ [bp+12]; Последний параметр - сверху ([bp+12])
    d equ [bp+10]
    c equ [bp+8]
    b equ [bp+6]
    a equ [bp+4]

    ; тут могут быть любые вычисления

    mov ax,d
    mov bx,c

    cmp ax, bx
    je equal

    jmp notequal

  equal:
    mov ah, 09h ; output
    lea dx, equalString
    int 21h
    lea dx, lineBreak ; \r\n
    int 21h
    jmp quit

  notequal:
    mov ah, 09h ; output
    lea dx, notEqualString
    int 21h
    lea dx, lineBreak ; \r\n
    int 21h

  quit:
    pop bp

ret 10 ; Из стека дополнительно извлекается 10 байт (по 2 байта на каждую переменную)

myFunc endp
;----------------------------------------------------------------------

    
code ends; end code segment

end start; end program