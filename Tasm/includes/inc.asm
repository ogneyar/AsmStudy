; inc.asm - includes test
data segment
    endString db 'End$' ; string
    lineBreak db 0Dh, 0Ah, 24h ; 0Dh = '\r', 0Ah = '\n', 24h = '$'
    ; equalString db 'equal$' ; string
    ; notEqualString db 'NOTequal$' ; string

    intA dw 1
    intB dw 2
    intC dw 3
    intD dw 4
    intE dw 4
data ends

stk segment stack
    db 256 dup ('')
stk ends

include funcs.asm ; myFunc
include macro.asm ; testMacro

code segment
    assume cs:code, ds:data, ss:stk
    
    start proc far
        mov ax, data
        mov ds, ax
        
        push intE; Пятый параметр - сверху
        push intD;
        push intC;
        push intB;Второй параметр
        push intA; Первый параметр (самый левый) - снизу

        call myFunc ; in file funcs.asm

        testMacro ; in file macro.asm

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

     
code ends; end code segment

end start; end program