:start
@echo off
@mode con cols=100 lines=30
@title texTide
@setlocal EnableDelayedExpansion
set "config=config.edi"
call :init
:menu
cls
color %property.colorHome%
call :print home.title
call :print spacer.1
call :print home.splash
call :print spacer.2
call :print home.menu
choice /c 12345 /n /cs /t 120 /d 6 /m       -
if "%errorlevel%" == "1" goto 
if "%errorlevel%" == "2" goto
if "%errorlevel%" == "3" call :about 
if "%errorlevel%" == "4" goto troubleshoot 
if "%errorlevel%" == "5" goto exit
goto menu

set /p exit=Press enter to exit.
call :troubleshoot
exit

:about
call :print util.fade
color %property.colorCredits%
call :print spacer.1 soundful
call :print home.title soundful
call :print spacer.1 soundful
call :print home.splash	soundful
call :print about soundful
call :print credits soundful
call :print util.fade soundful
exit /b 0

:exit
exit 0

:init
set $=
for /f "tokens=* delims=\n" %%s in (%config%) do (
	set line=%%s
	if "!line:~0,1!" neq "#" (
		for /f "tokens=1-2 delims=: " %%g in ("!line!") do (
			set "%%g=%%h"
		)
	)
)
set "beep=Echo/| CHOICE /N 2> nul"
call :initGraphicProperties
exit /b 0

:initGraphicProperties
set $=
for /f "tokens=* delims=\n" %%s in (graphics/%graphic%.edi) do (
	set line=%%s
	if defined $ (
			set "property.!$!=!line!"
	)
	set $=
	if "!line:~0,10!" == "@property." set $=!line:@property.=!
)
exit /b 0

:print
rem param1 = Id in graphic.edi param2 = delightful/soundful
set $=
for /f "tokens=* delims=\n" %%s in (graphics/%graphic%.edi) do (
	set line=%%s
	if "!line:~0,1!" == "@" set $=
	if defined $ (
		if "!line!" == "." (
			echo.
		) else (
			echo !line!
		)
		if "%~2" == "delightful" (
			@ping localhost -n 2 > nul
		) else if "%~2" == "soundful" (
			%beep%
		)
	)
	if "!line!" == "@%~1" set $=1
)
exit /b 0

:troubleshoot
color 0c
echo. 	
echo 	 TROUBLESHOOTER
echo.
echo 	 Restarting in 5 seconds.
echo 	 Skip by pressing any button.
echo. 	
timeout /t 5 > nul
goto start