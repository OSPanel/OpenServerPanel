@echo off
if not exist "%~dp0bin\osp.bat" exit /b 1
start "Open Server Panel" cmd /k "%~dp0bin\osp.bat" reset init
