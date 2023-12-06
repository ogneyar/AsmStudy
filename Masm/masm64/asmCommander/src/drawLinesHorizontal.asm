.code
;---------------------------------------------------------------------------------------------------------------
drawLineHorizontal proc
; Параметры:
; ECX - pos
; RDX - symbol
; Возврат: нет

	push rax
	push rcx
	push rdi
	push r11

    mov r11, rcx ; save pos

	; 1. Вычисляем адрес вывода
	call _getPosAddress ; RDI = screen_buffer + address_offset
	
	; 2. Выводим стартовый символ
	call drawStartSymbol

	; 3. Выводим символы simbol.Main_Symbol
	mov al, dl
	shr rcx, 48 ; CX = pos.Len

	rep stosb ; Store String Byte (rep - repeat сколько в RCX) // mov [ rdi ], al - запись данных из AL в память по адресу RDI
	
    mov rcx, r11 ; save pos
	; 4. Выводим конечный символ
	call drawEndSymbol

	pop r11	
	pop rdi	
	pop rcx
	pop rax

	ret

drawLineHorizontal endp
;---------------------------------------------------------------------------------------------------------------
drawLineTopHorizontal proc
; Параметры: нет
; Возврат: нет

    push rcx
    push rdx

    ; pos:SPOS
    xor rcx, rcx
    ; Len = (dwSize_X / 2) - 2
    mov cl, dwSize_X
    shr cl, 1
	sub cl, 2
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = 0 
    mov cl, 0
    shl rcx, 16
    ; X_Pos = 0 
    mov cl, 0   
    
    xor rdx, rdx
    ; symbol:SSYMBOL
    ; End_Symbol
    mov dl, 0bbh ; '╗' ; 187
    shl rdx, 16
    ; Start_Symbol
    mov dl, 0c9h ; '╔' ; 201
    shl rdx, 16
    ; Attributes
    mov dl, 01bh
    shl rdx, 16
    ; Main_Symbol
    mov dl, 0cdh ; '═' ; 205

    call drawLineHorizontal

    pop rdx
    pop rcx

    ret

drawLineTopHorizontal endp
;---------------------------------------------------------------------------------------------------------------
drawLineMeddleHorizontal proc
; Параметры: нет
; Возврат: нет

    push rcx
    push rdx

    ; pos:SPOS
    xor rcx, rcx
    ; Len = (dwSize_X / 2) - 2
    mov cl, dwSize_X
    shr cl, 1
	sub cl, 2
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = 0 + (dwSize_Y - 2)- 3
    mov cl, dwSize_Y
	sub cl, 5
    shl rcx, 16
    ; X_Pos = 0 
    mov cl, 0   
    
    xor rdx, rdx
    ; symbol:SSYMBOL
    ; End_Symbol
    mov dl, 0b6h ; '╢' ; 182
    shl rdx, 16
    ; Start_Symbol
    mov dl, 0c7h ; '╟' ; 199
    shl rdx, 16
    ; Attributes
    mov dl, 01bh
    shl rdx, 16
    ; Main_Symbol
    mov dl, 0c4h ; '─' ; 196

    call drawLineHorizontal

    pop rdx
    pop rcx

    ret

drawLineMeddleHorizontal endp
;---------------------------------------------------------------------------------------------------------------
drawLineBottomHorizontal proc
; Параметры: нет
; Возврат: нет

    push rcx
    push rdx
	
    ; pos:SPOS
    xor rcx, rcx
    ; Len = (dwSize_X / 2) - 2
    mov cl, dwSize_X
    shr cl, 1
	sub cl, 2
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = 0 + (dwSize_Y - 2) - 1
    mov cl, dwSize_Y
	sub cl, 3
    shl rcx, 16
    ; X_Pos = 0 
    mov cl, 0   
    
    xor rdx, rdx
    ; symbol:SSYMBOL
    ; End_Symbol
    mov dl, 0bch ; '╝' ; 188
    shl rdx, 16
    ; Start_Symbol
    mov dl, 0c8h ; '╚' ; 200
    shl rdx, 16
    ; Attributes
    mov dl, 01bh
    shl rdx, 16
    ; Main_Symbol
    mov dl, 0cdh ; '═' ; 205

    call drawLineHorizontal

    pop rdx
    pop rcx

    ret

drawLineBottomHorizontal endp
;---------------------------------------------------------------------------------------------------------------
