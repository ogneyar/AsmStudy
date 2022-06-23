@REM set path=C:\tasm\bin
tasm atidemo.asm atidemo.obj
tlink atidemo.obj vesamode.obj unreal.obj /3
pause