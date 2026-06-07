@echo off
echo:
setlocal

set "OPENSSL=%~dp0openssl.exe"
set "OPENSSL_CONF=%~dp0openssl.cnf"

set "OUTDIR=%~dp0..\..\user\ssl\default"
set "KEY=%OUTDIR%\cert.key"
set "CSR=%OUTDIR%\cert.csr"
set "CRT=%OUTDIR%\cert.crt"
set "EXT=%OUTDIR%\v3_selfsigned_server.cnf"

if not exist "%OUTDIR%\" mkdir "%OUTDIR%" || exit /b 1

del /q "%CSR%" "%CRT%" "%EXT%" >nul 2>nul

"%OPENSSL%" ecparam -genkey -name prime256v1 -out "%KEY%" || exit /b 1

(
  echo [ selfsigned_server ]
  echo basicConstraints = critical,CA:FALSE
  echo keyUsage = critical,digitalSignature
  echo extendedKeyUsage = serverAuth,clientAuth
  echo subjectKeyIdentifier = hash
  echo subjectAltName = @alt_names
  echo.
  echo [ alt_names ]
  echo DNS.1 = localhost
  echo DNS.2 = *.localhost
  echo IP.1 = 127.0.0.1
  echo IP.2 = ::1
) > "%EXT%"

"%OPENSSL%" req -new -sha256 ^
  -config "%OPENSSL_CONF%" ^
  -key "%KEY%" ^
  -out "%CSR%" ^
  -subj "/CN=localhost" || exit /b 1

for /f %%S in ('"%OPENSSL%" rand -hex 15') do set "SERIAL=0x01%%S"

"%OPENSSL%" x509 -req -sha256 ^
  -in "%CSR%" ^
  -signkey "%KEY%" ^
  -days 3650 ^
  -set_serial %SERIAL% ^
  -extfile "%EXT%" ^
  -extensions selfsigned_server ^
  -out "%CRT%" || exit /b 1

endlocal
