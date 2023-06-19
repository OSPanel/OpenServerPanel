@echo off
set "OSP_ROOT_DIR=%~dp0..\"
if exist "%OSP_ROOT_DIR%bin\ansicon.exe" "%OSP_ROOT_DIR%bin\ansicon.exe" -p >nul 2>nul
chcp 65001 > nul
cd /d %OSP_ROOT_DIR%modules
forfiles /S /M *.pdb /C "cmd /c echo @PATH"
forfiles /S /M *.lib /C "cmd /c echo @PATH"
:: forfiles /S /M *.pdb /C "cmd /c del /q @file"
:: forfiles /S /M *.lib /C "cmd /c del /q @file"
echo on
@PAUSE
