.code
;---------------------------------------------------------------------------------------------------------------
drawLineVertical proc
; Параметры:
; RCX - pos
; RDX - symbol
; Возврат: нет

	push rax
	push rcx
	push rdi
	push r10
	push r11

    mov r10, rcx ; save pos

	; 1. Вычисляем адрес вывода
	call _getPosAddress ; RDI = screen_buffer + address_offset
    ; sub rdi, 100

	; 2. Вычисление коррекции позиции вывода
	call _getScreenWidthSize ; R11 = pos.Screen_Width * 1 байт
	sub r11, 1 ; шаг назад на один символ
	
	; 3. Выводим стартовый символ
	call drawStartSymbol

	; 4. Выводим символы
	mov al, dl ; AL = symbol

	shr rcx, 48 ; RCX = pos.Len
_1:
	add rdi, r11
	stosb ; mov [ rdi ], eax

	loop _1
	
	add rdi, r11

    mov rcx, r10 ; save pos

	; 5. Выводим конечный символ
	call drawEndSymbol

	pop r11
	pop rdi
	pop rcx
	pop rbx
	pop rax

	ret

drawLineVertical endp
;---------------------------------------------------------------------------------------------------------------
drawLineLeftVertical proc
; Параметры: 
; ECX - pos.X, pos.Y
; Возврат: нет

    push rax
    push rcx
    push rdx

    mov eax, ecx ; сохраняем pos.X и pos.Y

    ; pos:SPOS
    xor rcx, rcx
    ; Len = (dwSize_Y - 3) - 2
    mov cl, dwSize_Y
	sub cl, 5
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = pos.Y
    mov ebx, eax
    shr bx, 16 ; достаём pos.Y
    mov cl, bl
    shl rcx, 16
    ; X_Pos = pos.X
    mov cl, al  
    
    xor rdx, rdx
    ; symbol:SSYMBOL
    ; End_Symbol
    mov dl, 0c8h ; '╚' ; 200
    shl rdx, 16
    ; Start_Symbol
    mov dl, 0c9h ; '╔' ; 201
    shl rdx, 16
    ; Attributes
    mov dl, 01bh
    shl rdx, 16
    ; Main_Symbol
    mov dl, 0bah ; '║' ; 186

    call drawLineVertical

    pop rdx
    pop rcx
    pop rax

	ret

drawLineLeftVertical endp
;---------------------------------------------------------------------------------------------------------------
drawLineMiddleVertical proc
; Параметры: 
; ECX - pos.X, pos.Y
; Возврат: нет

    push rax
    push rcx
    push rdx

    mov eax, ecx ; сохраняем pos.X и pos.Y

    ; pos:SPOS
    xor rcx, rcx
    ; Len = (dwSize_Y - 3) - 4
    mov cl, dwSize_Y
	sub cl, 7
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = pos.Y
    mov ebx, eax
    shr bx, 16 ; достаём pos.Y
    mov cl, bl
    shl rcx, 16
    ; X_Pos = pos.X + ( (dwSize_X / 2) / 2 )
    mov cl, dwSize_X
    shr cl, 2 ; dwSize_X / 4
    add cl, al ; + pos.X
    
    xor rdx, rdx
    ; symbol:SSYMBOL
    ; End_Symbol
    mov dl, 0d0h ; '╨' ; 208
    shl rdx, 16
    ; Start_Symbol
    mov dl, 0cbh ; '╦' ; 203
    shl rdx, 16
    ; Attributes
    mov dl, 01bh
    shl rdx, 16
    ; Main_Symbol
    mov dl, 0bah ; '║' ; 186

    call drawLineVertical

    pop rdx
    pop rcx
    pop rax

	ret

drawLineMiddleVertical endp
;---------------------------------------------------------------------------------------------------------------
drawLineRightVertical proc
; Параметры: 
; ECX - pos.X, pos.Y
; Возврат: нет

    push rax
    push rcx
    push rdx

    mov eax, ecx ; сохраняем pos.X и pos.Y

    ; pos:SPOS
    xor rcx, rcx
    ; Len = (dwSize_Y - 3) - 2
    mov cl, dwSize_Y
	sub cl, 5
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = pos.Y
    mov ebx, eax
    shr bx, 16 ; достаём pos.Y
    mov cl, bl
    shl rcx, 16
    ; X_Pos = pos.X + (dwSize_X / 2) - 1
    mov cl, dwSize_X
    shr cl, 1 ; dwSize_X / 2
	sub cl, 1
    add cl, al ; + pos.X
    
    xor rdx, rdx
    ; symbol:SSYMBOL
    ; End_Symbol
    mov dl, 0bch ; '╝' ; 188
    shl rdx, 16
    ; Start_Symbol
    mov dl, 0bbh ; '╗' ; 187
    shl rdx, 16
    ; Attributes
    mov dl, 01bh
    shl rdx, 16
    ; Main_Symbol
    mov dl, 0bah ; '║' ; 186

    call drawLineVertical

    pop rdx
    pop rcx
    pop rax

	ret

drawLineRightVertical endp
;---------------------------------------------------------------------------------------------------------------
