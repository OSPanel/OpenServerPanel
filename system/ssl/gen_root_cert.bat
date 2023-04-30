@echo off
echo:
setlocal
set "OPENSSL_CONF=%~dp0openssl.cnf"
if not exist "%~dp0..\..\data\ssl\root\" mkdir "%~dp0..\..\data\ssl\root"
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%~dp0..\..\data\ssl\root\cert.key"
"%~dp0openssl.exe" req -x509 -new -sha256 -key "%~dp0..\..\data\ssl\root\cert.key" -days 3650 -out "%~dp0..\..\data\ssl\root\cert.crt" -subj "/emailAddress=root@ospanel.local/C=EU/stateOrProvinceName=Local Network/O=Open Server Panel/CN=Open Server Panel"
if /i "%1"=="addstore" call "%~dp0add_root_to_certstore.bat"
endlocal
