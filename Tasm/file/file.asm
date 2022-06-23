
data segment
    questionOne db 'Whats your name?$' ; string
    ; questionOneLength=$-questionOne ; равнозначно, можно и так (:
    questionOneLength equ $-questionOne ; length
    handle dw 0 ; descriptor
    handle2 dw 0 
    path db 'file.txt',0
    path2 db 'file2.txt',0
    old_file_name db 'oldFileName.txt',0
    new_file_name db 'newFileName.txt',0

    filesize dw 256
    databuf dw 0
    
    lineBreak db 0Dh, 0Ah, '$'
    errorText db 'Error$' ; string
data ends

stk segment stack
    db 256 dup ('')
stk ends

code segment
    assume cs:code, ds:data, ss:stk
    ;start:
    start proc far
        mov ax, data
        mov ds, ax

        ; ----------------
        mov ah, 09h ; 09h (or 09) - output
        ; ----------------
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt
        
        ; ----------------
        mov ah, 3ch ; 3ch - create files
        ; ----------------
        mov al, 1
        mov cx, 0 ; without attributs
        ;xor cx, cx
        mov dx,offset path
        int 21h; interrupt
        jc error
        
        mov handle, ax ; save descriptor
        
        ; ----------------
        mov ah, 40h ; write in file
        ; ----------------
        mov bx, handle 
        mov cx, questionOneLength
        sub cx, 1
        lea dx, questionOne
        int 21h; interrupt

        ; ----------------
        mov ah, 3eh ; close file
        ; ----------------
        mov bx, handle
        int 21h; interrupt
        
        jmp exit



;----------------------------------------
        mov al,0
        mov ah,3dh ; open file
        mov dx,offset path2
        int 21h
        jc error

        mov handle2,ax

        mov ah,3fh ; read file
        mov bx,handle2
        mov cx,filesize
        mov dx,offset databuf
        int 21h
        ;jc error

        mov ah, 09h ; output
        lea dx, databuf
        int 21h ; interrupt

        mov ah, 09h ; output
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt

        
        jmp exit
;----------------------------------------

        mov ah, 56h ; ah = 56h, делаем запрос на переименование файла.
        lea dx, old_file_name ; ds:dx = имя старого файла.
        lea di, new_file_name ; es:di = имя нового файла.
        int 21h

        jmp exit
        
;----------------------------------------


        
      error:
        mov ah, 09h; output
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt
        ; -------------
        lea dx, errorText ; \r\n
        int 21h ; interrupt
        ; -------------
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt
        ; -------------
         
      exit:
        mov ah, 09h ; output
        lea dx, lineBreak ; \r\n
        int 21h ; interrupt
        ; -------------
        mov ah, 4ch ; exit
        int 21h ; interrupt

        ret ; return
        
    start endp; end procedure
    
code ends; end code segment

end start; end program

