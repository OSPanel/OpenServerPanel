:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | DB INIT SCRIPT
:: --------------------------------------------------------------------------------
@echo off
set "OSP_ROOT_DIR=%~dp0..\"
if exist "%OSP_ROOT_DIR%bin\ansicon.exe" "%OSP_ROOT_DIR%bin\ansicon.exe" -p >nul 2>nul
chcp 65001 > nul
call :mariadb MariaDB-10.6
call :mariadb MariaDB-10.7
call :mariadb MariaDB-10.8
call :mariadb MariaDB-10.9
call :mariadb MariaDB-10.10
call :mariadb MariaDB-10.11
call :mariadb MariaDB-11.0
goto end
:: --------------------------------------------------------------------------------
:: INIT MariaDB
:: --------------------------------------------------------------------------------
:mariadb
call osp off %1
del "%OSP_ROOT_DIR%modules\%1\*.ini" /q 2>nul
call osp init %1 initdb
call osp set %1
rd    "%OSP_ROOT_DIR%data\%1" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1"
cd /d "%OSP_ROOT_DIR%modules\%1"
copy my.ini my-default.ini
copy my.ini my_print_defaults.ini
call mysql_install_db --datadir="%OSP_ROOT_DIR%data\%1" --allow-remote-root-access -o
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%modules\%1\*.ini" /q 2>nul
call osp on %1
timeout /t 5 /nobreak > nul
call mysql --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\timezone_posix.sql"
timeout /t 3 /nobreak > nul
call osp restart %1 default
call osp set %1
timeout /t 5 /nobreak > nul
call mysql --force --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\install.sql"
call osp off %1
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%data\%1\*.ini" /q 2>nul
del "%OSP_ROOT_DIR%data\%1\*.err" /q 2>nul
robocopy "%OSP_ROOT_DIR%data\%1" "%OSP_ROOT_DIR%generate\new_data\%1" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3 >nul 2>nul
exit /b 0
:end
echo on
