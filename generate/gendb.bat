:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | DB INIT SCRIPT
:: --------------------------------------------------------------------------------
@echo off
set "OSP_ROOT_DIR=%~dp0..\"
chcp 65001 > nul
for /d %%D in ("%OSP_ROOT_DIR%generate\config\*") do robocopy "%%D" "%OSP_ROOT_DIR%config\%%~nxD" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /E /J /ETA /IM /MT:32 /R:3 /W:3 >nul 2>nul
rd    "%OSP_ROOT_DIR%generate\new_data" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%generate\new_data" 2>nul
TITLE DB Generator
start "MariaDB 1 Generator" "%OSP_ROOT_DIR%generate\genmariadb1.bat"
start "MariaDB 2 Generator" "%OSP_ROOT_DIR%generate\genmariadb2.bat"
start "MySQL Generator" "%OSP_ROOT_DIR%generate\genmysql.bat"
call :posgresql PostgreSQL-9.5
call :posgresql PostgreSQL-9.6
call :posgresql PostgreSQL-10
call :posgresql PostgreSQL-11
call :posgresql PostgreSQL-12
call :posgresql PostgreSQL-13
call :posgresql PostgreSQL-14
call :posgresql PostgreSQL-15
call :posgresql PostgreSQL-16
goto end
:: --------------------------------------------------------------------------------
:: INIT PostgreSQL
:: --------------------------------------------------------------------------------
:posgresql
call osp off %1
call osp init %1 default
call osp use %1
rd "%OSP_ROOT_DIR%data\%1\default" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1\default"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1\ospanel_data\default_data"
initdb --data-checksums --no-locale -U postgres --encoding=UTF8 -D "%OSP_ROOT_DIR%data\%1\default"
del "%OSP_ROOT_DIR%data\%1\default\pg_hba.conf" "%OSP_ROOT_DIR%data\%1\default\postgresql.conf"
robocopy "%OSP_ROOT_DIR%data\%1\default" "%OSP_ROOT_DIR%generate\new_data\%1\ospanel_data\default_data" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3 >nul 2>nul
exit /b 0
:end
echo on
@PAUSE
