@echo off
set "TMP_FILE=%~dp0tmp_license.txt"
set "HEAD_FILE=%~dp0LICENSE_HEAD"
set "RESULT_FILE=%~dp0..\licenses\licenses\Open Server Panel\LICENSE"
set "MASTER_FILE=%~dp0..\LICENSE"
cd ..\licenses
del /Q "%RESULT_FILE%"
forfiles /S /C "cmd /c if @isdir==FALSE echo: & echo: & echo *** LICENSE FILE @RELPATH: & echo: & echo: & type @PATH" >> %TMP_FILE%
copy "%HEAD_FILE%" + "%TMP_FILE%" "%RESULT_FILE%"
del /Q "%TMP_FILE%"
copy "%RESULT_FILE%" "%MASTER_FILE%"