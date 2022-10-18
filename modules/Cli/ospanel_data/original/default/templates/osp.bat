:: OPEN SERVER PANEL | COMMAND LINE INTERFACE
:: -----------------------------------------------------------------------------------
@for /f "tokens=2 delims=:." %%a in ('chcp') do @set "OSP_TERMINAL_CODEPAGE=%%a"
@call :trim %OSP_TERMINAL_CODEPAGE% OSP_TERMINAL_CODEPAGE
@chcp 65001 > nul
@if not exist "{root_dir}\temp\" goto canceled
:gettempname
@set "OSP_TMPVAL=~OSP_%RANDOM%.tmp"
@if exist "{root_dir}\temp\%OSP_TMPVAL%" goto gettempname
@(for /f %%N in ("1") do call,) > "{root_dir}\temp\%OSP_TMPVAL%"
@for %%S in ("{root_dir}\temp\%OSP_TMPVAL%") do @if %%~zS==0 (set "OSP_ECHO_STATE=OFF") else (set "OSP_ECHO_STATE=ON")
@echo off
del "{root_dir}\temp\%OSP_TMPVAL%"
if "%OSP_ACTIVE_ENV%"=="" set "OSP_ACTIVE_ENV=Windows"
if not exist "{root_dir}\bin\curl.exe"   set "OSP_ERR_MSG={lang_34}: {root_dir}\bin\curl.exe {lang_71}"   & goto error
if not exist "{root_dir}\bin\tail.exe"   set "OSP_ERR_MSG={lang_34}: {root_dir}\bin\tail.exe {lang_71}"   & goto error
if not exist "{root_dir}\system\SystemPreparationTool.exe" set "OSP_ERR_MSG={lang_34}: {root_dir}\system\SystemPreparationTool.exe {lang_71}" & goto error
:: -----------------------------------------------------------------------------------
:: ROUTER
:: -----------------------------------------------------------------------------------
:router
if /i "%1"=="add"         goto env_add
if /i "%1"=="exit"        goto shutdown
if /i "%1"=="-h"          goto help
if /i "%1"=="help"        goto help
if /i "%1"=="info"        echo: & echo  {lang_108}: %OSP_ACTIVE_ENV% & goto end
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
if /i "%1"=="-v"          echo: & echo  {lang_20}: {osp_version} & goto end
if /i "%1"=="version"     echo: & echo  {lang_20}: {osp_version} & goto end
if "%1"==""               goto help
set "OSP_ERR_MSG={lang_34}: {lang_72}" & goto error
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
echo  {lang_69}: osp help ^| {lang_20}: {osp_version} ^| © 2010-2022 ^«OSPanel.io^»
@exit /b 0
:: -----------------------------------------------------------------------------------
:: HELP
:: -----------------------------------------------------------------------------------
:help
call :logo
echo:
echo  {lang_73}: osp ^<{lang_74}^> [^<{lang_75}^>]
echo:
echo  {lang_76}:
echo:
echo  add     ^<MODULE^>  [append]  {lang_77}
echo                              {lang_67}
echo                              {lang_68}
echo                              {lang_78}
echo                              {lang_79}
echo                              {lang_80}
echo                              {lang_81}
echo  info                        {lang_84}
echo  reset                       {lang_88}
echo  set     ^<MODULE^>            {lang_89}
echo:
echo  {lang_116}:
echo:
echo  list                        {lang_86}
echo  off     ^<MODULE^>            {lang_70}
echo  on      ^<MODULE^> [PROFILE]  {lang_87}
echo  restart ^<MODULE^> [PROFILE]  {lang_58}
echo  shell   ^<MODULE^>            {lang_90}
echo  status  ^<MODULE^>            {lang_91}
echo:
echo  {lang_117}:
echo:
echo  exit                        {lang_82}
echo  log     ^<MODULE^|main^>  [N]  {lang_85}
echo  sysprep [silent^|ssd]        {lang_92}
echo                              {lang_93}
echo                              {lang_94}
echo                              {lang_95}
echo                              {lang_96}
echo                              {lang_97}
echo                              {lang_98}
echo  version                     {lang_99}
echo:
echo  {lang_100}:
echo:
echo  osp set PostgreSQL-9.6      {lang_101}
echo  osp on bind myprofile       {lang_83}
echo  osp restart mysql-8.0       {lang_102}
echo  osp log main 20             {lang_103}
echo  osp reset ^& osp add git     {lang_104}
goto end
:: -----------------------------------------------------------------------------------
:: SHUTTING DOWN THE APPLICATION
:: -----------------------------------------------------------------------------------
:shutdown
"{root_dir}\bin\curl.exe" -s -o nul {api_url}/exit
if %ERRORLEVEL% gtr 0 set "OSP_ERR_MSG={lang_34}: {lang_59}" & goto error
goto end
:: -----------------------------------------------------------------------------------
:: SYSTEM PREPARATION TOOL
:: -----------------------------------------------------------------------------------
:sysprep
if /i not "%2"=="silent" if /i not "%2"=="ssd" if not "%2"=="" goto invalid
if /i "%2"=="silent" start "" /WAIT "{root_dir}\system\SystemPreparationTool.exe" /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL
if /i "%2"=="ssd" start "" /WAIT "{root_dir}\system\SystemPreparationTool.exe" /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /MERGETASKS="taskSsdopts"
if "%2"=="" start "" "{root_dir}\system\SystemPreparationTool.exe"
goto end
:: -----------------------------------------------------------------------------------
:: LOG VIEW
:: -----------------------------------------------------------------------------------
:log
if "%2"=="" goto eargument
call :strfind "{modules_list}main:" ":%2:"
if not defined OSP_TMPVAL goto invalid
set "OSP_TMPVAL=OpenServerPanel"
if /i not "%2"=="main" set "OSP_TMPVAL=%2"
echo:
if not exist "{root_dir}\logs\%OSP_TMPVAL%.log" echo  {lang_111} & goto end
for %%S in ("{root_dir}\logs\%OSP_TMPVAL%.log") do if %%~zS==0 echo  {lang_111} & goto end
if "%3"=="" "{root_dir}\bin\tail.exe" "{root_dir}\logs\%OSP_TMPVAL%.log"
if not "%3"=="" "{root_dir}\bin\tail.exe" "{root_dir}\logs\%OSP_TMPVAL%.log" %3
goto end
:: -----------------------------------------------------------------------------------
:: ON/OFF/RESTART/STATUS/LIST
:: -----------------------------------------------------------------------------------
:mod_cmd
if /i not "%1"=="list" if "%2"=="" goto eargument
if /i not "%1"=="list" call :strfind "{modules_list}" ":%2:"
if /i not "%1"=="list" if not defined OSP_TMPVAL goto invalid
"{root_dir}\bin\curl.exe" -s -o nul {api_url}/mod/%1/%2/%3
if %ERRORLEVEL% gtr 0 set "OSP_ERR_MSG={lang_34}: {lang_59}" & goto error
if /i not "%1"=="status" goto end
if not exist "{root_dir}\logs\%2.log" goto end
for %%S in ("{root_dir}\logs\%2.log") do if %%~zS==0 goto end
echo:
"{root_dir}\bin\tail.exe" "{root_dir}\logs\%2.log"
goto end
:: -----------------------------------------------------------------------------------
:: SHELL
:: -----------------------------------------------------------------------------------
:mod_shell
if "%2"=="" goto eargument
call :strfind "{modules_list}" ":%2:"
if not defined OSP_TMPVAL goto invalid
echo:
if not exist "{root_dir}\data\Cli\shell_%2.bat" echo  {lang_105} & goto end
setlocal
call :env_reset
if exist "{root_dir}\data\Cli\env_%2.bat" call "{root_dir}\data\Cli\env_%2.bat" shell
call "{root_dir}\data\Cli\shell_%2.bat"
endlocal
goto end
:: -----------------------------------------------------------------------------------
:: ADD ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_add
if "%2"=="" goto eargument
call :strfind "{modules_list}" ":%2:"
if not defined OSP_TMPVAL goto invalid
call :strfind "%OSP_ACTIVE_ENV%" "%2"
if defined OSP_TMPVAL set "OSP_ERR_MSG={lang_34}: {lang_107}" & goto error
if not exist "{root_dir}\data\Cli\env_%2.bat" echo: & echo  {lang_106} & goto end
call "{root_dir}\data\Cli\env_%2.bat" add
goto end
:: -----------------------------------------------------------------------------------
:: SET ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_set
if "%2"=="" goto eargument
call :strfind "{modules_list}" ":%2:"
if not defined OSP_TMPVAL goto invalid
if not exist "{root_dir}\data\Cli\env_%2.bat" echo: & echo  {lang_106} & goto end
call :env_reset
call "{root_dir}\data\Cli\env_%2.bat"
goto end
:: -----------------------------------------------------------------------------------
:: WINDOWS ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_windows
for /f "tokens=1* delims==" %%a in ('set') do ( call :strfind %%a "ConEmu" & if not defined OSP_TMPVAL if /i not %%a==OSP_ECHO_STATE if /i not %%a==ANSICON if /i not %%a==ANSICON_DEF if /i not %%a==PROMPT set %%a=)
{windows_environment}
set "OSP_ACTIVE_ENV=Windows"
if /i "%2"=="init" if /i not "%3"=="silent" call :logo
if /i "%2"=="init" if /i not "%3"=="silent" echo: & echo  {lang_108}: %OSP_ACTIVE_ENV%
if /i "%2"=="init" set "OSP_TERMINAL_CODEPAGE={terminal_codepage}"
TITLE Open Server Panel ^| %OSP_ACTIVE_ENV%
goto end
:: -----------------------------------------------------------------------------------
:: DEFAULT ENVIRONMENT
:: -----------------------------------------------------------------------------------
:env_reset
for /f "tokens=1* delims==" %%a in ('set') do ( call :strfind %%a "ConEmu" & if not defined OSP_TMPVAL if /i not %%a==OSP_TERMINAL_CODEPAGE if /i not %%a==OSP_ECHO_STATE if /i not %%a==ANSICON if /i not %%a==ANSICON_DEF if /i not %%a==PROMPT set %%a=)
{default_environment}
exit /b 0
:: -----------------------------------------------------------------------------------
:: MISCELLANEOUS FUNCTIONS
:: -----------------------------------------------------------------------------------
:invalid
set "OSP_ERR_MSG={lang_34}: {lang_109}" & goto error
:eargument
set "OSP_ERR_MSG={lang_34}: {lang_110}" & goto error
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
chcp %OSP_TERMINAL_CODEPAGE% > nul
echo %OSP_ECHO_STATE%
@set "OSP_TERMINAL_CODEPAGE="
@set "OSP_ECHO_STATE="
@set "OSP_ERR_MSG="
@set "OSP_TMPVAL="
@exit /b 0
:canceled
@echo: & @echo  {lang_34}: {root_dir}\temp {lang_71} {lang_33}.
@if defined OSP_TERMINAL_CODEPAGE @chcp %OSP_TERMINAL_CODEPAGE% > nul
@set "OSP_TERMINAL_CODEPAGE="
@exit /b 1
:end
call :before_exit
@exit /b 0
:error
echo: & echo  %OSP_ERR_MSG%
call :before_exit
@exit /b 1