{environment}
if /i not "{terminal_codepage}"=="" chcp {terminal_codepage}>nul
if /i not "{terminal_codepage}"=="" if /i not "%1"=="shell" set "OSP_TERMINAL_CODEPAGE={terminal_codepage}"
if /i not "%1"=="add" set "OSP_ACTIVE_ENV=%ESC%[94m{module_name}%ESC%[0m" & set "OSP_ACTIVE_ENV_T={module_name}"
if /i "%1"=="add" set "OSP_ACTIVE_ENV=%ESC%[94m%OSP_ACTIVE_ENV%%ESC%[0m + %ESC%[94m{module_name}%ESC%[0m" & set "OSP_ACTIVE_ENV_T=%OSP_ACTIVE_ENV_T% + {module_name}"
call :strfind "{psv_modules_list}" ":%2:"
if not defined OSP_TMPVAL if /i not "%3"=="silent" if not exist "{root_dir}\temp\{module_name}.lock" echo: & echo  %ESC%[93m{lang_17}: {module_name} {lang_172}%ESC%[0m
if /i not "%1"=="shell" echo: & echo  {lang_52}: %OSP_ACTIVE_ENV%
if /i not "%3"=="silent" if /i not "%1"=="shell" TITLE Open Server Panel ^| %OSP_ACTIVE_ENV_T%
if /i "%1"=="shell" echo: