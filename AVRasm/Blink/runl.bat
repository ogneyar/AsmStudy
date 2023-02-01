echo off
cls
make lgt8f
if "%errorlevel%" == "0" (goto :1)
pause
:1