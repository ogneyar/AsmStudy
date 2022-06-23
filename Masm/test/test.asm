.386p
; ������� ������
.model flat, stdcall
; ���������, ���������� ���������� ��������� MASM ��� ���
ifdef MASM
    ; �������� � MASM
    extern ExitProcess@4:near
    extern MessageBoxA@16:near
    includelib c:\masm32\lib\kernel32.lib
    includelib c:\masm32\lib\user32.lib
else
    ; �������� � TASM
    extern ExitProcess:near
    extern MessageBoxA:near
    includelib c:\tasm32\lib\import32.lib
    ExitProcess@4 = ExitProcess
    MessageBoxA@16 = MessageBoxA
endif
;-----------------------------------------------------------
;������� ������
_data segment dword public use32 'data'
    messageWindow db '������� ���������',0
    titleWindow db '���������',0
_data ends
;������� ����
_text segment dword public use32 'code'
start:
    push 03; 0503h
    push offset titleWindow
    push offset messageWindow
    push 0 ; ���������� ������
    call MessageBoxA@16
    ;-----------------------------------
    push 0
    call ExitProcess@4
_text ends
end start