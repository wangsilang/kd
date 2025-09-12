@echo off
setlocal enabledelayedexpansion

echo KD 词典交互式批处理脚本
echo 输入 'exit' 退出脚本
echo -----------------------------

:loop
set /p query="请输入查询内容: "

if /i "%query%"=="exit" goto :end

echo.
echo 正在查询: %query%
echo -----------------------------
call build\kd.exe %query%
echo -----------------------------
echo.

goto loop

:end
echo 感谢使用，再见！