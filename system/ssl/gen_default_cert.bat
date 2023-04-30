@echo off
echo:
setlocal
set "OPENSSL_CONF=%~dp0openssl.cnf"
if not exist "%~dp0..\..\user\ssl\default\" mkdir "%~dp0..\..\user\ssl\default"
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%~dp0..\..\user\ssl\default\cert.key"
"%~dp0openssl.exe" req -new -sha256 -key "%~dp0..\..\user\ssl\default\cert.key" -out "%~dp0..\..\user\ssl\default\cert.csr" -subj "/emailAddress=default@ospanel.local/C=EU/stateOrProvinceName=Local Network/O=Open Server Panel/CN=Default Certificate"
"%~dp0openssl.exe" x509 -req -sha256 -days 3650 -in "%~dp0..\..\user\ssl\default\cert.csr" -signkey "%~dp0..\..\user\ssl\default\cert.key" -out "%~dp0..\..\user\ssl\default\cert.crt" > nul 2> nul
endlocal
