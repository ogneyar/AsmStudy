
@echo off
@REM E:\Program\masm64\ML64 /I"E:\Program\masm64\include" /I"E:\Program\masm64\include" /c /Cp "main.asm"
@REM E:\Program\masm64\LINK /LIBPATH:"E:\Program\masm64\lib" /BASE:0x100400000 /ENTRY:WinMain /SUBSYSTEM:WINDOWS main.obj user32.lib kernel32.lib
E:\Program\masm64\bin\ml64 /c /Cp main.asm
E:\Program\masm64\bin\link /BASE:0x100400000 /ENTRY:WinMain /SUBSYSTEM:WINDOWS main.obj
@REM "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\bin\Hostx64\x64\ml64" /c /Cp main.asm
@REM "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.38.33130\bin\Hostx64\x64\link" /BASE:0x100400000 /ENTRY:WinMain /SUBSYSTEM:WINDOWS main.obj
pause
