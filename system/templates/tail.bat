@echo off
set "ESC="
setlocal enabledelayedexpansion
for /f "skip=4 tokens=2 delims=:" %%a in ('mode con') do if not defined width set /a width=%%a
for /l %%a in (1,1,%width%) do set "line=!line!─"
if exist "%1" for %%S in ("%1") do if %%~zS==0 (
    echo %ESC%[90m%line%%ESC%[0m
    echo %ESC%[36m{lang_journal} %1 ^({lang_empty_log}^)%ESC%[0m
    echo %ESC%[90m%line%%ESC%[0m
) else (
    echo %ESC%[90m%line%%ESC%[0m
    echo %ESC%[36m{lang_journal} %1%ESC%[0m
    echo %ESC%[90m%line%%ESC%[0m
    "%OSP_DIR%\system\bin\tail.exe" %1 -%2 | "%OSP_DIR%\system\bin\bat.exe" -f -l log --style=plain --theme=ansi
    echo:
    echo %ESC%[90m%line%%ESC%[0m
)
endlocal
