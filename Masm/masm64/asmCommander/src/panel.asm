
.code
;---------------------------------------------------------------------------------------------------------------
_getPosAddress proc
; Параметры:
; RCX - pos
; RDX - symbol
; Возврат: RDI = screen_buffer + address_offset

	push rax
	push rbx

    lea rdi, screen_buffer

	; 1. Вычисляем адрес вывода: address_offset = (pos.Y_Pos * pos.Screen_Width + pos.X_Pos) * 4
	; 1.1 Вычисляем pos.Y * pos.Screen_Width
	mov rax, rcx
	shr rax, 16 ; AX = pos.Y_Pos
	movzx rax, ax ; RAX = AX = pos.Y_Pos

	mov rbx, rcx
	shr rbx, 32 ; BX = pos.Screen_Width
	movzx rbx, bx ; RBX = BX = pos.Screen_Width

	imul rax, rbx ; RAX = pos.Y_Pos * pos.Screen_Width

	; 1.2 Добавляем pos.X_Pos к RAX
	movzx rbx, cx ; RBX = CX = pos.X_Pos
	add rax, rbx ; RAX = pos.Y_Pos * pos.Screen_Width + pos.X_Pos

	; ; 1.3 RAX содержит смещение начала строки в символах, а надо - в байтах.
	; ; Т.к. каждый символ занимает 4 байта, надо умножить это смещение на 4
	; shl rax, 2 ; RAX = RAX * 4 = address_offset

	add rdi, rax ; RDI = screen_buffer + address_offset
    ; add rdi, 100
	
	pop rbx
	pop rax

	ret

_getPosAddress endp
;---------------------------------------------------------------------------------------------------------------
_getScreenWidthSize proc
; Вычисление ширины экрана в байтах
; Параметры:
; RCX - pos
; Возврат: R11

	mov r11, rcx ; R11 = pos
	shr r11, 32 ; R11 = pos.Len | pos.Screen_Width
	movzx r11, r11w ; R11 = pos.Screen_Width
	; shl r11, 2 ; R11 = pos.Screen_Width * 4 ; ширина экрана в байтах

	ret

_getScreenWidthSize endp
;---------------------------------------------------------------------------------------------------------------
drawLeftPanel proc
; Параметры: нет
; Возврат: нет

    push rcx

    ; Y_Pos = 0 ; X_Pos = 0
    xor rcx, rcx

    call drawLineTopHorizontal
    call drawLineBottomHorizontal

    call drawLineLeftVertical
    call drawLineRightVertical

    call drawLineMeddleHorizontal
    call drawLineMiddleVertical

    pop rcx

    ret

drawLeftPanel endp
;---------------------------------------------------------------------------------------------------------------
drawRightPanel proc
; Параметры: нет
; Возврат: нет

    push rcx
    
    ; Y_Pos = 0
    xor rcx, rcx
    ; X_Pos = dwSize_X / 2
    mov cl, dwSize_X 
    shr cl, 1

    call drawLineTopHorizontal
    call drawLineBottomHorizontal

    call drawLineLeftVertical
    call drawLineRightVertical

    call drawLineMeddleHorizontal
    call drawLineMiddleVertical

    pop rcx

    ret
    
drawRightPanel endp
;---------------------------------------------------------------------------------------------------------------
drawKey proc
; Параметры: 
; RCX - x_pos
; RDX - key
; Возврат: нет

    push rax
    push rcx
    push rdx
    push r8
    push r12

    mov r12, rcx   

    xor rcx, rcx
    ; Attributes = 07h ; чёрный фон, бежевый текст
    mov cl, 07h
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = dwSize_Y - 1 или - 2
    mov cl, dwSize_Y 
    sub cl, 2
    shl rcx, 16
    ; X_Pos = x_pos    
    mov rax, r12
    mov cl, al

    ; mov r8, rdx ; limit
    mov r8, 3 ; limit

    ; mov rdx, r14 ; key

    call drawLimitedText

    pop r12
    pop r8
    pop rdx
    pop rcx
    pop rax

    ret
    
