@echo off
setlocal
set "current_dir=%cd%"
wezterm-gui start --cwd "%current_dir%"
endlocal
