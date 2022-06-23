; обычное присвоение NULL = 0
NULL EQU 0

; если нажата кнопка OK
IDOK EQU 1
; Если нажата кнопка CANCEL
IDCANCEL EQU 2
; Если нажата кнопка RETRY 
IDRETRY EQU 4
; первый знак с права отвечает за количество и вид кнопок
MB_OK EQU 0x00000000
MB_OKCANCEL EQU 0x00000001
MB_ABORTRETRYIGNORE EQU 0x00000002
MB_YESNOCANCEL EQU 0x00000003
MB_YESNO EQU 0x00000004
MB_RETRYCANCEL EQU 0x00000005
MB_CANCELTRYCONTINUE EQU 0x00000006
; второй знак добавляет звук и иконку
MB_ICONSTOP EQU 0x00000010
MB_ICONQUESTION EQU 0x00000020
MB_ICONWARNING EQU 0x00000030
MB_ICONINFORMATION EQU 0x00000040
; третий знак выделяет кнопку (0 - первую, 1 - вторую, ...)
MB_DEFBUTTON2 EQU 0x00000100
MB_DEFBUTTON3 EQU 0x00000200
MB_DEFBUTTON4 EQU 0x00000300
; четвёртый знак с цифрой 4 добавляет кнопку "справка"
MB_HELP EQU 0x00004000
; пятый знак с цифрой 8 сдвигает текст вправо
MB_RIGHT EQU 0x00080000
; шестой знак 1 выворачивает весь бокс наизнанку
MB_RTLREADING EQU 0x00100000

; Завершает вызывающий процесс и все его потоки
extern _ExitProcess@4   ; Library - Kernel32.lib
; Отображает модальное диалоговое окно
extern _MessageBoxA@16     ; Library - User32.lib

; точка входа
global Start

section .data

    Caption db 'From Nasm',0
    Text db "Hello",0xA, "World"

section .text

    Start:
        ; push 0x00184212
        push MB_HELP + MB_ICONSTOP + MB_ABORTRETRYIGNORE + MB_DEFBUTTON3 + MB_RIGHT + MB_RTLREADING
        push Caption
        push Text
        push NULL
        call _MessageBoxA@16    ; вызов функции

        cmp EAX, IDRETRY
        je Start

        push NULL
        call _ExitProcess@4     ; вызов функции
