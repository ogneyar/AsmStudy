includelib kernel32.lib
   extrn __imp__GetModuleHandleA@4:dword
   extrn __imp__ExitProcess@4:dword
ExitProcess     equ __imp__ExitProcess@4
GetModuleHandle equ __imp__GetModuleHandleA@4