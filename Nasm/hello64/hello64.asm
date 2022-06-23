; Hello.asm
EXTERN MessageBoxW
EXTERN ExitProcess
SECTION .text USE64
start:
	sub rsp, 28h         ; Microsoft x64 calling convention "shadow space"
	xor rcx, rcx         ; HWND hWnd = NULL
        lea rdx, [banner]    ; LPCTSTR lpText = banner
        lea r8, [title]      ; LPCTSTR lpCaption = title
        xor r9, r9           ; UINT uType =  MB_OK
        call MessageBoxW     ; MessageBox(hWnd, lpText, lpCaption, uType)
        xor rcx, rcx         ; UINT uExitCode = 0
        call ExitProcess     ; ExitProcess(uExitCode)
SECTION .data
        banner dw __utf16__('Здравствуй Мир!'),0
        title dw __utf16__('Hello!'),0