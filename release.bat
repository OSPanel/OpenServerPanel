@echo off
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-7.1\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-7.2\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-7.3\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-7.4\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-8.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-8.1\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\*.bat" "%~dp0modules\PHP-8.2\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.1\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.2\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.3\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.4\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.5\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.6\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.7\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.8\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.9\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.10\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-10.11\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MariaDB-11.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-3.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-3.2\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-3.4\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-3.6\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-4.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-4.2\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-4.4\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-5.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MongoDB-6.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MySQL-5.5\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MySQL-5.6\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MySQL-5.7\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\MySQL-8.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-9.5\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-9.6\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-10\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-11\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-12\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-13\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-14\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\PostgreSQL-15\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\Redis-3.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\Redis-3.2\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\Redis-4.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\Redis-5.0\ospanel_data\original\default\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0modules\Redis-7.0\ospanel_data\original\default\templates\" /y
for /d %%D in ("%~dp0modules\*") do xcopy "%~dp0resources\cmd\env.bat" "%%D\ospanel_data\original\default\templates\" /y
del "%~dp0modules\ControlPanel\ospanel_data\original\default\templates\env.bat"
for /d %%D in ("%~dp0modules\*") do robocopy "%%D\ospanel_data\original" "%~dp0config\%%~nxD" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3
PAUSE
echo on