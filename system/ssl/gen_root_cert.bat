@echo off
echo:
setlocal
set "OPENSSL_CONF=%~dp0openssl.cnf"
set "ROOT_CERT_FILE=%~dp0..\..\data\ssl\root\cert.crt"
set "ROOT_KEY_FILE=%~dp0..\..\data\ssl\root\cert.key"
set "ROOT_CA_FILE=%~dp0..\..\data\ssl\cacert.pem"
set "PERL_CA_ROOT=%~dp0..\..\addons\Perl-5.32\perl\vendor\lib\Mozilla\CA"
if not exist "%~dp0..\..\data\ssl\root\" mkdir "%~dp0..\..\data\ssl\root"
del /Q "%ROOT_CERT_FILE%" >nul 2>nul
del /Q "%ROOT_KEY_FILE%" >nul 2>nul
del /Q "%ROOT_CA_FILE%" >nul 2>nul
del /Q "%PERL_CA_ROOT%\cacert.pem" >nul 2>nul
"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%ROOT_KEY_FILE%"
"%~dp0openssl.exe" req -x509 -new -sha256 -key "%ROOT_KEY_FILE%" -days 3650 -out "%ROOT_CERT_FILE%" -subj "/emailAddress=root@ospanel.local/C=EU/stateOrProvinceName=Local Network/O=Open Server Panel/CN=Open Server Panel"
copy "%~dp0..\..\system\ssl\cacert.pem" "%ROOT_CA_FILE%" >nul
echo:>> "%ROOT_CA_FILE%"
echo Open Server Panel Root CA>> "%ROOT_CA_FILE%"
echo =========================>> "%ROOT_CA_FILE%"
copy "%ROOT_CA_FILE%" + "%ROOT_CERT_FILE%" "%ROOT_CA_FILE%" /b /y >nul
echo:>> "%ROOT_CA_FILE%"
if exist "%PERL_CA_ROOT%\" copy "%ROOT_CA_FILE%" "%PERL_CA_ROOT%\cacert.pem" >nul
if /i "%1"=="addstore" call "%~dp0add_root_to_certstore.bat"
endlocal
