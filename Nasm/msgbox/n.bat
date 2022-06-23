nasm -f win32 msgbox.asm -o msgbox.obj
golink kernel32.dll user32.dll msgbox.obj