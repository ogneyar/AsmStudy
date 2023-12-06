
.code
;---------------------------------------------------------------------------------------------------------------
resizeConsole proc
; Параметры:
; ECX - stdout_handle
; Возврат: нет


local local_stdout:dword
local ConsoleWindow:SMALL_RECT

    push ax
    push dx
    push r8

    mov local_stdout, ecx

    invoke GetLargestConsoleWindowSize, local_stdout
    ; rax return in 31-16 bits: dwCoord.y // 15-00 bits: dwCoord.x
    lea r8, ConsoleWindow
    ; and dword ptr [ r8 + 0 ], 0 ; [r8 + SMALL_RECT.Left]
    xor dx, dx
    mov [ r8 + 0 ], dx ; [r8 + SMALL_RECT.Left]
    mov [ r8 + 2 ], dx ; [r8 + SMALL_RECT.Top]
    sub ax, MAXSCREENX
    sbb edx, edx
    and ax, dx
    add ax, MAXSCREENX-1
    mov [ r8 + 4 ], ax ; [r8 + SMALL_RECT.Right]
    shr eax, 16
    sub eax, MAXSCREENY
    sbb edx, edx
    and eax, edx
    add eax, MAXSCREENY-1
    mov [ r8 + 6 ], ax ; [r8 + SMALL_RECT.Bottom]
    invoke SetConsoleWindowInfo, local_stdout, TRUE, &ConsoleWindow
    invoke SetConsoleScreenBufferSize, local_stdout, MAXSCREENY*10000h+MAXSCREENX

    pop r8
    pop dx
    pop ax

    ret

resizeConsole endp
;---------------------------------------------------------------------------------------------------------------
getScreenBufferInfo proc
; Параметры:
; ECX - stdout_handle
; Возврат: нет

local csbi:CONSOLE_SCREEN_BUFFER_INFO

    push rbx
    push rdx

    invoke GetConsoleScreenBufferInfo, ecx, &csbi
    lea rdx, csbi                                   ; терминал  ; консоль

    mov bl, [ rdx + 0 ] ; dwSize.X                ; 11001100b ; 01111000b
    mov dwSize_X, bl
    mov bl, [ rdx + 2 ] ; dwSize.Y                ; 00001011b ; 00101001b
    mov dwSize_Y, bl
    mov bl, [ rdx + 4 ] ; dwCursorPosition.X      ; 00000000b ; 00000000b
    mov dwCursorPosition_X, bl
    mov bl, [ rdx + 6 ] ; dwCursorPosition.Y      ; 00000000b ; 00000000b
    mov dwCursorPosition_Y, bl
    mov bl, [ rdx + 8 ] ; wAttributes             ; 00001111b ; 00001111b
    mov wAttributes, bl
    mov bl, [ rdx + 10 ] ; srWindow.Left          ; 00000000b ; 00000000b
    mov srWindow_Left, bl
    mov bl, [ rdx + 12 ] ; srWindow.Top           ; 00000000b ; 00000000b
    mov srWindow_Top, bl
    mov bl, [ rdx + 14 ] ; srWindow.Right         ; 11001011b ; 01110111b
    mov srWindow_Right, bl
    mov bl, [ rdx + 16 ] ; srWindow.Bottom        ; 00001010b ; 00011101b
    mov srWindow_Bottom, bl
    mov bl, [ rdx + 18 ] ; dwMaximumWindowSize.X  ; 11001100b ; 01111000b
    mov dwMaximumWindowSize_X, bl
    mov bl, [ rdx + 20 ] ; dwMaximumWindowSize.Y  ; 00001011b ; 01000010b
    mov dwMaximumWindowSize_Y, bl

    ; invoke Print_Byte_Bin, stdout, dwMaximumWindowSize_X
    ; invoke Print_Symbol, stdout, 10

    pop rdx
    pop rbx

    ret

getScreenBufferInfo endp
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
getScreenWidthSize proc
; Вычисление ширины экрана в байтах
; Параметры:
; RDX - pos
; Возврат: R11

	mov r11, rdx ; R11 = pos
	shr r11, 32 ; R11 = pos.Len | pos.Screen_Width
	movzx r11, r11w ; R11 = pos.Screen_Width
	; shl r11, 2 ; R11 = pos.Screen_Width * 4 ; ширина экрана в байтах

	ret

