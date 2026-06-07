@echo off
if not exist "%~dp0..\..\data\ssl\root\cert.crt" exit /b 1
certutil.exe -user -addstore "Root" "%~dp0..\..\data\ssl\root\cert.crt"
certutil.exe -urlcache * delete >nul 2>nul
