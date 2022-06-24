@echo off
:test
cls
color 0a
start editor.bat /wait
color 0c
echo Press any key to execute
pause > nul
goto test