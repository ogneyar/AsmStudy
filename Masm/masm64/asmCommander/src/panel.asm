
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
    add rdi, 100
	
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

    call drawLineStartVertical
    call drawLineEndVertical

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

    call drawLineStartVertical
    call drawLineEndVertical

    call drawLineMeddleHorizontal
    call drawLineMiddleVertical

    pop rcx

    ret
    
drawRightPanel endp
;---------------------------------------------------------------------------------------------------------------
draw proc
; Параметры: нет
; Возврат: нет

    ; call clearBuffer

    call drawLeftPanel
    call drawRightPanel

    ret
    
draw endp
;---------------------------------------------------------------------------------------------------------------

