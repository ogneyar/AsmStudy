nasm -f win32 test.asm
golink /console kernel32.dll user32.dll test.obj