@echo off
setlocal enabledelayedexpansion

set "SOURCE1=..\resources\php_addons\composer.phar"
set "SOURCE2=..\resources\php_addons\config.json"
set "SOURCE3=..\resources\php_addons\composer.json"
set "SOURCE4=..\resources\php_addons\auth.json"
set "SOURCE5=..\resources\php_addons\keys.tags.pub"
set "SOURCE6=..\resources\php_addons\keys.dev.pub"

if not exist "%SOURCE1%" (
    echo %SOURCE1% not found!
    exit /b 1
)

if not exist "%SOURCE2%" (
    echo %SOURCE2% not found!
    exit /b 1
)

if not exist "%SOURCE3%" (
    echo %SOURCE3% not found!
    exit /b 1
)

if not exist "%SOURCE4%" (
    echo %SOURCE4% not found!
    exit /b 1
)

if not exist "%SOURCE5%" (
    echo %SOURCE5% not found!
    exit /b 1
)

if not exist "%SOURCE6%" (
    echo %SOURCE6% not found!
    exit /b 1
)

for %%V in (7.2 7.3 7.4 8.0 8.1 8.2 8.3 8.4) do (
    set "TARGET1=..\modules\PHP-%%V\ospanel_data\default_data\composer"
    if exist "!TARGET1!" (
        copy /Y "%SOURCE1%" "!TARGET1!\composer.phar" >nul
        copy /Y "%SOURCE2%" "!TARGET1!\config.json" >nul
        copy /Y "%SOURCE3%" "!TARGET1!\composer.json" >nul
        copy /Y "%SOURCE4%" "!TARGET1!\auth.json" >nul
        copy /Y "%SOURCE5%" "!TARGET1!\keys.tags.pub" >nul
        copy /Y "%SOURCE6%" "!TARGET1!\keys.dev.pub" >nul
    ) else (
        echo !TARGET1! not found!
    )

    set "TARGET2=..\modules\PHP-%%V-FCGI\ospanel_data\default_data\composer"
    if exist "!TARGET2!" (
        copy /Y "%SOURCE1%" "!TARGET2!\composer.phar" >nul
        copy /Y "%SOURCE2%" "!TARGET2!\config.json" >nul
        copy /Y "%SOURCE3%" "!TARGET2!\composer.json" >nul
        copy /Y "%SOURCE4%" "!TARGET2!\auth.json" >nul
        copy /Y "%SOURCE5%" "!TARGET2!\keys.tags.pub" >nul
        copy /Y "%SOURCE6%" "!TARGET2!\keys.dev.pub" >nul
    ) else (
        echo !TARGET2! not found!
    )
)

echo End.
pause