@echo off
:: VHD just should be a filename.
set VHD=%CD%\%~1

:: script for diskpart to execute
set VHDSCRIPT=%CD%\diskpart.txt

:: disk size (in MB)
set disksize=%~2

:: if the vhd or vhd script still exist
:: delete them. 
:: >nul 2>nul redirects the output of the command (which might be an error)
:: to nul. (on linux /dev/null)
del %VHD% >nul 2>nul
del %VHDSCRIPT% >nul 2>nul

:: Make vhd script for diskpart to execute
@(
	echo create vdisk FILE="%VHD%" MAXIMUM=%disksize% NOERR
	echo select vdisk FILE="%VHD%" NOERR
	echo attach vdisk NOERR
	echo convert gpt NOERR
	echo detach vdisk NOERR
	echo exit
)>%VHDSCRIPT%

diskpart.exe /s %VHDSCRIPT%
goto :eof