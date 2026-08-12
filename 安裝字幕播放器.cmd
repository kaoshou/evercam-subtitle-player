@echo off
rem Project: https://github.com/kaoshou/evercam-subtitle-player
setlocal
title EverCam Subtitle Player Installer

set "NO_LAUNCH="
if /I "%~2"=="--no-launch" set "NO_LAUNCH=-NoLaunch"

powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File "%~dp0scripts\Install-Player.ps1" -CourseFolder "%~1" %NO_LAUNCH%
if errorlevel 2 exit /b 0
if errorlevel 1 (
    echo.
    echo Installation failed. Please review the message above.
    pause
    exit /b 1
)

if /I "%~2"=="--no-launch" exit /b 0

echo.
echo Installation completed. The course player is now open.
timeout /t 3 /nobreak >nul
