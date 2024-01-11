@echo off
:: VHD just should be a filename.
set VHD=%CD%\%~1

:: script for diskpart to execute
set VHDSCRIPT=%CD%\diskpart.txt

:: if the vhd script still exist
:: delete them. 
:: >nul 2>nul redirects the output of the command (which might be an error)
:: to nul. (on linux /dev/null)
del %VHDSCRIPT% >nul 2>nul

:: Make vhd script for diskpart to execute
@(
	echo select vdisk FILE="%VHD%" 
	echo sel par 2 NOERR
	echo remove letter=A NOERR
	echo detach vdisk NOERR
)>%VHDSCRIPT%

diskpart.exe /s %VHDSCRIPT% > diskpart.log
goto :eof