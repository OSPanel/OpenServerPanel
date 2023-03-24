:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | DB INIT SCRIPT
:: --------------------------------------------------------------------------------
@echo off
set "OSP_ROOT_DIR=%~dp0..\"
if exist "%OSP_ROOT_DIR%system\ansicon\ansicon.exe" "%OSP_ROOT_DIR%system\ansicon\ansicon.exe" -p >nul 2>nul
chcp 65001 > nul
call :mysql MySQL-5.5
call :mysql MySQL-5.6
call :mysql MySQL-5.7
call :mysql MySQL-8.0
goto end
:: --------------------------------------------------------------------------------
:: INIT MySQL
:: --------------------------------------------------------------------------------
:mysql
call osp off %1
call osp init %1 initdb
call osp set Perl
call osp add %1
rd    "%OSP_ROOT_DIR%data\%1" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1"
cd /d "%OSP_ROOT_DIR%modules\%1"
del "%OSP_ROOT_DIR%modules\%1\*.ini" /q 2>nul
copy my.ini my-default.ini
copy my.ini my_print_defaults.ini
if not "%1"=="MySQL-5.7" if not "%1"=="MySQL-8.0" call perl scripts/mysql_install_db.pl --basedir="%OSP_ROOT_DIR%modules\%1" --datadir="%OSP_ROOT_DIR%data\%1" --skip-name-resolve --windows --verbose
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" start "" "%OSP_ROOT_DIR%modules\%1\bin\mysqld.exe" --defaults-file="%OSP_ROOT_DIR%modules\%1\my.ini" --initialize-insecure --console --standalone
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%modules\%1\*.ini" /q 2>nul
if not "%1"=="MySQL-5.5" copy "%OSP_ROOT_DIR%generate\setup\private_key.pem" "%OSP_ROOT_DIR%data\%1\private_key.pem"
if not "%1"=="MySQL-5.5" copy "%OSP_ROOT_DIR%generate\setup\public_key.pem" "%OSP_ROOT_DIR%data\%1\public_key.pem"
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" copy "%OSP_ROOT_DIR%generate\setup\ca.pem" "%OSP_ROOT_DIR%data\%1\ca.pem"
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" copy "%OSP_ROOT_DIR%generate\setup\server-cert.pem" "%OSP_ROOT_DIR%data\%1\server-cert.pem"
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" copy "%OSP_ROOT_DIR%generate\setup\server-key.pem" "%OSP_ROOT_DIR%data\%1\server-key.pem"
call osp on %1
timeout /t 5 /nobreak > nul
if "%1"=="MySQL-5.7" call mysql --protocol=PIPE --socket=%1 --host="" -u root mysql -e "INSTALL PLUGIN mysqlx SONAME 'mysqlx.dll';"
call mysql --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\timezone_posix.sql"
timeout /t 3 /nobreak > nul
call osp restart %1 default
call osp set %1
timeout /t 5 /nobreak > nul
call mysql --force --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\install.sql"
call osp off %1
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%data\%1\*.err" /q 2>nul
robocopy "%OSP_ROOT_DIR%data\%1" "%OSP_ROOT_DIR%generate\new_data\%1" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3 >nul 2>nul
exit /b 0
:end
exit /b 0
