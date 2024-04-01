if /i "%1"=="resetenv" goto resetenv
{environment}
goto end
:resetenv
{reset_environment}
:end
exit /b 0