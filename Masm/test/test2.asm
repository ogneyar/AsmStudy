.386
.model flat, stdcall
; option casemap :none   ; case sensitive
;#########################################################################
; include \masm32\include\windows.inc ; MB_OK, NULL
include \masm32\include\user32.inc ; MessageBox
include \masm32\include\kernel32.inc ; ExitProcess

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
;#########################################################################
.data
	MsgBoxCaption db "It's the first your program for Win32",0
	MsgBoxText    db "Assembler language for Windows is a fable!",0
;#########################################################################
.code
start:	
    ; push 0 ; MB_OK
    ; push offset MsgBoxCaption
    ; push offset MsgBoxText
    ; push 0 ; NULL
    ; call MessageBox
    ; push NULL
    ; call ExitProcess

    invoke MessageBox, 0, addr MsgBoxText, addr MsgBoxCaption, 0
	invoke ExitProcess, 0
    ; invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK
	; invoke ExitProcess, NULL

end start