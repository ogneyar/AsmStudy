
.code

Draw_Line proc
; ECX - stdout
; EDX - message
    ; вывод текста в консоль
    ; invoke WriteConsole, stdout, ADDR message, SIZEOF message;, ADDR cWritten, NULL

    ret

Draw_Line endp
