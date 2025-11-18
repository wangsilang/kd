@echo off
setlocal enabledelayedexpansion

set LOG_DIR=D:\Daily

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

for /f "tokens=1-3 delims=/" %%a in ('date /t') do (
    set DATE_STR=%%c%%a%%b
)
set LOG_FILE=%LOG_DIR%\kd_%DATE_STR%.txt

echo Input 'exit' to exit
echo -----------------------------

:loop
set /p query="input: "

if /i "%query%"=="exit" goto :end

echo %query% >> "%LOG_FILE%"

echo.
echo -----------------------------
call kd.exe %query%
echo -----------------------------
echo.

goto loop

:end
echo Thanks