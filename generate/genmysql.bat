:: --------------------------------------------------------------------------------
:: OPEN SERVER PANEL | MySQL INIT SCRIPT
:: --------------------------------------------------------------------------------
@echo off
setlocal enabledelayedexpansion

:: Initialize variables
set "SCRIPT_START_TIME=%time%"
set "TMP_ROOT=%~dp0.."
for %%I in ("%TMP_ROOT%") do set "TMP_ROOT=%%~fI"
set "OSP_ROOT_DIR=%TMP_ROOT%"
set "OSP_ROOT_DIR_UNIX=%TMP_ROOT:\=/%"

:: Set UTF-8 encoding
chcp 65001

echo.
echo ================================================================================
echo MYSQL INITIALIZATION SCRIPT
echo ================================================================================
echo [%date% %time%] Starting MySQL initialization...
echo.

:: Define database versions array
set "DB_VERSIONS= MySQL-5.7 MySQL-8.0 MySQL-8.4"

:: Process each database version
for %%V in (%DB_VERSIONS%) do (
    echo [%date% %time%] ^>^>^> Processing %%V...
    call :init_db "%%V"
    if !errorlevel! neq 0 (
        echo [%date% %time%] ❌ ERROR: Failed to initialize %%V
        echo.
        set "HAS_ERRORS=1"
    ) else (
        echo [%date% %time%] ✅ SUCCESS: %%V initialized successfully
        echo.
    )
)

:: Summary
echo ================================================================================
if defined HAS_ERRORS (
    echo [%date% %time%] ❌ Script completed with errors!
    echo Some MySQL versions failed to initialize. Please check the output above.
    exit /b 1
) else (
    echo [%date% %time%] ✅ All MySQL versions initialized successfully!
    echo Total execution time: %time% (started at %SCRIPT_START_TIME%)
    exit /b 0
)

:: --------------------------------------------------------------------------------
:: INIT database with improved error handling and progress indication
:: --------------------------------------------------------------------------------
:init_db
setlocal enabledelayedexpansion
set "VERSION=%~1"
set "db_dir=%OSP_ROOT_DIR%\modules\%VERSION%"
set "db_dir_unix=%OSP_ROOT_DIR_UNIX%/modules/%VERSION%"
set "data_dir=%OSP_ROOT_DIR%\modules\%VERSION%\ospanel_data\default_data"
set "db_pipe= --protocol=PIPE --ssl-mode=DISABLED"

echo     📁 Checking if %VERSION% directory exists...
if not exist "%db_dir%" (
    echo     ❌ ERROR: Directory %db_dir% does not exist!
    exit /b 1
)

echo     🧹 Cleaning old data and configuration...
if exist "%data_dir%" (
    rd /s /q "%data_dir%"
    if exist "%data_dir%" (
        echo     ⚠️  WARNING: Could not completely remove old data directory
    )
)

:: Clean old configuration files
del "%db_dir%\*.ini" /q

:: Set environment variables
echo     🔧 Setting up environment...
call :set_db_environment "%db_dir%" "%VERSION%"

:: Create necessary directories
echo     📂 Creating directory structure...
call :create_directories "%data_dir%"
if !errorlevel! neq 0 exit /b 1

:: Configure my.ini
echo     ⚙️  Configuring my.ini...
call :configure_db_ini "%db_dir%" "%VERSION%"
if !errorlevel! neq 0 (
    echo     ❌ ERROR: Failed to configure my.ini
    exit /b 1
)

:: Initialize database
echo     💾 Installing database...
cd /d "%db_dir%"
copy my.ini my-default.ini
copy my.ini my_print_defaults.ini

call :initialize_database "%VERSION%" "%db_dir%" "%data_dir%"
if !errorlevel! neq 0 exit /b 1

echo     ⏳ Waiting for installation to complete...
ping -n 3 127.0.0.1

:: Clean up temporary ini files
del "*.ini" /q

:: Configure my.ini again for startup
call :configure_db_ini "%db_dir%" "%VERSION%"

:: Install MySQL X Plugin for MySQL 5.7
if "%VERSION%"=="MySQL-5.7" (
    echo     🔌 Installing MySQL X Plugin...
    call :install_mysqlx_plugin "%db_dir%" "%VERSION%"
    if !errorlevel! neq 0 exit /b 1
)

:: Configure timezone data (version-specific logic)
echo     🌍 Configuring timezone data...
call :configure_timezone "%db_dir%" "%VERSION%"
if !errorlevel! neq 0 exit /b 1

echo     ⏳ Waiting for timezone configuration to complete...
ping -n 3 127.0.0.1

:: Execute main installation SQL
echo     🔧 Running main installation script...
copy /Y "%OSP_ROOT_DIR%\generate\config\%VERSION%\my_configured.ini" "%db_dir%\my.ini"
call :replace_placeholders "%db_dir%\my.ini" "%OSP_ROOT_DIR_UNIX%" "%VERSION%"
call :execute_installation_sql "%db_dir%" "%VERSION%"
if !errorlevel! neq 0 exit /b 1

:: Final cleanup
echo     🧹 Performing final cleanup...
call :final_cleanup "%db_dir%"

echo     ✅ %VERSION% initialization completed!

endlocal
exit /b 0

:: --------------------------------------------------------------------------------
:: Helper functions
:: --------------------------------------------------------------------------------

:set_db_environment
set "db_dir=%~1"
set "version=%~2"
set "DBI_USER="
set "DBI_TRACE="
set "MYSQL_GROUP_SUFFIX="
set "MYSQL_HOME=%db_dir%"
set "MYSQL_PS1="
set "MYSQL_PWD="
set "MYSQL_UNIX_PORT=%version%"
set "TEMP=%db_dir%\temp"
set "TMP=%TEMP%"
set "TMPDIR=%TEMP%"
set "USER=root"
exit /b 0

