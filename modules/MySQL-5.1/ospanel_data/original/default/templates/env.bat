{environment}
if /i not "{terminal_codepage}"=="" chcp {terminal_codepage}>nul
if /i not "{terminal_codepage}"=="" if /i not "%1"=="shell" set "OSP_TERMINAL_CODEPAGE={terminal_codepage}"
if /i not "%1"=="add" set "OSP_ACTIVE_ENV={module_name}"
if /i "%1"=="add" set "OSP_ACTIVE_ENV=%OSP_ACTIVE_ENV% + {module_name}"
if /i not "%1"=="shell" echo: & echo  {lang_52}: %OSP_ACTIVE_ENV%
if /i not "%3"=="silent" if /i not "%1"=="shell" TITLE Open Server Panel ^| %OSP_ACTIVE_ENV%