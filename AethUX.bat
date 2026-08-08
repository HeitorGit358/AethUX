@echo off
setlocal EnableExtensions
title AethUX - Windows 10 Theme Installer
color 0B

:: ============================================================
:: AethUX
:: Windows 10 Theme Installer
:: ============================================================

set "WIN7_URL=https://github.com/HeitorGit358/AethUX/raw/refs/heads/main/Files/Aero10%%20Seven.theme"
set "VISTA_URL=https://github.com/HeitorGit358/AethUX/raw/refs/heads/main/Files/Aero10%%20Vista.theme"

set "THEME_DIR=C:\Windows\Resources\Themes"
set "TEMP_DIR=%TEMP%\AethUX"

:: ============================================================
:: Administrator check
:: ============================================================

net session >nul 2>&1

if %errorlevel% neq 0 (
    echo.
    echo [!] Administrator privileges are required.
    echo [*] Restarting AethUX as Administrator...
    echo.

    powershell -NoProfile -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ============================================================
:: Windows 10 check
:: ============================================================

for /f "tokens=4-5 delims=. " %%A in ('ver') do (
    set "WIN_MAJOR=%%A"
    set "WIN_BUILD=%%B"
)

:: Windows 11 starts at build 22000
if defined WIN_BUILD (
    if %WIN_BUILD% GEQ 22000 goto Windows11
)

:: ============================================================
:: Prepare
:: ============================================================

if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%" >nul 2>&1

if not exist "%THEME_DIR%" (
    echo [ERROR] Windows Themes directory was not found.
    echo.
    pause
    exit /b 1
)

:: ============================================================
:: Main Menu
:: ============================================================

:MENU

cls

echo.
echo ==============================================
echo                    AETHUX
echo          Windows 10 Theme Installer
echo ==============================================
echo.
echo  System:
echo    Windows 10 detected
echo.
echo  Themes:
echo.
echo    [1] Install Windows 7 Theme
echo        Aero10 Seven
echo.
echo    [2] Install Windows Vista Theme
echo        Aero10 Vista
echo.
echo    [3] Install Custom .theme
echo.
echo    [0] Exit
echo.
echo ==============================================
echo.

set "CHOICE="
set /p "CHOICE=Select an option: "

if "%CHOICE%"=="1" goto WIN7
if "%CHOICE%"=="2" goto VISTA
if "%CHOICE%"=="3" goto CUSTOM
if "%CHOICE%"=="0" goto EXIT

echo.
echo [ERROR] Invalid option.
timeout /t 2 >nul
goto MENU


:: ============================================================
:: Windows 7 Theme
:: ============================================================

:WIN7

cls

echo.
echo ==============================================
echo           AETHUX - Windows 7 Theme
echo ==============================================
echo.
echo [1/3] Downloading Aero10 Seven...
echo.

set "THEME_FILE=%TEMP_DIR%\Aero10 Seven.theme"

curl.exe -L --fail --silent --show-error ^
    "%WIN7_URL%" ^
    -o "%THEME_FILE%"

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to download the theme.
    echo.
    pause
    goto MENU
)

echo [OK] Download complete.
echo.

echo [2/3] Installing theme...

copy /Y "%THEME_FILE%" "%THEME_DIR%\Aero10 Seven.theme" >nul

if errorlevel 1 (
    echo [ERROR] Failed to copy the theme.
    echo.
    pause
    goto MENU
)

echo [OK] Theme installed.
echo.

echo [3/3] Applying theme...
echo.

start "" "%THEME_DIR%\Aero10 Seven.theme"

echo [OK] Aero10 Seven launched.
echo.

pause
goto MENU


:: ============================================================
:: Windows Vista Theme
:: ============================================================

:VISTA

cls

echo.
echo ==============================================
echo          AETHUX - Windows Vista Theme
echo ==============================================
echo.
echo [1/3] Downloading Aero10 Vista...
echo.

set "THEME_FILE=%TEMP_DIR%\Aero10 Vista.theme"

curl.exe -L --fail --silent --show-error ^
    "%VISTA_URL%" ^
    -o "%THEME_FILE%"

if errorlevel 1 (
    echo.
    echo [ERROR] Failed to download the theme.
    echo.
    pause
    goto MENU
)

echo [OK] Download complete.
echo.

echo [2/3] Installing theme...

copy /Y "%THEME_FILE%" "%THEME_DIR%\Aero10 Vista.theme" >nul

if errorlevel 1 (
    echo [ERROR] Failed to copy the theme.
    echo.
    pause
    goto MENU
)

echo [OK] Theme installed.
echo.

echo [3/3] Applying theme...
echo.

start "" "%THEME_DIR%\Aero10 Vista.theme"

echo [OK] Aero10 Vista launched.
echo.

pause
goto MENU


:: ============================================================
:: Custom Theme
:: ============================================================

:CUSTOM

cls

echo.
echo ==============================================
echo             AETHUX - Custom Theme
echo ==============================================
echo.
echo Enter the full path to your .theme file.
echo.
set "CUSTOM_THEME="

set /p "CUSTOM_THEME=Path: "

if not exist "%CUSTOM_THEME%" (
    echo.
    echo [ERROR] File not found.
    echo.
    pause
    goto MENU
)

if /I not "%CUSTOM_THEME:~-6%"==".theme" (
    echo.
    echo [ERROR] The selected file is not a .theme file.
    echo.
    pause
    goto MENU
)

echo.
echo [1/2] Copying theme...

copy /Y "%CUSTOM_THEME%" "%THEME_DIR%\" >nul

if errorlevel 1 (
    echo [ERROR] Failed to copy the theme.
    echo.
    pause
    goto MENU
)

for %%F in ("%CUSTOM_THEME%") do set "CUSTOM_NAME=%%~nxF"

echo [OK] Theme installed.
echo.

echo [2/2] Applying theme...

start "" "%THEME_DIR%\%CUSTOM_NAME%"

echo [OK] Theme launched.
echo.

pause
goto MENU


:: ============================================================
:: Windows 11
:: ============================================================

:Windows11

cls

echo.
echo ==============================================
echo                    AETHUX
echo ==============================================
echo.
echo [ERROR] Unsupported Windows version.
echo.
echo AethUX currently supports Windows 10 only.
echo Windows 11 support will be added in a future
echo version.
echo.

pause
exit /b 1


:: ============================================================
:: Exit
:: ============================================================

:EXIT

cls

echo.
echo Thank you for using AethUX.
echo.

timeout /t 1 >nul

exit /b 0