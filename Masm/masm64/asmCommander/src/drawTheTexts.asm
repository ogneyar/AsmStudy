.code
;---------------------------------------------------------------------------------------------------------------
drawText proc
; Параметры:
; RCX - text_pos = { X_Pos, Y_Pos, Screen_Width, Attributes }
; RDX - str
; Возврат: RAX - длина строки str

	push rbx
	push rcx
	push rdx
	push rdi
	push r8

	; 1. Вычисляем адрес вывода
	; call _getPosAddress ; RDI = screen_buffer + address_offset
    lea rdi, screen_buffer
	add rdi, 100
	
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

	; RAX = address_offset	
    ; установка курсора консоли
    ; invoke SetConsoleCursorPosition, stdout_handle, rax	
	add rdi, rax ; RDI = screen_buffer + address_offset

	; mov r10, rdx ; save

	; mov rdx, rcx
	; shr rdx, 48 ; AL содержит Attributes

    ; ; invoke SetConsoleTextAttribute, stdout_handle, dl
	; lea rcx, stdout_handle
	; movzx rdx, dl
	; call SetConsoleTextAttribute

	; mov rdx, r10 ; unsave

	xor rbx, rbx ; счётчик длины строки

_1:
	mov al, [ rdx ] ; очередной символ строки

	cmp al, 0
	je _exit
	
	stosb

	inc rdx ; увеличиваем адрес
	inc rbx ; увеличиваем счётчик

	jmp _1

_exit:
	mov rax, rbx

	pop r8
	pop rdi
	pop rdx
	pop rcx
	pop rbx

    ret

drawText endp
;---------------------------------------------------------------------------------------------------------------
drawLimitedText proc
; Параметры:
; RCX - text_pos = { X_Pos, Y_Pos, Screen_Width, Attributes }
; RDX - str
; R8 - limit
; Возврат: нет

	push rax
	push rdx
	push rdi
	push r8

	; 1. Вычисляем адрес вывода
	call _getPosAddress ; RDI = screen_buffer + address_offset

	mov rax, rcx
	shr rax, 48 ; AL содержит Attributes

    invoke SetConsoleTextAttribute, stdout_handle, al

_1:
	mov al, [ rdx ] ; очередной символ строки

	cmp al, 0
	je _fill_spaces
		
	stosb
	inc rdx ; увеличиваем адрес

	dec r8
	cmp r8, 0
	je _exit ; прекращаем вывод, если строка достигла предела

	jmp _1

_fill_spaces:
	mov al, 020h ; сохраняем пробел
	mov rcx, r8 ; количество оставшихся символов

	rep stosd

_exit:
	
	pop r8
	pop rdi
	pop rdx
	pop rax

    ret

drawLimitedText endp
;---------------------------------------------------------------------------------------------------------------



;---------------------------------------------------------------------------------------------------------------
drawTest proc
; Параметры:
; RCX - text_pos = { X_Pos, Y_Pos, Screen_Width, Attributes }
; RDX - str
; Возврат: RAX - длина строки str

	push rax
	push rbx
	push rcx
	push rdx
	push rdi

	; 1. Вычисляем адрес вывода
	; call _getPosAddress ; RDI = screen_buffer + address_offset
    lea rdi, screen_buffer
	add rdi, 100
	
	; ; 1. Вычисляем адрес вывода: address_offset = (pos.Y_Pos * pos.Screen_Width + pos.X_Pos) * 4
	; ; 1.1 Вычисляем pos.Y * pos.Screen_Width
	; mov rax, rcx
	; shr rax, 16 ; AX = pos.Y_Pos
	; movzx rax, ax ; RAX = AX = pos.Y_Pos

	; mov rbx, rcx
	; shr rbx, 32 ; BX = pos.Screen_Width
	; movzx rbx, bx ; RBX = BX = pos.Screen_Width

	; imul rax, rbx ; RAX = pos.Y_Pos * pos.Screen_Width

	; ; 1.2 Добавляем pos.X_Pos к RAX
	; movzx rbx, cx ; RBX = CX = pos.X_Pos
	; add rax, rbx ; RAX = pos.Y_Pos * pos.Screen_Width + pos.X_Pos

	mov r10, rdx ; save

	; mov rdx, rcx
	; movzx rdx, dx

	; shr rdx, 16
	; invoke printByteBin, stdout_handle

 	; установка курсора консоли
    ; invoke SetConsoleCursorPosition, stdout_handle, 001d0000h


	; mov rdx, rax
	; RAX = address_offset	
    ; установка курсора консоли
    ; invoke SetConsoleCursorPosition, stdout_handle
	; add rdi, rax ; RDI = screen_buffer + address_offset


	; mov rdx, rcx
	; shr rdx, 48 ; AL содержит Attributes

    ; ; invoke SetConsoleTextAttribute, stdout_handle, dl
	; lea rcx, stdout_handle
	; movzx rdx, dl
	; call SetConsoleTextAttribute

	mov rdx, r10 ; unsave

_1:
	mov al, [ rdx ] ; очередной символ строки
	cmp al, 0
	je _exit	
	stosb
	inc rdx ; увеличиваем адрес
	jmp _1
_exit:

	pop rdi
	pop rdx
	pop rcx
	pop rbx
	pop rax

    ret

drawTest endp
;---------------------------------------------------------------------------------------------------------------

