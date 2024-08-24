@echo off
setlocal

REM Ensure targetDir is empty initially
set "targetDir="

REM Query zoxide and capture the output directory
for /f "delims=" %%i in ('zoxide query %* 2^>nul') do (
    set "targetDir=%%i"
)

REM Debug output
echo Target directory from zoxide: "%targetDir%"

REM If zoxide did not find the directory, use the provided argument as the directory
if not defined targetDir (
    echo zoxide did not find a match. Using the provided argument.
    set "targetDir=%~1"
)

REM Debug output
echo Final target directory: "%targetDir%"

REM Check if the directory exists
if exist "%targetDir%" (
    cd %targetDir%
    eza --icons --git-ignore --sort=changed --across --classify
) else (
    echo Directory "%targetDir%" does not exist.
)

endlocal
