@echo off
setlocal enabledelayedexpansion

set "search=%userprofile%"
set "replace=~"

for /f "delims=" %%i in ('more') do (
    set "line=%%i"
    set "line=!line:%search%=%replace%!"
    set "line=!line:\=/!"
    echo !line!
)

endlocal