getScreenWidthSize endp
;---------------------------------------------------------------------------------------------------------------
drawLineVertical proc
; extern "C" void Draw_Line_Vertical(CHAR_INFO * screen_buffer, SPos pos, ASymbol symbol);
; Параметры:
; RCX - screen_buffer
; RDX - pos
; R8 - symbol
; Возврат: нет

	push rax
	push rbx
	push rcx
	push rdi
	push r11

	; 1. Вычисляем адрес вывода
	call _getPosAddress ; RDI = screen_buffer + address_offset
	mov rdi, rax

	; 2. Вычисление коррекции позиции вывода
	call getScreenWidthSize ; R11 = pos.Screen_Width * 4
	sub r11, 4 ; шаг назад на один символ
	
	; 3. Выводим стартовый символ
	call drawStartSymbol

	; 4. Выводим символы
	mov eax, r8d ; EAX = symbol

	mov rcx, rdx
	shr rcx, 48 ; RCX = pos.Len
_1:
	add rdi, r11
	stosd ; mov [ rdi ], eax

	loop _1
	
	add rdi, r11

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
clearBuffer proc
; Параметры: нет
; Возврат: нет

    push rax
    push rbx
    push rcx

    lea rax, screen_buffer
    ; mov bx, '║'
    ; mov bx, 2551h
    mov bl, 020h ; ' ' ; 32
    ; mov bl, 0b6h ; '╢' ; 182
    ; mov bl, 0bah ; '║' ; 186
    ; mov bl, 0bbh ; '╗' ; 187
    ; mov bl, 0bch ; '╝' ; 188
    ; mov bl, 0c4h ; '─' ; 196
    ; mov bl, 0c7h ; '╟' ; 199
    ; mov bl, 0c8h ; '╚' ; 200
    ; mov bl, 0c9h ; '╔' ; 201
    ; mov bl, 0cbh ; '╦' ; 203
    ; mov bl, 0cdh ; '═' ; 205
    ; mov bl, 0d0h ; '╨' ; 208

    mov rcx, (MAXSCREENX * MAXSCREENY)

_filling_the_array:
    mov [ rax + ( rcx * sizeof byte ) - sizeof byte  ], bl
    loop _filling_the_array

    pop rcx
    pop rbx
    pop rax

    ret

clearBuffer endp
;---------------------------------------------------------------------------------------------------------------
clearArea proc
; Параметры:
; RCX - screen_buffer
; RDX - area_pos
; R8 - symbol
; Возврат: нет

	push rax
	push rbx
	push rcx
	push rdi
	push r10
	push r11

	; 1. Вычисляем адрес вывода
	call _getPosAddress ; RDI = screen_buffer + address_offset
	
	mov r10, rdi

	; 2. Вычисление коррекции позиции вывода
	call getScreenWidthSize ; R11 = pos.Screen_Width * 4

	; 3. Выводим символы
	mov eax, r8d ; EAX = symbol

	mov rbx, rdx
	shr rbx, 48 ; BH - area_pos.Height, BL - area_pos.Width

	xor rcx, rcx
_1:
	mov cl, bl

	; rep stosd ; mov [ rdi ], eax
    mov [ rdi ], al
    inc rdi

	add r10, r11
	mov rdi, r10

	dec bh
	jnz _1
	
	pop r11
	pop r10
	pop rdi
	pop rcx
	pop rbx
	pop rax

	ret

clearArea endp
;---------------------------------------------------------------------------------------------------------------
drawPanel proc
; Параметры:
; RCX - pos
; Возврат: нет

    ; lea rax, screen_buffer
    ; mov bl, 0cdh ; '═' ; 205
    ; mov [ rax + 200 ], bl

    ; mov dl, 'x'

    ; call drawLineHorizontal
    
    ret

drawPanel endp
;---------------------------------------------------------------------------------------------------------------
drawLeftPanel proc
; Параметры: нет
; Возврат: нет

    call drawLineTopHorizontal
    call drawLineMeddleHorizontal
    call drawLineBottomHorizontal

    ret

drawLeftPanel endp
;---------------------------------------------------------------------------------------------------------------
drawRightPanel proc
; Параметры: нет
; Возврат: нет

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

