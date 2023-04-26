if not exist "%~dp0..\..\user\ssl\root\cert.crt" exit /b 1
certutil.exe -user -addstore "Root" "%~dp0..\..\user\ssl\root\cert.crt"
