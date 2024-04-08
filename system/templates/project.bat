{project_env_text}
set "OSP_TMP_CODEPAGE={terminal_codepage}"
if not %ERRORLEVEL% gtr 0 cd /d "{project_dir}"
if not %ERRORLEVEL% gtr 0 set "OSP_ACTIVE_ENV=%1 ^| %OSP_ACTIVE_ENV%"
if not %ERRORLEVEL% gtr 0 if /i not "%2"=="silent" echo: & echo {lang_current_env}: %ESC%[36m%OSP_ACTIVE_ENV%%ESC%[0m
if not %ERRORLEVEL% gtr 0 TITLE %OSP_ACTIVE_ENV% ^| Open Server Panel
if not %ERRORLEVEL% gtr 0 if defined OSP_TMP_CODEPAGE chcp %OSP_TMP_CODEPAGE% > nul
if not %ERRORLEVEL% gtr 0 if /i "%2"=="start" goto start
goto end
:start
{project_command}
:end
exit /b %ERRORLEVEL%
