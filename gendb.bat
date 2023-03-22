:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | DB INIT SCRIPT
:: --------------------------------------------------------------------------------
@echo off
set "OSP_ROOT_DIR=%~dp0"
rd "%OSP_ROOT_DIR%generate\new_data" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%generate\new_data" 2>nul
call :posgresql PostgreSQL-9.5
call :posgresql PostgreSQL-9.6
call :posgresql PostgreSQL-10
call :posgresql PostgreSQL-11
call :posgresql PostgreSQL-12
call :posgresql PostgreSQL-13
call :posgresql PostgreSQL-14
call :posgresql PostgreSQL-15
call :mariadb MariaDB-10.1
call :mariadb MariaDB-10.2
call :mariadb MariaDB-10.3
call :mariadb MariaDB-10.4
call :mariadb MariaDB-10.5
call :mariadb MariaDB-10.6
call :mariadb MariaDB-10.7
call :mariadb MariaDB-10.8
call :mariadb MariaDB-10.9
call :mariadb MariaDB-10.10
call :mariadb MariaDB-10.11
call :mysql MySQL-5.5
call :mysql MySQL-5.6
call :mysql MySQL-5.7
call :mysql MySQL-8.0
goto :end
:: --------------------------------------------------------------------------------
:: INIT PostgreSQL
:: --------------------------------------------------------------------------------
:posgresql
call osp off %1
call osp set %1
rd "%OSP_ROOT_DIR%data\%1" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1"
call initdb --data-checksums --no-locale -U postgres --encoding=UTF8 -D "%OSP_ROOT_DIR%data\%1"
del "%OSP_ROOT_DIR%data\%1\pg_hba.conf" "%OSP_ROOT_DIR%data\%1\postgresql.conf"
robocopy "%OSP_ROOT_DIR%data\%1" "%OSP_ROOT_DIR%generate\new_data\%1" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3
exit /b 0
:: --------------------------------------------------------------------------------
:: INIT MariaDB
:: --------------------------------------------------------------------------------
:mariadb
call osp off %1
call osp set %1
rd "%OSP_ROOT_DIR%data\%1" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1"
cd /d "%OSP_ROOT_DIR%modules\%1"
del "%OSP_ROOT_DIR%modules\%1\*.ini" /s /q 2>nul
call osp init %1 initdb
copy my.ini my-default.ini
copy my.ini my_print_defaults.ini
call mysql_install_db --datadir="%OSP_ROOT_DIR%data\%1" --allow-remote-root-access -o
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%modules\%1\*.ini" /s /q 2>nul
call osp on %1
timeout /t 5 /nobreak > nul
call mysql --protocol=PIPE --socket=%1 --host="" -u root < "%OSP_ROOT_DIR%generate\setup\timezone_posix.sql"
timeout /t 3 /nobreak > nul
call osp restart %1 default
timeout /t 5 /nobreak > nul
call mysql --force --protocol=PIPE --socket=%1 --host="" -u root < "%OSP_ROOT_DIR%generate\setup\install.sql"
call osp off %1
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%data\%1\*.err" /s /q 2>nul
robocopy "%OSP_ROOT_DIR%data\%1" "%OSP_ROOT_DIR%generate\new_data\%1" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3
exit /b 0
:: --------------------------------------------------------------------------------
:: INIT MySQL
:: --------------------------------------------------------------------------------
:mysql
call osp off %1
call osp set %1
call osp add Perl
rd "%OSP_ROOT_DIR%data\%1" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%data\%1"
mkdir "%OSP_ROOT_DIR%generate\new_data\%1"
cd /d "%OSP_ROOT_DIR%modules\%1"
del "%OSP_ROOT_DIR%modules\%1\*.ini" /s /q 2>nul
call osp init %1 initdb
copy my.ini my-default.ini
copy my.ini my_print_defaults.ini
if not "%1"=="MySQL-5.7" if not "%1"=="MySQL-8.0" call perl scripts/mysql_install_db.pl --basedir="%OSP_ROOT_DIR%modules\%1" --datadir="%OSP_ROOT_DIR%data\%1" --skip-name-resolve --windows --verbose
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" start "" "%OSP_ROOT_DIR%modules\%1\bin\mysqld.exe" --defaults-file="%OSP_ROOT_DIR%modules\%1\my.ini" --initialize-insecure --console --standalone
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%modules\%1\*.ini" /s /q 2>nul
if not "%1"=="MySQL-5.5" copy "%OSP_ROOT_DIR%generate\setup\private_key.pem" "%OSP_ROOT_DIR%data\%1\private_key.pem"
if not "%1"=="MySQL-5.5" copy "%OSP_ROOT_DIR%generate\setup\public_key.pem" "%OSP_ROOT_DIR%data\%1\public_key.pem"
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" copy "%OSP_ROOT_DIR%generate\setup\ca.pem" "%OSP_ROOT_DIR%data\%1\ca.pem"
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" copy "%OSP_ROOT_DIR%generate\setup\server-cert.pem" "%OSP_ROOT_DIR%data\%1\server-cert.pem"
if not "%1"=="MySQL-5.5" if not "%1"=="MySQL-5.6" copy "%OSP_ROOT_DIR%generate\setup\server-key.pem" "%OSP_ROOT_DIR%data\%1\server-key.pem"
call osp on %1
timeout /t 5 /nobreak > nul
if "%1"=="MySQL-5.7" call mysql --host=%1 -u root mysql -e "INSTALL PLUGIN mysqlx SONAME 'mysqlx.dll';"
call mysql --protocol=PIPE --socket=%1 --host="" -u root mysql < "%OSP_ROOT_DIR%generate\setup\timezone_posix.sql"
timeout /t 3 /nobreak > nul
call osp restart %1 default
timeout /t 5 /nobreak > nul
call mysql --force --protocol=PIPE --socket=%1 --host="" -u root < "%OSP_ROOT_DIR%generate\setup\install.sql"
call osp off %1
timeout /t 3 /nobreak > nul
del "%OSP_ROOT_DIR%data\%1\*.err" /s /q 2>nul
robocopy "%OSP_ROOT_DIR%data\%1" "%OSP_ROOT_DIR%generate\new_data\%1" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3
exit /b 0
:end
echo on