:create_directories
set "data_dir=%~1"
for %%D in ("%data_dir%") do (
    if not exist "%%D" (
        mkdir "%%D"
        if not exist "%%D" (
            echo     ❌ ERROR: Failed to create directory %%D
            exit /b 1
        )
    )
)
exit /b 0

:configure_db_ini
set "db_dir=%~1"
set "version=%~2"
copy /Y "%OSP_ROOT_DIR%\generate\config\%version%\my.ini" "%db_dir%\my.ini"
if !errorlevel! neq 0 (
    echo     ❌ ERROR: Failed to copy my.ini template
    exit /b 1
)
call :replace_placeholders "%db_dir%\my.ini" "%OSP_ROOT_DIR_UNIX%" "%version%"
exit /b 0

:replace_placeholders
powershell -NoLogo -NoProfile -Command ^
  "try { (Get-Content '%~1') -replace '{root_dir}', '%~2' -replace '{module_name}', '%~3' | Set-Content '%~1'; exit 0 } catch { exit 1 }"
exit /b %errorlevel%

:get_db_startup_params
set "version=%~1"
if "%version%"=="MySQL-8.4" (
    set "DB_STARTUP_PARAMS=--enable-named-pipe --standalone --console --no-monitor=ON"
) else (
    set "DB_STARTUP_PARAMS=--enable-named-pipe --standalone --console"
)
exit /b 0

:initialize_database
set "version=%~1"
set "db_dir=%~2"
set "data_dir=%~3"

echo       🔧 Using mysqld initialize for %db_dir%
bin\mysqld.exe --defaults-file="%db_dir%\my.ini" --initialize-insecure --console --standalone

if !errorlevel! neq 0 (
    echo     ❌ ERROR: Database initialization failed for %version%
    exit /b 1
)
exit /b 0

:start_db_and_execute
set "db_dir=%~1"
set "version=%~2"
set "sql_file=%~3"
set "operation=%~4"

call :get_db_startup_params "%version%"

echo       🚀 Starting database server for %operation%...
start "MySQL_%version%_%operation%" bin\mysqld.exe --defaults-file="%db_dir%\my.ini" %DB_STARTUP_PARAMS%

echo       ⏳ Waiting for server to start...
ping -n 5 127.0.0.1

if "%sql_file%" neq "" (
    echo       📜 Executing %operation% SQL...
    bin\mysql.exe --force%db_pipe% --socket=%version% --host="" -u root mysql < "%sql_file%"
    set "sql_result=!errorlevel!"
) else (
    set "sql_result=0"
)

echo       🛑 Shutting down database server...
bin\mysqladmin.exe%db_pipe% --socket=%version% --host="" -u root shutdown
ping -n 5 127.0.0.1

if !sql_result! neq 0 (
    echo     ❌ ERROR: %operation% execution failed
    exit /b 1
)
exit /b 0

:install_mysqlx_plugin
set "db_dir=%~1"
set "version=%~2"

call :get_db_startup_params "%version%"

echo       🚀 Starting database server for MySQL X Plugin installation...
start "MySQL_%version%_mysqlx" bin\mysqld.exe --defaults-file="%db_dir%\my.ini" %DB_STARTUP_PARAMS%

echo       ⏳ Waiting for server to start...
ping -n 5 127.0.0.1

echo       🔌 Installing MySQL X Plugin...
bin\mysql.exe --defaults-file="%db_dir%\my.ini"%db_pipe% --socket=%version% --host="" -u root mysql -e "INSTALL PLUGIN mysqlx SONAME 'mysqlx.dll';"
set "plugin_result=!errorlevel!"

echo       🛑 Shutting down database server...
bin\mysqladmin.exe%db_pipe% --socket=%version% --host="" -u root shutdown
ping -n 3 127.0.0.1

if !plugin_result! neq 0 (
    echo     ⚠️  WARNING: MySQL X Plugin installation failed
)
exit /b 0

:configure_timezone
set "db_dir=%~1"
set "version=%~2"

call :start_db_and_execute_timezone_with_host "%db_dir%" "%version%"
exit /b !errorlevel!

:start_db_and_execute_timezone_with_host
set "db_dir=%~1"
set "version=%~2"

call :get_db_startup_params "%version%"

start "MySQL_%version%_timezone" bin\mysqld.exe --defaults-file="%db_dir%\my.ini" %DB_STARTUP_PARAMS%

ping -n 5 127.0.0.1

bin\mysql.exe --defaults-file="%db_dir%\my.ini"%db_pipe% --socket=%version% --host="" -u root mysql < "%OSP_ROOT_DIR%\generate\setup\timezone_posix.sql"
set "timezone_result=!errorlevel!"

echo       🛑 Shutting down database server...
bin\mysqladmin.exe%db_pipe% --socket=%version% --host="" -u root shutdown
ping -n 3 127.0.0.1

if !timezone_result! neq 0 (
    echo     ❌ ERROR: Timezone configuration failed
    exit /b 1
)
exit /b 0

:execute_installation_sql
set "db_dir=%~1"
set "version=%~2"

call :start_db_and_execute "%db_dir%" "%version%" "%OSP_ROOT_DIR%\generate\setup\install.sql" "installation"
exit /b %errorlevel%

:final_cleanup
set "db_dir=%~1"
if exist "%db_dir%\temp" rd /s /q "%db_dir%\temp"
del "%db_dir%\ospanel_data\default_data\*.ini" /q
del "%db_dir%\ospanel_data\default_data\*.err" /q
del "%db_dir%\*.ini" /q
exit /b 0
