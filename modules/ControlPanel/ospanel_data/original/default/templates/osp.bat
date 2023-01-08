:: OPEN SERVER PANEL | COMMAND LINE INTERFACE
:: -----------------------------------------------------------------------------------
@set "ESC="
@if exist "{root_dir}\system\ansicon\ansicon.exe" "{root_dir}\system\ansicon\ansicon.exe" -p >nul 2>nul
@for /f "tokens=2 delims=:." %%a in ('chcp') do @set "OSP_TERMINAL_CODEPAGE=%%a"
@call :trim %OSP_TERMINAL_CODEPAGE% OSP_TERMINAL_CODEPAGE
@chcp 65001 > nul
@if not exist "{root_dir}\temp\OSPanel.lock" goto notrunning
:gettempname
@set "OSP_TMPVAL=~OSP_%RANDOM%.tmp"
@if exist "{root_dir}\temp\%OSP_TMPVAL%" goto gettempname
@(for /f %%N in ("1") do call,) > "{root_dir}\temp\%OSP_TMPVAL%"
@for %%S in ("{root_dir}\temp\%OSP_TMPVAL%") do @if %%~zS==0 (set "OSP_ECHO_STATE=OFF") else (set "OSP_ECHO_STATE=ON")
@echo off
del "{root_dir}\temp\%OSP_TMPVAL%"
if "%OSP_ACTIVE_ENV%"=="" set "OSP_ACTIVE_ENV=Windows"
if not exist "{root_dir}\bin\curl.exe" set "OSP_ERR_MSG={root_dir}\bin\curl.exe {lang_79}" & goto error
if not exist "{root_dir}\bin\tail.exe" set "OSP_ERR_MSG={root_dir}\bin\tail.exe {lang_79}" & goto error
if not exist "{root_dir}\system\ansicon\ansicon.exe" set "OSP_ERR_MSG={root_dir}\system\ansicon\ansicon.exe {lang_79}" & goto error
if not exist "{root_dir}\system\System Preparation Tool.exe" set "OSP_ERR_MSG={root_dir}\system\System Preparation Tool.exe {lang_79}" & goto error
set "OSP_MODULES_LIST={modules_list}"
set "OSP_ACTIVE_MODULES_LIST={active_modules_list}"
set "OSP_PASSIVE_MODULES_LIST={passive_modules_list}"
:: -----------------------------------------------------------------------------------
:: ROUTER
:: -----------------------------------------------------------------------------------
:router
if /i "%1"=="add"         goto env_add
if /i "%1"=="exit"        goto shutdown
if /i "%1"=="-h"          goto help
if /i "%1"=="help"        goto help
if /i "%1"=="info"        echo: & echo  {lang_52}: %OSP_ACTIVE_ENV% & goto end
if /i "%1"=="init"        goto mod_cmd
if /i "%1"=="list"        goto mod_cmd
if /i "%1"=="log"         goto log
if /i "%1"=="off"         goto mod_cmd
if /i "%1"=="on"          goto mod_cmd
if /i "%1"=="reset"       goto env_windows
if /i "%1"=="restart"     goto mod_cmd
if /i "%1"=="set"         goto env_set
if /i "%1"=="shell"       goto mod_shell
if /i "%1"=="status"      goto mod_cmd
if /i "%1"=="sysprep"     goto sysprep
if /i "%1"=="-v"          echo: & echo  {lang_81}: {osp_version} & goto end
if /i "%1"=="version"     echo: & echo  {lang_81}: {osp_version} & goto end
if "%1"==""               goto help
set "OSP_ERR_MSG={lang_82}" & goto error
:: -----------------------------------------------------------------------------------
:: LOGO
:: -----------------------------------------------------------------------------------
:logo
echo    ___                     ____                             ____                  _
echo   / _ \ _ __   ___ _ __   / ___^|  ___ _ ____   _____ _ __  ^|  _ \ __ _ _ __   ___^| ^|
echo  ^| ^| ^| ^| '_ \ / _ \ '_ \  \___ \ / _ \ '__\ \ / / _ \ '__^| ^| ^|_) / _` ^| '_ \ / _ \ ^|
echo  ^| ^|_^| ^| ^|_) ^|  __/ ^| ^| ^|  ___) ^|  __/ ^|   \ V /  __/ ^|    ^|  __/ (_^| ^| ^| ^| ^|  __/ ^|
echo   \___/^| .__/ \___^|_^| ^|_^| ^|____/ \___^|_^|    \_/ \___^|_^|    ^|_^|   \__,_^|_^| ^|_^|\___^|_^|
echo        ^|_^|
echo:
echo  {lang_83}: osp help ^| {lang_81}: {osp_version} ^| © 2010-2022 ^«OSPanel.io^»
@exit /b 0
:: -----------------------------------------------------------------------------------
:: HELP
:: -----------------------------------------------------------------------------------
:help
call :logo
echo:
echo  {lang_84}: osp ^<{lang_85}^> [^<{lang_86}^>]
echo:
echo  {lang_87}:
echo:
echo  add     ^<MODULE^>            {lang_88}
echo                              {lang_89}
echo                              {lang_90}
echo                              {lang_91}
echo                              {lang_92}
echo  info                        {lang_93}
echo  reset   [init]    [silent]  {lang_94}
echo                              {lang_167}
echo                              {lang_168}
echo  set     ^<MODULE^>            {lang_95}
echo                              {lang_165}
echo                              {lang_166}
echo:
echo  {lang_96}:
echo:
echo  init    ^<MODULE^> [PROFILE]  {lang_127}
echo                              {lang_169}
echo                              {lang_128}
echo                              {lang_170}
echo                              {lang_171}
echo  list                        {lang_97}
echo  off     ^<MODULE^>            {lang_98}
echo  on      ^<MODULE^> [PROFILE]  {lang_99}
echo  restart ^<MODULE^> [PROFILE]  {lang_100}
echo  shell   ^<MODULE^>            {lang_101}
echo  status  ^<MODULE^>            {lang_102}
echo:
echo  {lang_103}:
echo:
echo  exit                        {lang_104}
echo  log     ^<MODULE^|main^>  [N]  {lang_105}
echo  sysprep [silent^|ssd]        {lang_106}
echo                              {lang_107}
echo                              {lang_108}
echo                              {lang_109}
echo                              {lang_110}
echo                              {lang_111}
echo                              {lang_112}
echo  version                     {lang_113}
echo:
echo  {lang_114}:
echo:
echo  osp set PostgreSQL-9.6      {lang_115}
echo  osp on bind myprofile       {lang_116}
echo  osp restart mysql-8.0       {lang_117}
echo  osp log main 20             {lang_118}
echo  osp reset ^& osp add git     {lang_119}
goto end
:: -----------------------------------------------------------------------------------
:: SHUTTING DOWN THE APPLICATION
:: -----------------------------------------------------------------------------------
:shutdown
"{root_dir}\bin\curl.exe" -f -s {api_url}/exit > nul
if exist "{root_dir}\temp\OSPanel.lock" set "OSP_ERR_MSG={lang_120}" & goto error
echo: & echo  {lang_63}
goto end
:: -----------------------------------------------------------------------------------
:: SYSTEM PREPARATION TOOL
:: -----------------------------------------------------------------------------------
:sysprep
if /i not "%2"=="silent" if /i not "%2"=="ssd" if not "%2"=="" goto invalid
if /i "%2"=="silent" start "" /WAIT "{root_dir}\system\System Preparation Tool.exe" /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL
if /i "%2"=="ssd" start "" /WAIT "{root_dir}\system\System Preparation Tool.exe" /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /MERGETASKS="taskSsdopts"
if "%2"=="" start "" "{root_dir}\system\System Preparation Tool.exe"
goto end
:: -----------------------------------------------------------------------------------
:: LOG VIEW
:: -----------------------------------------------------------------------------------
:log
if "%2"=="" goto eargument
call :strfind "%OSP_MODULES_LIST% main all" "%2"
if not defined OSP_TMPVAL goto invalid
set "OSP_TMPVAL=OpenServerPanel"
if /i not "%2"=="main" set "OSP_TMPVAL=%2"
if /i "%2"=="all" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
for %%a in (%OSP_TMPVAL%) do (
    if /i "%2"=="all" echo: & echo  {lang_150} %%a: & echo:
    if /i not "%2"=="all" echo:
    if not exist "{root_dir}\logs\%%a.log" echo  %ESC%[90m{lang_121}%ESC%[0m
    if exist "{root_dir}\logs\%%a.log" for %%S in ("{root_dir}\logs\%%a.log") do if %%~zS==0 (echo  %ESC%[90m{lang_121}%ESC%[0m) else (
        if "%3"=="" "{root_dir}\bin\tail.exe" "{root_dir}\logs\%%a.log"
        if not "%3"=="" "{root_dir}\bin\tail.exe" "{root_dir}\logs\%%a.log" %3
    )
)
goto end
:: -----------------------------------------------------------------------------------
:: INIT/ON/OFF/RESTART/STATUS/LIST
:: -----------------------------------------------------------------------------------
:mod_cmd
if /i "%1"=="list" "{root_dir}\bin\curl.exe" -f -s {api_url}/mod/list/all/
if /i "%1"=="list" if %ERRORLEVEL% gtr 0 set "OSP_ERR_MSG={lang_120}" & goto error
if /i "%1"=="list" goto end
if "%2"=="" goto eargument
call :strfind "%OSP_MODULES_LIST% all" "%2"
if not defined OSP_TMPVAL goto invalid
set "OSP_TMPVAL=%2"
if /i "%2"=="all" set "OSP_TMPVAL=%OSP_MODULES_LIST%"
if /i "%2"=="all" if /i "%1"=="on" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
if /i "%2"=="all" if /i "%1"=="off" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
if /i "%2"=="all" if /i "%1"=="restart" set "OSP_TMPVAL=%OSP_ACTIVE_MODULES_LIST%"
if /i "%2"=="all" echo: & echo  {lang_175} & echo  {lang_176}
if /i "%2"=="all" %SystemRoot%\System32\choice.exe /C YN /N /M "->{lang_177} (Y/N)?"
if /i "%2"=="all" if not %ERRORLEVEL%==1 goto end
setlocal EnableDelayedExpansion
for %%a in (%OSP_TMPVAL%) do (
    if /i "%1"=="restart" (
        "{root_dir}\bin\curl.exe" -f -s {api_url}/mod/off/%%a/%3
        if !errorlevel! gtr 0 (
            echo: & echo  %ESC%[91m{lang_16}: {lang_120}%ESC%[0m
        ) else (
            "{root_dir}\bin\curl.exe" -f -s {api_url}/mod/on/%%a/%3
            if !errorlevel! gtr 0 echo: & echo  %ESC%[91m{lang_16}: {lang_120}%ESC%[0m
        )
    ) else (
        "{root_dir}\bin\curl.exe" -f -s {api_url}/mod/%1/%%a/%3
        if !errorlevel! gtr 0 echo: & echo  %ESC%[91m{lang_16}: {lang_120}%ESC%[0m
    )
    if !errorlevel!==0 if /i "%1"=="status" if exist "{root_dir}\logs\%%a.log" for %%S in ("{root_dir}\logs\%%a.log") do if not %%~zS==0 echo: & "{root_dir}\bin\tail.exe" "{root_dir}\logs\%%a.log"
)
endlocal
goto end
:: -----------------------------------------------------------------------------------
:: SHELL
:: -----------------------------------------------------------------------------------
:mod_shell
if "%2"=="" goto eargument
call :strfind "%OSP_MODULES_LIST%" "%2"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST%" "%2"
if defined OSP_TMPVAL set "OSP_PSV=yes"
if not exist "{root_dir}\data\{module_name}\shell_%2.bat" echo: & echo  %ESC%[93m{lang_122}%ESC%[0m & goto end
setlocal
call :env_reset
if exist "{root_dir}\data\{module_name}\env_%2.bat" call "{root_dir}\data\{module_name}\env_%2.bat" shell
call "{root_dir}\data\{module_name}\shell_%2.bat"
endlocal
goto end
:: -----------------------------------------------------------------------------------
:: ADD ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_add
if "%2"=="" goto eargument
call :strfind "%OSP_MODULES_LIST%" "%2"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST%" "%2"
if defined OSP_TMPVAL set "OSP_PSV=yes"
call :strfind "%OSP_ACTIVE_ENV%" "%2"
if defined OSP_TMPVAL set "OSP_ERR_MSG={lang_123}" & goto error
if not exist "{root_dir}\data\{module_name}\env_%2.bat" echo: & echo  %ESC%[93m{lang_124}%ESC%[0m & goto end
call "{root_dir}\data\{module_name}\env_%2.bat" add
goto end
:: -----------------------------------------------------------------------------------
:: SET ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_set
if "%2"=="" goto eargument
call :strfind "%OSP_MODULES_LIST%" "%2"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_PASSIVE_MODULES_LIST%" "%2"
if defined OSP_TMPVAL set "OSP_PSV=yes"
if not exist "{root_dir}\data\{module_name}\env_%2.bat" echo: & echo  %ESC%[93m{lang_124}%ESC%[0m & goto end
call :env_reset
call "{root_dir}\data\{module_name}\env_%2.bat"
goto end
:: -----------------------------------------------------------------------------------
:: WINDOWS ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_windows
for /f "tokens=1* delims==" %%a in ('set') do ( call :strfind %%a "ConEmu" & if not defined OSP_TMPVAL if /i not %%a==OSP_ECHO_STATE if /i not %%a==ANSICON if /i not %%a==ANSICON_DEF if /i not %%a==PROMPT set %%a=)
{windows_environment}
set "ESC="
set "OSP_ACTIVE_ENV=Windows"
if /i not "{terminal_codepage}"=="" if /i "%2"=="init" set "OSP_TERMINAL_CODEPAGE={terminal_codepage}"
if /i "%2"=="init" if /i not "%3"=="silent" call :logo
if /i not "%3"=="silent" echo: & echo  {lang_52}: %OSP_ACTIVE_ENV%
TITLE Open Server Panel ^| %OSP_ACTIVE_ENV%
goto end
:: -----------------------------------------------------------------------------------
:: DEFAULT ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_reset
for /f "tokens=1* delims==" %%a in ('set') do ( call :strfind %%a "ConEmu" & if not defined OSP_TMPVAL if /i not %%a==OSP_TERMINAL_CODEPAGE if /i not %%a==OSP_ECHO_STATE if /i not %%a==ANSICON if /i not %%a==ANSICON_DEF if /i not %%a==PROMPT set %%a=)
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
:: -----------------------------------------------------------------------------------
:: EXIT
:: -----------------------------------------------------------------------------------
:before_exit
if defined OSP_TERMINAL_CODEPAGE chcp %OSP_TERMINAL_CODEPAGE% > nul
if defined OSP_ECHO_STATE echo %OSP_ECHO_STATE%
@set "OSP_TERMINAL_CODEPAGE="
@set "OSP_MODULES_LIST="
@set "OSP_ACTIVE_MODULES_LIST="
@set "OSP_PASSIVE_MODULES_LIST="
@set "OSP_ECHO_STATE="
@set "OSP_ERR_MSG="
@set "OSP_TMPVAL="
@set "OSP_PSV="
@exit /b 0
:notrunning
@echo: & @echo  %ESC%[91m{lang_16}: {lang_56}%ESC%[0m
@if defined OSP_TERMINAL_CODEPAGE @chcp %OSP_TERMINAL_CODEPAGE% > nul
@set "OSP_TERMINAL_CODEPAGE="
@exit /b 1
:end
call :before_exit
@exit /b 0
:error
if defined OSP_ERR_MSG echo: & echo  %ESC%[91m{lang_16}: %OSP_ERR_MSG%%ESC%[0m
call :before_exit
@exit /b 1