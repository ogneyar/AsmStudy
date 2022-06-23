; [BITS 16]
; [ORG 0]

SECTION .data
	hello DB ".COM",0xd,0xa,'$'

SECTION .text
; org 0x100

Start:
    mov ah, 0eh     ; режим вывода символа
    mov al, 'A'
    int 0x10        ; вызов прерывания
    
    mov al, 'B'
    int 0x10        ; вызов прерывания
    
    mov al, 43h     ; символ C (eng)
    int 0x10        ; вызов прерывания
    mov al, 40h     ; символ @
    int 10h         ; вызов прерывания   

    call Mail
    call Ru

    call Exit    

    mov al, '.'
    int 0x10        ; вызов прерывания
    mov al, 'R'
    int 0x10        ; вызов прерывания
    mov al, 'U'
    int 0x80        ; вызов прерывания


Exit:
    ; mov ax, 0x4c00    ; ah == 0x4c al == 0x00
    mov ah, 4ch     ; режим выхода
    mov al, 00h
    int 0x21        ; выход


Mail:
    mov al, 4dh     ; символ M (eng)
    int 0x10        ; вызов прерывания
    mov al, 41h     ; символ A (eng)
    int 10h         ; вызов прерывания
    mov al, 49h     ; символ I (eng)
    int 10h         ; вызов прерывания
    mov al, 4ch     ; символ L (eng)
    int 0x10        ; вызов прерывания

    ret

Ru:
    mov ah, 09h     ; режим вывода строки
	mov dx, hello
	int 21h
	
    ret
