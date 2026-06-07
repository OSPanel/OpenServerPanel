:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | DB INIT SCRIPT (robust for CI)
:: --------------------------------------------------------------------------------
@echo off
setlocal EnableExtensions
set LC_MESSAGES=English

:: Resolve root paths
set "TMP_ROOT=%~dp0.."
for %%I in ("%TMP_ROOT%") do set "TMP_ROOT=%%~fI"
set "OSP_ROOT_DIR=%TMP_ROOT%"
set "OSP_ROOT_DIR_UNIX=%TMP_ROOT:\=/%"

:: UTF-8 codepage
chcp 65001 >nul

TITLE DB Generator

:: ------------------------------------------------------------------------------
:: Run MySQL/MariaDB generators
:: ------------------------------------------------------------------------------

call "%OSP_ROOT_DIR%\generate\genmariadb.bat"
call "%OSP_ROOT_DIR%\generate\genmysql.bat"

:: ------------------------------------------------------------------------------
:: PostgreSQL init per version
:: ------------------------------------------------------------------------------

call :postgresql PostgreSQL-11
call :postgresql PostgreSQL-12
call :postgresql PostgreSQL-13
call :postgresql PostgreSQL-14
call :postgresql PostgreSQL-15
call :postgresql PostgreSQL-16
call :postgresql PostgreSQL-17
call :postgresql PostgreSQL-18

goto end

:: --------------------------------------------------------------------------------
:: INIT PostgreSQL (robust, no PowerShell, safe dirs, clean start)
:: Args: %1 = module name, e.g. PostgreSQL-15
:: --------------------------------------------------------------------------------

:postgresql
setlocal EnableDelayedExpansion

set "MODULE=%~1"
set "DB_DIR=%OSP_ROOT_DIR%\modules\%MODULE%"
set "DATA_DIR=%DB_DIR%\ospanel_data\default_data"
set "TMP_DIR=%DB_DIR%\temp"
set "BIN_DIR=%DB_DIR%\bin"

:: Проверки наличия каталога модуля и bin
if not exist "%DB_DIR%" (
  echo [%date% %time%] ❌ ERROR: Module directory not found: "%DB_DIR%"
  endlocal & exit /b 1
)
if not exist "%BIN_DIR%\initdb.exe" (
  echo [%date% %time%] ❌ ERROR: initdb.exe not found: "%BIN_DIR%\initdb.exe"
  endlocal & exit /b 1
)

:: Чистый старт: удалить старые data/temp и создать заново
if exist "%TMP_DIR%" rd /s /q "%TMP_DIR%"
:: if exist "%DATA_DIR%" rd /s /q "%DATA_DIR%"

mkdir "%TMP_DIR%" 2>nul
:: mkdir "%DATA_DIR%" 2>nul

:: if not exist "%DATA_DIR%" (
::   echo [%date% %time%] ❌ ERROR: Failed to create data dir: "%DATA_DIR%"
::   endlocal & exit /b 1
:: )

:: Переменные окружения для initdb/psql
set "PGDATA=%DATA_DIR%"
set "PGCLIENTENCODING=utf-8"
set "PGHOST=127.0.0.1"
set "PGLOCALEDIR=%DB_DIR%\share\locale"
set "PGSSLMODE=disable"
set "PGSYSCONFDIR=%DATA_DIR%"
set "PGTZ=Etc/GMT-3"
set "PGUSER=postgres"

:: Назначение порта (если когда-либо понадобится запускать сервер в этом же скрипте)
:: По умолчанию 5432. Можно разнести по версиям:
call :_pg_port_for_version "%MODULE%" PGPORT
set "PGPORT=%PGPORT%"

:: Выполняем initdb (data dir уже создан)
pushd "%DB_DIR%"
"%BIN_DIR%\initdb.exe" --data-checksums --no-locale -U postgres --encoding=UTF8 -D "%PGDATA%"
set "ec=!errorlevel!"
popd

if not "!ec!"=="0" (
  echo [%date% %time%] ❌ ERROR: initdb failed for %MODULE% (code !ec!)
  :: Не чистим data, чтобы можно было посмотреть логи, если они появились
  endlocal & exit /b 1
)

ping -n 3 127.0.0.1

:: После initdb: у initdb создаются собственные postgresql.conf/pg_hba.conf.
for %%F in ("pg_hba.conf" "postgresql.conf") do (
  if exist "%DATA_DIR%\%%~F" (
    attrib -r -s -h "%DATA_DIR%\%%~F" >nul 2>nul
    del /f /q /a "%DATA_DIR%\%%~F" >nul 2>nul
    if exist "%DATA_DIR%\%%~F" (
      echo [WARN] Не удалось удалить: "%DATA_DIR%\%%~F"
    ) else (
      echo [OK] Удалён: "%DATA_DIR%\%%~F"
    )
  ) else (
    echo [INFO] Файл не найден: "%DATA_DIR%\%%~F"
  )
)

:: Удаляем временный каталог
if exist "%TMP_DIR%" rd /s /q "%TMP_DIR%"

echo [%date% %time%] ✅ PostgreSQL initialized: %MODULE%
endlocal
exit /b 0

:: --------------------------------------------------------------------------------
:: Helper: map version to port (optional; default 5432)
:: Args: %1 = module (e.g. PostgreSQL-15), %2 = out var name (e.g. PGPORT)
:: --------------------------------------------------------------------------------
:_pg_port_for_version
setlocal
set "MODULE=%~1"
set "OUTVAR=%~2"
set "PORT=5432"

if /i "%MODULE%"=="PostgreSQL-11" set "PORT=54111"
if /i "%MODULE%"=="PostgreSQL-12" set "PORT=54121"
if /i "%MODULE%"=="PostgreSQL-13" set "PORT=54131"
if /i "%MODULE%"=="PostgreSQL-14" set "PORT=54141"
if /i "%MODULE%"=="PostgreSQL-15" set "PORT=54151"
if /i "%MODULE%"=="PostgreSQL-16" set "PORT=54161"
if /i "%MODULE%"=="PostgreSQL-17" set "PORT=54171"
if /i "%MODULE%"=="PostgreSQL-18" set "PORT=54181"

endlocal & set "%OUTVAR%=%PORT%"
exit /b 0

:end
echo on
endlocal