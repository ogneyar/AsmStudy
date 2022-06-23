includelib user32.lib
   extrn __imp__DispatchMessageA@4:dword
   extrn __imp__TranslateMessage@4:dword
   extrn __imp__GetMessageA@16:dword
   extrn __imp__LoadIconA@8:dword
   extrn __imp__UpdateWindow@4:dword
   extrn __imp__ShowWindow@8:dword
   extrn __imp__CreateWindowExA@48:dword
   extrn __imp__DefWindowProcA@16:dword
   extrn __imp__PostQuitMessage@4:dword
   extrn __imp__RegisterClassExA@4:dword
   extrn __imp__LoadCursorA@8:dword
   extrn __imp__DestroyWindow@4:dword
DispatchMessage  equ __imp__DispatchMessageA@4
TranslateMessage equ __imp__TranslateMessage@4
GetMessage       equ __imp__GetMessageA@16
LoadIcon         equ __imp__LoadIconA@8
UpdateWindow     equ __imp__UpdateWindow@4
ShowWindow       equ __imp__ShowWindow@8
CreateWindowEx   equ __imp__CreateWindowExA@48
DefWindowProc    equ __imp__DefWindowProcA@16
PostQuitMessage  equ __imp__PostQuitMessage@4
RegisterClassEx  equ __imp__RegisterClassExA@4
LoadCursor       equ __imp__LoadCursorA@8
DestroyWindow    equ __imp__DestroyWindow@4