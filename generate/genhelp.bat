@echo off
set "OSP_ROOT_DIR=%~dp0..\"
if exist "%OSP_ROOT_DIR%bin\ansicon.exe" "%OSP_ROOT_DIR%bin\ansicon.exe" -p >nul 2>nul
chcp 65001 > nul
call :genhelp MariaDB-10.1 -?
call :genhelp MariaDB-10.2 -?
call :genhelp MariaDB-10.3 -?
call :genhelp MariaDB-10.4 -?
call :genhelp MariaDB-10.5 -?
call :genhelp MariaDB-10.6 -?
call :genhelp MariaDB-10.7 -?
call :genhelp MariaDB-10.8 -?
call :genhelp MariaDB-10.9 -?
call :genhelp MariaDB-10.10 -?
call :genhelp MariaDB-10.11 -?
call :genhelp MariaDB-11.0 -?
call :genhelp MySQL-5.5 -?
call :genhelp MySQL-5.6 -?
call :genhelp MySQL-5.7 -?
call :genhelp MySQL-8.0 -?
call :genhelp php-7.1 -?
call :genhelp php-7.2 -?
call :genhelp php-7.3 -?
call :genhelp php-7.4 -?
call :genhelp php-8.0 -?
call :genhelp php-8.1 -?
call :genhelp php-8.2 -?
call :genhelp Redis-3.0 --help
call :genhelp Redis-3.2 --help
call :genhelp Redis-4.0 --help
call :genhelp Redis-5.0 --help
call :genhelp Redis-7.0 --help
call :genhelp PostgreSQL-9.5 --help
call :genhelp PostgreSQL-9.6 --help
call :genhelp PostgreSQL-10 --help
call :genhelp PostgreSQL-11 --help
call :genhelp PostgreSQL-12 --help
call :genhelp PostgreSQL-13 --help
call :genhelp PostgreSQL-14 --help
call :genhelp PostgreSQL-15 --help
call :genhelp Memcached-1.4 -help
call :genhelp Memcached-1.6 --help
call :genhelp MongoDB-3.0 --help
call :genhelp MongoDB-3.2 --help
call :genhelp MongoDB-3.4 --help
call :genhelp MongoDB-3.6 --help
call :genhelp MongoDB-4.0 --help
call :genhelp MongoDB-4.2 --help
call :genhelp MongoDB-4.4 --help
call :genhelp MongoDB-5.0 --help
call :genhelp MongoDB-6.0 --help
call :genhelp Unbound -help
call :genhelp Bind -help
goto end
:genhelp
call osp set %1
call osp add perl
set LC_MESSAGES=English
cd /d %OSP_ROOT_DIR%modules\%1
rd "%OSP_ROOT_DIR%modules\%1\ospanel_data\help" /s /q 2>nul
mkdir "%OSP_ROOT_DIR%modules\%1\ospanel_data\help" 2>nul
if not exist named.exe if not exist bin\isolationtester.exe call :reader %1 %2
if exist named.exe if not exist bin\isolationtester.exe call :reader2 %1 %2
if exist bin\isolationtester.exe call :reader3 %1 %2
forfiles /S /M *.pl /C "cmd /c call perl @file --help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\@file.txt 2>&1"
if exist bin\ibd2sdi.exe call ibd2sdi.exe --help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\ibd2sdi.exe.txt 2>&1
if exist bin\mysqld.exe call mysqld.exe --verbose --help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\mysqld.exe.txt 2>&1
if exist bin\mariadbd.exe call mariadbd.exe --verbose --help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\mariadbd.exe.txt 2>&1
if exist apache\bin\sqlite3.exe call sqlite3.exe -help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\sqlite3.exe.txt 2>&1
if exist apache\bin\openssl.exe call openssl.exe help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\openssl.exe.txt 2>&1
if exist named.exe call named.exe -f help > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\named.exe.txt 2>&1
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\mysql_secure_installation.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\mysql_tzinfo_to_sql.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\echo.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\deplister.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\redis-check-aof.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\redis-check-dump.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\redis-check-rdb.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\stackbuilder.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\sizes.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\testapp.exe.txt 2>nul
del /Q %OSP_ROOT_DIR%modules\%1\ospanel_data\help\arpaname.exe.txt 2>nul
cd /d %~dp0
exit /b 0
:reader
forfiles /S /M *.exe /C "cmd /c if /i not @fname==\"gswin64\" if /i not @fname==\"mariadb-upgrade-wizard\" if /i not @fname==\"mysql_upgrade_wizard\" if /i not @fname==\"phpdbg\" call @file %2 > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\@file.txt 2>&1"
exit /b 0
:reader2
forfiles /S /M *.exe /C "cmd /c if /i not @fname==\"nslookup\" call @file %2 > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\@file.txt 2>&1"
exit /b 0
:reader3
forfiles /S /M *.exe /C "cmd /c if /i not @fname==\"pgAdmin3\" if /i not @fname==\"isolationtester\" if /i not @fname==\"stackbuilder\" call @file %2 > %OSP_ROOT_DIR%modules\%1\ospanel_data\help\@file.txt 2>&1"
exit /b 0
:end
call osp set git
call git --help > %OSP_ROOT_DIR%modules\git\ospanel_data\help\git.exe.txt 2>&1
call osp set perl
call perl --help > %OSP_ROOT_DIR%modules\perl\ospanel_data\help\perl.exe.txt 2>&1
echo on
@PAUSE
