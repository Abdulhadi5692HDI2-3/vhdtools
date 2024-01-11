@echo off
:: VHD just should be a filename.
set VHD=%CD%\%~1

:: script for diskpart to execute
set VHDSCRIPT=%CD%\diskpart.txt

:: efi partition size (in MB)
set partsize=%~2

:: if the vhd script still exist
:: delete them. 
:: >nul 2>nul redirects the output of the command (which might be an error)
:: to nul. (on linux /dev/null)
del %VHDSCRIPT% >nul 2>nul

:: Make vhd script for diskpart to execute
@(
	echo select vdisk FILE="%VHD%" NOERR
	echo attach vdisk NOERR
	echo create partition efi size=%partsize% NOERR
	echo format quick fs=fat32 label="System" NOERR
	echo assign letter=A NOERR
	echo detach vdisk NOERR
	echo exit
)>%VHDSCRIPT%

diskpart.exe /s %VHDSCRIPT%
goto :eof