drawKey endp
;---------------------------------------------------------------------------------------------------------------
drawKeyName proc
; Параметры: 
; RCX - x_pos
; RDX - name
; Возврат: нет

    push rax
    push rcx
    push rdx
    push r8
    push r12

    mov r12, rcx   
 
    xor rcx, rcx
    ; Attributes = 0b0h ; чёрный фон, бежевый текст
    mov cl,  0b0h
    shl rcx, 16
    ; Screen_Width = dwSize_X
    mov cl, dwSize_X
    shl rcx, 16
    ; Y_Pos = dwSize_Y - 1 или - 2
    mov cl, dwSize_Y 
    sub cl, 2
    shl rcx, 16
    ; X_Pos = x_pos    
    mov rax, r12
    add rax, 3
    mov cl, al

    ; mov r8, rdx ; limit
    mov r8, 6 ; limit

    ; mov rdx, r14 ; name

    call drawLimitedText

    pop r12
    pop r8
    pop rdx
    pop rcx
    pop rax

    ret

drawKeyName endp
;---------------------------------------------------------------------------------------------------------------
drawMenuItem proc
; Параметры: 
; RCX - x_pos
; RDX - len
; R8 - key
; R9 - name
; Возврат: нет

    push rcx
    push rdx
    push r8
    push r9
    push r12
        
    mov r12, r9

    invoke drawKey, rcx, r8
    
    invoke drawKeyName, rcx, r12

    pop r12
    pop r9
    pop r8
    pop rdx
    pop rcx

    ret

drawMenuItem endp
;---------------------------------------------------------------------------------------------------------------
drawMenu proc
; Параметры: нет
; Возврат: нет
local str_key[4]:byte
local str_name[7]:byte

    lea r8, str_key
    mov al, '1'
    mov [ r8 ], al
    inc r8
    mov al, 0
    mov [ r8 ], al
    lea r8, str_key
    
    lea r9, str_name
    mov al, 'H'
    mov [ r9 ], al
    inc r9
    mov al, 'e'
    mov [ r9 ], al
    inc r9
    mov al, 'l'
    mov [ r9 ], al
    inc r9
    mov al, 'p'
    mov [ r9 ], al
    inc r9
    mov al, 0
    mov [ r9 ], al
    lea r9, str_name

    ; invoke drawMenuItem, x_pos, len, key, name
    invoke drawMenuItem, 0, 10;, r8, r9

    ret
    
drawMenu endp
;---------------------------------------------------------------------------------------------------------------
draw proc
; Параметры: нет
; Возврат: нет

    ; формирование буфера консоли - screen_buffer
    call drawLeftPanel
    call drawRightPanel
    ; call drawMenu
    ; изменение заголовка консоли
    invoke SetConsoleTitle, &str_title
    ; изменение текстового атрибута (цвета фона и цвета текста)
    invoke SetConsoleTextAttribute, stdout_handle, 1bh
    ; установка курсора консоли
    invoke SetConsoleCursorPosition, stdout_handle, 0 
    ; вывод в консоль
    invoke WriteConsole, stdout_handle, ADDR screen_buffer, SIZEOF screen_buffer
    
    ; формирование буфера консоли - screen_buffer
    ; call clearBuffer
    call drawMenu
    ; ; изменение текстового атрибута (цвета фона и цвета текста)
    ; invoke SetConsoleTextAttribute, stdout_handle, 07h    
 	; ; установка курсора консоли
    ; invoke SetConsoleCursorPosition, stdout_handle, 001c0000h ; (x = 0000h, y = dwSize_Y - 2 = 001ch)
    ; ; вывод в консоль
    ; ; invoke WriteConsole, stdout_handle, ADDR string_buffer, SIZEOF string_buffer
    ; invoke WriteConsole, stdout_handle, ADDR screen_buffer, dwSize_X

    ret
    
draw endp
;---------------------------------------------------------------------------------------------------------------

