; обычное присвоение NULL = 0
NULL EQU 0
; обычное присвоение STD_OUTPUT_HANDLE = -11
; The standard output device. (вывод на экран)
STD_OUTPUT_HANDLE EQU -11
; STD_INPUT_HANDLE EQU -10
; STD_ERROR_HANDLE EQU -12

; переменные для модального окна
MB_OKCANCEL EQU 0x00000001
IDOK EQU 1
IDCANCEL EQU 2

; Извлекает дескриптор для указанного стандартного устройства
; (standard input, standard output, or standard error)
extern _GetStdHandle@4  ; Library - Kernel32.lib
; Запись данных в указанный файл или устройство ввода-вывода
extern _WriteFile@20    ; Library - Kernel32.lib
; Завершает вызывающий процесс и все его потоки
extern _ExitProcess@4   ; Library - Kernel32.lib
; Отображает модальное диалоговое окно
extern _MessageBoxA@16     ; Library - User32.lib

; точка входа
global Start

section .data

    Message db "Hello from Nasm on Windows", 0Dh, 0Ah ; 0Dh - конец строки, а 0Ah - переход на новую строку
    MessageLength EQU $-Message

    MessageExit db 0x0A, "Exit Nasm"
    MessageExitLength EQU $-MessageExit
    
    Caption db 'From Nasm',0
    Text db "Hello",0xA, "World"

    ; choice DB 'y'

section .bss
    ; res - резервирование данных, resd вроде 4байта (reserve dword)
    StandardHandle resd 1
    Written resd 1

section .text

    Start:
        ; push - типа запись данных в функцию ( GetStdHandle( STD_OUTPUT_HANDLE ) )
        push STD_OUTPUT_HANDLE  
        call _GetStdHandle@4    ; вызов функции
        ; запись данных из EAX в переменную StandardHandle
        mov dword [StandardHandle], EAX

        push MB_OKCANCEL
        push Caption
        push Text
        push NULL
        call _MessageBoxA@16    ; вызов функции

        cmp EAX, IDOK
        je Retry

        push NULL
        push Written
        push MessageExitLength
        push MessageExit
        push dword [StandardHandle]
        call _WriteFile@20      ; вызов функции

        jmp Exit


    Retry:
        push NULL
        push Written
        push MessageLength
        push Message
        push dword [StandardHandle]
        call _WriteFile@20      ; вызов функции

        jmp Start

    
    Exit:
        push NULL
        call _ExitProcess@4     ; вызов функции



    ; Start:
    ;     mov	edx,1		      ; длина сообщения 
    ;     mov	ecx,choice        ; сообщение для вывода
    ;     mov	ebx,1		      ; файловый дескриптор (stdout)
    ;     mov	eax,4		      ; номер системного вызова (sys_write)
    ;     int	0x80		      ; вызов ядра 
        
    ;     mov	eax,1		      ; номер системного вызова (sys_exit)
    ;     int	0x80		      ; вызов ядра
 