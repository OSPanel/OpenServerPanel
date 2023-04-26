if not exist "%~dp0..\..\user\ssl\root\root.crt" exit /b 1
certutil.exe -user -addstore "Root" "%~dp0..\..\user\ssl\root\root.crt"
