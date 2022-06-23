%include 'les32.inc'

global Start

section general main
Start:
	

	push MB_OK | MB_ICONQUESTION | MB_RETRYCANCEL | MB_DEFBUTTON2
	push title
	push banner
	push NULL
	call [MessageBoxA]

	push IDRETRY
	
	pop ebx

    ; cmp eax, IDRETRY
	cmp eax, ebx
    je Start

    jmp Exit

Exit:
	push NULL
	call [ExitProcess]

section information data
	banner db 'Hello world?',0xD,0xA,0
	title db 'Hello',0

