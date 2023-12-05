.data

str_title db 'My title in this console',0
stdout_handle dd ?
cWritten dd ?
hexArr byte 25 dup (0) ; массив из 25 символов
;---------------------------------------------------------------------------------------------------------------
; CONSOLE_SCREEN_BUFFER_INFO
dwSize_X db ?
dwSize_Y db ?
dwCursorPosition_X db ?
dwCursorPosition_Y db ?
wAttributes db ?
srWindow_Left db ?
srWindow_Top db ?
srWindow_Right db ?
srWindow_Bottom db ?
dwMaximumWindowSize_X db ?
dwMaximumWindowSize_Y db ?
;---------------------------------------------------------------------------------------------------------------