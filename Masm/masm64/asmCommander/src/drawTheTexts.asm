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
	; push r8

    lea rdi, screen_buffer

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

	; pop r8
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
	push rcx
	push rdx
	push rdi
	push r12
	push r13

    lea rdi, screen_buffer

	mov r12, rcx ; save text_pos
	mov r13, r8 ; save limit

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

	rep stosb

_exit:

	mov rdx, r12 ; text_pos
	shr rdx, 48 ; DL содержит Attributes
	; изменение текстового атрибута (цвета фона и цвета текста)
    invoke SetConsoleTextAttribute, stdout_handle;, rdx
	
	xor rdx, rdx
	mov edx, r12d ; r12d = 001c0000h
 	; установка курсора консоли
    invoke SetConsoleCursorPosition, stdout_handle;, rdx ; (x = 0000h, y = dwSize_Y - 2 = 001ch)
	
	mov r8, r13 ; limit
    ; вывод в консоль
    invoke WriteConsole, stdout_handle, ADDR screen_buffer;, limit

	pop r13
	pop r12
	pop rdi
	pop rdx
	pop rcx
	pop rax

    ret

drawLimitedText endp
;---------------------------------------------------------------------------------------------------------------
