nasm -f win32 helloworld.asm -o helloworld.obj
golink /console kernel32.dll helloworld.obj