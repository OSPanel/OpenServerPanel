:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | RELEASE SCRIPT
:: --------------------------------------------------------------------------------
@echo off
for /d %%D in ("%~dp0modules\*") do robocopy "%%D\ospanel_data\original" "%~dp0config\%%~nxD" /UNICODE /DCOPY:DAT /COPY:DAT /TIMFIX /MIR /J /ETA /IM /MT:32 /R:3 /W:3
echo on
@PAUSE