@echo off
for /d %%D in ("%~dp0generate\config\*") do robocopy "%%D" "%~dp0config\%%~nxD" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /E /J /ETA /IM /MT:32 /R:3 /W:3
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.1\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.2\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.3\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.4\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.5\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.6\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.7\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.8\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.9\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.10\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MariaDB-10.11\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.1\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.2\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.3\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.4\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.5\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.6\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.7\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.8\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.9\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.10\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MariaDB-10.11\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MySQL-5.5\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MySQL-5.6\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MySQL-5.7\initdb\templates\" /y
xcopy "%~dp0resources\cmd\shell.bat" "%~dp0config\MySQL-8.0\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MySQL-5.5\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MySQL-5.6\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MySQL-5.7\initdb\templates\" /y
xcopy "%~dp0resources\cmd\env.bat" "%~dp0config\MySQL-8.0\initdb\templates\" /y
PAUSE
echo on
