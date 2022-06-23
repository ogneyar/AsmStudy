all:
	nasm -f win32 les32.asm
	golink les32.obj kernel32.dll user32.dll

t:
	nasm -f win32 t.asm
	golink t.obj kernel32.dll 

b:
	nasm beep.asm -o beep.exe