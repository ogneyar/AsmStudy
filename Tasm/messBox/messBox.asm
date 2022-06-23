;добавляем наши библиотеки и описания
include def32.inc
include user32.inc
include kernel32.inc
 .386        ;модель памяти flat появилась на 386 - ом процессоре
 .model flat

;константы
 .const
class db "window class 1",0 ;класс окна
name_ db "Da window!",0     ;Имя окна
;переменные

 .data
wc   wndclassex<4*12, cs_hredraw or cs_vredraw, offset win_proc,0,0,?,?,?, color_window+1,0,offset class,0>

 .data?
msg_ msg <?,?,?,?,?,?> ;сообщения

;сам код
 .code
_start: ;начальная метка
 xor ebx,ebx
 push ebx
 call GetModuleHandle
 mov esi,eax                    ;получаем hanle нашей программы в esi
 mov dword ptr wc.hInstance,eax ;так-же устанавливаем его отцом нашего окна
 push IDI_APPLICATION
 push ebx
 call LoadIcon
 mov wc.hIcon,eax               ;стандартная иконка Windows
 push idc_arrow
 push ebx
 call LoadCursor
 mov wc.hCursor,eax             ;стандартную мышь
 push offset wc
 call RegisterClassEx           ;регистрируем его (переменную окна wc)
 mov ecx,CW_USEDEFAULT
 push ebx
 push esi
 push ebx
 push ebx
 push ecx
 push ecx
 push ecx
 push ecx
 push WS_OVERLAPPEDWINDOW
 push offset name_
 push offset class
 push ebx
 call CreateWindowEx            ;И создаём окно!
 push eax
 push SW_SHOWNORMAL
 push eax
 call ShowWindow                ;показываем его народу;)
 call UpdateWindow              ;показываем его и обновляем!
 mov edi,offset msg_
main_:
 push ebx
 push ebx
 push ebx
 push edi
 call GetMessage                ;получаем сообщение
 test eax,eax
 jz exit_                       ;если это 0, то выход
 push edi
 call TranslateMessage
 push edi
 call DispatchMessage           ;преобразуем сообщения для процедуры окна.
 jmp main_
exit_:
 push ebx
 call ExitProcess               ;выход из программы

win_proc proc                   ;процедура окна!
 push ebp
 mov ebp,esp

wp_hWnd   equ dword ptr [ebp+08h] ;так как сообщения передаются
wp_uMsg   equ dword ptr [ebp+0Ch] ;при помощи стека,
wp_wParam equ dword ptr [ebp+10h] ;то можно напрямую
wp_lParam equ dword ptr [ebp+14h] ;к ним обращатся!

 cmp wp_uMsg,WM_DESTROY            ;если сообщение о закрытии окна
 jne not_
 push 0
 call PostQuitMessage              ;послать сообщение о выходе
 jmp end_
not_: ;если нет
 leave
 jmp DefWindowProc                 ;Пусть Windows обрабатывает сообщение
end_:
 leave
;Возвращение из процедуры с удалением из стека четырёх(16/4=4) параметров
 ret 16
win_proc endp

 end _start