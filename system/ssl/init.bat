mkdir "%~dp0..\..\user\ssl\root"
mkdir "%~dp0..\..\user\ssl\default"
del /Q "%~dp0..\..\user\ssl\root\cert.key"
del /Q "%~dp0..\..\user\ssl\root\cert.crt"
del /Q "%~dp0..\..\user\ssl\default\cert.key"
del /Q "%~dp0..\..\user\ssl\default\cert.csr"
del /Q "%~dp0..\..\user\ssl\default\cert.crt"
set "OPENSSL_CONF=%~dp0openssl.cnf"
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%~dp0..\..\user\ssl\root\cert.key"
"%~dp0openssl.exe" req -x509 -new -sha256 -key "%~dp0..\..\user\ssl\root\cert.key" -days 3650 -out "%~dp0..\..\user\ssl\root\cert.crt" -subj "/emailAddress=/C=EU/stateOrProvinceName=/O=Open Server Panel/CN=Open Server Panel"
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%~dp0..\..\user\ssl\default\cert.key"
"%~dp0openssl.exe" req -new -sha256 -key "%~dp0..\..\user\ssl\default\cert.key" -out "%~dp0..\..\user\ssl\default\cert.csr" -subj "/emailAddress=/C=EU/stateOrProvinceName=/O=Open Server Panel/CN=Default Certificate"
"%~dp0openssl.exe" x509 -req -sha256 -days 3650 -in "%~dp0..\..\user\ssl\default\cert.csr" -signkey "%~dp0..\..\user\ssl\default\cert.key" -out "%~dp0..\..\user\ssl\default\cert.crt"
if /i "%1"=="addstore" call "%~dp0add_root_to_certstore.bat"