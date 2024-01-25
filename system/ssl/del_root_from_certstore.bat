@echo off
if not exist "%~dp0..\..\data\ssl\root\cert.crt" exit /b 1
certutil.exe -user -delstore "Root" "Open Server Panel"
certutil.exe -urlcache * delete >nul 2>nul
