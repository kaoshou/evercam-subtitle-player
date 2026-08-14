@echo off
rem Project: https://github.com/kaoshou/evercam-subtitle-player
setlocal EnableExtensions
title EverCam Subtitle Player Installer

set "INSTALLER_SCRIPT=%~dp0scripts\Install-Player.ps1"
set "POWERSHELL_EXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
set "NO_LAUNCH="
if /I "%~2"=="--no-launch" set "NO_LAUNCH=-NoLaunch"

if not exist "%INSTALLER_SCRIPT%" (
    echo.
    echo The installer package is incomplete.
    echo Missing file: %INSTALLER_SCRIPT%
    pause
    exit /b 1
)

if not exist "%POWERSHELL_EXE%" set "POWERSHELL_EXE=powershell.exe"

if "%~1"=="" (
    "%POWERSHELL_EXE%" -NoLogo -NoProfile -ExecutionPolicy Bypass -STA -File "%INSTALLER_SCRIPT%" %NO_LAUNCH%
) else (
    "%POWERSHELL_EXE%" -NoLogo -NoProfile -ExecutionPolicy Bypass -STA -File "%INSTALLER_SCRIPT%" -CourseFolder "%~1" %NO_LAUNCH%
)

set "INSTALL_EXIT=%ERRORLEVEL%"
if "%INSTALL_EXIT%"=="2" exit /b 0
if not "%INSTALL_EXIT%"=="0" (
    echo.
    echo Installation failed. Error code: %INSTALL_EXIT%
    echo Please keep this window open and review the error message above.
    echo Project help: https://github.com/kaoshou/evercam-subtitle-player
    echo.
    pause
    exit /b 1
)

if /I "%~2"=="--no-launch" exit /b 0

echo.
echo Installation completed. The course player is now open.
timeout /t 3 /nobreak >nul
