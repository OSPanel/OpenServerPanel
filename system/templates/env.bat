if /i "%1"=="resetenv" goto resetenv
{environment}
if /i not "{terminal_codepage}"=="" if /i not "%1"=="shell" set "OSP_CODEPAGE={terminal_codepage}" & if defined OSP_TMP_CODEPAGE set "OSP_TMP_CODEPAGE={terminal_codepage}"
goto end
:resetenv
{reset_environment}
:end
exit /b 0