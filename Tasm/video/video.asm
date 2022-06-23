.8086
; .486

.model small
; .model large

.code
    start:
        mov ax, DGROUP
        mov ds, ax
        ; ----------------
        
        ; graphic mode
        ; mov ah, 00h ; mode setting command
        ; mov al, 10h ; turning on graphic mode
        mov ax, 0010h ; or so
        int 10h ; calling the BIOS

        ; Draw a line
        mov si, 150 ; si- starting coordinate (X)
        mov cx, 300 ; number of points horizontally

      line:

        push cx ; putting the number of points on the stack
        
        mov ah, 0Ch ; pixel output command
        mov al, 04h ; setting the color (1 - blue, 2 - green, 3 - ligthblue, 4 - red, 5 - violet, 6 - orange, 7 - white, 8 - grey)
        ; mov ax, 0C04h ; or so
        mov bh, 0 ; video page

        mov cx, si ; X-coordinate (changing)
        mov dx, 175 ; Y-coordinate (constant)
        
        int 10h ; calling the BIOS

        inc si ; increment X-coordinates

        pop cx ; getting the number of points from the stack
        
      loop line ; a cycle of CX steps (cx--)
      

        ; stop the program to view its work
        mov ah, 08h ; the command for keyboard input without displaying in the console
        int 21h ; calling the DOS

        ; switching the video adapter to text mode
        mov ah, 00h ; mode setting command
        mov al, 03h ; turning on text mode
        ;mov ax,0003h ; or so
        int 10h ; calling the BIOS
        

        mov ah, 09h
        lea dx, hello
        int 21h ; calling the DOS

        ; ---------------- EXIT
        mov ax, 4c00h
        int 21h

.data
    hello db 'Hello, World!$'

.stack 100h

end start

