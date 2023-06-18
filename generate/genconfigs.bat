:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | CONFIGURATION FILE GENERATOR
:: --------------------------------------------------------------------------------
@echo off
for /d %%D in ("%~dp0..\modules\*") do robocopy "%%D\ospanel_data\original" "%~dp0..\config\%%~nxD" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3
echo on
@PAUSE