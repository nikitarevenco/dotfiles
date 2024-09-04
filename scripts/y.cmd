@echo off

set tmpfile=%TEMP%\yazi-cwd.%random%

yazi %* --cwd-file="%tmpfile%"

set /p cwd=<%tmpfile%

if not "%cwd%"=="" (
    cd /d "%cwd%"
)

del "%tmpfile%"
