
@REM E:\Program\masm64\bin\ml64 /c /Cp main.asm
@REM E:\Program\masm64\bin\link /BASE:0x100400000 /ENTRY:main /SUBSYSTEM:CONSOLE main.obj

@REM cls
set masm64_path=E:\Program\masm64\
%masm64_path%bin\ml64 /Cp /c /I"%masm64_path%Include" main.asm || exit
%masm64_path%bin\link /SUBSYSTEM:console /LIBPATH:"%masm64_path%Lib" ^
/ENTRY:main /BASE:0x100400000 main.obj || exit

@REM del main.obj
main.exe
