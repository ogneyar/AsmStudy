   
data segment
    ; endString db 'End$' ; string
    equalString db 'equal$' ; string
    notEqualString db 'NOTequal$' ; string
    lineBreak2 db 0Dh, 0Ah, 24h ; 0Dh = '\r', 0Ah = '\n', 24h = '$'
data ends

stk segment stack
    db 256 dup ('')
stk ends

code segment
assume cs:code, ds:data, ss:stk
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
    lea dx, lineBreak2 ; \r\n
    int 21h
    jmp quit

  notequal:
    mov ah, 09h ; output
    lea dx, notEqualString
    int 21h
    lea dx, lineBreak2 ; \r\n
    int 21h

  quit:
    
    pop bp
    
ret 10 ; Из стека дополнительно извлекается 10 байт (по 2 байта на каждую переменную)

myFunc endp
;----------------------------------------------------------------------


code ends; end code segment
