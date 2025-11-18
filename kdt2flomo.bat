@echo off
setlocal enabledelayedexpansion

REM Set Flomo API URL
set "URL=https://flomoapp.com/iwh/MjI3NTc4MA/87897ddf1c96211ee78e976102fb37c4/"

REM Set log directory
set "LOG_DIR=D:\Daily"

REM Create log directory
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

REM Get current date as filename
for /f "tokens=1-3 delims=/" %%a in ('date /t') do (
    set "DATE_STR=%%c%%a%%b"
)
set "LOG_FILE=%LOG_DIR%\kd_%DATE_STR%.txt"

REM Check if log file exists
if not exist "%LOG_FILE%" (
    echo Log file does not exist: %LOG_FILE%
    goto :end
)

echo Pushing log file to Flomo...
echo Log file: %LOG_FILE%
echo #en/kdt >> "%LOG_FILE%"

REM Use PowerShell to read file content and send POST request
powershell -Command "try { $content = Get-Content -Raw '%LOG_FILE%'; $response = Invoke-RestMethod -Uri '%URL%' -Method Post -Body @{content=$content} -ContentType 'application/x-www-form-urlencoded'; Write-Host 'Push successful'; exit 0 } catch { Write-Host 'Push failed:' $_.Exception.Message; exit 1 }"

REM Check if push was successful
if %ERRORLEVEL% EQU 0 (
    echo Push successful, deleting log file...
    del "%LOG_FILE%"
    if exist "%LOG_FILE%" (
        echo Warning: Failed to delete log file
    ) else (
        echo Log file deleted
    )
) else (
    echo Push failed, keeping log file
)

:end
echo Thanks