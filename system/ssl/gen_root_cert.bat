@echo off
echo:
setlocal

set "OPENSSL_CONF=%~dp0openssl.cnf"

set "ROOT_DIR=%~dp0..\..\data\ssl\root"
set "ROOT_CERT_FILE=%ROOT_DIR%\cert.crt"
set "ROOT_KEY_FILE=%ROOT_DIR%\cert.key"

set "SYSTEM_CA_FILE=%~dp0..\..\system\ssl\cacert.pem"
set "ROOT_CA_FILE=%~dp0..\..\data\ssl\cacert.pem"

if not exist "%ROOT_DIR%\" mkdir "%ROOT_DIR%" || exit /b 1

del /Q "%ROOT_CERT_FILE%" >nul 2>nul
del /Q "%ROOT_KEY_FILE%"  >nul 2>nul
del /Q "%ROOT_CA_FILE%"   >nul 2>nul

for /f %%S in ('"%~dp0openssl.exe" rand -hex 15') do set "SERIAL=0x01%%S"

"%~dp0openssl.exe" ecparam -genkey -name prime256v1 -out "%ROOT_KEY_FILE%" || exit /b 1

"%~dp0openssl.exe" req -x509 -new -sha256 ^
  -config "%OPENSSL_CONF%" -extensions v3_ca ^
  -key "%ROOT_KEY_FILE%" ^
  -days 3650 ^
  -set_serial %SERIAL% ^
  -out "%ROOT_CERT_FILE%" ^
  -subj "/O=Open Server Panel/CN=Open Server Panel Root CA" || exit /b 1

if not exist "%SYSTEM_CA_FILE%" exit /b 1

copy /b /y "%SYSTEM_CA_FILE%" "%ROOT_CA_FILE%" >nul || exit /b 1
echo:>> "%ROOT_CA_FILE%"
echo Open Server Panel Root CA>> "%ROOT_CA_FILE%"
echo =========================>> "%ROOT_CA_FILE%"
copy /b /y "%ROOT_CA_FILE%" + "%ROOT_CERT_FILE%" "%ROOT_CA_FILE%" >nul || exit /b 1
echo:>> "%ROOT_CA_FILE%"

copy /b /y "%ROOT_CA_FILE%" "%~dp0..\..\bin\curl-ca-bundle.crt" >nul
copy /b /y "%ROOT_CA_FILE%" "%~dp0..\..\system\bin\curl-ca-bundle.crt" >nul

if /i "%~1"=="addstore" call "%~dp0add_root_to_certstore.bat"

endlocal
