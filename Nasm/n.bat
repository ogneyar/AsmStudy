nasm -f win32 t.asm
golink /console t.obj kernel32.dll user32.dll