OPTION DOTNAME
; option casemap:none

include temphls.inc
include win64.inc
include kernel32.inc
includelib kernel32.lib

.data

msgtw db 'Hello world!!!',10,13
stdout dd ?
cWritten dd ?
 
.code

main proc 
LOCAL msg:MSG
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov stdout, eax 
    invoke SetConsoleMode, eax, ENABLE_PROCESSED_OUTPUT
    invoke WriteConsole, stdout, ADDR msgtw, SIZEOF msgtw, ADDR cWritten, NULL
    invoke Sleep, 3000
    invoke ExitProcess, NULL
main endp

end
