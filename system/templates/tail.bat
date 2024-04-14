@echo off
set "ESC="
setlocal enabledelayedexpansion
set "width="
for /f "tokens=2 delims=:" %%a in ('mode con^|more +4') do if not defined width set /a width=%%a
for /l %%a in (1,1,%width%) do set "line=!line!─"
if exist "%1" for %%S in ("%1") do if %%~zS==0 (
    echo %ESC%[90m%line%%ESC%[0m
    echo {lang_journal} %1 ^({lang_empty_log}^)
    echo %ESC%[90m%line%%ESC%[0m
) else (
    echo %ESC%[90m%line%%ESC%[0m
    echo {lang_journal} %1
    echo %ESC%[90m%line%%ESC%[0m
    "{root_dir}\system\bin\tail.exe" %1 -%2 | "{root_dir}\system\bin\bat.exe" -f -l log --style=plain --theme=ansi
    echo:
    echo %ESC%[90m%line%%ESC%[0m
)
endlocal
