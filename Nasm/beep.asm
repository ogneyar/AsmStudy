;TmrBeep.asm

;вывод ноты "Ми" через встроенный динамик

;tasm TmrBeep.asm
;tlink /t TmrBeep.obj
; code segment
; assume cs:code, ds:code

org 100h

start:

;загрузка счетчика канала 2 значением 0E24h (нота "Ми")

mov al, 24h ;сначала выводится младший байт

out 42h, al

mov al, 0Eh ;затем выводится старший байт

out 42h, al

;включение сигнала и динамика

in al, 61h

or al, 00000011b

out 61h, al

;формирование задержки

xor cx, cx

l1: mov bx, cx

mov cx, 8000h

l2: loop l2

mov cx, bx

loop l1

;выключение сигнала и динамика

in al, 61h

and al, 11111100b

out 61h, al

;завершение программы

mov ax, 4C00h

int 21h

; code ends

; end start