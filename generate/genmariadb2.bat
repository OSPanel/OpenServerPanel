:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | DB INIT SCRIPT
:: --------------------------------------------------------------------------------
@echo off
set "OSP_ROOT_DIR=%~dp0..\"
chcp 65001 > nul
call :mariadb MariaDB-10.8
call :mariadb MariaDB-10.9
call :mariadb MariaDB-10.10
call :mariadb MariaDB-10.11
call :mariadb MariaDB-11.0
call :mariadb MariaDB-11.1
call :mariadb MariaDB-11.2
goto end
:: --------------------------------------------------------------------------------
:: INIT MariaDB
:: --------------------------------------------------------------------------------
:mariadb
call osp off %1
del "%OSP_ROOT_DIR%modules\%1\*.ini" /q 2>nul
call osp init %1 initdb
call osp use %1
rd    "%OSP_ROOT_DIR%data\%1\default" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1\default"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1\ospanel_data\default_data"
cd /d "%OSP_ROOT_DIR%modules\%1"
copy my.ini my-default.ini
copy my.ini my_print_defaults.ini
mysql_install_db --datadir="%OSP_ROOT_DIR%data\%1\default" --allow-remote-root-access -o
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%modules\%1\*.ini" /q 2>nul
call osp on %1
timeout /t 5 /nobreak > nul
if not "%1"=="MariaDB-10.8" mysql --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\timezone_posix.sql"
if "%1"=="MariaDB-10.8" mysql --protocol=PIPE --socket=%1 -u root mysql < "%OSP_ROOT_DIR%generate\setup\timezone_posix.sql"
timeout /t 3 /nobreak > nul
call osp restart %1 default
call osp use %1
timeout /t 5 /nobreak > nul
if not "%1"=="MariaDB-10.8" mysql --force --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\install.sql"
if "%1"=="MariaDB-10.8" mysql --force --protocol=PIPE --socket=%1 -u root mysql < "%OSP_ROOT_DIR%generate\setup\install.sql"
call osp off %1
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%data\%1\default\*.ini" /q 2>nul
del "%OSP_ROOT_DIR%data\%1\default\*.err" /q 2>nul
robocopy "%OSP_ROOT_DIR%data\%1\default" "%OSP_ROOT_DIR%generate\new_data\%1\ospanel_data\default_data" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3 >nul 2>nul
exit /b 0
:end
echo on
@PAUSE
