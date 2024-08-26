
@echo off
setlocal

if "%~1"=="" (
    echo Usage: move [source] [destination]
    exit /b 1
)

set "source=%~1"
set "destination=%~2"

echo Moving files/directories from "%source%" to "%destination%"

robocopy "%source%" "%destination%" /MOV /E

if %ERRORLEVEL% LEQ 8 (
    echo Move operation completed successfully.
) else (
    echo Move operation encountered errors.
)

:: Remove empty source directory if it was originally a directory
if exist "%source%" rd /s /q "%source%"

endlocal
