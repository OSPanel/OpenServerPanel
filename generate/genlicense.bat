@echo off
cd ..\licenses
setlocal
set "TMP_FILE=tmp_license.txt"
del /Q "licenses\Open Server Panel\LICENSE"
del /Q %TMP_FILE%
forfiles /S /C "cmd /c if @isdir==FALSE echo: >> %TMP_FILE% & echo: >> %TMP_FILE% & echo *** LICENSE FILE @RELPATH: >> %TMP_FILE% & echo: >> %TMP_FILE% & echo: >> %TMP_FILE% & type @PATH >> %TMP_FILE%"
copy ..\generate\LICENSE_HEAD + %TMP_FILE% "licenses\Open Server Panel\LICENSE"
del /Q %TMP_FILE%
endlocal