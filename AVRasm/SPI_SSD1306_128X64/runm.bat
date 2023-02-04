echo off
cls
make pro_mini
if "%errorlevel%" == "0" (goto :1)
pause
:1