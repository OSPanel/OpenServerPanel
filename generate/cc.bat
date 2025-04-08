@echo off
setlocal enabledelayedexpansion

set "SOURCE=..\resources\php_addons\composer.phar"

if not exist "%SOURCE%" (
    echo %SOURCE% not found!
    exit /b 1
)

for %%V in (7.2 7.3 7.4 8.0 8.1 8.2 8.3 8.4) do (
    set "TARGET1=..\modules\PHP-%%V\ospanel_data\default_data\composer"
    if exist "!TARGET1!" (
        copy /Y "%SOURCE%" "!TARGET1!\composer.phar" >nul
    ) else (
        echo !TARGET1! not found!
    )

    set "TARGET2=..\modules\PHP-%%V-FCGI\ospanel_data\default_data\composer"
    if exist "!TARGET2!" (
        copy /Y "%SOURCE%" "!TARGET2!\composer.phar" >nul
    ) else (
        echo !TARGET2! not found!
    )
)

echo End.
pause