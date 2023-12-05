set masm64_path=E:\Program\masm64\
%masm64_path%bin\ml64 /Cp /c /I"%masm64_path%Include" main.asm || exit
%masm64_path%bin\link /SUBSYSTEM:console /LIBPATH:"%masm64_path%Lib" ^
/ENTRY:main /BASE:0x100400000 main.obj || exit
@REM /ENTRY:main /BASE:0x400000 /LARGEADDRESSAWARE:NO main.obj || exit
main.exe
