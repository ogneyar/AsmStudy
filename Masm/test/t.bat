ml /c /coff /D MASM test.asm 
@REM /D MASM - определение константы
link /SUBSYSTEM:WINDOWS test.obj
test.exe