:: -----------------------------------------------------------------------------------
:: OPEN SERVER PANEL | COMMAND LINE INTERFACE
:: -----------------------------------------------------------------------------------
@set "ESC="
@if "{terminal_ansi_fix}"=="on" @if not defined OSP_FIXED @if exist "{root_dir}\system\bin\ansicon.exe" @set "OSP_FIXED=YES" & "{root_dir}\system\bin\ansicon.exe" -p >nul 2>nul
@if exist "{root_dir}\system\bin\colortest.exe" "{root_dir}\system\bin\colortest.exe"
@if %ERRORLEVEL% gtr 0 @if "{terminal_ansi_fix}"=="auto" @if /i not "%ConEmuANSI%"=="ON" @if not defined OSP_FIXED @if exist "{root_dir}\system\bin\ansicon.exe" @set "OSP_FIXED=YES" & "{root_dir}\system\bin\ansicon.exe" -p >nul 2>nul
@for /f "tokens=2 delims=:." %%a in ('chcp') do @set "OSP_CODEPAGE=%%a"
@call :trim %OSP_CODEPAGE% OSP_CODEPAGE
@chcp 65001 > nul
@if not exist "{root_dir}\temp\OSPanel.lock" goto notrunning
:gettempname
@set "OSP_TMPVAL=~OSP_%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%.tmp"
@if exist "{root_dir}\temp\%OSP_TMPVAL%" goto gettempname
@(for /f %%N in ("1") do call,) > "{root_dir}\temp\%OSP_TMPVAL%"
@for %%S in ("{root_dir}\temp\%OSP_TMPVAL%") do @if %%~zS==0 (set "OSP_ECHO_STATE=OFF") else (set "OSP_ECHO_STATE=ON")
@echo off
del "{root_dir}\temp\%OSP_TMPVAL%"
if "%OSP_ACTIVE_ENV%"=="" set "OSP_ACTIVE_ENV=System" & set "OSP_ACTIVE_ENV_VAL=:System:"
if not exist "{root_dir}\system\bin\curl.exe" set "OSP_ERR_MSG={root_dir}\system\bin\curl.exe {lang_79}" & goto error
if not exist "{root_dir}\system\bin\tail.exe" set "OSP_ERR_MSG={root_dir}\system\bin\tail.exe {lang_79}" & goto error
if not exist "{root_dir}\system\bin\ansicon.exe" set "OSP_ERR_MSG={root_dir}\system\bin\ansicon.exe {lang_79}" & goto error
if not exist "{root_dir}\system\bin\colortest.exe" set "OSP_ERR_MSG={root_dir}\system\bin\colortest.exe {lang_79}" & goto error
if not exist "{root_dir}\system\bin\syspreptool.exe" set "OSP_ERR_MSG={root_dir}\system\bin\syspreptool.exe {lang_79}" & goto error
set "OSP_MODULES_LIST={modules_list}"
set "OSP_ACTIVE_MODULES_LIST={active_modules_list}"
set "OSP_PASSIVE_MODULES_LIST={passive_modules_list}"
set "OSP_MODULES_LIST_=:%OSP_MODULES_LIST: =:%:"
set "OSP_ACTIVE_MODULES_LIST_=:%OSP_ACTIVE_MODULES_LIST: =:%:"
set "OSP_PASSIVE_MODULES_LIST_=:%OSP_PASSIVE_MODULES_LIST: =:%:"
:: -----------------------------------------------------------------------------------
:: ROUTER
:: -----------------------------------------------------------------------------------
:router
if /i "%1"=="add"         goto env_add
if /i "%1"=="exit"        goto shutdown
if /i "%1"=="-h"          goto help
if /i "%1"=="help"        goto help
if /i "%1"=="info"        echo: & echo {lang_52}: %OSP_ACTIVE_ENV% & goto end
if /i "%1"=="init"        goto mod_cmd
if /i "%1"=="modules"     goto request
if /i "%1"=="log"         goto log
if /i "%1"=="off"         goto mod_cmd
if /i "%1"=="on"          goto mod_cmd
if /i "%1"=="project"     goto project
if /i "%1"=="convert"     goto convert
if /i "%1"=="domains"     goto request
if /i "%1"=="reset"       goto env_windows
if /i "%1"=="restart"     goto mod_cmd
if /i "%1"=="use"         goto env_set
if /i "%1"=="initssl"     goto initssl
if /i "%1"=="shell"       goto mod_shell
if /i "%1"=="status"      goto mod_cmd
if /i "%1"=="sysprep"     goto sysprep
if /i "%1"=="-v"          echo: & echo {lang_178}: Open Server Panel v{osp_version} x64 {osp_version_datetime} & goto end
if /i "%1"=="version"     echo: & echo {lang_178}: Open Server Panel v{osp_version} x64 {osp_version_datetime} & goto end
if "%1"==""               goto help
set "OSP_ERR_MSG={lang_82}" & goto error
:: -----------------------------------------------------------------------------------
:: LOGO
:: -----------------------------------------------------------------------------------
:logo
echo   ___                     ____                             ____                  _
echo  / _ \ _ __   ___ _ __   / ___^|  ___ _ ____   _____ _ __  ^|  _ \ __ _ _ __   ___^| ^|
echo ^| ^| ^| ^| '_ \ / _ \ '_ \  \___ \ / _ \ '__\ \ / / _ \ '__^| ^| ^|_) / _` ^| '_ \ / _ \ ^|
echo ^| ^|_^| ^| ^|_) ^|  __/ ^| ^| ^|  ___) ^|  __/ ^|   \ V /  __/ ^|    ^|  __/ (_^| ^| ^| ^| ^|  __/ ^|
echo  \___/^| .__/ \___^|_^| ^|_^| ^|____/ \___^|_^|    \_/ \___^|_^|    ^|_^|   \__,_^|_^| ^|_^|\___^|_^|
echo       ^|_^|
echo:
echo {lang_83}: osp help ^| {lang_81}: {osp_version} ^| © 2010-2023 ^«OSPanel.io^»
@exit /b 0
:: -----------------------------------------------------------------------------------
:: HELP
:: -----------------------------------------------------------------------------------
:help
call :logo
echo:
echo {lang_84}: osp ^<{lang_85}^> [^<{lang_86}^>]
echo:
echo {lang_87}:
echo:
echo add     ^<MODULE^>            {lang_88}
echo                             {lang_89}
echo                             {lang_90}
echo info                        {lang_93}
echo project ^<DOMAIN^>            {lang_186}
echo reset   [init]              {lang_94}
echo                             {lang_167}
echo use     ^<MODULE^>            {lang_95}
echo                             {lang_165}
echo                             {lang_166}
echo:
echo {lang_96}:
echo:
echo init    ^<MODULE^> [PROFILE]  {lang_127}
echo                             {lang_169}
echo                             {lang_128}
echo                             {lang_170}
echo                             {lang_171}
echo off     ^<MODULE^>            {lang_98}
echo on      ^<MODULE^> [PROFILE]  {lang_99}
echo restart ^<MODULE^> [PROFILE]  {lang_100}
echo shell   ^<MODULE^>            {lang_101}
echo status  ^<MODULE^>            {lang_102}
echo:
echo {lang_103}:
echo:
echo convert ^<DOMAIN^>            {lang_188}
echo domains                     {lang_197}
echo exit                        {lang_104}
echo initssl                     {lang_204}
echo log     ^<MODULE^|main^>  [N]  {lang_105}
echo modules                     {lang_97}
echo sysprep [silent^|ssd]        {lang_106}
echo                             {lang_107}
echo                             {lang_108}
echo                             {lang_109}
echo                             {lang_110}
echo                             {lang_111}
echo                             {lang_112}
echo version                     {lang_113}
echo:
echo {lang_114}:
echo:
echo osp exit ^& ospanel          {lang_202}
echo osp use PostgreSQL-9.6      {lang_115}
echo osp on bind myprofile       {lang_116}
echo osp restart mysql-8.0       {lang_117}
echo osp log main 20             {lang_118}
echo osp reset ^& osp add git     {lang_119}
goto end
:: -----------------------------------------------------------------------------------
:: SHUTTING DOWN THE APPLICATION
:: -----------------------------------------------------------------------------------
:shutdown
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
if exist "{root_dir}\data\{module_name}\env_%%a.bat" call "{root_dir}\data\{module_name}\env_%%a.bat" resetenv
)
{system_environment}
set "OSP_ACTIVE_ENV=System" & set "OSP_ACTIVE_ENV_VAL=:System:"
if /i not "{terminal_codepage}"=="" set "OSP_CODEPAGE={terminal_codepage}"
"{root_dir}\system\bin\curl.exe" -f -s {cmd_api_url}/exit > nul
if exist "{root_dir}\temp\OSPanel.lock" goto error
echo: & echo {lang_63}
goto end
:: -----------------------------------------------------------------------------------
:: INIT SSL
:: -----------------------------------------------------------------------------------
:initssl
if not exist "{root_dir}\system\ssl\gen_root_cert.bat" set "OSP_ERR_MSG={root_dir}\system\ssl\gen_root_cert.bat {lang_79}" & goto error
if exist "{root_dir}\data\ssl\root\cert.crt" del /Q "{root_dir}\data\ssl\root\cert.crt"
call "{root_dir}\system\ssl\gen_root_cert.bat"
if not exist "{root_dir}\data\ssl\root\cert.crt" set "OSP_ERR_MSG={lang_205}" & goto error
"%SystemRoot%\System32\certutil.exe" -user -addstore "Root" "{root_dir}\data\ssl\root\cert.crt"
"%SystemRoot%\System32\certutil.exe" -urlcache * delete > nul 2> nul
goto end
:: -----------------------------------------------------------------------------------
:: SYSTEM PREPARATION TOOL
:: -----------------------------------------------------------------------------------
:sysprep
if /i not "%2"=="silent" if /i not "%2"=="ssd" if not "%2"=="" goto invalid
if /i "%2"=="silent" start "" /WAIT "{root_dir}\system\bin\syspreptool.exe" /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL
if /i "%2"=="ssd" start "" /WAIT "{root_dir}\system\bin\syspreptool.exe" /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /MERGETASKS="taskSsdopts"
if "%2"=="" start "" "{root_dir}\system\bin\syspreptool.exe"
goto end
:: -----------------------------------------------------------------------------------
:: LOG VIEW
:: -----------------------------------------------------------------------------------
:log
if "%2"=="" goto eargument
set "OSP_TMP_NAME=%2"
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
    if /i "%%a"=="%2" set "OSP_TMP_NAME=%%a"
)
call :strfind "%OSP_MODULES_LIST_%main:all:" ":%OSP_TMP_NAME%:"
if not defined OSP_TMPVAL goto invalid
set "OSP_TMPVAL=OpenServerPanel"
if /i not "%OSP_TMP_NAME%"=="main" set "OSP_TMPVAL=%OSP_TMP_NAME%"
if /i "%OSP_TMP_NAME%"=="all" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
for %%a in (%OSP_TMPVAL%) do (
    if /i "%OSP_TMP_NAME%"=="all" echo: & echo {lang_150} %%a & echo:
    if /i not "%OSP_TMP_NAME%"=="all" echo:
    if not exist "{root_dir}\logs\%%a.log" echo %ESC%[90m{lang_121}%ESC%[0m
    if exist "{root_dir}\logs\%%a.log" for %%S in ("{root_dir}\logs\%%a.log") do if %%~zS==0 (echo %ESC%[90m{lang_121}%ESC%[0m) else (
        if "%3"=="" "{root_dir}\system\bin\tail.exe" "{root_dir}\logs\%%a.log"
        if not "%3"=="" "{root_dir}\system\bin\tail.exe" "{root_dir}\logs\%%a.log" %3
        echo %ESC%[0m
    )
)
goto end
:: -----------------------------------------------------------------------------------
:: DOMAINS/MODULES LIST
:: -----------------------------------------------------------------------------------
:request
"{root_dir}\system\bin\curl.exe" -f -s {cmd_api_url}/%1
if %ERRORLEVEL% gtr 0 goto error
goto end
:: -----------------------------------------------------------------------------------
:: INIT/ON/OFF/RESTART/STATUS
:: -----------------------------------------------------------------------------------
:mod_cmd
if "%2"=="" goto eargument
set "OSP_TMP_NAME=%2"
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
    if /i "%%a"=="%2" set "OSP_TMP_NAME=%%a"
)
call :strfind "%OSP_MODULES_LIST_%all:" ":%OSP_TMP_NAME%:"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if defined OSP_TMPVAL set "OSP_PSV=yes"
if /i "%1"=="on" if defined OSP_PSV set "OSP_ERR_MSG={lang_22}" & goto error
if /i "%1"=="off" if defined OSP_PSV set "OSP_ERR_MSG={lang_22}" & goto error
if /i "%1"=="restart" if defined OSP_PSV set "OSP_ERR_MSG={lang_22}" & goto error
set "OSP_TMPVAL=%OSP_TMP_NAME%"
if /i "%OSP_TMP_NAME%"=="all" set "OSP_TMPVAL=%OSP_MODULES_LIST%"
if /i "%OSP_TMP_NAME%"=="all" if /i "%1"=="on" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
if /i "%OSP_TMP_NAME%"=="all" if /i "%1"=="off" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
if /i "%OSP_TMP_NAME%"=="all" if /i "%1"=="restart" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
if /i "%OSP_TMP_NAME%"=="all" echo: & echo {lang_175} & echo {lang_176}
if /i "%OSP_TMP_NAME%"=="all" "%SystemRoot%\System32\choice.exe" /C YN /N /M "->{lang_177} (Y/N)?"
if /i "%OSP_TMP_NAME%"=="all" if not %ERRORLEVEL%==1 goto end
setlocal EnableDelayedExpansion
for %%a in (%OSP_TMPVAL%) do (
    if /i "%1"=="restart" (
        "{root_dir}\system\bin\curl.exe" -f -s {cmd_api_url}/off/%%a/%3
        if !errorlevel! gtr 0 (
            call :echo_error %1 %OSP_TMP_NAME% %3
        ) else (
            "{root_dir}\system\bin\curl.exe" -f -s {cmd_api_url}/on/%%a/%3
            if !errorlevel! gtr 0 call :echo_error %1 %OSP_TMP_NAME% %3
        )
    ) else (
        "{root_dir}\system\bin\curl.exe" -f -s {cmd_api_url}/%1/%%a/%3
        if !errorlevel! gtr 0 call :echo_error %1 %OSP_TMP_NAME% %3
    )
    if !errorlevel!==0 if /i "%1"=="status" if exist "{root_dir}\logs\%%a.log" for %%S in ("{root_dir}\logs\%%a.log") do if not %%~zS==0 echo: & "{root_dir}\system\bin\tail.exe" "{root_dir}\logs\%%a.log" & echo %ESC%[0m
)
endlocal
goto end
:: -----------------------------------------------------------------------------------
:: SHELL
:: -----------------------------------------------------------------------------------
:mod_shell
if "%2"=="" goto eargument
set "OSP_TMP_NAME=%2"
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
    if /i "%%a"=="%2" set "OSP_TMP_NAME=%%a"
)
call :strfind "%OSP_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if defined OSP_TMPVAL set "OSP_PSV=yes"
if not exist "{root_dir}\data\{module_name}\shell_%OSP_TMP_NAME%.bat" set "OSP_ERR_MSG={lang_122} %OSP_TMP_NAME%" & goto error
setlocal
call :env_reset
call "{root_dir}\data\{module_name}\env_%OSP_TMP_NAME%.bat" %1 %OSP_TMP_NAME% %3 & call :post_env %1 %OSP_TMP_NAME% %3
echo:
TITLE %OSP_TMP_NAME% shell ^| Open Server Panel
call "{root_dir}\data\{module_name}\shell_%OSP_TMP_NAME%.bat"
endlocal
TITLE %OSP_ACTIVE_ENV% ^| Open Server Panel
goto end
:: -----------------------------------------------------------------------------------
:: IDN CONVERTER
:: -----------------------------------------------------------------------------------
:convert
if "%2"=="" goto eargument
"{root_dir}\system\bin\curl.exe" -f -s {cmd_api_url}/convert/%2
if %ERRORLEVEL% gtr 0 goto error
@goto end
:: -----------------------------------------------------------------------------------
:: PROJECT
:: -----------------------------------------------------------------------------------
:project
if "%2"=="" goto eargument
if not exist "{root_dir}\data\{module_name}\project_%2.bat" set "OSP_ERR_MSG={lang_124} %2" & goto error
set "OSP_TMP_CODEPAGE=%OSP_CODEPAGE%"
set "OSP_TMP_ECHO_STATE=%OSP_ECHO_STATE%"
call "{root_dir}\data\{module_name}\project_%2.bat" %2 %3
@if %ERRORLEVEL% gtr 0 @set "OSP_ERR_STATE=ON"
@echo off
chcp 65001 > nul
if defined OSP_TMP_CODEPAGE set "OSP_CODEPAGE=%OSP_TMP_CODEPAGE%" & set "OSP_TMP_CODEPAGE="
if defined OSP_TMP_ECHO_STATE set "OSP_ECHO_STATE=%OSP_TMP_ECHO_STATE%" & set "OSP_TMP_ECHO_STATE="
if defined OSP_ERR_STATE set "OSP_ERR_STATE=" & goto error
goto end
:: -----------------------------------------------------------------------------------
:: MODULE ENVIRONMENT (ADD)
:: -----------------------------------------------------------------------------------
:env_add
if "%2"=="" goto eargument
set "OSP_TMP_NAME=%2"
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
    if /i "%%a"=="%2" set "OSP_TMP_NAME=%%a"
)
call :strfind "%OSP_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if defined OSP_TMPVAL set "OSP_PSV=yes"
call :strfind "%OSP_ACTIVE_ENV_VAL%" ":%OSP_TMP_NAME%:"
if defined OSP_TMPVAL set "OSP_ERR_MSG={lang_123}" & goto error
if not exist "{root_dir}\data\{module_name}\env_%OSP_TMP_NAME%.bat" set "OSP_ERR_MSG={lang_124} %OSP_TMP_NAME%" & goto error
call "{root_dir}\data\{module_name}\env_%OSP_TMP_NAME%.bat" %1 %OSP_TMP_NAME% %3 & call :post_env %1 %OSP_TMP_NAME% %3
goto end
:: -----------------------------------------------------------------------------------
:: MODULE ENVIRONMENT (USE)
:: -----------------------------------------------------------------------------------
:env_set
if "%2"=="" goto eargument
set "OSP_TMP_NAME=%2"
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
    if /i "%%a"=="%2" set "OSP_TMP_NAME=%%a"
)
call :strfind "%OSP_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST_%" ":%OSP_TMP_NAME%:"
if defined OSP_TMPVAL set "OSP_PSV=yes"
if not exist "{root_dir}\data\{module_name}\env_%OSP_TMP_NAME%.bat" set "OSP_ERR_MSG={lang_124} %OSP_TMP_NAME%" & goto error
call :env_reset
call "{root_dir}\data\{module_name}\env_%OSP_TMP_NAME%.bat" %1 %OSP_TMP_NAME% %3 & call :post_env %1 %OSP_TMP_NAME% %3
goto end
:: -----------------------------------------------------------------------------------
:: DEFAULT SYSTEM ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_windows
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
if exist "{root_dir}\data\{module_name}\env_%%a.bat" call "{root_dir}\data\{module_name}\env_%%a.bat" resetenv
)
{system_environment}
set "OSP_ACTIVE_ENV=System" & set "OSP_ACTIVE_ENV_VAL=:System:"
if /i not "{terminal_codepage}"=="" if /i "%2"=="init" set "OSP_CODEPAGE={terminal_codepage}"
if /i "%2"=="init" if /i not "%3"=="silent" call :logo
if /i not "%2"=="silent" if /i not "%3"=="silent" if /i not "%3"=="noprint" echo: & echo {lang_52}: %OSP_ACTIVE_ENV%
TITLE %OSP_ACTIVE_ENV% ^| Open Server Panel
goto end
:: -----------------------------------------------------------------------------------
:: RESET ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_reset
{system_environment}
if not "%OSP_MODULES_LIST%"=="" for %%a in (%OSP_MODULES_LIST%) do (
if exist "{root_dir}\data\{module_name}\env_%%a.bat" call "{root_dir}\data\{module_name}\env_%%a.bat" resetenv
)
{default_environment}
set "ESC="
exit /b 0
:: -----------------------------------------------------------------------------------
:: MISCELLANEOUS FUNCTIONS
:: -----------------------------------------------------------------------------------
:invalid
set "OSP_ERR_MSG={lang_125}" & goto error
:eargument
set "OSP_ERR_MSG={lang_126}" & goto error
:strfind
setlocal
set "pos="
set "str=%~1"
set "sub=%~2"
call set "Replaced=%%str:%sub%=%%"
if /i not "%str%"=="%Replaced%" set "pos=yes"
endlocal & set "OSP_TMPVAL=%pos%"
exit /b 0
:trim
@set %2=%1
@exit /b 0
:post_env
if /i not "%1"=="add" set "OSP_ACTIVE_ENV=%2" & set "OSP_ACTIVE_ENV_VAL=:%2:"
if /i "%1"=="add" set "OSP_ACTIVE_ENV=%OSP_ACTIVE_ENV% + %2" & set "OSP_ACTIVE_ENV_VAL=%OSP_ACTIVE_ENV_VAL%:%2:"
if not defined OSP_PSV if not exist "{root_dir}\temp\%2.lock" echo: & echo %ESC%[93m{lang_17}: %2 {lang_172}%ESC%[0m
if /i not "%1"=="shell" if /i not "%3"=="silent" echo: & echo {lang_52}: %OSP_ACTIVE_ENV%
if /i not "%1"=="shell" TITLE %OSP_ACTIVE_ENV% ^| Open Server Panel
@exit /b 0
:: -----------------------------------------------------------------------------------
:: EXIT
:: -----------------------------------------------------------------------------------
:before_exit
@if defined OSP_CODEPAGE @chcp %OSP_CODEPAGE% > nul
@if defined OSP_ECHO_STATE @echo %OSP_ECHO_STATE%
@set "OSP_CODEPAGE="
@set "OSP_MODULES_LIST="
@set "OSP_ACTIVE_MODULES_LIST="
@set "OSP_PASSIVE_MODULES_LIST="
@set "OSP_MODULES_LIST_="
@set "OSP_ACTIVE_MODULES_LIST_="
@set "OSP_PASSIVE_MODULES_LIST_="
@set "OSP_ECHO_STATE="
@set "OSP_ERR_MSG="
@set "OSP_TMPVAL="
@set "OSP_TMP_NAME="
@set "OSP_PSV="
@exit /b 0
:notrunning
@echo:
@echo %ESC%[91m{lang_16}
@echo ————————————————————————————————————————————————————
@echo {lang_26}: osp %1 %2 %3
@echo {lang_30}: {lang_56}
@echo {lang_31}: {lang_120}%ESC%[0m
@if defined OSP_CODEPAGE @chcp %OSP_CODEPAGE% > nul
@set "OSP_CODEPAGE="
@exit /b 1
:end
@call :before_exit
@exit /b 0
:echo_error
@echo:
@echo %ESC%[91m{lang_16}
@echo ————————————————————————————————————————————————————
@echo {lang_26}: osp %1 %2 %3
@echo {lang_31}: {lang_120}%ESC%[0m
@exit /b 1
:error
@echo:
@echo %ESC%[91m{lang_16}
@echo ————————————————————————————————————————————————————
@echo {lang_26}: osp %1 %2 %3
@if defined OSP_ERR_MSG @echo {lang_30}: %OSP_ERR_MSG%
@echo {lang_31}: {lang_120}%ESC%[0m
@call :before_exit
@exit /b 1