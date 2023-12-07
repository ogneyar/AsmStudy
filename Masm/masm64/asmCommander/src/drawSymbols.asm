.code
;---------------------------------------------------------------------------------------------------------------
drawStartSymbol proc
; Выводим стартовый символ
; Параметры:
; RDI - текущий адрес в буфере окна
; RDX - symbol
; Возврат: нет

	push rax
	push rbx

	mov eax, edx ; RAX = EAX = { simbol.Attributes, simbol.Main_Symbol }
	mov rbx, rdx
	shr rbx, 32 ; RBX = EBX = { simbol.End_Symbol, simbol.Start_Symbol }
	mov al, bl ;  RAX = EAX = { simbol.Attributes, simbol.Start_Symbol }

	stosb ; Store String Byte

	pop rbx
	pop rax

	ret

drawStartSymbol endp
;---------------------------------------------------------------------------------------------------------------
drawEndSymbol proc
; Выводим конечный символ
; Параметры:
; RDI - текущий адрес в буфере окна
; RDX - symbol
; Возврат: нет

	push rax
	push rbx

	mov rbx, rdx
	shr rbx, 48 ; RBX = BX = simbol.End_Symbol
	mov al, bl ;  RAX = EAX = { simbol.Attributes, simbol.Start_Symbol }
	
	stosb ; Store String Byte
	
	pop rbx
	pop rax

	ret

drawEndSymbol endp
;---------------------------------------------------------------------------------------------------------------
