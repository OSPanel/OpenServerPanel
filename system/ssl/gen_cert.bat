@echo off
setlocal
set "OPENSSL_CONF=%~dp0openssl.cnf"
if not exist "%~dp0..\..\temp\%1_%2_v3.txt" exit /b 1
if not exist "%~dp0..\..\data\ssl\root\cert.crt" exit /b 1
if not exist "%~dp0..\..\data\ssl\root\cert.key" exit /b 1
if not exist "%~dp0..\..\data\ssl\%1\%2\" mkdir "%~dp0..\..\data\ssl\%1\%2"
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%~dp0..\..\data\ssl\%1\%2\cert.key"
"%~dp0openssl.exe" req -new -SHA256 -key "%~dp0..\..\data\ssl\%1\%2\cert.key" -out "%~dp0..\..\data\ssl\%1\%2\cert.csr" -subj "/emailAddress=/C=/stateOrProvinceName=/O=/CN=%2"
"%~dp0openssl.exe" x509 -req -SHA256 -extfile "%~dp0..\..\temp\%1_%2_v3.txt" -days 3650 -extensions trust_cert -in "%~dp0..\..\data\ssl\%1\%2\cert.csr" -CA "%~dp0..\..\data\ssl\root\cert.crt" -CAkey "%~dp0..\..\data\ssl\root\cert.key" -out "%~dp0..\..\data\ssl\%1\%2\cert.crt"
endlocal
