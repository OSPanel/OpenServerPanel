@echo off
if not exist "%~dp0..\..\temp\%1_v3.txt" exit /b 1
mkdir "%~dp0..\..\user\ssl\modules\%1"
del /Q "%~dp0..\..\user\ssl\modules\%1\cert.key"
del /Q "%~dp0..\..\user\ssl\modules\%1\cert.csr"
del /Q "%~dp0..\..\user\ssl\modules\%1\cert.crt"
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%~dp0..\..\user\ssl\modules\%1\cert.key"
"%~dp0openssl.exe" req -new -SHA256 -key "%~dp0..\..\user\ssl\modules\%1\cert.key" -out "%~dp0..\..\user\ssl\modules\%1\cert.csr" -subj "/emailAddress=root@ospanel.local/C=EU/stateOrProvinceName=Local Network/O=Open Server Panel/CN=%1"
"%~dp0openssl.exe" x509 -req -SHA256 -extfile "%~dp0..\..\temp\%1_v3.txt" -days 3650 -extensions trust_cert -in "%~dp0..\..\user\ssl\modules\%1\cert.csr" -CA "%~dp0..\..\user\ssl\root\root.crt" -CAkey "%~dp0..\..\user\ssl\root\root.key" -out "%~dp0..\..\user\ssl\modules\%1\cert.crt"
del /Q "%~dp0..\..\temp\%1_v3.txt"
