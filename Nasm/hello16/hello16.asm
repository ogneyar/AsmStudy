; DOS

SECTION .text
org 0x100		; эта директива нужна только в случае .com файла, в котором нет никаких	секций
	mov ah, 0x9
	mov dx, hello
	int 0x21	
	mov ax, 0x4c00		; ah == 0x4c al == 0x00
	int 0x21
SECTION .data
	hello DB "Hello, world!",0xd,0xa,'$'